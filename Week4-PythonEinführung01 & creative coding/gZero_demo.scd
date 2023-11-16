// This is SuperCollider
// it's an environment for sound Synthesis and Algorithmic Composition

//In this example we're gonna play recording and playing with sound containers

//we evaluate lines of code by steping on top of them with the cursor and pressing the keys cmd + enter (ctrl in windows)

//first start the buffer
s.boot;

// then we'll need to start by creating the continer where we're gonna record the sound aka the buffer

~digiTape = Buffer.alloc(s, 44100 * 4, 1);

//now we're gonna create a function that passes-thru the audio from our built-in mic in the pc

(
{var snd; // create a variable to hold the sound signal
	snd = SoundIn.ar(0); // create a function that grabs the audio from the microphone and assign it to the snd variable
	snd = snd * MouseY.kr(0,0.8); // now use MouseY, then we could use the Y axis of the cursor to up or down the volume of our sound
	//its gonna create a very piercing high sound
	snd = snd.dup; // duplicate the signal so its stereo
	snd = BPF.ar(snd, MouseX.kr(300,1500)); // use a filter to remove hi pitch and low rumble
	snd.fold2;
}.play;
)




(
{var snd, rec, play,trig, rates; // we add more variables to hold our sounds
	snd = SoundIn.ar(0);
	snd = snd * MouseY.kr(0,0.8);

	// Sequencer
	trig = Impulse.kr(1/3); //generates an impulse
	a = Drand([0.5,1,-1,2, -0,25],inf); // this is the sequence (the one in the array), it's gonna be repeated forever in a random choice
	rates = Demand.kr(trig, 0, a).lag(0.3); // this is where the trig and the sequence come together

	snd = BPF.ar(snd, MouseX.kr(300,2000));

	rec = RecordBuf.ar( // uGen to record and overdub sounds
		inputArray: snd,   // our sound
		bufnum: ~digiTape,   // our buffer
		recLevel: 0.7, // the volume of the sound comming in
		preLevel: 0.6, // the amount of the output that is coming back in
	);

	play = PlayBuf.ar(1,~digiTape, rate:rates ,loop:1);

	[play,CombL.ar(snd)] ;

}.play;
)



(
{var snd, rec, play,trig, rates; // we add more variables to hold our sounds
	snd = SoundIn.ar(0);
	snd = snd * MouseY.kr(0,1);

	// Sequencer
	trig = Impulse.kr(2); //generates an impulse
	a = Drand((0..3),inf); // this is the sequence (the one in the array), it's gonna be repeated forever in a random choice
	rates = Demand.kr(trig, 0, a).lag(0.3); // this is where the trig and the sequence come together
	rates.poll;
	snd = LPF.ar(snd, MouseX.kr(100,3500));

	play = (1..12).collect{
		arg i;
		SelectX.ar(rates,
			[
				CombL.ar(snd, 2, 2/i )/i,
				CombL.ar(snd,2, i/12.rand)/i,
				PitchShift.ar(snd,pitchRatio: 0.73)
			],
		) //select
	}; // collect

	play = Splay.ar(play);

	(play + snd) * 0.8;

}.play;
)






