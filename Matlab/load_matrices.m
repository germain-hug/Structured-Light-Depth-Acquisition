% Read from JSON Files

M = loadjson('synthetic.matrices');

cam_intrinsic  = M{1}.intrinsic;
cam_extrinsic  = M{1}.extrinsic;
cam_projection = M{1}.projection;

proj_intrinsic = M{2}.intrinsic;
proj_extrinsic = M{2}.extrinsic;
proj_projection = M{2}.projection;


