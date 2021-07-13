

Origin=rgb2gray(im2double(imread('shiyan3.bmp'))); %%����ͼ�񱥺Ͷ�ͬʱ�������ȣ��������ȹ�һ��

LengthofSide=[3,4,5];  %%�������з��벻ͬ���˲�ͼ�εı߳�


%% ���ò�ͬ�����Σ��߳�Ϊ3��4��5����ͼ�������ֵ�˲������Ƚϲ�ͬ�˲���Χ�µĽ��
figure(1)
subplot(2,2,1),imshow(Origin);title('ԭʼͼ��');  %%չʾԭʼͼ��

for i=1:1:3
    m=LengthofSide(i);              %%����ѡ���оٵı߳�
    Ori_Smo=medfilt2(Origin,[m m]); %%��medfilt2�Զ�άͼ�������������������ֵ�˲�
    subplot(2,2,i+1),imshow(Ori_Smo),title(['��ֵ�˲���ΧȡֵΪ:',num2str(m),'*',num2str(m)]); %%��ʾ��ֵ�˲��Ľ��
end
 suptitle('��ͬ��ָ�˲���Χ�Ľ���Ƚ�');

 
%% �Ծ�����ֵ�˲����ͼ����������䷽���㷨��ɷָ��㷨�����Ƚϲ�ͬ��ֵ�˲���ͼ�񾭹��ı任�Ľ��
figure(2)
for i=1:1:3
    m=LengthofSide(i);              %%����ѡ���оٵı߳�
    Ori_Smo=medfilt2(Origin,[m m]); %%��medfilt2�Զ�άͼ�������������������ֵ�˲�,
    Limit=graythresh(Ori_Smo);      %%��graythresh����ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ��
    Ori_two=imbinarize(Ori_Smo,Limit); %%��imbinarize�������зָ������䷽����ֵ����
    subplot(1,3,i),imshow(Ori_two),title(['�˲���ΧΪ:',num2str(m),'*',num2str(m),'�µķָ���']);%%��ʾ��䷽����ֵ�Ľ��
end
suptitle('��ͬ�˲���Χ����䷽����ֵ�Ľ��');


%% �Էָ�������ͼ����и�ʴ���������㣬�����������㲻ͬ���Ⱥ�˳�򣬷�Ϊ������ͱ����㣬�뾶ȡֵΪ3��5��7
% ����Ϊ��������������ȸ�ʴ���㣬����������
figure(3)
Radius=[3,5,7];     %%���������г������Բ�뾶
for k=1:3
 for i=1:1:3
    m=LengthofSide(k);              
    Ori_Smo=medfilt2(Origin,[m m]); %%��medfilt2�Զ�άͼ�������������������ֵ�˲�,
    Limit=graythresh(Ori_Smo);      %%��graythresh����ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ��
    Ori_two=imbinarize(Ori_Smo,Limit); %%��imbinarize�������зָ������䷽����ֵ����
    R=Radius(i);    %%ѡȡ����뾶
    Base=strel('disk',R);    %%����һ���뾶ΪR��Բ�̵Ĳ����ṹԪ�أ��������͸�ʴ����������Ȳ���
    Ori_Ro=imerode(Ori_two,Base);    %%ʹ��imerode��������ͼ��ʴ����
    Ori_Fin=imdilate(Ori_Ro,Base);   %%ʹ��imdilate���������������� 
    subplot(3,3,((k-1)*3+i)),imshow(Ori_Fin),title(['Բ�뾶ȡֵΪ',num2str(R),'�������Ľ��']); %%��ʾ������Ľ��
 end
end

suptitle('��ֵ�˲��߳��ֱ�Ϊ3��4��5�����ϵ��£�ʱ�Ĳ�ͬԲ�뾶�µĿ����㴦��Ч��');

%����Ϊ��������������������㣬�ڸ�ʴ����
figure(4)
Radius=[3,5,7];     %%���������г������Բ�뾶
for k=1:3
 for i=1:1:3
    m=LengthofSide(k);              
    Ori_Smo=medfilt2(Origin,[m m]); %%��medfilt2�Զ�άͼ�������������������ֵ�˲�,
    Limit=graythresh(Ori_Smo);      %%��graythresh����ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ��
    Ori_two=imbinarize(Ori_Smo,Limit); %%��imbinarize�������зָ������䷽����ֵ����
    R=Radius(i);    %%ѡȡ����뾶
    Base=strel('disk',R);    %%����һ���뾶ΪR��Բ�̵Ĳ����ṹԪ�أ��������͸�ʴ����������Ȳ���
   Ori_Dil=imdilate(Ori_two,Base);   %%ʹ��imdilate����������������
    Ori_Fin=imerode(Ori_Dil,Base);    %%ʹ��imerode��������ͼ��ʴ����
    subplot(3,3,((k-1)*3+i)),imshow(Ori_Fin),title(['Բ�뾶ȡֵΪ',num2str(R),'�������Ľ��']); %%��ʾ������Ľ��
 end
end

suptitle('��ֵ�˲��߳��ֱ�Ϊ3��4��5�����ϵ��£�ʱ�Ĳ�ͬԲ�뾶�µı����㴦��Ч��');