% 这个文件用于测试wasatch的加网效果

num=floor(((256-128.5)^2*2)^0.5+0.5);
% 保存每个圆环内的点的数目
Nr=zeros(1,num);
% 建立元胞，保存每个圆环内的点的坐标，这样就不用重复计算了
pointsX=cell(1,num);
pointsY=cell(1,num);
for xx=1:256
    for yy=1:256
        tmp=floor(((xx-128.5)^2+(yy-128.5)^2)^0.5+0.5);
        Nr(tmp)=Nr(tmp)+1;
        pointsX{tmp}=[pointsX{tmp} ,xx];
        pointsY{tmp}=[pointsY{tmp} ,yy];        
    end
end

ttt=imread('test.bmp');
ttt=im2double(ttt);
greyL=1/2;
testImg = ttt;

Anisotropy=zeros(1,num);
AnisotropyCell=cell(1,num);



Rmean=zeros(1,num);
sample256=testImg;   

sample256 = fft2(sample256);
sample256 = fftshift(sample256);
sample256 =(abs(sample256)).^2/256^2;
for i=1:num
     for j=1:length(pointsX{i})
            val = sample256(pointsY{i}(j),pointsX{i}(j));
            Rmean(i)= Rmean(i) + val;
            AnisotropyCell{i}=[AnisotropyCell{i},sample256(pointsY{i}(j),pointsX{i}(j))];   
     end
    Rmean(i)=Rmean(i)/length(pointsX{i});
    Anisotropy(i)=var(AnisotropyCell{i})/Rmean(i)^2;
end
Anisotropy=log10(Anisotropy);
Rmean=Rmean/greyL*(1-greyL);
subplot(2 ,1 ,1);
plot(2:num,Rmean(2:num));
title('Radially Averaged Power Spectra');
y1=ylabel('\it{P}_{r}(\it{f}_{r})/\sigma_{g}^{2}');
%set(y1,'Rotation',90);
axis([0 180 0 4]);
set(gca,'ytick',0:1:4);
subplot(2,1,2);
plot(2:num,Anisotropy(2:num));
title('Anosotropy');

