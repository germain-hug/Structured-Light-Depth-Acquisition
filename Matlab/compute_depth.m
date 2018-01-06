function d= compute_depth(uv_code, own_calib, own_data, provided_data)

if(own_calib && ~own_data)
    load_synthetic_calib_results;
end
if(own_data)
    load_own_calib;
end
if(~own_calib && ~own_data)
    load_matrices;
end
if(provided_data)
    load_real_calib;
end

[w,h,~] = size(uv_code);
d = zeros(w,h,3);

% Load Intrinsic Matrix
K1 = cam_intrinsic;
K2 = proj_intrinsic;

% Compute Rotation/Translation matrices
R1 = cam_extrinsic(1:3,1:3);
T1 = cam_extrinsic(1:3,4);
R2 = proj_extrinsic(1:3,1:3);
T2 = proj_extrinsic(1:3,4);


% For each point solve the linear system
for i=1:w
    for j=1:h
        if(uv_code(i,j,1)~=-1)
            % Compute A and b
            A = zeros(4,3);
            b = zeros(4,1);
            
            % Convert points to normalized camera coordinates
            p1 = K1\[j;i;1];
            p2 = K2\[uv_code(i,j,2); uv_code(i,j,1);1];
            
            % Compute linear constraints -> Camera
            A(1,:) = [R1(3,1)*p1(1)-R1(1,1), R1(3,2)*p1(1)-R1(1,2), R1(3,3)*p1(1)-R1(1,3)];
            A(2,:) = [R1(3,1)*p1(2)-R1(2,1), R1(3,2)*p1(2)-R1(2,2), R1(3,3)*p1(2)-R1(2,3)];
            b(1:2) = [T1(1)-T1(3)*p1(1), T1(2)-T1(3)*p1(2)];
            
            % Compute linear constraints -> Projector (~ camera no.2)
            A(3,:) = [R2(3,1)*p2(1)-R2(1,1), R2(3,2)*p2(1)-R2(1,2), R2(3,3)*p2(1)-R2(1,3)];
            A(4,:) = [R2(3,1)*p2(2)-R2(2,1), R2(3,2)*p2(2)-R2(2,2), R2(3,3)*p2(2)-R2(2,3)];
            b(3:4) = [T2(1)-T2(3)*p2(1), T2(2)-T2(3)*p2(2)];
            
            % Compute the least squares solution
            x = A\b;
            
            % Store Depth
            d(i,j,:) = cam_extrinsic(1:3,1:4)*[x;1];
        end
    end
end

end

