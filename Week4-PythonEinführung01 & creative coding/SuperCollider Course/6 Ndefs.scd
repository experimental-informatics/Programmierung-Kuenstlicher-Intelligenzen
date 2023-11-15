b = Buffer.loadDialog; // load a soundfile for processing
b.postln; // check details after load

(
Ndef(\source, {|pos = 0, rate = 1, loop = 0, t_trig = 0|
	var pb;
	pb = PlayBuf.ar(b.numChannels, b, BufRateScale.kr(b)  * rate, t_trig, pos  * BufSampleRate.kr(b), loop); // pos in seconds
	// could add an envelope here
});
)

Ndef(\source).play // make it audible

Ndef(\source).set(\t_trig, 1); // retrigger the playback (could also rerun chunk above)

(
Ndef(\source).stop(3); // make it inaudible but still running
Ndef(\pulseChop, {|rate = 4, width = 0.5|
	Ndef(\source).ar * LFPulse.ar(rate, width:width).range(0, 1); // Ndefs can spoof a UGen
}).play(vol: 0.2, fadeTime: 3)
)

(
Ndef(\distort, {|pre = 20|
	(\in.ar(0 ! Ndef(\source).numChannels) * pre).distort
}).play(vol: 0.2);
)

// ... make your own, with EQ, other effects, etc.

// patch in
Ndef(\pulseChop) <>>.in Ndef(\distort);

Ndef(\distort).fadeTime = 4; // set crossfade time when replaced

// redefine while it's running
(
Ndef(\distort, {|pre = 20|
	(\in.ar(0 ! Ndef(\source).numChannels) * pre).softclip
})
)
// repatch
Ndef(\distort) <<>.in Ndef(\source);

// auto gui!
NdefMixer(s);

// use s.record, etc. to record output

/// Using Patterns with Ndefs

(
// just plays back
SynthDef(\playbackSimpEnv, {|out = 0, rel = 0.5, pos = 0, rate = 1, level = 0.1|
	var pb;
	// we need to declare the number of channels here since that's fixed when we make the def
	pb = PlayBuf.ar(b.numChannels, b, BufRateScale.kr(b)  * rate, startPos: pos  * BufSampleRate.kr(b)); // pos in seconds
	pb = pb * Env.linen(releaseTime:rel, level: level).kr(2); // shape it with an envelope, kr is a shortcut for EnvGen
	Out.ar(out, pb); //play out bus 0 at rate 1;
}).add;
)

(
~patt = Pbind(
	\instrument, \playbackSimpEnv,
	\dur, Pseq([Pgeom(0.01, 1.1707, 18).trace, 0.1,Pgeom(0.1, 0.94, 100).trace ]), // we use trace to post the vals
	\rel, 0.05
) // don't play here.
)

Ndef(\pattPlayer, ~patt).play; // now you can plug a pattern into an Ndef and use it as one.

// we can also use patterns to control args

(
Ndef(\sourcePatt, {|pos = 0, rate = 1, loop = 0, t_trig = 0|
	PlayBuf.ar(b.numChannels, b, BufRateScale.kr(b)  * rate, t_trig, pos  * BufSampleRate.kr(b), loop);
});

Ndef(\sourcePatt)[1] = \set -> Pbind(\rate, Pbrown(0.9, 1.1, 0.01), \dur, 0.125);

Ndef(\sourcePatt).play
)

/// granulator in an Ndef
p = Platform.resourceDir +/+ "sounds/a11wlk01.wav";
b = Buffer.read(s, p);
// b = Buffer.loadDialog;

(
SynthDef(\sineGrainPosInSeconds, {|rate = 1, sustain = 1, amp = 0.1, pos = 0, out = 0|
	var pb;
	pb = PlayBuf.ar(b.numChannels, b, rate * BufRateScale.kr(b), startPos:pos * BufSampleRate.kr(b), loop:1);
	pb = pb * EnvGen.ar(Env.sine(sustain, amp), doneAction:2);
	OffsetOut.ar(out, pb);
}).add;
)

(
~granPatt = Pbind(\instrument, \sineGrain,
	\dur, Pwhite(0.01, 0.05),
	\legato, Pwhite(4, 6),
	\pos, Pseg(Pseq([0.5, 1.0], inf), Pseq([0.5, 0], inf)),
	\out, Prand([0, 1], inf),
	\rate, Pwhite(0.9, 1.1));
)




Ndef(\granPatt, ~granPatt).play

Ndef(\granPatt).gui


Ndef(\verb, { FreeVerb.ar(Ndef(\granPatt).ar, 1.0, 0.8) }).play(vol: 0.4)