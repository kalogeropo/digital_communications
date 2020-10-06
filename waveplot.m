function []  = waveplot(sample,y,Fs,filename)
%WAVEPLOT Summary of this function goes here
%   Detailed explanation goes here
info = audioinfo(sample);

t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);
f=figure();
plot(t,y)
xlabel('Time')
ylabel('Audio Signal')
saveas(f,filename,"png")
end

