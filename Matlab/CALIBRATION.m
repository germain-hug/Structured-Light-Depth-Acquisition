% This file performs the Camera/Projector Calibration

function CALIBRATION

% ------ Camera Reprojection
clear all; close all; clc;

    % Synthetic Scenes
    for l=0:2:5
        I_0 = imread(strcat('calibration/000',num2str(l),'.png'));
        I_1 = imread(strcat('calibration/000',num2str(l+1),'.png'));
        path = strcat('calibration/000',num2str(l+1),'_reprojected.png');
        reproject_image(I_0, I_1, 1024, 768, 378,277, 270, path, true);
    end

    % Real (provided) Scenes
    for l=1:9
        I_0 = imread(strcat('real_calibration/IMG_932',num2str(l),'.jpg'));
        I_1 = imread(strcat('real_calibration/IMG_932',num2str(l),'.jpg'));
        path = strcat('real_calibration/IMG_932',num2str(l),'_reprojected.jpg');
        reproject_image(I_0, I_1, 1024, 768, 518,120, 299, path, true);
    end

    % Real (shot) Scenes
    for l=1:5
        I_0 = imread(strcat('own_calibration/IMG_124',num2str(l+1),'.jpg'));
        I_1 = imread(strcat('own_calibration/IMG_124',num2str(l+1),'.jpg'));
        path = strcat('own_calibration/IMG__proj_124',num2str(l+1),'.jpg');
        reproject_image(I_0, I_1, 1280, 800, 440, 200, 400, path, false);
    end




function reproject_image(I_0, I_1, w_p, h_p, x_0, y_0, dx, path, resize)

% =========== Parameters ============
% I_0 : Input Image (projected)
% I_1 : Output Image (to be rectified)
% [w_p,h_p] : Output Image Size
% [x_0,y_0] : Checkerboard Offset
% dx : Checkerboard Size (pixels)
% ====================================

% Enter Four Corners
figure
imshow(I_0);
title('Select Corners');
[x, y] = getline(gcf);
close all;

% Compute Homography
pts1Cart =  [x(1:4)';y(1:4)'];
pts2Cart =  [x_0,  x_0+dx, x_0+dx, x_0;...
             y_0,  y_0,    y_0+dx, y_0+dx];

% Estimate Homography
HEst = calcBestHomography(pts1Cart, pts2Cart);

% Reproject Image
t = maketform('projective',HEst');
if(resize)
    I_0_out = imtransform(I_0,t,'XData',[1 w_p], 'YData', [1 h_p]);
    I_1_out = imtransform(I_1,t,'XData',[1 w_p], 'YData', [1 h_p]);
else
    I_0_out = imtransform(I_0,t);
    I_1_out = imtransform(I_1,t);
end

% Save Image
imwrite(I_1_out,path);


%% Plotting
% figure
% subplot(2,2,1)
% imshow(I_0); title('Original Projected Image');
% subplot(2,2,2)
% imshow(I_1); title('Original Checkerboard Image');
% subplot(2,2,3)
% imshow(I_0_out); title('Rectified Projected Image');
% subplot(2,2,4)
% imshow(I_1_out); title('Reprojected Checkerboard Image');


%% ==========================================================================
function H = calcBestHomography(pts1Cart, pts2Cart)

pts1Cart = [pts1Cart; ones(1,size(pts1Cart,2))];
pts2Cart = [pts2Cart; ones(1,size(pts2Cart,2))];

A = zeros(2*size(pts1Cart,2),9);
for i = 1:size(pts1Cart,2)
    ui = pts1Cart(1,i);
    vi = pts1Cart(2,i);
    xi = pts2Cart(1,i);
    yi = pts2Cart(2,i);
    A(2*i-1,:) = [0,0,0,-ui,-vi,-1,yi*ui,yi*vi,yi];
    A(2*i,:) = [ui,vi,1,0,0,0,-xi*ui,-xi*vi,-xi];
end

h = solveAXEqualsZero(A);
H = reshape(h,[3,3])';

%% ==========================================================================
function x = solveAXEqualsZero(A)
[~,~,V] = svd(A);
x = V(:,end);
