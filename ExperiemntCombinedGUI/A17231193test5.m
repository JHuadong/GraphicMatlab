function varargout = A17231193test5(varargin)
% A17231193TEST5 MATLAB code for A17231193test5.fig
%      A17231193TEST5, by itself, creates a new A17231193TEST5 or raises the existing
%      singleton*.
%
%      H = A17231193TEST5 returns the handle to a new A17231193TEST5 or the handle to
%      the existing singleton*.
%
%      A17231193TEST5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in A17231193TEST5.M with the given input arguments.
%
%      A17231193TEST5('Property','Value',...) creates a new A17231193TEST5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before A17231193test5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to A17231193test5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help A17231193test5

% Last Modified by GUIDE v2.5 02-Jun-2020 20:09:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @A17231193test5_OpeningFcn, ...
                   'gui_OutputFcn',  @A17231193test5_OutputFcn, ...
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


% --- Executes just before A17231193test5 is made visible.
function A17231193test5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to A17231193test5 (see VARARGIN)

% Choose default command line output for A17231193test5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes A17231193test5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = A17231193test5_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A17231193;
pause(0.5);
close(A17231193test5);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global test_im;
global test_images;
global hid_wght;
global hid_pro;
global out_wght;
global out_pro;
global test_labels;
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

%% ѵ������չ��
step=30;  %ѵ������
a=0.3;     %��������ϵ��
in=784;    %������Ԫ����
hid=28;    %������Ԫ����
out=10;    %�����Ԫ����


out_wght=randn(out,hid);  %randu��������һ��m*n������������ͬ
out_pro=randn(out,1);
hid_wght=randn(hid,in);
hid_pro=randn(hid,1);

%���¿�ʼѵ������ѵ��300��
for i=0:step
r=randperm(60000);%randperm��matlab�������������������һ���������С����ڵĲ���������������ķ�Χ��
imagex=train_im(:,r);
labely=train_lam(:,r); %����������ɵĲ����ǽ�����ĵ�r��ת�ú��͸�����

for k=1:60000
    x=imagex(:,k);
    y=labely(:,k);
    
    hid_put=layerout(hid_wght,hid_pro,x); %layerout������ϣ���һ������
    out_put=layerout(out_wght,out_pro,hid_put);
    
    %����ʵ�����ݸ���
    o_update=(y-out_put).*out_put.*(1-out_put);
    h_update=((out_wght')*o_update).*hid_put.*(1-hid_put);
    
    outw_update = a*(o_update*(hid_put'));
    outb_update = a*o_update;
    hidw_update = a*(h_update*(x'));
    hidb_update = a*h_update;
    
    out_wght=out_wght+outw_update;
    out_pro=out_pro+outb_update;
    hid_wght=hid_wght+hidw_update;
    hid_pro=hid_pro+hidb_update;
    
    
end

if(i==step)
set(handles.edit1,'string','ѵ���Լ��������');
pause(0.5);
else
d=strcat('��ѵ��',num2str(i),'��');
set(handles.edit1,'string',d);
pause(0.5);
end

end

Accu=testing(test_im,test_labels,out_wght,out_pro,hid_wght,hid_pro); %����10000��������׼ȷ��
set(handles.edit3,'String',Accu/10000)



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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% ʶ��10000�����������е�һ����������ʾ����������ͼ��
testnum=str2num(get(handles.edit2,'string')); %10000
l=length(testnum);
global test_im;
global test_images;
global hid_wght;
global hid_pro;
global out_wght;
global out_pro;
coll=[];
figure(1);
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
    coll(:,i)=j;
    ert=strcat('ʶ����Ϊ',num2str(coll));
    set(handles.edit4,'string',ert);
    pause(0.5);
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% �������Ÿ�˹�����ķ�������ʶ��׼ȷ�ʵı仯����
global test_images;
global out_wght;
global out_pro;
global hid_wght;
global hid_pro;
global test_labels;
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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
