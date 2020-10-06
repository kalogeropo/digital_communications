

M=4; 
%M=8 

% lets create our binary input
% lb = 10000 - 1000000

lb = 10000;
bin_in = randi([0 1],1,lb);

bin_in =[1 0 0 1 1 0 0 0 1 0 1 0 ] %Test input #DEBUG

[test,Am] = mapper(bin_in,M);
%disp(Am)
Tsymbol = 4*(10^(-6));
Fc = 2.5*10^6;
Ts = 10^(-7);
disp(Tsymbol/Ts)
time_axis = 0:Ts:(Tsymbol*length(test));
pulse_A = sqrt(2/Tsymbol);

p_test = test*pulse_A;
pulse_gen=zeros(1,length(time_axis));
z=1;


%disp(length(pulse_gen)/40)
for i=1:Tsymbol/Ts:length(pulse_gen)-1
    for j=i:(i+Tsymbol/Ts)
        pulse_gen(j)=p_test(z);
    end
    z=z+1;
end
figure(1)

subplot(2,2,1)  
plot(time_axis,pulse_gen)
title("pulse")
hold on 
cosine_funct =cos(2*pi*Fc*time_axis);
%basis function calc- 
y=cosine_funct*pulse_A;
signal_without_wnoinse = cosine_funct .* pulse_gen;


subplot(2,2,2)
plot(time_axis,signal_without_wnoinse)
title("signal")
hold on
%noise gen
snr=0:2:20;
%hypothesis:
%adding AWNG we are creating 11 different signals
%sig= s(t)+n(t)
%signals=[];
symbols = [];
bins= [];

for ii=1:length(snr)
sig = awgn(signal_without_wnoinse,snr(ii)) ;

%subplot(2,2,3)
%plot(time_axis,sig)
%title("signal with noise which is recived")
%hold on
hold off
%plot(time_axis(1:100),signals(1,1:100))


test1 = sig.*y;
%subplot(2,2,4)
%plot(time_axis,test1)
%title("sig after demod")
%hold off
new_Sm=[];
disp(length(test1))
z=1;
for i=1:Tsymbol/Ts:length(pulse_gen)-1
    new_Sm(z)=sum(test1(i:i+Tsymbol/Ts));
    z=z+1;
end
new_Sm=new_Sm./10^4;
old_sm=Am(:,2);
newlist=zeros(1,length(new_Sm));
for i=1:length(new_Sm)
    dif=(-old_sm+new_Sm(i)).^2;
    [minimum,I]=min(dif);
    %I = find(minimum)
    newlist(i)= old_sm(I);
end

%for Ser
count =0;
for i = 1:length(newlist)
  if test(i) == newlist(i)   
      count =count +1;
  end
  
end
symbols=[symbols count];


%for Ber 
bin_out = demapper(newlist,Am,M);

%debug
v = bin_in-bin_out(1:end);
test_v=sum(v == 0);%need to be equal to the length of input
bins=[bins test_v];
end
disp(length(test))
ber =bins./length(bin_out);
ser = symbols./length(test);
ber_axis_x=[0:length(bin_out)-2];
ser_axis_x=[0:length(test)-1];
figure(2)
semilogy(ber_axis_x,ber)
title("BER diagram")
figure(3)
semilogy(ser_axis_x,ser)
title("SER diagram")

