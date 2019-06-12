s.boot;

{PinkNoise.ar(LFPulse.kr(9,0,0.1)*0.2!2)}.play;

(
SynthDef.new(\sine,{
	arg freq=400, amp=0.2, atk=0.002, rel=0.08;
	var sig, env;
	env = Env.new([0,1,0],[atk,rel],[1,-1]).kr(2);
	sig = SinOsc.ar(freq, 0, amp)!2 * env;
	Out.ar(0, sig);
}).add;
)

(
Synth(\sine,[
	\freq, exprand(200, 2000),
	\rel, exprand(0.05, 0.5),
]);
)

(
t = TempoClock.new(140/60);
p = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pseq([Pseq([2,1,1],4),3,1,2,2,2,2,4],inf) / 2,
	\midinote, Pseq([76, 71, 72, 74, 72, 71, 69, 69, 72, 76, 74, 71, 71, 72, 74, 76, 72, 69, 69], inf),
    \amp, 0.8,
).play(t);
)

t.tempo_(200/60);
t.tempo_(100/60);

p.stop;