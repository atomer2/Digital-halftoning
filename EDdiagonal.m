%对角线路径
function res =  EDdiagonal(img ,filter , magnitudeOfWn)
img = im2double(img);
sf = size(filter);

% Output image, will be filled pixel by pixel
res = zeros(size(img));

% Zero-padding input image, so that we don't have to deal with edges when
% applying the filter. The extra pixels are removed in the output image
I = padarray(img , sf);
padx = sf(2);
pady = sf(1);
%si = size(I);
sizeOfOriginal=size(img);
% Threshold image and save to output (taking into account the zero
% padding introduced)
oy=1;
ox=1;
while ~( oy==0 && ox==0)       %加入白噪声，magnitudeOfWn是白噪声的强度(0,1)
        threshold = 128 + (128-256 * rand())* magnitudeOfWn; 
        threshold = threshold / 256;
        y=oy+pady;
        x=ox+padx;
        res(oy,ox) = ( I(y,x) > threshold);        
        % Calculate error
        error = double(I(y,x) - res(oy,ox));      
        % Get position where the filter should be applied
        [xmin xmax ymin ymax] = filterPosition(x, y, sf);        
        % Distribute error according to the filter
        I(ymin:ymax, xmin:xmax) = I(ymin:ymax, xmin:xmax) + error * filter;
        [oy,ox]=move(oy,ox,sizeOfOriginal(1),sizeOfOriginal(2));
end
end



function [Ry,Rx] = move(y,x,Ymax,Xmax)
tranEven =[-1,1;0,1;1,0];
tranOdd = [1,-1;1,0;0,1];
index = 1;
if mod(y+x,2)
    for i=1:3
        if(~outOfrange([y,x]+tranOdd(i,:),Xmax,Ymax))
            break;
        end 
        index=index+1;
    end
    if index == 4
        Ry=0;
        Rx=0;
        return;
    else
        k = [y,x] + tranOdd(index,:);
        Ry=k(1);
        Rx=k(2);
    end
else
    for i=1:3
        if(~outOfrange([y,x]+tranEven(i,:),Xmax,Ymax))
            break;
        end 
        index=index+1;
    end
    if index == 4
        Ry=0;
        Rx=0;
        return;
    else
        k = [y,x] + tranEven(index,:);
        Ry=k(1);
        Rx=k(2);
    end        
end
end

function b = outOfrange(xy,Xmax,Ymax)
if xy(1) < 1 || xy(1) > Ymax || xy(2) < 1 || xy(2) > Xmax 
    b = 1;
else
    b= 0;
end
end

