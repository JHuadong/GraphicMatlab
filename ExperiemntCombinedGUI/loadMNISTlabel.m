%% ������̵��������Ƕ�ȡMNIST���ݼ��еı�ǩ��Label���������һ��һλ���飨1*��ǩ����label
function label=loadMNISTlabel(filename)

fid=fopen(filename,'r'); %�����ļ����ҽ��ж�����

%label ���ݻ�ͼ��������Ϣ��ʼ֮ǰ����һЩ��ͷ��Ϣ��
%���� label �ļ��� 2 �� 32λ���ͣ�

magicNum = fread(fid,1,'int32',0,'ieee-be'); %����ͬ��ȡImage�ļ�

LabNum=fread(fid,1,'int32',0,'ieee-be'); 


%��ȡ��ǩ��Ϣ

label=fread(fid,Inf,'unsigned char');

label=label'; %������һ��һλ�������Ͳ���Ҫreshape��ֱ��ת��

fclose(fid); %s�ͷ�ָ��
end
