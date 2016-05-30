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



testImg = ones(2580,5160);
greyL=15/16;
testImg = testImg * greyL;
testImgAfterED = errorDiffusion(testImg,1);
figure(3);imshow(testImgAfterED);
%imshow(testImgAfterED,[0 1]);

RAPS=zeros(1,num);

for interval=266:256:2315
    Rmean=zeros(1,num);
    sample256=testImgAfterED(1500:1755,interval:interval+255);
    figure(1),imshow(sample256,[0 ,1]);

    sample256 = fft2(sample256);
    sample256 = fftshift(sample256);
    sample256 =(abs(sample256)).^2/256^2;
    for i=1:num
        for j=1:length(pointsX{i})
            Rmean(i)= Rmean(i) + sample256(pointsY{i}(j),pointsX{i}(j));
        end
        Rmean(i)=Rmean(i)/length(pointsX{i});
    end
    RAPS= RAPS + Rmean;
end
RAPS = RAPS /9/(greyL*(1-greyL));
%RAPS =log(RAPS);
figure(2),plot(2:num,RAPS(2:num));
axis([0 180 0 6]);
set(gca,'ytick',0:1:4)


