%% 本模块用于神经元进行训练,共有28个隐藏神经元，输入了784个神经元
function [out_wght,out_pro,hid_wght,hid_pro]=Training(image,label)

%各个变量的含义如下
%out_wght表示输出权重
%out_pro表示输出偏置
%hid_wght表示隐藏层权重
%hid_pro表示隐藏层偏置

step=50;  %训练次数
a=0.3;     %迭代更新系数
in=784;    %输入神经元个数
hid=28;    %隐藏神经元个数
out=10;    %输出神经元个数
o=1;

out_wght=randn(out,hid);  %randu函数返回一个m*n的随机项矩阵。下同
out_pro=randn(out,1);
hid_wght=randn(hid,in);
hid_pro=randn(hid,1);

%以下开始训练，共训练300次
for i=0:step
r=randperm(60000);%randperm是matlab函数，功能是随机打乱一个数字序列。其内的参数决定了随机数的范围。
imagex=image(:,r);
labely=label(:,r); %上下两句完成的操作是将数组的第r列转置后送给变量

for k=1:60000
    x=imagex(:,k);
    y=labely(:,k);
    
    hid_put=layerout(hid_wght,hid_pro,x); %layerout进行拟合，是一个方程
    out_put=layerout(out_wght,out_pro,hid_put);
    
    %以下实现数据更新
    o_update=(y-out_put).*out_put.*(1-out_put);
    h_update=((out_wght')*o_update).*hid_put.*(1-hid_put);
    
    outw_update = a*(o_update*(hid_put'));
    outb_update = a*o_update;
    hidw_update = a*(h_update*(x'));
    hidb_update = a*h_update;
    
    out_wght=out_wght+outw_update;
    out_pro=out_pro+outb_update;
    hid_wght=hid_wght+hidw_update;
    hid_pro=hid_pro+hidb_update;
    
    
end
fprintf('已完成%d次训练\n',i);
end


end