%��������ϵΪ����Ϊx�����������·�Ϊy��������ԭ������Ϊ��1��1��
clear;close all;clc;

%% �������ͼ����ʾ
Origin=im2double(rgb2gray(imread('houghorg.bmp'))); %%����ԭʼͼ��
Ori_Gau=im2double((imread('houghgau.bmp')));%%��������˹������ͼ��
Ori_Sal=im2double((imread('houghsalt.bmp'))); %%������뽷��������ͼ��
[height,width]=size(Origin);                 %%�õ�ͼ�����ĳߴ�

option1=input('ԭͼ(1),��˹����ͼ(2),��������ͼ(3)');%���ǵ�ͼƬ̫������һ��ѡһ���������
if(option1==1)
    Ori=Origin;
elseif(option1==2)
    Ori=Ori_Gau;
elseif(option1==3)
    Ori=Ori_Sal;
 
end

%% �ں��������ı����£��ȶ�ͼ����ֵ�˲�

if (option1==1)
    Ori_smo=Origin;                %%û������ʱ������ֵ�˲�
else
side=9;                        
Ori_smo=medfilt2(Ori,[side side]);  %%������ͼ�����9*9��ֵ�˲�
end


%% �����������Ӷ����ֲ�ͬ������ͼ����б�Ե��Ⲣ��ʾ���
Ori_Rob=edge(Ori_smo,'Roberts');
Ori_Sob=edge(Ori_smo,'Sobel');
Ori_Lap=edge(Ori_smo,'log');     %%��ѡ���ͼ�����������ӽ��б�Ե���

figure(1)
subplot(2,2,1),imshow(Ori),title('ԭͼ');
subplot(2,2,2),imshow(Ori_Rob),title('Roberts�����');
subplot(2,2,3),imshow(Ori_Sob),title('Sobel�����');
subplot(2,2,4),imshow(Ori_Lap),title('Lap�����');
suptitle('��Ե�����');


%% ��Ե���Ѱ���Լ�λ�ü�¼�뱻����ͼ���ѡ��
option2=input(' Roberts(1) or Sobel(2) or Laplacian(3):\n '); %ѡ��һ�ֱ�Ե��ⷽ�����к���hough�任
if(option2==1)
    Ori_edg=Ori_Rob;
elseif(option2==2)
    Ori_edg=Ori_Sob;
elseif(option2==3)
    Ori_edg=Ori_Lap;
end

totalnum=sum(sum(Ori_edg));
X=zeros(1,totalnum);Y=zeros(1,totalnum); %����Ե��������������У������������
Acu=0;                                   %��������ʼ��
for i=1:width
    for j=1:height
        if Ori_edg(j,i) %%��0��Ϊ1�������Ѱ�ҹ켣��,����j���У�iΪ��
            Acu=Acu+1;
            X(Acu)=i;  %%�����Ե�����ڵ�����
            Y(Acu)=j;  %%�����Ե�����ڵ�����
            if (Acu==totalnum)
                break;
            end
        end
    end
    if (Acu==totalnum)
        break;
    end
end

%% ��Hough�任�Բ���������ȡ
%����ԭʼ����Ϊ(x-a_0)^2+(y-b_0)^2=r^2,�淶����Ϊ(a-x_i)^2+(b-y_i)^2=r^2
%��ͼ���й۲���Դ���ȷ��Բ��λ��(385,108),��Բ�ļ��㷶Χ��С������㸽��20*20�����򣬿��Լ�С������

Arrayx_min=375;Arrayy_min=98;  %%�趨Բ�Ĳ������
range1=20;                     %%�趨Բ�Ĳ��Է�Χ
ARRX=(Arrayx_min:Arrayx_min+range1-1)';
ARRY=(Arrayy_min:Arrayy_min+range1-1)';

r_min=80;                      %%�趨�߳��������         
range2=20;                     %%�趨�߳����Է�Χ
            
delta=50;                      %%�趨���
r_step=0.5;                    %%�趨�뾶r�Ĳ��Բ���
count=0;
A_Maxpro=[];
B_Maxpro=[];
Rmaxnum=[];

for r=r_min:r_step:r_min+range2 %�뾶
    count=count+1;
    Numer=zeros(range1,range1);    %��һ��20*20�ľ�������¼�����������Բ�켣�еĴ���
    for k=1:totalnum             %ÿ�������㶼����ɸѡ
        left=repmat(((ARRX-X(k)).^2)',range1,1)+repmat((ARRY-Y(k)).^2,1,range1);
        right=r^2;
        Deff=round(left-right);  %�Խ����������ȡ��
        Isot=(Deff<delta&Deff>-delta);
        Numer=Numer+Isot;
    end
    maxNumer=max(Numer(:));      %�ҳ�ͳ�Ʒ�ֵ
    [b_maxpro,a_maxpro]=find(Numer==max(Numer(:))); %%����ͳ�Ʒ�ֵ�ĵ���������ΪԲ��
    A_Maxpro=[A_Maxpro;a_maxpro];
    B_Maxpro=[B_Maxpro;b_maxpro];
    Rmaxnum=[Rmaxnum;maxNumer];  %�����������󣬼�¼������ĳһ��r�µ�ͳ�Ʒ�ֵ�Լ�Բ������
end

finalposi=find(Rmaxnum==max(Rmaxnum));    %Ѱ��ͳ�Ʒ�ֵ���ʱ�ľ���λ��
finR=r_min+(finalposi-1)*r_step;          %%����λ�����������ֵʱ�İ뾶r
finpo_a=A_Maxpro(finalposi)+Arrayx_min;   
finpo_b=B_Maxpro(finalposi)+Arrayy_min;   %���Բ�ĵ�λ��

%%  ���ݵõ��Ĳ����������ߣ�����������ͼ��ı�Ե�����
Image=zeros(height,width);
delta2=1;
for i=1:height
    for k=1:width
        r_im=sqrt((k-finpo_a)^2+(i-finpo_b)^2);
        if(r_im<finR+delta2 &&r_im>finR-delta2)
            Image(i,k)=1;
        end
    end
end

Image=Image+Ori;

figure(2)
subplot(2,2,1),imshow(Origin);
title('ԭʼͼ��');
subplot(2,2,2),imshow(Ori);
title('��Ӧ����ͼ��');
subplot(2,2,3),imshow(Ori_edg);
title('��Ե���ͼ��');
subplot(2,2,4),imshow(Image);
title('�ؽ�����ͼ��');