function dec = gc2dec( gra )

s2 = size(gra,2);%num of columns in the input vector
bin = (zeros(1,s2));

%gray to binary conversion
    for j2 = s2:-1:2
        temp = mod(sum(gra(1,1:j2-1)),2);
        if temp == 1
            bin(j2) = (1 - gra(1,j2));
        else
            bin(j2) = (gra(1,j2));
        end
    end    
    bin(1) = (gra(1,1));
    dec = sum(bin.*([512,256,128,64,32,16,8,4,2,1]));

end

