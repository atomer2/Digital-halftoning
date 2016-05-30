function res =  EDnormal(img ,filter , magnitudeOfWn)
img = im2double(img);
sf = size(filter);

% Output image, will be filled pixel by pixel
res = zeros(size(img));

% Zero-padding input image, so that we don't have to deal with edges when
% applying the filter. The extra pixels are removed in the output image
I = padarray(img , sf);
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
        %加入白噪声，magnitudeOfWn是白噪声的强度
        threshold = 128 + (128-256 * rand())* magnitudeOfWn; 
        threshold = threshold / 256;
        res(oy,ox) = ( I(y,x) > threshold);
        
        % Calculate error
        error = double(I(y,x) -res(oy,ox));
        
        % Get position where the filter should be applied
        [xmin xmax ymin ymax] = filterPosition(x, y, sf);
        
        % Distribute error according to the filter
        I(ymin:ymax, xmin:xmax) = I(ymin:ymax, xmin:xmax) + error * filter;
    end
end

end


    
