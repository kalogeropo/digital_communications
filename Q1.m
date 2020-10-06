sample = 'speech.wav';

[y,Fs] = audioread(sample);

%waveplot just visualize our sample data
samplefilename=sample(1:end-4)
waveplot(sample,y,Fs,samplefilename);
for i=2:2:8
    gen_name = "samle_Qed_";
    filename = strcat(gen_name,num2str(i))
[z,c,D]=LloydMax(y,i,-1,1);

new_signal = c(z);
ent = ent_calc(new_signal,c);
display (ent)

%A simple audio test
audio_test = audioplayer(new_signal, Fs);
%play(audio_test)
waveplot(sample,new_signal,Fs,filename);

end