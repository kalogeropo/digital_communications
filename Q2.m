load cameraman.mat;
imshow(uint8(i));
sample_image = i(:);
%assign dynamicly to zone [-1,1]
sample_image = (sample_image-128)/128;
%temp=sample_image;

%


rev_to_original_zone =(sample_image*128)+128;

% testing the conversion 
%comp= temp == rev_to_original_zone;
%disp(sum(comp))
for j=2:2:4
    gen_name = "samle_image_Qed_";
    filename = strcat(gen_name,num2str(j))
    [z,c,D]=LloydMax(sample_image,j,-1,1);
    new_signal = c(z);
    ent = ent_calc(new_signal,c);
    display (ent)

%reshape
    rev_to_original_zone =(new_signal*128)+128;
    conv_image=reshape(rev_to_original_zone,256,256);
    imshow(uint8(conv_image));
end