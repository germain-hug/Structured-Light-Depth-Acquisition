function new_code_cube = smooth_code(code_cube)
[w,h,~] = size(code_cube);
new_code_cube = zeros(w,h,2);

N = 9;
window = gausswin(N)/sum(gausswin(N));

% Smooth U Codes vertically
for i = 1:h
    new_code_cube(:,i,1) = conv(code_cube(:,i,1),window,'same');
end


% Smooth V Codes horizontally
for i = 1:w
    new_code_cube(i,:,2) = conv(code_cube(i,:,2),window,'same');
end



end

