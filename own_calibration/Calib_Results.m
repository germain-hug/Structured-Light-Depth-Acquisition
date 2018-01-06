% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1439.536287297326226 ; 1311.615282496824420 ];

%-- Principal point:
cc = [ 1351.148046111607073 ; 1555.974666483239389 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.035739713318456 ; -0.003585831361624 ; 0.019537615387307 ; 0.034893752789969 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 115.663339688469335 ; 94.244976583838991 ];

%-- Principal point uncertainty:
cc_error = [ 0.000000000000000 ; 0.000000000000000 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.033119894516470 ; 0.007719449425431 ; 0.011091533084236 ; 0.011186205383230 ; 0.000000000000000 ];

%-- Image size:
nx = 1603;
ny = 1355;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 5;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 0;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -1.892909e+00 ; -2.160802e+00 ; 4.603973e-02 ];
Tc_1  = [ -2.543210e+03 ; -1.767949e+03 ; 2.863513e+03 ];
omc_error_1 = [ 2.959296e-02 ; 1.411944e-02 ; 4.859618e-02 ];
Tc_error_1  = [ 3.195972e+01 ; 2.015284e+01 ; 2.298704e+02 ];

%-- Image #2:
omc_2 = [ -1.689910e+00 ; -2.051673e+00 ; 3.309529e-01 ];
Tc_2  = [ -2.569598e+03 ; -1.368078e+03 ; 2.933288e+03 ];
omc_error_2 = [ 1.695426e-02 ; 2.275634e-02 ; 3.950420e-02 ];
Tc_error_2  = [ 3.254487e+01 ; 1.941099e+01 ; 2.235003e+02 ];

%-- Image #3:
omc_3 = [ -2.179212e+00 ; -2.024478e+00 ; -1.579129e-01 ];
Tc_3  = [ -2.179603e+03 ; -1.323051e+03 ; 2.448942e+03 ];
omc_error_3 = [ 4.104991e-02 ; 9.515079e-03 ; 5.758545e-02 ];
Tc_error_3  = [ 2.502499e+01 ; 1.702309e+01 ; 1.928982e+02 ];

%-- Image #4:
omc_4 = [ -2.000741e+00 ; -2.184780e+00 ; 3.407804e-01 ];
Tc_4  = [ -2.484012e+03 ; -1.649609e+03 ; 2.839303e+03 ];
omc_error_4 = [ 2.381800e-02 ; 1.203011e-02 ; 4.990006e-02 ];
Tc_error_4  = [ 3.449581e+01 ; 2.709604e+01 ; 2.236619e+02 ];

%-- Image #5:
omc_5 = [ -1.831037e+00 ; -1.730280e+00 ; -3.347335e-01 ];
Tc_5  = [ -2.185878e+03 ; -1.160635e+03 ; 3.078625e+03 ];
omc_error_5 = [ 2.335664e-02 ; 2.230691e-02 ; 3.627132e-02 ];
Tc_error_5  = [ 3.503347e+01 ; 1.907056e+01 ; 2.093071e+02 ];

