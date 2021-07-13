%% 拟合输出方程
function [y]=layerout(out_wght,out_pro,x)

%out_wght输出权重
%out_pro输出偏置
y=out_wght*x+out_pro;
Base=length(y);

for i=1:Base
    y(i)=1/(1+exp(-y(i)));
end
y;
end
