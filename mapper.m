function [Sm,Am] = mapper(bits,M)
%Am stands for A Map and not the Amplitude of m
bits_per_symbol = log2(M);
pam_canst_axis = [M+1:2:-1 1:2:M-1]
f_p_c_axis = zeros(1,2*length(pam_canst_axis));
for i=1:length(pam_canst_axis)
f_p_c_axis(i)= -pam_canst_axis(length(pam_canst_axis)+1 - i);
f_p_c_axis(i+length(pam_canst_axis))=pam_canst_axis(i);
end
disp(f_p_c_axis)
%MAPPER Summary of this function goes here
%   we are mapping the values of Am for our perpose
%   this is a simple mapper method - a gray code method 
%   is used in graymapper 
Am=zeros(length(f_p_c_axis),2);
for i=1:length(f_p_c_axis)
Am(i,1)= i-1;
Am(i,2)= f_p_c_axis(i);
end
disp(Am);
bits = vec2mat(bits,bits_per_symbol);
dec_bits = bi2de(bits,"left-msb");

for i=1:length(Am)
    dec_bits(dec_bits == Am(i,1)) = Am(i,2);
end
Sm = dec_bits;
end

