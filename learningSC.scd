(
SynthDef.new(
	\pureTone,
	{
		arg freq=500, amp=0.5, gate=0;
		var sig, env;
		env = EnvGen.kr(Env.asr, gate, 1, 0, 1, doneAction:2);
		sig = SinOsc.ar(freq, 0, amp);
		sig = sig * env;
		Out.ar(0,sig);
	}
).add;
)

x = Synth.new(\pureTone);
x.set(\gate, 1);
x.set(\gate, 0);
x.set(\freq, 500);