b = Buffer.loadDialog; // load a soundfile for processing
b.postln; // check details after load

p = Platform.resourceDir +/+ "sounds/a11wlk01.wav";
c = Buffer.read(s, p);

(
Ndef(\autotune, {|pos = 0, rate = 1, loop = 0, t_trig = 0|
	var pb, pitchSource, freqpb, freqps;
	pb = PlayBuf.ar(b.numChannels, b, BufRateScale.kr(b)  * rate, t_trig, pos  * BufSampleRate.kr(b), loop);
	pitchSource = Mix(PlayBuf.ar(c.numChannels, c, BufRateScale.kr(c)  * rate, t_trig, pos  * BufSampleRate.kr(c), loop));

	freqpb = Pitch.kr(pb)[0];
	freqps = Pitch.kr(pitchSource)[0];

	PitchShift.ar(pb, pitchRatio:freqps/freqpb);
}).play;
)

Ndef(\autotune).set(\t_trig, 1);

Ndef(\autotune).set(\loop, 1);

(
Ndef(\filterByAmp, {|pos = 0, rate = 1, loop = 0, t_trig = 0, scaleAmp = 1, topFreq = 440, rq = 0.1|
	var pb, amp;
	pb = PlayBuf.ar(b.numChannels, b, BufRateScale.kr(b)  * rate, t_trig, pos  * BufSampleRate.kr(b), loop);
	amp = Amplitude.kr(pb, mul:scaleAmp).poll(label:\amp);
	RLPF.ar(pb, (topFreq * amp).clip(0, topFreq).lag(0.5).poll(label:\freq), rq);
}).play(vol: 0.2);
)

Ndef(\filterByAmp).gui

// use demo file here
(
Ndef(\filterByPitch, {|pos = 0, rate = 1, loop = 0, t_trig = 0, fade = 0, rq = 0.1, pitchScale = 1, lag = 0.2|
	var pb, pitch;
	pb = PlayBuf.ar(c.numChannels, c, BufRateScale.kr(c)  * rate, t_trig, pos  * BufSampleRate.kr(c), loop);
	pitch = Pitch.kr(pb, median:5)[0] * pitchScale;
	XFade2.ar(BPF.ar(pb, pitch.lag(lag), rq), pb, fade);
}).play(vol: 0.5);
)

Ndef(\filterByPitch).gui

(
Ndef(\pitchWobble, {|pos = 0, rate = 1, loop = 0, t_trig = 0, scaleAmp = 1, rateNoise = 4|
	var pb, amp;
	pb = PlayBuf.ar(b.numChannels, b, BufRateScale.kr(b)  * rate, t_trig, pos  * BufSampleRate.kr(b), loop);
	pb = pb * LFNoise2.kr(rateNoise).range(0.9, 1.1); // make some amp variations
	amp = Amplitude.kr(pb, mul:scaleAmp).poll(label:\amp);
	PitchShift.ar(pb, pitchRatio: LFNoise2.kr(rateNoise, amp, 1))
}).play(vol: 0.2);

Ndef(\pitchWobble2, {|pos = 0, rate = 1, loop = 0, t_trig = 0, scaleAmp = 1, rateNoise = 4|
	var pb, amp;
	pb = PlayBuf.ar(b.numChannels, b, BufRateScale.kr(b)  * rate, t_trig, pos  * BufSampleRate.kr(b), loop);
	pb = pb * LFNoise2.kr(rateNoise).range(0.9, 1.1); // make some amp variations
	amp = Amplitude.kr(pb, mul:scaleAmp).poll(label:\amp);
	PitchShift.ar(pb, pitchRatio: LFNoise2.kr(rateNoise, amp, 1))
}).play(vol: 0.2, out: 1);
)

Ndef(\pitchWobble).gui


Ndef(\pitchWobble).set(\t_trig, 1); Ndef(\pitchWobble2).set(\t_trig, 1);