s.boot;

{SinOsc.ar(20).range(200,2000)}.plot(0.2);

[1,2,3,4,5,6,7,8,9,10].explin(1,9,100,1000).plot

({
	var freq, sig;
	freq = LFTri.kr(8).explin(-1,1, 200,1000);
}.plot(1))

{SinOsc.kr(1.5).range(1,2)}.plot


exprand(1, 100);

[1,2,3].linexp(1,3,-5,5);

[1,2,3,4,5,6,7,8,9].lincurve(1,9,-10,20, 5).plot;

e = Env.new([0,10,40,400,300,100,20]).plot;
({
	var sig;
	sig = [
		SinOsc.ar(500, 0, 0.2),
		BrownNoise.ar(0.2),
	];
	sig = sig * [
		LFPulse.kr(5),
		SinOsc.kr(0.5).range(0,1),
	];
}.play)

a = {rrand(1, 5)}!2;

a.linexp(1, 5, 10, 500);

100.linexp(100,2200,3000,3000).postln;

