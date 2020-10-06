function [xq, centers, D] = LloydMax(x, N, x_min, x_max)
% ------Lloyd-max:
% inputs: x,N,x_max,x_min
%  x is the input signal as a vector
%  N is the number of bits which will be used (2,4,8)
%  x_min, x_max is the min,max allowed values

%ploting var
plt_vec=[];
centers = [];

%changin all out of bounds values of x
x(x<x_min)=x_min;
x(x>x_max)=x_max;

%0.initialize proccess, random Q_levels,centers uniform q.
range = x_max - x_min;
levels = 2 ^ N;
size_of_sample = length(x);
%display(size_of_sample)
centers(1)=x_min + range/(2*levels);
for i=2:levels
    centers(i)=centers(i-1) + range/levels;
end
%axis consideration as a line (x_min.....C(1)....C(M)....Xmax)
line= [x_min centers x_max];
line = sort(line);
D=[-1,1];
%disp(length( line))

k=2;
while abs(D(k)-D(k-1))>= eps
    xq=[];
%1. Calculate the quanitiser zones as the medium of q_levels  
% the first and the last value of vector T should be the min and max value
% respectivly
    T=[];
    T(1)=line(1);
    for i=2:(length(line)-2)
        T(i) = (line(i) + line(i+1))/2;
    end
    T(i+1) = line(end);
% disp(T)
%2. iterate the signal using calculated zones as before
%   (x_min...T2 ... T(N-1).....x_max)
%   iteration of sample signal x
Distortion_sum = 0;
zonal_sum = zeros(1,length(T)-1);
for signal_index=1:size_of_sample
    %Q_areas
    
    for i=1:(length(line)-1)
        %display(T(i))
        if x(signal_index)>=T(i) && x(signal_index)<=T(i+1) 
           %assign quantum num to result vector 
           %fprintf("zone,[%d],Ti=%f,Ti+1=%f,x(sig)=%f \n",i, T(i), T(i+1), x(signal_index))
           xq(signal_index)=i;
           %calculate distortion @ p341 Proakis.
           Distortion_sum = Distortion_sum +(line(i+1)-x(signal_index))^2;
           
           %calculate zone sum so we can compute the new centers
           zonal_sum(i)=zonal_sum(i)+x(signal_index);
        end
    end
    
end
%debug
%disp(sum(xq(:) == 1))
%disp(sum(xq(:) == 2))
%disp(sum(xq(:) == 3))
%disp(sum(xq(:) == 4)) %expected 0

%new area centers
zones_count= [];
for i=2:(length(line)-1)
    zones_count(i-1) = sum(xq(:) == (i-1));
    if zones_count(i-1) ~=0
    line(i)=zonal_sum(i-1)/zones_count(i-1);
    end
end
%disp(line)
%disp(size(zones_count))
%disp(size(zonal_sum))
new_D=Distortion_sum/size_of_sample;

D=[D new_D];
%disp(D)
k=k+1;
centers=line(2:end-1);
plt_vec(k-2) = sqnr_calc(x,xq,centers);
end
yaxis=(1:k-2);
filename = strcat("SQNR",num2str(levels));
plt_func(plt_vec,yaxis,"No of K","SQNR","SQNR for Lloyd-max iteration",filename)
end