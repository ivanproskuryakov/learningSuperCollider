~midinotes = Pseries(60, 2, 14).asStream;

(
r = Routine.new({
	14.do{
		Synth(\sine, [\freq, ~midinotes.next.midicps]);
		0.5.wait;
	}
}).play
)

p = Pwrand([1,2,3], [0.1,0.5,0.8], inf).asStream;
p.nextN(1);

p = Pwrand([1,2,3], [1,5,8].normalizeSum, inf).asStream;
p.nextN(1);


p = Pshuf((1..5), inf).asStream;
p.nextN(10);

p = Pseq([1,2,3,10], inf).asStream;
p.nextN(10);

p = Prand([1,2,3,10], inf).asStream;
p.nextN(10);

p = Pxrand([1,2,3,10], inf).asStream;
p.nextN(10);

