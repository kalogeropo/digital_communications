function [bin_out] = demapper(Sm,map,M)
disp(map)
M=log2(M);
for i=length(map):-1 : 1
    Sm(Sm == map(i,2))=map(i,1);
end
bin_out = de2bi(Sm(1),M,"left-msb"); 
debug = Sm(1);
for i=2:length(Sm)
    nik = Sm(i);
    temp = de2bi(Sm(i),M,"left-msb");
    bin_out = [bin_out temp ];
    debug = [debug nik];
end
end

