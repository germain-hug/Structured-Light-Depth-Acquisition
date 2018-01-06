function new_seq = convert2gray(seq)

[w,h,~,N] = size(seq);
new_seq = zeros(w,h,N);

for i=1:N
    new_seq(:,:,i) = rgb2gray(seq(:,:,:,i));
end

end

