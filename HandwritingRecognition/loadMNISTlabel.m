%% 这个方程的作用是是读取MNIST数据集中的标签（Label），结果是一个一位数组（1*标签数）label
function label=loadMNISTlabel(filename)

fid=fopen(filename,'r'); %导入文件并且进行读操作

%label 数据或图像像素信息开始之前会有一些表头信息，
%对于 label 文件是 2 个 32位整型，

magicNum = fread(fid,1,'int32',0,'ieee-be'); %解释同读取Image文件

LabNum=fread(fid,1,'int32',0,'ieee-be'); 


%读取标签信息

label=fread(fid,Inf,'unsigned char');

label=label'; %由于是一个一位向量，就不需要reshape，直接转置

fclose(fid); %s释放指针
end
