function save_ply(d,filename)

fid=fopen(filename,'w');
fprintf(fid, ['ply', '\n']);
fprintf(fid, ['format ascii 1.0\n']);
fprintf(fid, ['element vertex ', num2str(size(find(d(:,:,3)),1)), '\n']);
fprintf(fid, ['property float x', '\n']);
fprintf(fid, ['property float y', '\n']);
fprintf(fid, ['property float z', '\n']);
fprintf(fid, ['end_header', '\n']);


for i=1:size(d,1)
    for j=1:size(d,2)
        if(d(i,j,3)~=0)
            fprintf(fid, '%f %f %f\n', d(i,j,1),d(i,j,2), d(i,j,3));
        end
    end
end
end

