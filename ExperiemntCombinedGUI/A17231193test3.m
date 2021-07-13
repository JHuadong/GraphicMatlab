function varargout = A17231193test3(varargin)
% A17231193TEST3 MATLAB code for A17231193test3.fig
%      A17231193TEST3, by itself, creates a new A17231193TEST3 or raises the existing
%      singleton*.
%
%      H = A17231193TEST3 returns the handle to a new A17231193TEST3 or the handle to
%      the existing singleton*.
%
%      A17231193TEST3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in A17231193TEST3.M with the given input arguments.
%
%      A17231193TEST3('Property','Value',...) creates a new A17231193TEST3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before A17231193test3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to A17231193test3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help A17231193test3

% Last Modified by GUIDE v2.5 19-May-2020 13:19:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @A17231193test3_OpeningFcn, ...
                   'gui_OutputFcn',  @A17231193test3_OutputFcn, ...
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


% --- Executes just before A17231193test3 is made visible.
function A17231193test3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to A17231193test3 (see VARARGIN)

% Choose default command line output for A17231193test3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes A17231193test3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = A17231193test3_OutputFcn(hObject, eventdata, handles) 
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
A17231193;
pause(1);
close(A17231193test3);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Origin=rgb2gray(im2double(imread('shiyan3.bmp'))); %%消除图像饱和度同时保留亮度，而且亮度归一化
LengthofSide=[3,4,5];  %%在数组中放入不同的滤波图形的边长
figure(1)
subplot(2,2,1),imshow(Origin);title('原始图像');  %%展示原始图像

for i=1:1:3
    m=LengthofSide(i);              %%依次选择列举的边长
    Ori_Smo=medfilt2(Origin,[m m]); %%用medfilt2对二维图像的任意矩形区域进行中值滤波
    subplot(2,2,i+1),imshow(Ori_Smo),title(['中值滤波范围取值为:',num2str(m),'*',num2str(m)]); %%显示中值滤波的结果
end
 suptitle('不同中指滤波范围的结果比较');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Origin=rgb2gray(im2double(imread('shiyan3.bmp'))); %%消除图像饱和度同时保留亮度，而且亮度归一化
LengthofSide=[3,4,5];  %%在数组中放入不同的滤波图形的边长
figure(2)
for i=1:1:3
    m=LengthofSide(i);              %%依次选择列举的边长
    Ori_Smo=medfilt2(Origin,[m m]); %%用medfilt2对二维图像的任意矩形区域进行中值滤波,
    Limit=graythresh(Ori_Smo);      %%用graythresh函数使用最大类间方差法找到图片的一个合适的阈值。
    Ori_two=imbinarize(Ori_Smo,Limit); %%用imbinarize函数进行分割处理，即类间方差阈值运算
    subplot(1,3,i),imshow(Ori_two),title(['滤波范围为:',num2str(m),'*',num2str(m),'下的分割结果']);%%显示类间方差阈值的结果
end
suptitle('不同滤波范围下类间方差阈值的结果');



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Origin=rgb2gray(im2double(imread('shiyan3.bmp'))); %%消除图像饱和度同时保留亮度，而且亮度归一化
LengthofSide=[3,4,5];  %%在数组中放入不同的滤波图形的边长
figure(3)
Radius=[3,5,7];     %%在数组中列出运算的圆半径
for k=1:3
 for i=1:1:3
    m=LengthofSide(k);              
    Ori_Smo=medfilt2(Origin,[m m]); %%用medfilt2对二维图像的任意矩形区域进行中值滤波,
    Limit=graythresh(Ori_Smo);      %%用graythresh函数使用最大类间方差法找到图片的一个合适的阈值。
    Ori_two=imbinarize(Ori_Smo,Limit); %%用imbinarize函数进行分割处理，即类间方差阈值运算
    R=Radius(i);    %%选取运算半径
    Base=strel('disk',R);    %%创建一个半径为R的圆盘的操作结构元素，用于膨胀腐蚀及开闭运算等操作
    Ori_Ro=imerode(Ori_two,Base);    %%使用imerode函数进行图像腐蚀运算
    Ori_Fin=imdilate(Ori_Ro,Base);   %%使用imdilate函数进行膨胀运算 
    subplot(3,3,((k-1)*3+i)),imshow(Ori_Fin),title(['圆半径取值为',num2str(R),'开运算后的结果']); %%显示开运算的结果
 end
end

suptitle('中值滤波边长分别为3，4，5（由上到下）时的不同圆半径下的开运算处理效果');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Origin=rgb2gray(im2double(imread('shiyan3.bmp'))); %%消除图像饱和度同时保留亮度，而且亮度归一化
LengthofSide=[3,4,5];  %%在数组中放入不同的滤波图形的边长
figure(4)
Radius=[3,5,7];     %%在数组中列出运算的圆半径
for k=1:3
 for i=1:1:3
    m=LengthofSide(k);              
    Ori_Smo=medfilt2(Origin,[m m]); %%用medfilt2对二维图像的任意矩形区域进行中值滤波,
    Limit=graythresh(Ori_Smo);      %%用graythresh函数使用最大类间方差法找到图片的一个合适的阈值。
    Ori_two=imbinarize(Ori_Smo,Limit); %%用imbinarize函数进行分割处理，即类间方差阈值运算
    R=Radius(i);    %%选取运算半径
    Base=strel('disk',R);    %%创建一个半径为R的圆盘的操作结构元素，用于膨胀腐蚀及开闭运算等操作
    Ori_Dil=imdilate(Ori_two,Base);   %%使用imdilate函数进行膨胀运算
    Ori_Fin=imerode(Ori_Dil,Base);    %%使用imerode函数进行图像腐蚀运算 
    subplot(3,3,((k-1)*3+i)),imshow(Ori_Fin),title(['圆半径取值为',num2str(R),'开运算后的结果']); %%显示闭运算的结果
 end
end

suptitle('中值滤波边长分别为3，4，5（由上到下）时的不同圆半径下的闭运算处理效果');


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
imshow(imread('shiyan3.bmp'));

% Hint: place code in OpeningFcn to populate axes2
