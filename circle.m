%rectangle('Position',[100,100,10,10],'Curvature',[1,1],  'FaceColor','r');
hold on;
x=1:256;
y=1:256;
[R C]=meshgrid(x,y);
%plot(R(:),C(:),'.');
Cx=13.5;
Cy=13.5;
Cr=1:13;
Cv=[Cx-Cr;Cy-Cr];
jz=ones(2,13);
jz=jz*13.5;
jz=jz-Cv;
Cv=Cv.*2;
jz=[jz;Cv];
% for i=1:13
% rectangle('Position',jz(:,i),'Curvature',[1,1]);
% end
%��������Բ����ֱ��
num=floor(((256-128.5)^2*2)^0.5+0.5);
%����ÿ��Բ���ڵĵ����Ŀ
Nr=zeros(1,num);
%����Ԫ��������ÿ��Բ���ڵĵ�����꣬�����Ͳ����ظ�������
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
plot(1:num,Nr);


