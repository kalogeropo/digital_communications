function [SQNR] = sqnr_calc(x,xq,centers)
xq=xq';

x_prog = centers(xq);
%SNR_PLOT_CALC calculates SNR, mode=2
%SQNR = E[X^2]/E[X*^2]
%E[X^2]=mean(sample_signal_vec(i)^2), E[X*^2]=mean(x -x~)^2
S= mean(x.^2);
temp= x-x_prog';
N = mean(temp.^2);
SQNR = 10 * log10(S/N);
%fprintf("sqnr = %f\n",SQNR)

end

