(
p = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pseq([Pseq([2,1,1],4), 3,1,2,2,2,2,4], inf),
	\midinote, Pseq([76, 71, 72, 74, 72, 71, 69, 69, 72, 76, 74, 72, 71, 72, 74, 76, 72, 69, 69], inf),
	\amp, 0.8
).play;
)

Synth(\sine);

(
Synth(\play, [
	\buf, b.bufnum,
	\rate, 1,
]);
)


// The actual play
(
t = TempoClock.new(140/60).permanent_(true);
~postBeat = {t.beats.postln;1;};
t.schedAbs(t.nextBar, {~postBeat.value});
)

(
SynthDef.new(\play,{
	arg buf=0, amp=0.4, rel=0.12, rate=1;
	var sig, env;

	env = Env.new([1,0],[rel],[-1]).kr(2);
	sig = PlayBuf.ar(2, buf, rate) * env * amp;
	Out.ar(0, sig);
}).add;
)

(
SynthDef.new(\sine,{
	arg freq=400, amp=1.2, atk=0.002, rel=0.08;
	var sig, env;

	env = Env.new([0,1,0],[atk,rel],[1,-1]).kr(2);
	sig = LFTri.ar(freq, 0, amp)!2 * env;
	Out.ar(0, sig);
}).add;
)

(p = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pseq([1/8], inf) * t.beatsPerBar,
	\scale, Scale.minor,
	\degree, Pseq([
		5,\,2,3,4,\,3,2,
		1,\,1,3,5,\,4,3,
		2,\,\,3,4,\,5,\,
		3,\,1,\,1,\,1,\,

		\,5,\,6,8,\,7,6,
		5,\,\,3,5,\,4,3,
		2,\,2,3,4,\,5,\,
		3,\,1,\,1,\,\,\
	]-1, inf),
	\mtranspose, 2,
	\amp, 0.8
).play(t, quant:4);
)


(
b = Buffer.read(s, "/Users/proskuryakovivan/Music/wav/Electro-Tom.wav");
q = Pbind(
	\instrument, \play,
	\dur, 1/4,
	\buf, b.bufnum,
	\freq, Pseq([
		1, \, 100, 100, 25, \, 5, \,
	], inf),
	\rate, Pseq([
		1, \, 100, 100, 25, \, 5, \,
	], inf),
	\amp, 0.5,
	\rel, 0.1
).play(t, quant:4);
)

q.play;
q.stop;
b.play;






