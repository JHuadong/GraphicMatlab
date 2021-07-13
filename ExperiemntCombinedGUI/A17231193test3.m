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
Origin=rgb2gray(im2double(imread('shiyan3.bmp'))); %%����ͼ�񱥺Ͷ�ͬʱ�������ȣ��������ȹ�һ��
LengthofSide=[3,4,5];  %%�������з��벻ͬ���˲�ͼ�εı߳�
figure(1)
subplot(2,2,1),imshow(Origin);title('ԭʼͼ��');  %%չʾԭʼͼ��

for i=1:1:3
    m=LengthofSide(i);              %%����ѡ���оٵı߳�
    Ori_Smo=medfilt2(Origin,[m m]); %%��medfilt2�Զ�άͼ�������������������ֵ�˲�
    subplot(2,2,i+1),imshow(Ori_Smo),title(['��ֵ�˲���ΧȡֵΪ:',num2str(m),'*',num2str(m)]); %%��ʾ��ֵ�˲��Ľ��
end
 suptitle('��ͬ��ָ�˲���Χ�Ľ���Ƚ�');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Origin=rgb2gray(im2double(imread('shiyan3.bmp'))); %%����ͼ�񱥺Ͷ�ͬʱ�������ȣ��������ȹ�һ��
LengthofSide=[3,4,5];  %%�������з��벻ͬ���˲�ͼ�εı߳�
figure(2)
for i=1:1:3
    m=LengthofSide(i);              %%����ѡ���оٵı߳�
    Ori_Smo=medfilt2(Origin,[m m]); %%��medfilt2�Զ�άͼ�������������������ֵ�˲�,
    Limit=graythresh(Ori_Smo);      %%��graythresh����ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ��
    Ori_two=imbinarize(Ori_Smo,Limit); %%��imbinarize�������зָ������䷽����ֵ����
    subplot(1,3,i),imshow(Ori_two),title(['�˲���ΧΪ:',num2str(m),'*',num2str(m),'�µķָ���']);%%��ʾ��䷽����ֵ�Ľ��
end
suptitle('��ͬ�˲���Χ����䷽����ֵ�Ľ��');



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Origin=rgb2gray(im2double(imread('shiyan3.bmp'))); %%����ͼ�񱥺Ͷ�ͬʱ�������ȣ��������ȹ�һ��
LengthofSide=[3,4,5];  %%�������з��벻ͬ���˲�ͼ�εı߳�
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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Origin=rgb2gray(im2double(imread('shiyan3.bmp'))); %%����ͼ�񱥺Ͷ�ͬʱ�������ȣ��������ȹ�һ��
LengthofSide=[3,4,5];  %%�������з��벻ͬ���˲�ͼ�εı߳�
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


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
imshow(imread('shiyan3.bmp'));

% Hint: place code in OpeningFcn to populate axes2
