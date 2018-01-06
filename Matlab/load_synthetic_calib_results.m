% Loads the calibration results obtained from calib_gui 
% on synthetic calibration

load('calibration_jpg/Calib_Results_Camera.mat');
cam_intrinsic = KK;
cam_extrinsic = [Rc_1,Tc_1];
cam_projection = cam_intrinsic*cam_extrinsic;

load('calibration_jpg/Calib_Results_Proj.mat');
proj_intrinsic = KK;
proj_extrinsic = [Rc_1,Tc_1];
proj_projection = proj_intrinsic*proj_extrinsic;