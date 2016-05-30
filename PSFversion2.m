greyL = 1/8;
RAPS = ones(1,num);
Ani = ones(1,num);
Ani = Ani * -10;
subplot(2 ,1 ,1);

plot(1/256:1/256:num/256,RAPS(1:num));
hold on;
plot(greyL^0.5,0,'*');
text(greyL^0.5,0.5,'\it{f}_{p}');
title('Radially Averaged Power Spectra');
y1=ylabel('\it{P}_{r}(\it{f}_{r})/\sigma_{g}^{2}');
%set(y1,'Rotation',90);
axis([1/256 num/256 0 6]);
set(gca,'ytick',0:2:6);
subplot(2,1,2);
plot(1/256:1/256:num/256,Ani(1:num),'r--');
axis([1/256 num/256 -20 20]);
set(gca,'ytick',-20:10:20);
ylabel('Anisotropy(dB)');
title('Anisotropy');


