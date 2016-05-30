% Img = imread( 'gray31.bmp' );
% Y=fft2(Img);
% Y=fftshift(Y);
% Y=log(abs(Y));
% t = errorDiffusion(Img,2);
% OP = fft2(t);
% OP = fftshift(OP);
% margin=log(abs(OP));
% subplot(2,2,1),imshow(Img),title('‘≠Õº');
% subplot(2,2,2),imshow(Y,[]),title('‘≠Õº∏µ¿Ô“∂±‰ªª');
% subplot(2,2,3),imshow(t),title('ŒÛ≤Ó¿©…¢¥¶¿Ì');
% subplot(2,2,4),imshow(margin,[]),title('ŒÛ≤Ó¿©…¢∏µ¿Ô“∂±‰ªª');


% F1=[0,1/3;1/3,1/3];
% F2=[0,1/2;1/4,1/4];
% F3=[0,9/10;1/20,1/20];
% Img = imread( 'gray31.bmp' );
% omg=EDdiagonal(Img,F3,0.9);
%  %omg=EDserpentine(Img,F2,1);
% %omg=EDnormal(Img,F3,1);
% imshow(omg);
% 
%  OP = fft2(omg);
%  OP = fftshift(OP);
%  OP = abs(OP);
%  a = sum(OP(230:281,230:281));
%  a = sum(a);
%  b = sum(OP(:));
%  b=sum(b);
% c=a/b;
% disp(c);
 
 
%  margin=log(OP);
%  imshow(margin,[]);


testImg = ones(2580, 276);
greyL = 5/8;
testImg = testImg * greyL;
imwrite(testImg,'ht.bmp');

%testImgAfterED = errorDiffusion(testImg,1);
%imshow(testImgAfterED);