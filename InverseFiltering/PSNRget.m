function PSNR=PSNRget(Image,Image_re)
h=512;w=h;
B=8;
MAX=2^B-1;
Variance=sum(sum((Image-Image_re).^2))/(h*w); %%得到均方差
PSNR=20*log10(MAX/sqrt(Variance));         %%峰值信噪比