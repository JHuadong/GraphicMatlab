%% ������̵Ĺ����Ƕ�ȡMNIST���ݼ��е�ͼƬ��Image������ȡ�Ľ����һ����ά����ÿһ����һ��ͼ��Image
function picture=loadMNISTimage(filename)

%filenameָ�Ǹ�����ͼ�����ݵ��ļ�
%picture��һ����ά����(��СΪ28*28*ͼ�������)

FID=fopen(filename,'r'); %fopen�����ļ���'r'�������Ϊ��ȡ

%��ȡǰ16���ֽڣ���128��bit
%ԭ������������ label ���ݻ�ͼ��������Ϣ��ʼ֮ǰ����һЩ��ͷ��Ϣ��
%���� label �ļ��� 2 �� 32λ���ͣ����� image �ļ��� 4 �� 32λ���ͣ�������Image�ļ�


%���¾��Ǳ�ͷ
magicNum=fread(FID,1, 'int32',0,'ieee-be');    %���Ƕ�ȡ�ļ��Ļ�������־�ļ������ԣ�
%'int32'ָ32λ���κ�sizeA(1)��ϣ�һ�ζ���32��bit��
%��ieee-be��ָ���Ƕ�ȡ˳��Ϊ��˶�ȡ��0ָ���Ƕ�ȡ�����������,��ͬ
ImageNum=fread(FID,1,'int32',0,'ieee-be');     %ͼ�����

RowNum=fread(FID,1,'int32',0,'ieee-be');   %����

ColNum=fread(FID,1,'int32',0,'ieee-be');   %����

%������ͼ���ļ�������
picture=fread(FID,Inf,'unsigned char'); %inf:����fidָ��Ĵ򿪵��ļ���ȫ�����ݡ�'uchar'�޷����ַ�

picture=reshape(picture,ColNum,RowNum,ImageNum); %MATLAB�н�ָ���ľ���任���ض�ά������һ�ֺ�����
                                                 %�Ҿ�����Ԫ�ظ������䣬�����������µ��������������������ά���������н�����picture��Ϊ����*����*ͼ�����

picture=permute(picture,[2 1 3]); %��������ά�ȣ�ԭ����ͼ���ڴ���ʱ�Ƿ�������ģ�����Ҫ�ٷ�һ��������

fclose(FID); %������ã���Ȼָ���޷��ͷ�

end