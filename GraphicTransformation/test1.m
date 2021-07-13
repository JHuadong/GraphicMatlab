

Lenaorigin=imread('lena.png');      %%��ȡͼ��
figure(1)
imshow(Lenaorigin);                 %%������ͼ��ĻҶȷ�Χ����ԭͼ��ʾ
Lenadou=im2double(Lenaorigin);      %%��ͼ�����ݽ���˫���ȴ���
title('δ���д����ͼ��');


%%%%%%%%%%%%%%%%%%FFT�任,DCT�任���������任�Ľ����ʾ%%%%%%%%%%
%%
Lena_fft=fftshift(fft2(Lenadou));   %%��ԭͼ����2ά����Ҷ�任
Lena_fft1=log10(abs(Lena_fft)+1);     %%ͼ���Ƶ������Ƶ������˥���ĺ���������������������������
                                      %%��ͬ��
figure(2)      
subplot(1,3,1);
imshow(Lena_fft1);                   %%��ʾ��ά����Ҷ�任�Ľ��
title('FFT���');

Lena_dct=dct2(Lenadou);                       %%��ͼ����ж�ά��ɢ���ұ任
Lena_dct1=im2uint8(abs(Lena_dct));   %%�Զ�ά��ɢ���ұ任ͼ�����8λ�޷�����������
subplot(1,3,2);
imshow(Lena_dct1);                            %%��ʾ��ά��ɢ���ұ任�Ľ��
title('DCT���');

Hadema=hadamard(512);               %%����һ��512*512�Ĺ���������
Lena_hadema=Hadema*Lenadou*Hadema/512;%%���ù�ʽG=HFH������GΪ�任�Ľ����FΪԭʼͼ��HΪ�任����
Lena_hadema1=im2uint8(log10(abs(Lena_hadema)+1)); %%�Թ������任ͼ�����8λ�޷�����������
subplot(1,3,3);
imshow(Lena_hadema1);               %%��ʾ�������任�Ľ��
title('�������任���');
%%

%%%%%%%%%%%%%%%%%%%%%%%%%�Ա任ͼ���95%Сֵ���㣬��任���ȽϽ��%%%%%%%%%%%%%%%%%%%%%%%%
Nuzero=0.95;

%%                     
figure(3)                                  
m1=abs(Lena_fft(:));                        %%m1��һ��512^2*1��һά����
Mostup1=max(m1);

for Menxian1=0:0.01:Mostup1
    Accu=numel(m1(m1<Menxian1))/numel(m1);
    if Accu>=Nuzero
        break;
    end
end                                         %%����Ѱ������ֵ����������С����仯����С������
                                            %%��ֵ�������ﵽ95��ʱ������ѭ��,��ͬ��
Lenafft_No=Lena_fft;

for j=1:512                                 %%����Ѱ�ҵ�������ֵ��ͼ�񲿷���������,��ͬ��
    for k=1:512
        if abs(Lenafft_No(j,k))<Menxian1
            Lenafft_No(j,k)=0;
        end
    end
end
        
 Lenafft_anti=ifft2(ifftshift(Lenafft_No)); %%�Բ��������ͼ����и���Ҷ��任
 Lenafft_anti1=im2uint8(Lenafft_anti);      %%�Ա任���ͼ����а�λ��������,��ͬ
 subplot(1,3,1)
 imshow(Lenafft_anti1);
 title('FFT����ظ�');
 
 
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
 
 Lenadct_anti=idct2(Lenadct_No);           %% �Բ��������ͼ�������ɢ������任
 Lenadct_anti1=im2uint8(Lenadct_anti);
 subplot(1,3,2)
 imshow(Lenadct_anti1);
 title('DCT����ظ�');
 
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
 
 Lenahmd_anti=Hadema'*Lenahmd_No*Hadema./512';          %% �Բ��������ͼ����й�������任�����ù�ʽG=HFH�õ�F=H'*G*H'
 Lenahmd_anti1=im2uint8(Lenahmd_anti);
 subplot(1,3,3)
 imshow(Lenahmd_anti1);
 title('����������ظ�');
        
              

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��SNR�����бȽ�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
side=512;
level=8;                 %%����ʾͼ��ʱӦ�õİ�λ�޷�����������
Total=2^level-1;         %%Total��ʾͼ��ӵ�еĻҶȼ�����


%%
Variance1=sum(sum((Lenadou-Lenafft_anti).^2))/(side^2);   %%��÷����ͬ
PSNR1=20*log10(Total/sqrt(Variance1));                       %%��ֵ�����

Variance2=sum(sum((Lenadou-Lenadct_anti).^2))/(side^2);   %%��÷����ͬ
PSNR2=20*log10(Total/sqrt(Variance2));                       %%��ֵ�����

Variance3=sum(sum((Lenadou-Lenahmd_anti).^2))/(side^2);   %%��÷����ͬ
PSNR3=20*log10(Total/sqrt(Variance3));                       %%��ֵ�����



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
















