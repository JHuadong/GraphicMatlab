%% ��ģ��������Ԫ����ѵ��,����28��������Ԫ��������784����Ԫ
function [out_wght,out_pro,hid_wght,hid_pro]=Training(image,label)

%���������ĺ�������
%out_wght��ʾ���Ȩ��
%out_pro��ʾ���ƫ��
%hid_wght��ʾ���ز�Ȩ��
%hid_pro��ʾ���ز�ƫ��

step=50;  %ѵ������
a=0.3;     %��������ϵ��
in=784;    %������Ԫ����
hid=28;    %������Ԫ����
out=10;    %�����Ԫ����
o=1;

out_wght=randn(out,hid);  %randu��������һ��m*n������������ͬ
out_pro=randn(out,1);
hid_wght=randn(hid,in);
hid_pro=randn(hid,1);

%���¿�ʼѵ������ѵ��300��
for i=0:step
r=randperm(60000);%randperm��matlab�������������������һ���������С����ڵĲ���������������ķ�Χ��
imagex=image(:,r);
labely=label(:,r); %����������ɵĲ����ǽ�����ĵ�r��ת�ú��͸�����

for k=1:60000
    x=imagex(:,k);
    y=labely(:,k);
    
    hid_put=layerout(hid_wght,hid_pro,x); %layerout������ϣ���һ������
    out_put=layerout(out_wght,out_pro,hid_put);
    
    %����ʵ�����ݸ���
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
fprintf('�����%d��ѵ��\n',i);
end


end