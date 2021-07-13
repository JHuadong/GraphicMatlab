%% ������
%% ��ȡMNIST�����ļ��е�ͼƬ
train_images=loadMNISTimage('train-images.idx3-ubyte'); %����60000��ѵ������ÿ��ͼƬ28*28
test_images=loadMNISTimage('t10k-images.idx3-ubyte');   %����10000��ѵ��������С������ͬ

%% ��ȡMNIST���ݼ��еı�ǩ���ؽ�
train_labels=loadMNISTlabel('train-labels.idx1-ubyte');%0-9ʮ������,����60000��
test_labels=loadMNISTlabel('t10k-labels.idx1-ubyte'); %����10000��

train_im=reshape(train_images,28*28,60000)./255; %�ؽ�ͼ�β��ҹ�һ��
test_im=reshape(test_images,28*28,10000)./255;

train_lam=zeros(10,60000);
test_lam=zeros(10,10000);  %��ǩ�����ʼ��
for i=1:60000
   train_lam((train_labels(i)+1),i)=1; 
end

[out_wght,out_pro,hid_wght,hid_pro]=Training(train_im,train_lam);
Accu=testing(test_im,test_labels,out_wght,out_pro,hid_wght,hid_pro); %����10000��������׼ȷ��
fprintf('��ȷ��Ϊ:%d/10000\n',Accu);

%% ʶ��10000�����������е�һ����������ʾ����������ͼ��
testnum=str2num(input('��������Ҫʶ���ͼ��任:\n','s')); %10000
l=length(testnum);
figure(1);
fprintf('ʶ����Ϊ��\n')
for i=1:l
    x = test_im(:,testnum(i));
    hid = layerout(hid_wght,hid_pro,x);
    re=layerout(out_wght,out_pro,hid);
    for j=1:10
        if re(j)==max(re)
            break;
        end
    end
    j=j-1;
    subplot(l,1,i);
    imshow(test_images(:,:,testnum(i)));
    fprintf('%d\n',j);
end

%% �������Ÿ�˹�����ķ�������ʶ��׼ȷ�ʵı仯����
acc=zeros(length([0:0.05:1]));
ct=1;
for var=0:0.05:1
    test_images_n=test_images./255;
    for j=1:10000
        test_images_n(:,:,j)=imnoise(test_images_n(:,:,j),'gaussian',var);
    end
    test_img_n=reshape(test_images_n,28*28,10000);
    acc(ct)=testing(test_img_n,test_labels,out_wght,out_pro,hid_wght,hid_pro)./10000.*100;
    ct=ct+1;
end
figure(2);
x=0:0.05:1;
plot(x,acc(:,1),'-*r');
xlabel('��˹��������');
ylabel('ʶ��׼ȷ��/%');
