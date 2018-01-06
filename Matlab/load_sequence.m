function output = load_sequence(path, prefix, first, last, digits, suffix)

%
% Read a sequence of images, convert them in gray level and returns the
% data in a matrix
% 
% Arguments:
%
% path: path of the files
% prefix: prefix of the filename
% first: first frame
% last: last frame
% digits: number of digits of the frame number
% suffix: suffix of the filename
%
% Example:
%
% mov = load_sequence('../images','myimage', 0, 10, 4, 'png')
%   -> that will load images from '../images/myimage0000.png' to '../images/myimage0010.png'
%
% mov = load_sequence('../images/','myimage', 42, 42, 2, 'png')
%   -> that will load only one image: '../images/myimage42.png'
%

% Get the padded frame number
number = padded_number(first, digits);

% Check for slash at the end of the path
if(path(end)=='/')
    slash='';
else
    slash='/';
end

% Create the filename
filename = strcat(path,slash,prefix,number,'.',suffix);

% Load image and convert it to gray level
current = imread(filename);

% Print filename
% sprintf('file=%s\n',filename)

% Create output matrix
output = uint8(zeros(size(current,1), size(current,2), last-first+1));
output(:,:,1) = current;

for i=2:last-first+1
    
    % Get the padded frame number
    number = padded_number(first+i-1, digits);
    
    % Create the filename
    filename = strcat(path,slash,prefix,number,'.',suffix);
    
    % Load image and convert it to gray level
    current = imread(filename);
    
    % Update output matrix
    output(:,:,i) = current;
    
    % Print filename
	% sprintf('file=%s\n',filename)
    
end

end

function output = padded_number(number, digits)

%
% Add zeros to the left of the number to match the given length
%

% Convert to string
output = num2str(number);
    
% Get length of string
l = size(output,2);
    
% Add necessary zeros
for i=l+1:digits
    
    output=strcat('0', output);
    
end

end
