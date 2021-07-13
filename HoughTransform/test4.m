%假设坐标系为正右为x轴正方向，正下方为y轴正方向，原点坐标为（1，1）
clear;close all;clc;

%% 读入材料图像并显示
Origin=im2double(rgb2gray(imread('houghorg.bmp'))); %%读入原始图像
Ori_Gau=im2double((imread('houghgau.bmp')));%%读入加入高斯噪声的图像
Ori_Sal=im2double((imread('houghsalt.bmp'))); %%读入加入椒盐噪声的图像
[height,width]=size(Origin);                 %%得到图像矩阵的尺寸

option1=input('原图(1),高斯噪声图(2),椒盐噪声图(3)');%考虑到图片太多于是一次选一种情况处理
if(option1==1)
    Ori=Origin;
elseif(option1==2)
    Ori=Ori_Gau;
elseif(option1==3)
    Ori=Ori_Sal;
 
end

%% 在含有噪声的背景下，先对图像中值滤波

if (option1==1)
    Ori_smo=Origin;                %%没有噪声时不用中值滤波
else
side=9;                        
Ori_smo=medfilt2(Ori,[side side]);  %%对噪声图像进行9*9中值滤波
end


%% 利用三种算子对两种不同的噪声图像进行边缘检测并显示结果
Ori_Rob=edge(Ori_smo,'Roberts');
Ori_Sob=edge(Ori_smo,'Sobel');
Ori_Lap=edge(Ori_smo,'log');     %%对选择的图像用三种算子进行边缘检测

figure(1)
subplot(2,2,1),imshow(Ori),title('原图');
subplot(2,2,2),imshow(Ori_Rob),title('Roberts检测结果');
subplot(2,2,3),imshow(Ori_Sob),title('Sobel检测结果');
subplot(2,2,4),imshow(Ori_Lap),title('Lap检测结果');
suptitle('边缘检测结果');


%% 边缘点的寻找以及位置记录与被处理图像的选择
option2=input(' Roberts(1) or Sobel(2) or Laplacian(3):\n '); %选择一种边缘检测方法进行后面hough变换
if(option2==1)
    Ori_edg=Ori_Rob;
elseif(option2==2)
    Ori_edg=Ori_Sob;
elseif(option2==3)
    Ori_edg=Ori_Lap;
end

totalnum=sum(sum(Ori_edg));
X=zeros(1,totalnum);Y=zeros(1,totalnum); %将边缘点坐标放入数组中，方便后续调用
Acu=0;                                   %计数器初始化
for i=1:width
    for j=1:height
        if Ori_edg(j,i) %%非0即为1，借此来寻找轨迹点,其中j是行，i为列
            Acu=Acu+1;
            X(Acu)=i;  %%储存边缘点所在的列数
            Y(Acu)=j;  %%储存边缘点所在的行数
            if (Acu==totalnum)
                break;
            end
        end
    end
    if (Acu==totalnum)
        break;
    end
end

%% 用Hough变换对参数进行提取
%假设原始方程为(x-a_0)^2+(y-b_0)^2=r^2,规范方程为(a-x_i)^2+(b-y_i)^2=r^2
%从图像中观察可以大致确定圆心位于(385,108),把圆心计算范围缩小到这个点附近20*20的区域，可以减小计算量

Arrayx_min=375;Arrayy_min=98;  %%设定圆心测试起点
range1=20;                     %%设定圆心测试范围
ARRX=(Arrayx_min:Arrayx_min+range1-1)';
ARRY=(Arrayy_min:Arrayy_min+range1-1)';

r_min=80;                      %%设定边长测试起点         
range2=20;                     %%设定边长测试范围
            
delta=50;                      %%设定误差
r_step=0.5;                    %%设定半径r的测试步长
count=0;
A_Maxpro=[];
B_Maxpro=[];
Rmaxnum=[];

for r=r_min:r_step:r_min+range2 %半径
    count=count+1;
    Numer=zeros(range1,range1);    %用一个20*20的矩阵来记录方正点出现在圆轨迹中的次数
    for k=1:totalnum             %每个样本点都进行筛选
        left=repmat(((ARRX-X(k)).^2)',range1,1)+repmat((ARRY-Y(k)).^2,1,range1);
        right=r^2;
        Deff=round(left-right);  %对结果四舍五入取整
        Isot=(Deff<delta&Deff>-delta);
        Numer=Numer+Isot;
    end
    maxNumer=max(Numer(:));      %找出统计峰值
    [b_maxpro,a_maxpro]=find(Numer==max(Numer(:))); %%具有统计峰值的点有最大可能为圆心
    A_Maxpro=[A_Maxpro;a_maxpro];
    B_Maxpro=[B_Maxpro;b_maxpro];
    Rmaxnum=[Rmaxnum;maxNumer];  %以上三个矩阵，记录的是在某一个r下的统计峰值以及圆心坐标
end

finalposi=find(Rmaxnum==max(Rmaxnum));    %寻找统计峰值最大时的矩阵位置
finR=r_min+(finalposi-1)*r_step;          %%根据位置来求得最大峰值时的半径r
finpo_a=A_Maxpro(finalposi)+Arrayx_min;   
finpo_b=B_Maxpro(finalposi)+Arrayy_min;   %求出圆心的位置

%%  根据得到的参数绘制曲线，并加在噪声图像的边缘检测上
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
title('原始图像');
subplot(2,2,2),imshow(Ori);
title('对应噪声图像');
subplot(2,2,3),imshow(Ori_edg);
title('边缘检测图像');
subplot(2,2,4),imshow(Image);
title('重建叠加图像');