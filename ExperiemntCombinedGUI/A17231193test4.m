function varargout = A17231193test4(varargin)
% A17231193TEST4 MATLAB code for A17231193test4.fig
%      A17231193TEST4, by itself, creates a new A17231193TEST4 or raises the existing
%      singleton*.
%
%      H = A17231193TEST4 returns the handle to a new A17231193TEST4 or the handle to
%      the existing singleton*.
%
%      A17231193TEST4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in A17231193TEST4.M with the given input arguments.
%
%      A17231193TEST4('Property','Value',...) creates a new A17231193TEST4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before A17231193test4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to A17231193test4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help A17231193test4

% Last Modified by GUIDE v2.5 26-May-2020 17:51:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @A17231193test4_OpeningFcn, ...
                   'gui_OutputFcn',  @A17231193test4_OutputFcn, ...
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


% --- Executes just before A17231193test4 is made visible.
function A17231193test4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to A17231193test4 (see VARARGIN)

% Choose default command line output for A17231193test4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes A17231193test4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = A17231193test4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Origin=im2double(rgb2gray(imread('houghorg.bmp'))); %%����ԭʼͼ��
Ori_Gau=im2double((imread('houghgau.bmp')));%%��������˹������ͼ��
Ori_Sal=im2double((imread('houghsalt.bmp'))); %%������뽷��������ͼ��
option1=str2num(get(handles.edit2,'string'));%���ǵ�ͼƬ̫������һ��ѡһ���������
if(option1==1)
    Ori=Origin;
elseif(option1==2)
    Ori=Ori_Gau;
elseif(option1==3)
    Ori=Ori_Sal;
 
end

%% �ں��������ı����£��ȶ�ͼ����ֵ�˲�

if (option1==1)
    Ori_smo=Origin;                %%û������ʱ������ֵ�˲�
else
side=9;                        
Ori_smo=medfilt2(Ori,[side side]);  %%������ͼ�����9*9��ֵ�˲�
end


%% �����������Ӷ����ֲ�ͬ������ͼ����б�Ե��Ⲣ��ʾ���
Ori_Rob=edge(Ori_smo,'Roberts');
Ori_Sob=edge(Ori_smo,'Sobel');
Ori_Lap=edge(Ori_smo,'log');     %%��ѡ���ͼ�����������ӽ��б�Ե���

figure(1)
subplot(2,2,1),imshow(Ori),title('ԭͼ');
subplot(2,2,2),imshow(Ori_Rob),title('Roberts�����');
subplot(2,2,3),imshow(Ori_Sob),title('Sobel�����');
subplot(2,2,4),imshow(Ori_Lap),title('Lap�����');
suptitle('��Ե�����');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% �������ͼ����ʾ
Origin=im2double(rgb2gray(imread('houghorg.bmp'))); %%����ԭʼͼ��
Ori_Gau=im2double((imread('houghgau.bmp')));%%��������˹������ͼ��
Ori_Sal=im2double((imread('houghsalt.bmp'))); %%������뽷��������ͼ��
[height,width]=size(Origin);                 %%�õ�ͼ�����ĳߴ�

option1=str2num(get(handles.edit2,'string'));%���ǵ�ͼƬ̫������һ��ѡһ���������
if(option1==1)
    Ori=Origin;
elseif(option1==2)
    Ori=Ori_Gau;
elseif(option1==3)
    Ori=Ori_Sal;
 
end

%% �ں��������ı����£��ȶ�ͼ����ֵ�˲�

if (option1==1)
    Ori_smo=Origin;                %%û������ʱ������ֵ�˲�
else
side=9;                        
Ori_smo=medfilt2(Ori,[side side]);  %%������ͼ�����9*9��ֵ�˲�
end


%% �����������Ӷ����ֲ�ͬ������ͼ����б�Ե��Ⲣ��ʾ���
Ori_Rob=edge(Ori_smo,'Roberts');
Ori_Sob=edge(Ori_smo,'Sobel');
Ori_Lap=edge(Ori_smo,'log');     %%��ѡ���ͼ�����������ӽ��б�Ե���




%% ��Ե���Ѱ���Լ�λ�ü�¼�뱻����ͼ���ѡ��
option2=str2num(get(handles.edit1,'string')); %ѡ��һ�ֱ�Ե��ⷽ�����к���hough�任
if(option2==1)
    Ori_edg=Ori_Rob;
elseif(option2==2)
    Ori_edg=Ori_Sob;
elseif(option2==3)
    Ori_edg=Ori_Lap;
end

totalnum=sum(sum(Ori_edg));
X=zeros(1,totalnum);Y=zeros(1,totalnum); %����Ե��������������У������������
Acu=0;                                   %��������ʼ��
for i=1:width
    for j=1:height
        if Ori_edg(j,i) %%��0��Ϊ1�������Ѱ�ҹ켣��,����j���У�iΪ��
            Acu=Acu+1;
            X(Acu)=i;  %%�����Ե�����ڵ�����
            Y(Acu)=j;  %%�����Ե�����ڵ�����
            if (Acu==totalnum)
                break;
            end
        end
    end
    if (Acu==totalnum)
        break;
    end
end

%% ��Hough�任�Բ���������ȡ
%����ԭʼ����Ϊ(x-a_0)^2+(y-b_0)^2=r^2,�淶����Ϊ(a-x_i)^2+(b-y_i)^2=r^2
%��ͼ���й۲���Դ���ȷ��Բ��λ��(385,108),��Բ�ļ��㷶Χ��С������㸽��20*20�����򣬿��Լ�С������

Arrayx_min=375;Arrayy_min=98;  %%�趨Բ�Ĳ������
range1=20;                     %%�趨Բ�Ĳ��Է�Χ
ARRX=(Arrayx_min:Arrayx_min+range1-1)';
ARRY=(Arrayy_min:Arrayy_min+range1-1)';

r_min=80;                      %%�趨�߳��������         
range2=20;                     %%�趨�߳����Է�Χ
            
delta=50;                      %%�趨���
r_step=0.5;                    %%�趨�뾶r�Ĳ��Բ���
count=0;
A_Maxpro=[];
B_Maxpro=[];
Rmaxnum=[];

for r=r_min:r_step:r_min+range2 %�뾶
    count=count+1;
    Numer=zeros(range1,range1);    %��һ��20*20�ľ�������¼�����������Բ�켣�еĴ���
    for k=1:totalnum             %ÿ�������㶼����ɸѡ
        left=repmat(((ARRX-X(k)).^2)',range1,1)+repmat((ARRY-Y(k)).^2,1,range1);
        right=r^2;
        Deff=round(left-right);  %�Խ����������ȡ��
        Isot=(Deff<delta&Deff>-delta);
        Numer=Numer+Isot;
    end
    maxNumer=max(Numer(:));      %�ҳ�ͳ�Ʒ�ֵ
    [b_maxpro,a_maxpro]=find(Numer==max(Numer(:))); %%����ͳ�Ʒ�ֵ�ĵ���������ΪԲ��
    A_Maxpro=[A_Maxpro;a_maxpro];
    B_Maxpro=[B_Maxpro;b_maxpro];
    Rmaxnum=[Rmaxnum;maxNumer];  %�����������󣬼�¼������ĳһ��r�µ�ͳ�Ʒ�ֵ�Լ�Բ������
end

finalposi=find(Rmaxnum==max(Rmaxnum));    %Ѱ��ͳ�Ʒ�ֵ���ʱ�ľ���λ��
finR=r_min+(finalposi-1)*r_step;          %%����λ�����������ֵʱ�İ뾶r
finpo_a=A_Maxpro(finalposi)+Arrayx_min;   
finpo_b=B_Maxpro(finalposi)+Arrayy_min;   %���Բ�ĵ�λ��

%%  ���ݵõ��Ĳ����������ߣ�����������ͼ��ı�Ե�����
Image=zeros(height,width);
delta2=1;
for i=1:height
    for k=1:width
        r_im=sqrt((k-finpo_a)^2+(i-finpo_b)^2);
        if(r_im<finR+delta2 &&r_im>finR-delta2)
            Image(i,k)=1;
        end
    end
end

Image=Image+Ori;

figure(2)
subplot(2,2,1),imshow(Origin);
title('ԭʼͼ��');
subplot(2,2,2),imshow(Ori);
title('��Ӧ����ͼ��');
subplot(2,2,3),imshow(Ori_edg);
title('��Ե���ͼ��');
subplot(2,2,4),imshow(Image);
title('�ؽ�����ͼ��');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A17231193;
pause(1);
close(A17231193test4);


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
imwd=imread('houghorg.bmp');
imshow(imwd);

% Hint: place code in OpeningFcn to populate axes3
