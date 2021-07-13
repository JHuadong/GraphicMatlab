clc;
clear all;

Origin=im2double(imread('Lena.png'));  %%����ԭʼͼ�񲢽��и�������ת��
[M,~]=size(Origin);                   %%����ͼ����512*512�ģ�����ֻ��Ҫ���������֪�����

%% չʾδ�任ͼ��
figure(1)
subplot(1,3,1),imshow(Origin);
title('ԭʼͼ��');


%% ģ��һ���˶����ʵĴ��ݺ���H��u��v��
T=5;
a=0.1;
b=a;                                  %%����ϵͳ�ĺ���ϵ��
V=[-M/2:M/2-1];U=V';                  %%�趨����u,v��ȡֵ��Χ
A=repmat(a.*U,1,M)+repmat(b.*V,M,1);  %%repmat��������A�����ݶѵ��ڣ�MxN���ľ���B�У�B����Ĵ�С��MxN��A��������ݾ���
H=T/pi./A.*sin(pi.*A).*exp(-1i*pi.*A);%%����H��u,v������
H(find(A==0))=T;                      %%��ֹ�����˲����ڷ�ĸ�ϳ����޷���������



%% ���ݾ����ʽ�õ�δ���������˶�ģ������G��u��v��=H��u��v��F��u��v��������ʾֱ���渵��Ҷ�Ľ��
Ori_fft=fftshift(fft2(Origin));       %%��ԭͼ����и���Ҷ�任
Pc_vague=Ori_fft.*H;                  %%�õ��˶�ģ��ͼ��ĸ���Ҷ�任
Ori_antifft=real(ifft2(ifftshift(Pc_vague))); %%�õ��ܵ�ģ�����ʵ�ͼ��
subplot(1,3,2),imshow(uint8(255.*mat2gray(Ori_antifft)));%%Ϊ�˽�ʡ�洢�ռ䣬��64λdouble����ת��Ϊ�������������uint8(8λ�޷���������
title('�˶�ģ��ͼ��');



%% ���÷����˲��������������˶�ģ��ͼ����и�ԭ����ʱ�������ʸ�ԭ�������ԭͼһ���ģ��������ַ�������������ʱ���ǵ�Ч��
Pc_Gevague=Pc_vague./H;
Pc_ReGevague=real(ifft2(ifftshift(Pc_Gevague))); %%�õ������˲��Ľ��ͼ��
subplot(1,3,3),imshow(uint8(255.*mat2gray(Pc_ReGevague))); %%��ʾ�����˲��Ľ��ͼ��
title('�������˲�');


%% ����һ�����������Ĵ���ϵͳģ�ͣ���G��u,v��=H��u,v��F��u,v��+N��u,v����չʾ
Noise_even=0;                            %%��˹�����ľ�ֵΪ0
Noise_var=1e-3;                         %%��˹�����ķ���Ϊ1e-3
Noise=imnoise(zeros(M),'gaussian',Noise_even,Noise_var); %%��imnoise������վ����м���һ����ֵΪ0������Ϊ1e-3�ĸ�˹���������ǲ��������Լ�
Noise_fft=fftshift(fft2(Noise));        %%��˹�����ĸ���Ҷ�任
Pc_vague_No=Pc_vague+Noise_fft;         %%����G��u,v����ģ��
Pc_vagueNoRe=real(ifft2(ifftshift(Pc_vague_No))); %�Լ���������ģ�ͽ�����任

figure(2)
subplot(1,3,1),imshow(uint8(255.*mat2gray(Pc_vagueNoRe))); %%��ʾ����������ͼ��
title('�Ѽ��������˶�ģ��ͼ��');


%% �Լ��������Ľ���ͼ�����ֱ�ӷ����˲��Ա��������˲����бȽ�
Pc_Gevague1=Pc_vague_No./H;           %%����F��u,v��=G��u,v��/H��u,v���ɵ�
Pc_gevague=abs(Pc_Gevague1);
Anti_vague=real(ifft2(ifftshift(Pc_Gevague1))); %%����Ҷ��任
% subplot(1,3,2),imshow(uint8(255.*mat2gray(Anti_vague))); %%ͬ��
% title('��������ֱ�ӷ����˲�');

%% �Է����˲���Ѱ����ѵĸ�ԭ������뾶R r=5.39
maxPSNR1=-1000;
bestR=0;                                %%����ֵ�ĳ�ʼ��

for R=3:1e-2:6
    Pc_VagnoRe=zeros(M);                
    for X=1:M
        for Y=1:M
            if sqrt((X-M/2)^2+(Y-M/2)^2)<R   %%�ж�����λ�þ���ͼ���ĵ�λ��,���ڰ뾶R�Ĳ���ȡ0�����ఴ�շ����˲�������ֵ
                Pc_VagnoRe(X,Y)=Pc_vague_No(X,Y)./H(X,Y);
            end
        end
    end
    
    Anti_Nopc=real(ifft2(ifftshift(Pc_VagnoRe)));
    PSNR=PSNRget(Origin,Anti_Nopc);
    if PSNR>maxPSNR1                 %%����һ��Rȡֵ�µ�PSNR��Ƚϣ����������滻bestR��ֵΪ���ڵ�R
        maxPSNR1=PSNR;
        bestR=R;
    end
end


%% չʾ����Ѹ�ԭ�뾶R������µĸ�ԭͼ��
Pc_VagnoRe=zeros(M);

for X=1:M
        for Y=1:M
            if sqrt((X-M/2).^2+(Y-M/2).^2)<bestR   %%�ж�����λ�þ���ͼ���ĵ�λ��
                Pc_VagnoRe(X,Y)=Pc_vague_No(X,Y)./H(X,Y);
            end
        end
end

Fin_Pc=abs(Pc_VagnoRe);
Fin_Pc1=real(ifft2(ifftshift(Pc_VagnoRe)));  %%����Ҷ��任
subplot(1,3,2),imshow(uint8(255.*mat2gray(Fin_Pc1)));  %%��ʾ����Բ�˲��Ľ��
title(['��Ѱ뾶Ϊ',num2str(bestR),'��Բ�����˲��Ľ��']);


%% Ѱ����ѵ��������źŵ�Ƶ�����ܶȱ�ֵK
maxPSNR2=-1000;
bestK=0;                   %%����ֵ�ĳ�ʼ��
buf=(abs(H)).^2;
for K=0:1e-2:1
    Pc_vagnore=Pc_vague_No./H.*buf./(buf+K);       %%1/.H.*buf./(buf+K)��ά���˲���ϵͳ���ݺ���
    rePc_vagnore=real(ifft2(ifftshift(Pc_vagnore)));  %%����Ҷ��任
    PSNR=PSNRget(Origin,rePc_vagnore);
    if PSNR>maxPSNR2
        maxPSNR2=PSNR;
        bestK=K;
    end   
end
    
%% ���������ҵ������Kֵ��ʾά����任�Ľ��
Pc_vagnore=Pc_vague_No./H.*buf./(buf+bestK);     %%���Kֵ�µ���任Ƶ��
Pc_vagnore1=real(ifft2(ifftshift(Pc_vagnore)));
subplot(1,3,3),imshow(uint8(255.*mat2gray(Pc_vagnore1)));  %%��ʾά���˲��Ľ��
title(['���ϵ��K',num2str(bestK),'ά���˲��Ľ��']);


%% ����ά���˲��Ľ��
th_Pc=Pc_vague_No./H.*buf./(buf+Noise_fft./Ori_fft);  %%�����е�ά����任���Ƶ��
th_Pc1=real(ifft2(ifftshift(th_Pc)));           
% figure(3)
% subplot(1,3,1),imshow(uint8(255.*mat2gray(th_Pc1)));
% title('����ά���˲����');



