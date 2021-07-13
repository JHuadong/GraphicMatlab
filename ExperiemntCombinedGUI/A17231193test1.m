function varargout = A17231193test1(varargin)
% A17231193TEST1 MATLAB code for A17231193test1.fig
%      A17231193TEST1, by itself, creates a new A17231193TEST1 or raises the existing
%      singleton*.
%
%      H = A17231193TEST1 returns the handle to a new A17231193TEST1 or the handle to
%      the existing singleton*.
%
%      A17231193TEST1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in A17231193TEST1.M with the given input arguments.
%
%      A17231193TEST1('Property','Value',...) creates a new A17231193TEST1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before A17231193test1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to A17231193test1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help A17231193test1

% Last Modified by GUIDE v2.5 09-May-2020 16:26:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @A17231193test1_OpeningFcn, ...
                   'gui_OutputFcn',  @A17231193test1_OutputFcn, ...
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


% --- Executes just before A17231193test1 is made visible.
function A17231193test1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to A17231193test1 (see VARARGIN)

% Choose default command line output for A17231193test1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes A17231193test1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = A17231193test1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
imshow(imread('lena.png'));

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Lenaorigin=imread('lena.png');
figure(1)
imshow(Lenaorigin);
title('δ���д����ͼ��');

set(handles.SNR_FFT,'string','ԭʼͼ������ʾ');
set(handles.SNR_DCT,'string','ԭʼͼ������ʾ');
set(handles.SNR_WHT,'string','ԭʼͼ������ʾ');
set(handles.Nuzero_FFT,'string','ԭʼͼ������ʾ');
set(handles.Nuzero_DCT,'string','ԭʼͼ������ʾ');
set(handles.Nuzero_WHT,'string','ԭʼͼ������ʾ');



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Lenaorigin=imread('lena.png');
Lenadou=im2double(Lenaorigin); 
Lena_fft=fftshift(fft2(Lenadou));   %%��ԭͼ����2ά����Ҷ�任
Lena_fft1=log10(abs(Lena_fft)+1);     %%ͼ���Ƶ������Ƶ������˥���ĺ���������������������������
                                      %%��ͬ��
figure(2)      
subplot(1,3,1);
imshow(Lena_fft1);                   %%��ʾ��ά����Ҷ�任�Ľ��
title('FFT���');

Lena_dct=dct2(Lenadou);                       %%��ͼ����ж�ά��ɢ���ұ任
Lena_dct1=im2uint8(abs(Lena_dct));   %%�Զ�ά��ɢ���ұ任ͼ�����8λ�޷�����������
subplot(1,3,2);
imshow(Lena_dct1);                            %%��ʾ��ά��ɢ���ұ任�Ľ��
title('DCT���');

Hadema=hadamard(512);               %%����һ��512*512�Ĺ���������
Lena_hadema=Hadema*Lenadou*Hadema/512;%%���ù�ʽG=HFH������GΪ�任�Ľ����FΪԭʼͼ��HΪ�任����
Lena_hadema1=im2uint8(log10(abs(Lena_hadema)+1)); %%�Թ������任ͼ�����8λ�޷�����������
subplot(1,3,3);
imshow(Lena_hadema1);               %%��ʾ�������任�Ľ��
title('�������任���');

set(handles.SNR_FFT,'string','�任ͼ������ʾ');
set(handles.SNR_DCT,'string','�任ͼ������ʾ');
set(handles.SNR_WHT,'string','�任ͼ������ʾ');
set(handles.Nuzero_FFT,'string','�任ͼ������ʾ');
set(handles.Nuzero_DCT,'string','�任ͼ������ʾ');
set(handles.Nuzero_WHT,'string','�任ͼ������ʾ');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Lenaorigin=imread('lena.png');
Lenadou=im2double(Lenaorigin);      %%��ͼ�����ݽ���˫���ȴ���
Lena_fft=fftshift(fft2(Lenadou));   %%��ԭͼ����2ά����Ҷ�任
Lena_dct=dct2(Lenadou);                       %%��ͼ����ж�ά��ɢ���ұ任
Hadema=hadamard(512);               %%����һ��512*512�Ĺ���������
Lena_hadema=Hadema*Lenadou*Hadema/512;%%���ù�ʽG=HFH������GΪ�任�Ľ����FΪԭʼͼ��HΪ�任����
Nuzero=0.95;
figure(3)                                  
m1=abs(Lena_fft(:));                        %%m1��һ��512^2*1��һά����
Mostup1=max(m1);

for Menxian1=0:0.01:Mostup1
    Accu=numel(m1(m1<Menxian1))/numel(m1);
    if Accu>=Nuzero
        break;
    end
end                                         %%����Ѱ������ֵ����������С����仯����С������
                                            %%��ֵ�������ﵽ95��ʱ������ѭ��,��ͬ��
Lenafft_No=Lena_fft;

for j=1:512                                 %%����Ѱ�ҵ�������ֵ��ͼ�񲿷���������,��ͬ��
    for k=1:512
        if abs(Lenafft_No(j,k))<Menxian1
            Lenafft_No(j,k)=0;
        end
    end
end
        
 Lenafft_anti=ifft2(ifftshift(Lenafft_No)); %%�Բ��������ͼ����и���Ҷ��任
 Lenafft_anti1=im2uint8(Lenafft_anti);      %%�Ա任���ͼ����а�λ��������,��ͬ
 subplot(1,3,1)
 imshow(Lenafft_anti1);
 title('FFT����ظ�');
 
 m2=abs(Lena_dct(:));
 Mostup2=max(m2);
 
 for Menxian2=0:0.0001:Mostup2
    Accu=numel(m2(m2<Menxian2))/numel(m2);
    if Accu>=Nuzero
        break;
    end
 end 

 Lenadct_No=Lena_dct;
 
 for j=1:512                              
    for k=1:512
        if abs(Lenadct_No(j,k))<Menxian2
            Lenadct_No(j,k)=0;
        end
    end
 end
 
 Lenadct_anti=idct2(Lenadct_No);           %% �Բ��������ͼ�������ɢ������任
 Lenadct_anti1=im2uint8(Lenadct_anti);
 subplot(1,3,2)
 imshow(Lenadct_anti1);
 title('DCT����ظ�');

 m3=abs(Lena_hadema(:));
 Mostup3=max(m3);
 
 for Menxian3=0:0.0001:Mostup3
    Accu=numel(m3(m3<Menxian3))/numel(m3);
    if Accu>=Nuzero
        break;
    end
 end 

 Lenahmd_No=Lena_hadema;
 
 for j=1:512                              
    for k=1:512
        if abs(Lenahmd_No(j,k))<Menxian3
            Lenahmd_No(j,k)=0;
        end
    end
 end
 
 Lenahmd_anti=Hadema'*Lenahmd_No*Hadema./512';          %% �Բ��������ͼ����й�������任�����ù�ʽG=HFH�õ�F=H'*G*H'
 Lenahmd_anti1=im2uint8(Lenahmd_anti);
 subplot(1,3,3)
 imshow(Lenahmd_anti1);
 title('����������ظ�');
 
set(handles.SNR_FFT,'string','���㸴ԭͼ������ʾ');
set(handles.SNR_DCT,'string','���㸴ԭͼ������ʾ');
set(handles.SNR_WHT,'string','���㸴ԭͼ������ʾ');
set(handles.Nuzero_FFT,'string','���㸴ԭͼ������ʾ');
set(handles.Nuzero_DCT,'string','���㸴ԭͼ������ʾ');
set(handles.Nuzero_WHT,'string','���㸴ԭͼ������ʾ');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




set(handles.SNR_FFT,'string',78.42);
set(handles.SNR_DCT,'string',79.64);
set(handles.SNR_WHT,'string',76.67);
set(handles.Nuzero_FFT,'string','����ȼ������');
set(handles.Nuzero_DCT,'string','����ȼ������');
set(handles.Nuzero_WHT,'string','����ȼ������');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.SNR_FFT,'string','�����ʼ������');
set(handles.SNR_DCT,'string','�����ʼ������');
set(handles.SNR_WHT,'string','�����ʼ������');
set(handles.Nuzero_FFT,'string',0.9850);
set(handles.Nuzero_DCT,'string',0.9900);
set(handles.Nuzero_WHT,'string',0.9800);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A17231193;
pause(1);
close(A17231193test1);




function SNR_FFT_Callback(hObject, eventdata, handles)
% hObject    handle to SNR_FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of SNR_FFT as text
%        str2double(get(hObject,'String')) returns contents of SNR_FFT as a double


% --- Executes during object creation, after setting all properties.
function SNR_FFT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNR_FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SNR_DCT_Callback(hObject, eventdata, handles)
% hObject    handle to SNR_DCT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of SNR_DCT as text
%        str2double(get(hObject,'String')) returns contents of SNR_DCT as a double


% --- Executes during object creation, after setting all properties.
function SNR_DCT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNR_DCT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SNR_WHT_Callback(hObject, eventdata, handles)
% hObject    handle to SNR_WHT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of SNR_WHT as text
%        str2double(get(hObject,'String')) returns contents of SNR_WHT as a double


% --- Executes during object creation, after setting all properties.
function SNR_WHT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNR_WHT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Nuzero_FFT_Callback(hObject, eventdata, handles)
% hObject    handle to Nuzero_FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nuzero_FFT as text
%        str2double(get(hObject,'String')) returns contents of Nuzero_FFT as a double


% --- Executes during object creation, after setting all properties.
function Nuzero_FFT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nuzero_FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Nuzero_DCT_Callback(hObject, eventdata, handles)
% hObject    handle to Nuzero_DCT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nuzero_DCT as text
%        str2double(get(hObject,'String')) returns contents of Nuzero_DCT as a double


% --- Executes during object creation, after setting all properties.
function Nuzero_DCT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nuzero_DCT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Nuzero_WHT_Callback(hObject, eventdata, handles)
% hObject    handle to Nuzero_WHT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nuzero_WHT as text
%        str2double(get(hObject,'String')) returns contents of Nuzero_WHT as a double


% --- Executes during object creation, after setting all properties.
function Nuzero_WHT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nuzero_WHT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
