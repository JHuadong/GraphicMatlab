%% �÷������ڲ��Ի���ʶ��Ľ��
function [sum]=testing(image,label,out_wght,out_pro,hid_wght,hid_pro)

%image:������������������
%label:���������ı�ǩ
%out_wght:�����Ȩ��
%out_pro:��������
%hid_wght:���ز�Ȩ��
%hid_pro:���ز�ƫִ

testing=zeros(10,10000); %�������󲢳�ʾ��

for i=1:10000
    x=image(:,i);
    hid=layerout(hid_wght,hid_pro,x);
    testing(:,i)=layerout(out_wght,out_pro,hid);
end

%������ȷ��
result=max(testing);

sum=0; %��ʼ��

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