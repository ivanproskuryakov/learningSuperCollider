// Defining Synth
(
SynthDef.new(\sine, {
	arg freq=440, amp=0.4, rel=0.3, pan=0, clipAmp =1;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.perc(0.0001, rel), doneAction:2);
	sig = (sig * clipAmp).clip(-1, 1);
	sig = sig * env * amp;
	Out.ar(0, sig!2);
}).add;
)

// Pattern Function
(
p = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pwhite(0.2, 0.8, inf),
	\freq, Pfuncn({
		Array.fill(1, {exprand(100, 10000)})
	}, inf).round(100),
	\amp, 0.01,
	\rel, Pexprand(4, 6, inf)
).play
)

// Pattern MUL
(
p = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pexprand(0.01, 0.1, inf),
	\freq, Pexprand(50, 3000, inf).round(50)
	*
	Pwhite(-0.2,0.2).midiratio,
	\amp, 0.02,
	\rel, Pexprand(4, 6, inf),
	\pan, Pwhite(-1.0, 1.0, inf),
).play
)

// Pattern + Freq,Detune + Pif
(
p = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pexprand(0.01, 0.1, inf),
	\midinote, Pdefn(\midiCtrl, 43),
	\harmonic, Pexprand(1, 30, inf).round,
	\detune, Pwhite(-4.0,4.0, inf),
	\amp, Pexprand(0.01, 0.06, inf),
	\rel, Pexprand(4, 6, inf),
	\pan, Pdefn(\panCtrl, 0),
	\clipAmp, Pdefn(\clipCtrl, 1),
).play
)

Pdefn(\midiCtrl, 33);
Pdefn(\panCtrl, Pif(Pkey(\harmonic) > 15, -1, 1));
Pdefn(\panCtrl, Pwhite(-1, 1, inf));

p.stop;

// Default synth, Note
(freq:300, sustain:3.5, amp:0.5, volume:0.02, instument:\sine).play;

// Chaning setting on fly
(
~notes = Pxrand([60, 62, 64, 65, 67, 69, 71, 72], inf).asStream;
~amps = Pexprand(0.1, 1, inf).asStream;
~durs = Pxrand([0.1, 0.2], [0.9, 0.1], inf).asStream;
)

(
~r = Routine.new({
	loop {
		Synth.new(\sine, [
			\freq, ~notes.next.midicps,
			\amp, ~amps.next,
		]);
		~durs.next.wait;
	}
}).play;
)