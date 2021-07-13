

Origin=rgb2gray(im2double(imread('shiyan3.bmp'))); %%消除图像饱和度同时保留亮度，而且亮度归一化

LengthofSide=[3,4,5];  %%在数组中放入不同的滤波图形的边长


%% 采用不同正方形（边长为3，4，5）对图像进行中值滤波，并比较不同滤波范围下的结果
figure(1)
subplot(2,2,1),imshow(Origin);title('原始图像');  %%展示原始图像

for i=1:1:3
    m=LengthofSide(i);              %%依次选择列举的边长
    Ori_Smo=medfilt2(Origin,[m m]); %%用medfilt2对二维图像的任意矩形区域进行中值滤波
    subplot(2,2,i+1),imshow(Ori_Smo),title(['中值滤波范围取值为:',num2str(m),'*',num2str(m)]); %%显示中值滤波的结果
end
 suptitle('不同中指滤波范围的结果比较');

 
%% 对经过中值滤波后的图像进行最大类间方差算法完成分割算法，并比较不同中值滤波的图像经过改变换的结果
figure(2)
for i=1:1:3
    m=LengthofSide(i);              %%依次选择列举的边长
    Ori_Smo=medfilt2(Origin,[m m]); %%用medfilt2对二维图像的任意矩形区域进行中值滤波,
    Limit=graythresh(Ori_Smo);      %%用graythresh函数使用最大类间方差法找到图片的一个合适的阈值。
    Ori_two=imbinarize(Ori_Smo,Limit); %%用imbinarize函数进行分割处理，即类间方差阈值运算
    subplot(1,3,i),imshow(Ori_two),title(['滤波范围为:',num2str(m),'*',num2str(m),'下的分割结果']);%%显示类间方差阈值的结果
end
suptitle('不同滤波范围下类间方差阈值的结果');


%% 对分割运算后的图像进行腐蚀和膨胀运算，根据两个运算不同的先后顺序，分为开运算和闭运算，半径取值为3，5，7
% 以下为开运算操作，即先腐蚀运算，再膨胀运算
figure(3)
Radius=[3,5,7];     %%在数组中列出运算的圆半径
for k=1:3
 for i=1:1:3
    m=LengthofSide(k);              
    Ori_Smo=medfilt2(Origin,[m m]); %%用medfilt2对二维图像的任意矩形区域进行中值滤波,
    Limit=graythresh(Ori_Smo);      %%用graythresh函数使用最大类间方差法找到图片的一个合适的阈值。
    Ori_two=imbinarize(Ori_Smo,Limit); %%用imbinarize函数进行分割处理，即类间方差阈值运算
    R=Radius(i);    %%选取运算半径
    Base=strel('disk',R);    %%创建一个半径为R的圆盘的操作结构元素，用于膨胀腐蚀及开闭运算等操作
    Ori_Ro=imerode(Ori_two,Base);    %%使用imerode函数进行图像腐蚀运算
    Ori_Fin=imdilate(Ori_Ro,Base);   %%使用imdilate函数进行膨胀运算 
    subplot(3,3,((k-1)*3+i)),imshow(Ori_Fin),title(['圆半径取值为',num2str(R),'开运算后的结果']); %%显示开运算的结果
 end
end

suptitle('中值滤波边长分别为3，4，5（由上到下）时的不同圆半径下的开运算处理效果');

%以下为闭运算操作，先膨胀运算，在腐蚀运算
figure(4)
Radius=[3,5,7];     %%在数组中列出运算的圆半径
for k=1:3
 for i=1:1:3
    m=LengthofSide(k);              
    Ori_Smo=medfilt2(Origin,[m m]); %%用medfilt2对二维图像的任意矩形区域进行中值滤波,
    Limit=graythresh(Ori_Smo);      %%用graythresh函数使用最大类间方差法找到图片的一个合适的阈值。
    Ori_two=imbinarize(Ori_Smo,Limit); %%用imbinarize函数进行分割处理，即类间方差阈值运算
    R=Radius(i);    %%选取运算半径
    Base=strel('disk',R);    %%创建一个半径为R的圆盘的操作结构元素，用于膨胀腐蚀及开闭运算等操作
   Ori_Dil=imdilate(Ori_two,Base);   %%使用imdilate函数进行膨胀运算
    Ori_Fin=imerode(Ori_Dil,Base);    %%使用imerode函数进行图像腐蚀运算
    subplot(3,3,((k-1)*3+i)),imshow(Ori_Fin),title(['圆半径取值为',num2str(R),'开运算后的结果']); %%显示闭运算的结果
 end
end

suptitle('中值滤波边长分别为3，4，5（由上到下）时的不同圆半径下的闭运算处理效果');