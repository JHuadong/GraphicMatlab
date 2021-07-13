

Lenaorigin=imread('lena.png');      %%读取图像
figure(1)
imshow(Lenaorigin);                 %%不限制图像的灰度范围进行原图显示
Lenadou=im2double(Lenaorigin);      %%对图像数据进行双精度处理
title('未进行处理的图像');


%%%%%%%%%%%%%%%%%%FFT变换,DCT变换，哈德曼变换的结果显示%%%%%%%%%%
%%
Lena_fft=fftshift(fft2(Lenadou));   %%对原图进行2维傅里叶变换
Lena_fft1=log10(abs(Lena_fft)+1);     %%图像的频谱随着频率增加衰减的很厉害，所以用这个函数来替代，
                                      %%下同理
figure(2)      
subplot(1,3,1);
imshow(Lena_fft1);                   %%显示二维傅里叶变换的结果
title('FFT结果');

Lena_dct=dct2(Lenadou);                       %%对图像进行二维离散余弦变换
Lena_dct1=im2uint8(abs(Lena_dct));   %%对二维离散余弦变换图像进行8位无符号整型量化
subplot(1,3,2);
imshow(Lena_dct1);                            %%显示二维离散余弦变换的结果
title('DCT结果');

Hadema=hadamard(512);               %%产生一个512*512的哈德曼方阵
Lena_hadema=Hadema*Lenadou*Hadema/512;%%利用公式G=HFH，其中G为变换的结果，F为原始图像，H为变换矩阵
Lena_hadema1=im2uint8(log10(abs(Lena_hadema)+1)); %%对哈德曼变换图像进行8位无符号整型量化
subplot(1,3,3);
imshow(Lena_hadema1);               %%显示哈德曼变换的结果
title('哈德曼变换结果');
%%

%%%%%%%%%%%%%%%%%%%%%%%%%对变换图像的95%小值置零，逆变换并比较结果%%%%%%%%%%%%%%%%%%%%%%%%
Nuzero=0.95;

%%                     
figure(3)                                  
m1=abs(Lena_fft(:));                        %%m1是一个512^2*1的一维数组
Mostup1=max(m1);

for Menxian1=0:0.01:Mostup1
    Accu=numel(m1(m1<Menxian1))/numel(m1);
    if Accu>=Nuzero
        break;
    end
end                                         %%用于寻找门限值，让门限由小到达变化，当小于门限
                                            %%的值的数量达到95％时，结束循环,下同理
Lenafft_No=Lena_fft;

for j=1:512                                 %%根据寻找到的门限值对图像部分像素置零,下同理
    for k=1:512
        if abs(Lenafft_No(j,k))<Menxian1
            Lenafft_No(j,k)=0;
        end
    end
end
        
 Lenafft_anti=ifft2(ifftshift(Lenafft_No)); %%对部分置零的图像进行傅里叶逆变换
 Lenafft_anti1=im2uint8(Lenafft_anti);      %%对变换后的图像进行八位整型量化,下同
 subplot(1,3,1)
 imshow(Lenafft_anti1);
 title('FFT置零回复');
 
 
 %%
 m2=abs(Lena_dct(:));
 Mostup2=max(m2);
 
 for Menxian2=0:0.0001:Mostup2
    Accu=numel(m2(m2<Menxian2))/numel(m2);
    if Accu>=Nuzero
        break;
    end
 end 

 Lenadct_No=Lena_dct;
 
 for j=1:512                              
    for k=1:512
        if abs(Lenadct_No(j,k))<Menxian2
            Lenadct_No(j,k)=0;
        end
    end
 end
 
 Lenadct_anti=idct2(Lenadct_No);           %% 对部分置零的图像进行离散余弦逆变换
 Lenadct_anti1=im2uint8(Lenadct_anti);
 subplot(1,3,2)
 imshow(Lenadct_anti1);
 title('DCT置零回复');
 
 %%
 m3=abs(Lena_hadema(:));
 Mostup3=max(m3);
 
 for Menxian3=0:0.0001:Mostup3
    Accu=numel(m3(m3<Menxian3))/numel(m3);
    if Accu>=Nuzero
        break;
    end
 end 

 Lenahmd_No=Lena_hadema;
 
 for j=1:512                              
    for k=1:512
        if abs(Lenahmd_No(j,k))<Menxian3
            Lenahmd_No(j,k)=0;
        end
    end
 end
 
 Lenahmd_anti=Hadema'*Lenahmd_No*Hadema./512';          %% 对部分置零的图像进行哈德曼逆变换，利用公式G=HFH得到F=H'*G*H'
 Lenahmd_anti1=im2uint8(Lenahmd_anti);
 subplot(1,3,3)
 imshow(Lenahmd_anti1);
 title('哈德曼置零回复');
        
              

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%求SNR并进行比较%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
side=512;
level=8;                 %%在显示图像时应用的八位无符号整型量化
Total=2^level-1;         %%Total表示图像拥有的灰度级数量


%%
Variance1=sum(sum((Lenadou-Lenafft_anti).^2))/(side^2);   %%求得方差，下同
PSNR1=20*log10(Total/sqrt(Variance1));                       %%峰值信噪比

Variance2=sum(sum((Lenadou-Lenadct_anti).^2))/(side^2);   %%求得方差，下同
PSNR2=20*log10(Total/sqrt(Variance2));                       %%峰值信噪比

Variance3=sum(sum((Lenadou-Lenahmd_anti).^2))/(side^2);   %%求得方差，下同
PSNR3=20*log10(Total/sqrt(Variance3));                       %%峰值信噪比



%%
tPSNR=74;
for Nuzero1=0.940:0.005:0.995
m_1=abs(Lena_fft(:)); 
Mostup11=max(m_1);
for Menxian11=0:0.01:Mostup11
    Accu=numel(m_1(m_1<Menxian11))/numel(m_1);
    if Accu>=Nuzero1
        break;
    end
 end 
FRE1=Lena_fft.*((abs(Lena_fft))>Menxian11);
IRE1 = ifft2(ifftshift(FRE1));
Variance11=sum(sum((Lenadou-IRE1).^2))/(side^2);   
PSNR11=20*log10(Total/sqrt(Variance11));                   
if PSNR11<tPSNR
Nuzero1=Nuzero1-0.005;
pt_fft=(1-Nuzero1)*100;

break;
end
end
%%
for Nuzero2=0.940:0.005:0.995
m_2=abs(Lena_dct(:));
Mostup22=max(m_2);
for Menxian22=0:0.0001:Mostup22
    Accu=numel(m_2(m_2<Menxian22))/numel(m_2);
    if Accu>=Nuzero2
        break;
    end
end 
DRE2=Lena_dct.*((abs(Lena_dct))>Menxian22);
IRE2 =idct2(DRE2);
Variance22=sum(sum((Lenadou-IRE2).^2))/(side^2);   
PSNR22=20*log10(Total/sqrt(Variance22));  
if PSNR22<tPSNR
Nuzero2=Nuzero2-0.005;
pt_dct=(1-Nuzero2)*100;

break;
end
end
%%
for Nuzero3=0.940:0.005:0.995
m_3=abs(Lena_hadema(:));
 Mostup33=max(m_3);
for Menxian33=0:0.0001:Mostup33
    Accu=numel(m_3(m_3<Menxian33))/numel(m_3);
    if Accu>=Nuzero3
        break;
    end
end 
DRE3=Lena_hadema.*((abs(Lena_hadema))>Menxian33);
IRE3=Hadema'*DRE3*Hadema'./512;
Variance33=sum(sum((Lenadou-IRE3).^2))/(side^2);   
PSNR33=20*log10(Total/sqrt(Variance33));  
if PSNR33<tPSNR
Nuzero3=Nuzero3-0.005;
pt_hdm=(1-Nuzero3)*100;

break;
end
end
















