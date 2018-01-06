function code_seq = compute_code(seq,own_data)

% This function computes the UV codes from the structured light patterns

[w,h,N] = size(seq);
code_seq = zeros(w,h,2);
T = 0.02; % Unknown classification Threshold

code = seq(:,:,1:2:N) > 0;
bin_seq = [1,2,4,8,16,32,64,128,256,512];

for i=1:w
    for j=1:h
        
        % Compute differences with inverts
        dI = seq(i,j,1:2:N) - seq(i,j,2:2:N);
        gray_u = reshape(dI(1:10) >= 0,10,1);
        gray_v = reshape(dI(11:20) >= 0,10,1);
        
        % Convert to decimal values
        code_seq(i,j,:) = [sum(gray_u.*bin_seq'),sum(gray_v.*bin_seq')];
        
        % Detect Unknown values
         if(sum(dI) == 0 && ~own_data)
            code_seq(i,j,:) = -1; % Mark as unknown
         elseif(abs(sum(dI)) < T && own_data)
            code_seq(i,j,:) = -1; % Mark as unknown
         end
    end
end

end

