num=floor(((256-128.5)^2*2)^0.5+0.5);
Nr=zeros(1,num);
%将样本点保存起来，这样就不用每次都计算了
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

Anisotropy = zeros(1,num);
AnisotropyCell = cell(1,num);


testImg = imread('ht.bmp');

greyL = 5/8;
RAPS = zeros(1,num);


%% 进行谱估计
% 通过平均周期图法进行谱估计，因为误差扩散在边缘处会有
% 不稳定的现象，所以要在离边缘足够远的地方取样
leftMargin = 10;
topMargin = 10;
% 样品分段的段数
N = 5;
powerSpectrumEstimate=zeros(256,256);
for i = 0:N-1
    sample256 = testImg( (topMargin + i * 256):( topMargin + i * 256 + 255),leftMargin:leftMargin + 255);
    sample256 = fft2(sample256);
    sample256 = fftshift(sample256);
    sample256 = (abs(sample256)).^2/256^2;
    powerSpectrumEstimate = powerSpectrumEstimate + sample256;
end
powerSpectrumEstimate = powerSpectrumEstimate / N;

%% 求径向平均功率谱(RSPD）及各向异性(Anisotropy)

% 不计算直流成分，也就是i==1
for i=2:num
        for j=1:length(pointsX{i})
            val = powerSpectrumEstimate(pointsY{i}(j),pointsX{i}(j));
            RAPS(i)= RAPS(i) + val;
            AnisotropyCell{i}=[AnisotropyCell{i},powerSpectrumEstimate(pointsY{i}(j),pointsX{i}(j))];           
        end
        RAPS(i)=RAPS(i)/length(pointsX{i});
        Anisotropy(i)=var(AnisotropyCell{i})/RAPS(i)^2;
end

RAPS = RAPS / (greyL*(1-greyL));
%Anisotropy的范围可以较大，所以纵坐标取分贝
Anisotropy  = 20 * log10(Anisotropy);

%% 绘制图像
% RASP
subplot(2 ,1 ,1);
plot(1/256:1/256:num/256,RAPS(1:num));
hold on;

if greyL > 0.5
    greyL = 1 - greyL;
end

plot(greyL^0.5,0,'*');
text(greyL^0.5,0.5,'\it{f}_{p}');
axis([1/256 num/256 0 6]);
set(gca,'ytick',0:2:6);
title('Radially Averaged Power Spectra');
ylabel('\it{P}_{r}(\it{f}_{r})/\sigma_{g}^{2}');

% Anisotropy
subplot(2,1,2);
plot(1/256:1/256:num/256,Anisotropy(1:num));
hold on;
plot([1/256 num/256],[-10 -10],'g--');
axis([1/256 num/256 -20 20]);
set(gca,'ytick',-20:10:20);
ylabel('Anisotropy(dB)');
title('Anisotropy');

