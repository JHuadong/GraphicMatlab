function varargout = A17231193test2(varargin)
% A17231193TEST2 MATLAB code for A17231193test2.fig
%      A17231193TEST2, by itself, creates a new A17231193TEST2 or raises the existing
%      singleton*.
%
%      H = A17231193TEST2 returns the handle to a new A17231193TEST2 or the handle to
%      the existing singleton*.
%
%      A17231193TEST2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in A17231193TEST2.M with the given input arguments.
%
%      A17231193TEST2('Property','Value',...) creates a new A17231193TEST2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before A17231193test2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to A17231193test2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help A17231193test2

% Last Modified by GUIDE v2.5 13-May-2020 12:00:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @A17231193test2_OpeningFcn, ...
                   'gui_OutputFcn',  @A17231193test2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before A17231193test2 is made visible.
function A17231193test2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to A17231193test2 (see VARARGIN)

% Choose default command line output for A17231193test2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes A17231193test2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = A17231193test2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Origin=im2double(imread('Lena.png'));  %%读入原始图像并进行浮点数据转换
[M,~]=size(Origin);                   %%由于图像是512*512的，所以只需要求出长即可知道面积
figure(1)
subplot(1,3,1),imshow(Origin);
title('原始图像');
T=5;
a=0.1;
b=a;                                  %%降质系统的函数系数
V=[-M/2:M/2-1];U=V';                  %%设定变量u,v的取值范围
A=repmat(a.*U,1,M)+repmat(b.*V,M,1);  %%repmat功能是以A的内容堆叠在（MxN）的矩阵B中，B矩阵的大小由MxN及A矩阵的内容决定
H=T/pi./A.*sin(pi.*A).*exp(-1i*pi.*A);%%构建H（u,v）函数
H(find(A==0))=T;                      %%防止反向滤波法在分母上出现无法计算的情况
Ori_fft=fftshift(fft2(Origin));       %%对原图像进行傅里叶变换
Pc_vague=Ori_fft.*H;                  %%得到运动模糊图像的傅里叶变换
Ori_antifft=real(ifft2(ifftshift(Pc_vague))); %%得到受到模糊降质的图像
subplot(1,3,2),imshow(uint8(255.*mat2gray(Ori_antifft)));%%为了节省存储空间，将64位double类型转换为特殊的数据类型uint8(8位无符号整数）
title('运动模糊图像');
Pc_Gevague=Pc_vague./H;
Pc_ReGevague=real(ifft2(ifftshift(Pc_Gevague))); %%得到反向滤波的结果图像
subplot(1,3,3),imshow(uint8(255.*mat2gray(Pc_ReGevague))); %%显示方向滤波的结果图像
title('无噪声滤波');



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A17231193;
pause(1);
close(A17231193test2);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Origin=im2double(imread('Lena.png'));  %%读入原始图像并进行浮点数据转换
[M,~]=size(Origin);                   %%由于图像是512*512的，所以只需要求出长即可知道面积
T=5;
a=0.1;
b=a;                                  %%降质系统的函数系数
V=[-M/2:M/2-1];U=V';                  %%设定变量u,v的取值范围
A=repmat(a.*U,1,M)+repmat(b.*V,M,1);  %%repmat功能是以A的内容堆叠在（MxN）的矩阵B中，B矩阵的大小由MxN及A矩阵的内容决定
H=T/pi./A.*sin(pi.*A).*exp(-1i*pi.*A);%%构建H（u,v）函数
H(find(A==0))=T;                      %%防止反向滤波法在分母上出现无法计算的情况
Ori_fft=fftshift(fft2(Origin));       %%对原图像进行傅里叶变换
Pc_vague=Ori_fft.*H;                  %%得到运动模糊图像的傅里叶变换


Noise_even=0;                            %%高斯噪声的均值为0
Noise_var=1e-3;                         %%高斯噪声的方差为1e-3
Noise=imnoise(zeros(M),'gaussian',Noise_even,Noise_var); %%用imnoise函数向空矩阵中加入一个均值为0，方差为1e-3的高斯噪声，就是产生噪声自己
Noise_fft=fftshift(fft2(Noise));        %%高斯噪声的傅里叶变换
Pc_vague_No=Pc_vague+Noise_fft;         %%构造G（u,v）的模型
Pc_vagueNoRe=real(ifft2(ifftshift(Pc_vague_No))); %对加入噪声的模型进行逆变换

figure(2)
subplot(1,3,1),imshow(uint8(255.*mat2gray(Pc_vagueNoRe))); %%显示加入噪声的图像
title('已加噪声的运动模糊图像');

Pc_VagnoRe=zeros(M);
bestR=5.39;
for X=1:M
        for Y=1:M
            if sqrt((X-M/2).^2+(Y-M/2).^2)<bestR   %%判断像素位置距离图中心的位置
                Pc_VagnoRe(X,Y)=Pc_vague_No(X,Y)./H(X,Y);
            end
        end
end

Fin_Pc=abs(Pc_VagnoRe);
Fin_Pc1=real(ifft2(ifftshift(Pc_VagnoRe)));  %%傅里叶逆变换
subplot(1,3,2),imshow(uint8(255.*mat2gray(Fin_Pc1)));  %%显示区域圆滤波的结果
title(['最佳半径为',num2str(bestR),'的圆内逆滤波的结果']);
buf=(abs(H)).^2;
bestK=0.05;
Pc_vagnore=Pc_vague_No./H.*buf./(buf+bestK);     %%最佳K值下的逆变换频谱
Pc_vagnore1=real(ifft2(ifftshift(Pc_vagnore)));
subplot(1,3,3),imshow(uint8(255.*mat2gray(Pc_vagnore1)));  %%显示维纳滤波的结果
title(['最佳系数K',num2str(bestK),'维纳滤波的结果']);