clc;
clear all;

Origin=im2double(imread('Lena.png'));  %%读入原始图像并进行浮点数据转换
[M,~]=size(Origin);                   %%由于图像是512*512的，所以只需要求出长即可知道面积

%% 展示未变换图像
figure(1)
subplot(1,3,1),imshow(Origin);
title('原始图像');


%% 模拟一个运动降质的传递函数H（u，v）
T=5;
a=0.1;
b=a;                                  %%降质系统的函数系数
V=[-M/2:M/2-1];U=V';                  %%设定变量u,v的取值范围
A=repmat(a.*U,1,M)+repmat(b.*V,M,1);  %%repmat功能是以A的内容堆叠在（MxN）的矩阵B中，B矩阵的大小由MxN及A矩阵的内容决定
H=T/pi./A.*sin(pi.*A).*exp(-1i*pi.*A);%%构建H（u,v）函数
H(find(A==0))=T;                      %%防止反向滤波法在分母上出现无法计算的情况



%% 根据卷积公式得到未加噪声的运动模糊，即G（u，v）=H（u，v）F（u，v），并显示直接逆傅里叶的结果
Ori_fft=fftshift(fft2(Origin));       %%对原图像进行傅里叶变换
Pc_vague=Ori_fft.*H;                  %%得到运动模糊图像的傅里叶变换
Ori_antifft=real(ifft2(ifftshift(Pc_vague))); %%得到受到模糊降质的图像
subplot(1,3,2),imshow(uint8(255.*mat2gray(Ori_antifft)));%%为了节省存储空间，将64位double类型转换为特殊的数据类型uint8(8位无符号整数）
title('运动模糊图像');



%% 利用反向滤波法对无噪声的运动模糊图像进行复原，此时毫无疑问复原结果是与原图一样的，而且两种方法在无噪声的时候是等效的
Pc_Gevague=Pc_vague./H;
Pc_ReGevague=real(ifft2(ifftshift(Pc_Gevague))); %%得到反向滤波的结果图像
subplot(1,3,3),imshow(uint8(255.*mat2gray(Pc_ReGevague))); %%显示方向滤波的结果图像
title('无噪声滤波');


%% 构造一个包含噪声的传输系统模型，即G（u,v）=H（u,v）F（u,v）+N（u,v）并展示
Noise_even=0;                            %%高斯噪声的均值为0
Noise_var=1e-3;                         %%高斯噪声的方差为1e-3
Noise=imnoise(zeros(M),'gaussian',Noise_even,Noise_var); %%用imnoise函数向空矩阵中加入一个均值为0，方差为1e-3的高斯噪声，就是产生噪声自己
Noise_fft=fftshift(fft2(Noise));        %%高斯噪声的傅里叶变换
Pc_vague_No=Pc_vague+Noise_fft;         %%构造G（u,v）的模型
Pc_vagueNoRe=real(ifft2(ifftshift(Pc_vague_No))); %对加入噪声的模型进行逆变换

figure(2)
subplot(1,3,1),imshow(uint8(255.*mat2gray(Pc_vagueNoRe))); %%显示加入噪声的图像
title('已加噪声的运动模糊图像');


%% 对加入噪声的降质图像进行直接反向滤波以便与区域滤波进行比较
Pc_Gevague1=Pc_vague_No./H;           %%根据F（u,v）=G（u,v）/H（u,v）可得
Pc_gevague=abs(Pc_Gevague1);
Anti_vague=real(ifft2(ifftshift(Pc_Gevague1))); %%傅里叶逆变换
% subplot(1,3,2),imshow(uint8(255.*mat2gray(Anti_vague))); %%同上
% title('有噪声且直接反向滤波');

%% 对反向滤波器寻找最佳的复原的区域半径R r=5.39
maxPSNR1=-1000;
bestR=0;                                %%所求值的初始化

for R=3:1e-2:6
    Pc_VagnoRe=zeros(M);                
    for X=1:M
        for Y=1:M
            if sqrt((X-M/2)^2+(Y-M/2)^2)<R   %%判断像素位置距离图中心的位置,大于半径R的部分取0，其余按照反向滤波器规则赋值
                Pc_VagnoRe(X,Y)=Pc_vague_No(X,Y)./H(X,Y);
            end
        end
    end
    
    Anti_Nopc=real(ifft2(ifftshift(Pc_VagnoRe)));
    PSNR=PSNRget(Origin,Anti_Nopc);
    if PSNR>maxPSNR1                 %%与上一个R取值下的PSNR相比较，如果更大就替换bestR的值为现在的R
        maxPSNR1=PSNR;
        bestR=R;
    end
end


%% 展示在最佳复原半径R的情况下的复原图像
Pc_VagnoRe=zeros(M);

for X=1:M
        for Y=1:M
            if sqrt((X-M/2).^2+(Y-M/2).^2)<bestR   %%判断像素位置距离图中心的位置
                Pc_VagnoRe(X,Y)=Pc_vague_No(X,Y)./H(X,Y);
            end
        end
end

Fin_Pc=abs(Pc_VagnoRe);
Fin_Pc1=real(ifft2(ifftshift(Pc_VagnoRe)));  %%傅里叶逆变换
subplot(1,3,2),imshow(uint8(255.*mat2gray(Fin_Pc1)));  %%显示区域圆滤波的结果
title(['最佳半径为',num2str(bestR),'的圆内逆滤波的结果']);


%% 寻找最佳的噪声对信号的频率谱密度比值K
maxPSNR2=-1000;
bestK=0;                   %%所求值的初始化
buf=(abs(H)).^2;
for K=0:1e-2:1
    Pc_vagnore=Pc_vague_No./H.*buf./(buf+K);       %%1/.H.*buf./(buf+K)是维纳滤波的系统传递函数
    rePc_vagnore=real(ifft2(ifftshift(Pc_vagnore)));  %%傅里叶逆变换
    PSNR=PSNRget(Origin,rePc_vagnore);
    if PSNR>maxPSNR2
        maxPSNR2=PSNR;
        bestK=K;
    end   
end
    
%% 根据上面找到的最佳K值显示维纳逆变换的结果
Pc_vagnore=Pc_vague_No./H.*buf./(buf+bestK);     %%最佳K值下的逆变换频谱
Pc_vagnore1=real(ifft2(ifftshift(Pc_vagnore)));
subplot(1,3,3),imshow(uint8(255.*mat2gray(Pc_vagnore1)));  %%显示维纳滤波的结果
title(['最佳系数K',num2str(bestK),'维纳滤波的结果']);


%% 理论维纳滤波的结果
th_Pc=Pc_vague_No./H.*buf./(buf+Noise_fft./Ori_fft);  %%理论中的维纳逆变换后的频谱
th_Pc1=real(ifft2(ifftshift(th_Pc)));           
% figure(3)
% subplot(1,3,1),imshow(uint8(255.*mat2gray(th_Pc1)));
% title('理论维纳滤波结果');



