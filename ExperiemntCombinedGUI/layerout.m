%% ����������
function [y]=layerout(out_wght,out_pro,x)

%out_wght���Ȩ��
%out_pro���ƫ��
y=out_wght*x+out_pro;
Base=length(y);

for i=1:Base
    y(i)=1/(1+exp(-y(i)));
end
y;
end
