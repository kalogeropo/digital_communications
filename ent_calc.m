function [ent] = ent_calc(new_signal,c)
freq = zeros(1,length(c));
for i=1:length(c)
    freq(i)= sum(new_signal ==c(i));
end
    prob = freq./length(new_signal);
    prob = nonzeros(prob);
    logprob = log(prob);
       % disp(logprob)
    ent = - sum((prob.*logprob));
end

