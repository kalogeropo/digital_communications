sample = 'speech.wav';

[y,Fs] = audioread(sample);

[z,c,D]=LloydMax(y,2,-1,1);

new_signal = c(z);
[ent,prob] = ent_calc2(new_signal,c);
disp(prob)
%disp(sum(prob)) %check if sum==1 
temp=(y'-new_signal).^2;
average_distortion = mean(temp);
%Generate a bell-curve histogram from Gaussian data 
%and fitting our data in it.
Theory_prob=hist(new_signal,c);
Theory_prob=Theory_prob./length(y);


