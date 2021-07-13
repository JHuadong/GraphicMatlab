%% 该方程用于测试机器识别的结果
function [sum]=testing(image,label,out_wght,out_pro,hid_wght,hid_pro)

%image:测试样本的像素数据
%label:测试样本的标签
%out_wght:输出层权重
%out_pro:输出层编置
%hid_wght:隐藏层权重
%hid_pro:隐藏层偏执

testing=zeros(10,10000); %创建矩阵并出示化

for i=1:10000
    x=image(:,i);
    hid=layerout(hid_wght,hid_pro,x);
    testing(:,i)=layerout(out_wght,out_pro,hid);
end

%计算正确率
result=max(testing);

sum=0; %初始化

for j=1:10000
    for k=1:10
        if result(j)==testing(k,j)
            if label(j)==(k-1)
                sum=sum+1;
            end
        end
    end
end
end