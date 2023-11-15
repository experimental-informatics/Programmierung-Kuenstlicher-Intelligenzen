/////////////// Synthesis
// We'll look mostly at examples, rather than theory here (which is covered in the readings)
// Along the way we'll learn a little more about getting SC to do some work for you

// Additive Synthesis (many of these examples by David Cottle, or based on them)
// build up something by combining components

// Harmonics with varying amplitude
// Spelled out one at a time
(
{
	var speed = 14;
	f = 300;
	t = Impulse.kr(1/3);
	Mix([
		SinOsc.ar(f*1, mul: LFNoise1.kr(rrand(speed, speed*2), 0.5, 0.5)/1),
		SinOsc.ar(f*2, mul: LFNoise1.kr(rrand(speed, speed*2), 0.5, 0.5)/2),
		SinOsc.ar(f*3, mul: LFNoise1.kr(rrand(speed, speed*2), 0.5, 0.5)/3),
		SinOsc.ar(f*4, mul: LFNoise1.kr(rrand(speed, speed*2), 0.5, 0.5)/4),
		SinOsc.ar(f*5, mul: LFNoise1.kr(rrand(speed, speed*2), 0.5, 0.5)/5),
		SinOsc.ar(f*6, mul: LFNoise1.kr(rrand(speed, speed*2), 0.5, 0.5)/6),
		SinOsc.ar(f*7, mul: LFNoise1.kr(rrand(speed, speed*2), 0.5, 0.5)/7),
		SinOsc.ar(f*8, mul: LFNoise1.kr(rrand(speed, speed*2), 0.5, 0.5)/8),
		SinOsc.ar(f*9, mul: LFNoise1.kr(rrand(speed, speed*2), 0.5, 0.5)/9),
		SinOsc.ar(f*10, mul: LFNoise1.kr(rrand(speed, speed*2), 0.5, 0.5)/10),
		SinOsc.ar(f*11, mul: LFNoise1.kr(rrand(speed, speed*2), 0.5, 0.5)/11),
		SinOsc.ar(f*12, mul: LFNoise1.kr(rrand(speed, speed*2), 0.5, 0.5)/12)
	]) * 0.5
}.scope(1)
)

// different release times in envelopes
(
{
	f = 100;
	t = Impulse.kr(1/3);
	Mix([
		SinOsc.ar(f*1, mul: EnvGen.kr(Env.perc(0, 1.4), t)/1),
		SinOsc.ar(f*2, mul: EnvGen.kr(Env.perc(0, 1.1), t)/2),
		SinOsc.ar(f*3, mul: EnvGen.kr(Env.perc(0, 2), t)/3),
		SinOsc.ar(f*4, mul: EnvGen.kr(Env.perc(0, 1), t)/4),
		SinOsc.ar(f*5, mul: EnvGen.kr(Env.perc(0, 1.8), t)/5),
		SinOsc.ar(f*6, mul: EnvGen.kr(Env.perc(0, 2.9), t)/6),
		SinOsc.ar(f*7, mul: EnvGen.kr(Env.perc(0, 4), t)/7),
		SinOsc.ar(f*8, mul: EnvGen.kr(Env.perc(0, 0.3), t)/8),
		SinOsc.ar(f*9, mul: EnvGen.kr(Env.perc(0, 1), t)/9),
		SinOsc.ar(f*10, mul: EnvGen.kr(Env.perc(0, 3.6), t)/10),
		SinOsc.ar(f*11, mul: EnvGen.kr(Env.perc(0, 2.3), t)/11),
		SinOsc.ar(f*12, mul: EnvGen.kr(Env.perc(0, 1.1), t)/12)
	]) * 0.5
}.scope(1)
)

// different release times in envelopes, randomised with trigger!
(
{
	f = 100;
	t = Impulse.kr(1/3);
	Mix([
		SinOsc.ar(f*1, mul: EnvGen.kr(Env.perc(0, TRand.kr(0.4, 3, t)), t)/1),
		SinOsc.ar(f*2, mul: EnvGen.kr(Env.perc(0, TRand.kr(0.4, 3, t)), t)/2),
		SinOsc.ar(f*3, mul: EnvGen.kr(Env.perc(0, TRand.kr(0.4, 3, t)), t)/3),
		SinOsc.ar(f*4, mul: EnvGen.kr(Env.perc(0, TRand.kr(0.4, 3, t)), t)/4),
		SinOsc.ar(f*5, mul: EnvGen.kr(Env.perc(0, TRand.kr(0.4, 3, t)), t)/5),
		SinOsc.ar(f*6, mul: EnvGen.kr(Env.perc(0, TRand.kr(0.4, 3, t)), t)/6),
		SinOsc.ar(f*7, mul: EnvGen.kr(Env.perc(0, TRand.kr(0.4, 3, t)), t)/7),
		SinOsc.ar(f*8, mul: EnvGen.kr(Env.perc(0, TRand.kr(0.4, 3, t)), t)/8),
		SinOsc.ar(f*9, mul: EnvGen.kr(Env.perc(0, TRand.kr(0.4, 3, t)), t)/9),
		SinOsc.ar(f*10, mul: EnvGen.kr(Env.perc(0, TRand.kr(0.4, 3, t)), t)/10),
		SinOsc.ar(f*11, mul: EnvGen.kr(Env.perc(0, TRand.kr(0.4, 3, t)), t)/11),
		SinOsc.ar(f*12, mul: EnvGen.kr(Env.perc(0, TRand.kr(0.4, 3, t)), t)/12)
	]) * 0.5
}.scope(1)
)

// use multichannel expansion
(
{
	f = 100;
	t = Impulse.kr(1/3);
	Mix(
		SinOsc.ar(
			f*(1..12),
			mul: EnvGen.kr(
				Env.perc(0, 1),
				t,
				levelScale: 1/(1..12),
				timeScale: [1.4, 1.1, 2, 1, 1.8, 2.9, 4, 0.3, 1, 3.6, 2.3, 1.1]
			)
		)
	) * 0.5
}.scope(1)
)

// a little variation each time helps with realism
(
{
	t = Impulse.kr(1/3);
	Mix(
		SinOsc.ar(
			[60, 64, 67, 71, 74, 78].midicps, mul: EnvGen.kr(
				Env.perc(0, 1),
				t,
				levelScale: 1/(1..6), timeScale: { TRand.kr(1.0, 3.0, t) }.dup(6)
		)
	)
	) * [0.3, 0.3] // pseudo pan
}.scope(2)
)


// with a random pitch shift, and formants
(
{
	t = Impulse.kr(1);
	Mix(
		SinOsc.ar(
			([60, 64, 67, 71, 74, 78] + TIRand.kr(0, 12, t) ++ [45, 46, 47]).midicps, mul: EnvGen.kr(
				Env.perc(0, 1),
				t,
				levelScale: 1/(1..6) ++ [0.8, 0.9, 0.9], timeScale: { TRand.kr(1.0, 3.0, t) }.dup(6) ++ (0.1 ! 3)
		)
	)
	) * [0.3, 0.3] // pseudo pan
}.scope(2)
)

(
{
	Mix(
		Pan2.ar(
			SinOsc.ar(
				[60, 62, 63, 65, 67, 68, 71, 72].midicps,
				mul: LFNoise1.kr(rrand(0.1, 0.5).dup(8), 0.5, 0.5) // makes 8 LFNoises
			),
			{1.0.rand2}.dup(8)
		)
	) * 0.2
}.scope(2)
)


// Inharmonic spectrum
(
{
	Mix(
		SinOsc.ar(
			[72, 135, 173, 239, 267, 306, 355, 473, 512, 572, 626],
			0, //phase
			[0.25, 0.11, 0.12, 0.04, 0.1, 0.15, 0.05, 0.01, 0.03, 0.02, 0.12]
		)
	)
}.scope(1)
)

// Randomised freqs
// Let it run for a while, the strikes are random
(
{
	var trigger, partials = 12;
	trigger = Dust.kr(3/7);
	Pan2.ar(
		Mix(
			{
				SinOsc.ar(exprand(50.0, 4000)) * EnvGen.kr(
					Env.perc(0, rrand(0.2, 3.0)), trigger,
					1.0.rand
			) }.dup(partials)
		)/partials,
		1.0.rand2 )
}.scope(2)
)


// use Mix:fill and/or Array:fill
(
{
	var trigger, fund, flashInst;
	flashInst = Array.fill(5, {
		trigger = Dust.kr(3/7); fund = rrand(100, 400);
		Pan2.ar(
			Mix(
				// fill an Array with the results of evaluating this function 16 times
				// counter goes from 0 to 16
				Array.fill(16, {arg counter;
					var partial;
					partial = counter + 1;
					SinOsc.ar(fund*partial)
					* EnvGen.kr(Env.adsr(0, 0, 1.0, 5.0), trigger, 1/partial)
					* max(0, LFNoise1.kr(rrand(5.0, 12.0)))
				})
			) * 0.2,
			1.0.rand2
		)
	});
	Mix(flashInst)*0.6
}.scope(2);
)


(
{
	var harmonics = 16, fund = 50, speeds;
	speeds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]/5;
	// like Array.fill but sum the results
	Mix.fill(harmonics, { arg count;
		Pan2.ar(
			SinOsc.ar(
				fund * (count + 1),
				mul: max(0, SinOsc.kr(speeds.wrapAt(count)))
			),
			1.0.rand2
		)
	}
	) / (2*harmonics)
}.scope(2);
)


(
{
	var partials = 16;
	Mix.fill(partials, { arg count;
		Pan2.ar( SinOsc.ar(
			exprand(100, 2000),
			mul: max(0, SinOsc.kr(rrand(1/3, 1/6))*rrand(0.1, 0.9))),
		1.0.rand2
		)
	}) / (2 * partials)
}.scope(2);
)


/// Subtractive Synthesis
// start with something rich (e.g. noise) and take away
(
{
	Klank.ar(
		`[
			[100, 200, 300, 400, 500, 600, 700, 800, 900, 1000], // freqs
			[0.05, 0.2, 0.04, 0.06, 0.11, 0.01, 0.15, 0.03, 0.15, 0.2] // amps
		],
		PinkNoise.ar(MouseX.kr(0.01, 0.1))
	)
}.scope(1)
)


(
{
	Klank.ar(
		`[
			// generated values using Array:series
			Array.series(10, 50, 50), // start at 50, and add 50 ten times
			Array.series(10, 1.0, -0.1) // start at 1.0 and add -0.1 ten times
		],
		ClipNoise.ar(0.01) // different noise source
	)
}.scope(1)
)

(
{
	Klank.ar(
		`[{exprand(60, 10000)}.dup(15)], // rand freqs
		PinkNoise.ar(0.005)
	)
}.scope(1);
)

(
{
	var chime, freqSpecs, burst, totalHarm = 10; var burstEnv, att = 0, burstLength = 0.0001;
	freqSpecs = `[
		{rrand(100, 1200)}.dup(totalHarm), //freq array
		{rrand(0.3, 1.0)}.dup(totalHarm).normalizeSum.round(0.01), // amp array
		{rrand(2.0, 4.0)}.dup(totalHarm)]; //decay rate array
	burstEnv = Env.perc(0, burstLength); //envelope times
	burst = PinkNoise.ar(EnvGen.kr(burstEnv, gate: Impulse.kr(1))); // Noise burst
	Klank.ar(freqSpecs, burst) * MouseX.kr(0.1, 0.8)
}.scope(1)
)


(
{
	var totalInst, totalPartials, baseFreq, ampControl, chimes, cavern;
	totalInst = 5; //Total number of chimes
	totalPartials = 12; //Number of partials in each chime
	baseFreq = rrand(200, 1000); //Base frequency for chimes
	chimes = Mix({
		Pan2.ar(
			Klank.ar(`[
				{baseFreq*rrand(1.0, 12.0)}.dup(totalPartials),
				Array.rand(totalPartials, 0.3, 0.9), // fill an array with vals between 0.3 and 0.9
				Array.rand(totalPartials, 0.5, 6.0)
			],
			Decay.ar(
				Dust.ar(0.2, 0.02), //Times per second, amp
				0.001, //decay rate
				PinkNoise.ar //Noise
			)),
			1.0.rand2 //Pan position
		)
	}.dup(totalInst));
	cavern = Mix({
		var base;
		base = exprand(50, 500);
		Klank.ar(
			//frequency, amplitudes
			`[
				{rrand(1, 24) * base * rrand(1.0, 1.1)}.dup(totalPartials),
				Array.rand(10, 1.0, 5.0).normalizeSum
			],
			GrayNoise.ar( [rrand(0.03, 0.1), rrand(0.03, 0.1)]) )*max(0, LFNoise1.kr(3/rrand(5, 20), mul: 0.005))
	}.dup(5));
	cavern + chimes
}.scope(2)
)

// Rotating Wheels
(
{
	var totalPartials = 4;
	Mix( {
		var base;
		base = exprand(50, 10000);
		Pan2.ar(
			Klank.ar(
				`[ //frequency, amplitudes
					{rrand(1, 24) * base * rrand(1.0, 1.1)}.dup(totalPartials),
					Array.rand(10, 1.0, 5.0).normalizeSum
				],
				GrayNoise.ar( rrand(0.03, 0.1))
			)*max(0, SinOsc.kr(6/rrand(1, 10), mul: 0.005)),
			LFNoise1.kr(1)
		)
	}.dup(8));
}.play
)



// comb delay
(
{
	t = Impulse.kr(5);
	o = SinOsc.ar(TRand.kr(2000, 4000, t), mul: EnvGen.kr(Env.perc(0.001, 0.1), t))*0.1;
	Mix(Pan2.ar( CombL.ar(o, 2.0, Array.fill(5, {rrand(0.2, 1.9)})), Array.fill(5, {1.0.rand2}) ));
}.play
)

// Some sort of simple physical modelling synthesis
// we have an exciter and a resonator (like most instruments)
// from Thor Magnusson

// we use a noise ugen to generate a burst
(
{
	Decay.ar(Impulse.ar(1), 0.05, WhiteNoise.ar) * 0.5;
}.play
)

// but then we use Comb delay to create the delay line that creates the tone
(
// let's create a synthdef using a kind of Karplus-Strong
SynthDef(\ks_guitar, { arg note, pan, rand, decayTime, noiseType=1;
	var x, y, env;
	env = Env.new(#[1, 1, 0],#[2, 0.001]);
	// A simple exciter x, with some randomness.
	x = Decay.ar(Impulse.ar(0, 0, rand), 0.1+rand, WhiteNoise.ar);
	x = CombL.ar(x, 0.05, note.reciprocal, decayTime, EnvGen.ar(env, doneAction:2));
	x = Pan2.ar(x, pan);
	Out.ar(0, LeakDC.ar(x));
}).add;
)
// and play the synthdef
(
{
	// loop through this func 20 times
	20.do({
		Synth(\ks_guitar, [
			\note, 220+(400.rand),
			\pan, 1.0.rand2,
			\rand, 0.1+0.1.rand,
			\decayTime, 2+1.0.rand
		]);

		(1.0.rand + 0.5).wait;
	});
}.fork
)

// here using patterns
(
Pbind(\instrument, \ks_guitar, // using our synthdef
	\note, Pseq.new([60, 61, 63, 66], inf).midicps, // freq arg
	\dur, Pseq.new([0.25, 0.5, 0.25, 1], inf),  // dur arg
	\rand, Prand.new([0.2, 0.15, 0.15, 0.11], inf),  // dur arg
	\pan, 2.0.rand-1,
	\delayTime, 2+1.0.rand;  // envdur arg
).play;
)

(
// synthetic piano patch (James McCartney)
// exciter and resonator
var n;
n = 6;	// number of keys playing
play({
	Mix(Array.fill(n, {	// mix an array of notes
		var delayTime, pitch, detune, strike, hammerEnv, hammer;

		// calculate delay based on a random note
		pitch = (36 + 54.rand);
		strike = Impulse.ar(0.1+0.4.rand, 1.0.rand, 0.1); // random period for each key
		hammerEnv = Decay2.ar(strike, 0.008, 0.04); // excitation envelope
		Pan2.ar(
			// array of 3 strings per note
			Mix(Array.fill(3, { arg i;
				// detune strings, calculate delay time :
				detune = #[-0.05, 0, 0.04].at(i);
				delayTime = 1 / (pitch + detune).midicps;
				// each string gets own exciter :
				hammer = LFNoise2.ar(3000, hammerEnv); // 3000 Hz was chosen by ear..
				CombL.ar(hammer,		// used as a string resonator
					delayTime, 		// max delay time
					delayTime,			// actual delay time
					6) 				// decay time of string
			})),
			(pitch - 36)/27 - 1 // pan position: lo notes left, hi notes right
		)
	}))
})
)

/// more unusual stuff

// bespoke make your own
// vinyl crackling http://sccode.org/1-4Sj

(
SynthDef(\vinylCrackling, { arg out=0;
	var pop,imp,modImp,midNoise,hiNoise,loNoise,loopTime=8,numChan=2,w,x,y;

	//Harder pops
	pop = TDuty.ar(Dseq({ 1.0.bilinrand.abs } ! loopTime,inf));
	pop = Resonz.ar(Decay.ar(pop,TRand.ar(0.001,0.1,pop)),Demand.ar(pop,0,Dseq({ 7000.bilinrand.abs+40 } ! loopTime,inf)),
		mul:Demand.ar(pop,0,Dseq({ exprand(0.1,0.87) } ! loopTime,inf)));
	pop = LeakDC.ar(pop,TRand.ar(0.9,0.9995,pop));
	#w,x,y = PanB2.ar(pop,Demand.ar(pop,0,Dseq({ 1.0.rand2 } ! loopTime,inf)));

	//Softer, highpass filtered impulses
	imp = { arg i; HPF.ar(LPF.ar(Dust2.ar(8),8000.0),6000.0,WhiteNoise.ar(0.7)) } ! numChan;

	//Faster, modulated lowpass filtered impulses
	modImp = LPF.ar(Dust.ar(LFDNoise3.ar(1).exprange(100,500),LFDNoise3.ar(10).exprange(0.01,0.07)),9000.0) ! numChan;

	//Mid frequency modulated noise background
	midNoise = LPF.ar(GrayNoise.ar(LFDNoise3.ar(60))*WhiteNoise.ar(0.009),12000.0) ! numChan;

	//High frequency modulated noise background
	hiNoise = HPF.ar(LPF.ar(GrayNoise.ar(LFDNoise3.ar(60))*WhiteNoise.ar(0.01),14000.0),8000.0) ! numChan;

	//Low frequency modulated noise background
	loNoise = LPF.ar(BrownNoise.ar(PinkNoise.ar.range(0.001,0.02)),1200) ! numChan;

	Out.ar(out,DecodeB2.ar(numChan,w,x,y)+imp+modImp+midNoise+hiNoise+loNoise);
}).add;
)

Synth(\vinylCrackling);


// Stochastic Synthesis (after Xenakis), Gendy1, Gendy2, Gendy3

// Careful! Can be unpredictable

//1 CP = random noise effect
{Pan2.ar(Gendy1.ar(initCPs:1))}.play

//2 CPs = suudenly an oscillator (though a fast modulating one here)
{Pan2.ar(Gendy1.ar(initCPs:2))}.play

//wandering bass/ powerline
{Pan2.ar(Gendy1.ar(1,1,1.0,1.0,30,100,0.3,0.05,5))}.play

//advantages of messing with the random number generation- causes periodicities
{Pan2.ar(Gendy2.ar(a:MouseX.kr(0.0,1.0),c:MouseY.kr(0.0,1.0)))}.play

//stochastic waveform distortion- also play me at the same time as the previous example...
{Pan2.ar(Gendy3.ar(1,2,0.3,-0.7,MouseX.kr(55,110,'exponential'),0.03,0.1))}.play


//// Adapting all the stuff above

/// make an example into an Ndef
NdefMixer(s);
Ndef(\gendyBass, {Pan2.ar(Gendy1.ar(1,1,1.0,1.0,30,100,0.3,0.05,5))});

// add some distortion
Ndef(\dist, { (Ndef(\gendyBass).ar * \pre.kr(20)).softclip }).play(vol: 0.5)


// make it into a pattern
(
SynthDef(\gendyBass, {|sustain = 1, out = 0, pan = 0, freq = 100, amp = 0.5|
	var gendy;
	gendy = Pan2.ar(Gendy1.ar(1,1,1.0,1.0,freq * 0.9, freq * 1.1,0.3,0.05,5), pan);
	Out.ar(out, gendy * EnvGen.kr(Env.linen(sustainTime:sustain, releaseTime:0.01), doneAction:2) * amp);
}).add;
)

Pbind(\instrument, \gendyBass, \dur, Pbrown(0.01, 0.5, 0.2), \legato, 2.2, \pan, Pbrown(-1, 1, 0.5), \freq, Pwalk((30, 30.5..120), Prand([-1, 1],inf), 1, 100).midicps).play