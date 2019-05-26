(
SynthDef.new(
	\pureTone,
	{
		arg freq=500, amp=0.5, gate=1, out=0;
		var sig, env;
		env = EnvGen.kr(Env.asr, gate, 1, 0, 1, doneAction:2);
		sig = SinOsc.ar(freq, 0, amp);
		sig = sig * env;
		Out.ar(0, sig!2);
	}
).add;
)

x = Synth.new(\pureTone);
x.set(\gate, 0);


a = {rrand(20, 80)}!8;

(
~synths = a.collect({
	arg nodeNum;
	Synth.new(\pureTone, [
		\freq, nodeNum.midicps,
		\amp, 0.05
	])
}))

(
~synths.do({
	arg synth;
	synth.set(\freq, rrand(20, 80).midicps);
}))

(
~synths.do({
	arg synth;
	synth.free;
}))


(
~synths.do({
	arg synth;
	synth.set(\gate, 0);
}))
~synths[0].set(\gate, 0);
~synths[1].set(\gate, 0);
~synths[2].set(\gate, 0);
~synths[3].set(\gate, 0);
~synths[4].set(\gate, 0);
~synths[5].set(\gate, 0);
~synths[6].set(\gate, 0);
~synths[7].set(\gate, 0);
~synths[8].set(\gate, 0);