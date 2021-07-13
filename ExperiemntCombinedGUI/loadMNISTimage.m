%% 这个方程的功能是读取MNIST数据集中的图片（Image），读取的结果是一个三维矩阵，每一层是一个图像Image
function picture=loadMNISTimage(filename)

%filename指那个储存图像数据的文件
%picture是一个三维数组(大小为28*28*图像的数量)

FID=fopen(filename,'r'); %fopen导入文件，'r'代表操作为读取

%读取前16个字节，共128个bit
%原因是在真正的 label 数据或图像像素信息开始之前会有一些表头信息，
%对于 label 文件是 2 个 32位整型，对于 image 文件是 4 个 32位整型，这里是Image文件


%以下就是表头
magicNum=fread(FID,1, 'int32',0,'ieee-be');    %这是读取文件的幻数，标志文件的特性，
%'int32'指32位整形和sizeA(1)配合，一次读入32个bit，
%‘ieee-be’指的是读取顺序为大端读取，0指的是读取完后不跳过数据,下同
ImageNum=fread(FID,1,'int32',0,'ieee-be');     %图像个数

RowNum=fread(FID,1,'int32',0,'ieee-be');   %列数

ColNum=fread(FID,1,'int32',0,'ieee-be');   %行数

%以下是图像文件的内容
picture=fread(FID,Inf,'unsigned char'); %inf:读出fid指向的打开的文件的全部数据。'uchar'无符号字符

picture=reshape(picture,ColNum,RowNum,ImageNum); %MATLAB中将指定的矩阵变换成特定维数矩阵一种函数，
                                                 %且矩阵中元素个数不变，函数可以重新调整矩阵的行数、列数、维数。本例中将矩阵picture变为行数*列数*图像个数

picture=permute(picture,[2 1 3]); %交换行列维度，原因是图像在存入时是反过来存的，所以要再反一遍来抵消

fclose(FID); %必须调用，不然指针无法释放

end