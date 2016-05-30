function O = errorDiffusion(I, type)
% O = errorDiffusion(I, type)
% Error diffusion method for image dithering.
% I: The input image
% type: 1 or 2
%		type = 1: Floyd & Steinberg filter
%		type = 2: Stucki filter
%
% Written by Michalis Zervos - All rights reserved
% http://michal.is/projects/image-dithering-in-matlab/


if (type == 1)
	% Floyd & Steinberg filter
	F = [0 0 7;
		 3 5 1];
	F = 1/sum(F(:)) .* F;

elseif (type == 2)
	% Stucki filter
	F = [0 0 0 8 4;
		 2 4 8 4 2;
		 1 2 4 2 1];
	F = 1/sum(F(:)) .* F;
else
	fprintf('Error. Type should be one of the following:\n');
	fprintf('1 for Floyd & Steinberg\n');
	fprintf('2 for Stucki\n');
	O = zeros(1,1);
	return;
end

I = im2double(I);
threshold = 0.5;

sf = size(F);

% Output image, will be filled pixel by pixel
O = zeros(size(I));

% Zero-padding input image, so that we don't have to deal with edges when
% applying the filter. The extra pixels are removed in the output image
I = padarray(I, sf);
padx = sf(2);
pady = sf(1);

si = size(I);


% For each pixel of the images (disregarding the zero-padded ones)
for y = pady+1:si(1)-pady
    for x = padx+1:si(2)-padx
        
        % Threshold image and save to output (taking into account the zero
        % padding introduced)
        oy = y - pady;
        ox = x - padx;
        O(oy,ox) = (I(y,x) >= threshold);
        
        % Calculate error
        error = double(I(y,x) - O(oy,ox));
        
        % Get position where the filter should be applied
        [xmin ,xmax ,ymin ,ymax] = filterPosition(x, y, sf);
        
        % Distribute error according to the filter
        I(ymin:ymax, xmin:xmax) = I(ymin:ymax, xmin:xmax) + error * F;
    end
end

end

% Rectangle of image where the filter should be applied, based on the
% current processed pixel (x,y)
function [xmin, xmax, ymin, ymax] = filterPosition(x, y, sf)
    k = floor(sf(2)/2);

    ymin = y;
    ymax = y + sf(1) - 1;
    xmin = x - (sf(2) - k - 1);
    xmax = x + k;

end