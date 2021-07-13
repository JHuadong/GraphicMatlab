%% 主函数
%% 读取MNIST数据文件中的图片
train_images=loadMNISTimage('train-images.idx3-ubyte'); %共有60000个训练集，每个图片28*28
test_images=loadMNISTimage('t10k-images.idx3-ubyte');   %共有10000个训练集，大小遇上相同

%% 读取MNIST数据集中的标签并重建
train_labels=loadMNISTlabel('train-labels.idx1-ubyte');%0-9十个数字,共有60000个
test_labels=loadMNISTlabel('t10k-labels.idx1-ubyte'); %共有10000个

train_im=reshape(train_images,28*28,60000)./255; %重建图形并且归一化
test_im=reshape(test_images,28*28,10000)./255;

train_lam=zeros(10,60000);
test_lam=zeros(10,10000);  %标签数组初始化
for i=1:60000
   train_lam((train_labels(i)+1),i)=1; 
end

[out_wght,out_pro,hid_wght,hid_pro]=Training(train_im,train_lam);
Accu=testing(test_im,test_labels,out_wght,out_pro,hid_wght,hid_pro); %测试10000个样例的准确度
fprintf('正确率为:%d/10000\n',Accu);

%% 识别10000个测试样例中的一个，并且显示测试样本的图像
testnum=str2num(input('请输入需要识别的图像变换:\n','s')); %10000
l=length(testnum);
figure(1);
fprintf('识别结果为：\n')
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

%% 绘制随着高斯噪声的方差增大，识别准确率的变化曲线
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
xlabel('高斯噪声方差');
ylabel('识别准确率/%');
