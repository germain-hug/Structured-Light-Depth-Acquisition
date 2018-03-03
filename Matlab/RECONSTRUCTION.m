clear all; close all; clc;

% =======================================================
own_calib = 1; % (provide/estimated calib. - for synthetic scenes only)
own_data  = 1; % To use the own captured real data
provided_data = 0; % To use the provided real data
folder = 'notebook_T1'; ext = 'png';
% =======================================================

if(own_data)
    % Choose either 'shoe_T1' or 'bathroom_T1' :
    folder = 'shoe_T1'; ext = 'jpg';
end

if(provided_data)
    % Choose either 'real_crayon_dalek' or 'real_tea' :
    folder = 'real_tea'; ext = 'jpg';
end

% ---- Load Projected Cube Sequence
fprintf('Loading Sequences...');
if(~provided_data)
    seq  = load_sequence_color(folder,'00',0,39,2,ext);
end

if(provided_data)
    seq  = load_sequence_color(folder,'IMG_',9377,9416,4,ext);
end

[w,h,~,N] = size(seq);
fprintf('done\n');

% ---- Convert Sequences to Grayscale
seq  = convert2gray(seq);

% ---- Compute Binary Codes
fprintf('Compute (u,v) codes...');
uv_code = compute_code(seq,own_data);
fprintf('done\n');

% ---- Smooth UV Codes
% fprintf('Smoothing codes...');
% clear seq;
% uv_code = smooth_code(uv_code);
% fprintf('done\n');


% ---- Compute 3D Point Cloud
fprintf('Computing 3D Point Cloud...');
d = compute_depth(uv_code,own_calib, own_data, provided_data);
fprintf('done\n');

% ---- Write PLY File
fprintf('Writing PLY File...');
clear uv_code;
if(own_calib)
    save_ply(d,strcat(folder,'_own_calib.txt'));
else
    save_ply(d,strcat(folder,'.txt'));
end
fprintf('done\n');
