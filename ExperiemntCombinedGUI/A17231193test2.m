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
Origin=im2double(imread('Lena.png'));  %%����ԭʼͼ�񲢽��и�������ת��
[M,~]=size(Origin);                   %%����ͼ����512*512�ģ�����ֻ��Ҫ���������֪�����
figure(1)
subplot(1,3,1),imshow(Origin);
title('ԭʼͼ��');
T=5;
a=0.1;
b=a;                                  %%����ϵͳ�ĺ���ϵ��
V=[-M/2:M/2-1];U=V';                  %%�趨����u,v��ȡֵ��Χ
A=repmat(a.*U,1,M)+repmat(b.*V,M,1);  %%repmat��������A�����ݶѵ��ڣ�MxN���ľ���B�У�B����Ĵ�С��MxN��A��������ݾ���
H=T/pi./A.*sin(pi.*A).*exp(-1i*pi.*A);%%����H��u,v������
H(find(A==0))=T;                      %%��ֹ�����˲����ڷ�ĸ�ϳ����޷���������
Ori_fft=fftshift(fft2(Origin));       %%��ԭͼ����и���Ҷ�任
Pc_vague=Ori_fft.*H;                  %%�õ��˶�ģ��ͼ��ĸ���Ҷ�任
Ori_antifft=real(ifft2(ifftshift(Pc_vague))); %%�õ��ܵ�ģ�����ʵ�ͼ��
subplot(1,3,2),imshow(uint8(255.*mat2gray(Ori_antifft)));%%Ϊ�˽�ʡ�洢�ռ䣬��64λdouble����ת��Ϊ�������������uint8(8λ�޷���������
title('�˶�ģ��ͼ��');
Pc_Gevague=Pc_vague./H;
Pc_ReGevague=real(ifft2(ifftshift(Pc_Gevague))); %%�õ������˲��Ľ��ͼ��
subplot(1,3,3),imshow(uint8(255.*mat2gray(Pc_ReGevague))); %%��ʾ�����˲��Ľ��ͼ��
title('�������˲�');



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
Origin=im2double(imread('Lena.png'));  %%����ԭʼͼ�񲢽��и�������ת��
[M,~]=size(Origin);                   %%����ͼ����512*512�ģ�����ֻ��Ҫ���������֪�����
T=5;
a=0.1;
b=a;                                  %%����ϵͳ�ĺ���ϵ��
V=[-M/2:M/2-1];U=V';                  %%�趨����u,v��ȡֵ��Χ
A=repmat(a.*U,1,M)+repmat(b.*V,M,1);  %%repmat��������A�����ݶѵ��ڣ�MxN���ľ���B�У�B����Ĵ�С��MxN��A��������ݾ���
H=T/pi./A.*sin(pi.*A).*exp(-1i*pi.*A);%%����H��u,v������
H(find(A==0))=T;                      %%��ֹ�����˲����ڷ�ĸ�ϳ����޷���������
Ori_fft=fftshift(fft2(Origin));       %%��ԭͼ����и���Ҷ�任
Pc_vague=Ori_fft.*H;                  %%�õ��˶�ģ��ͼ��ĸ���Ҷ�任


Noise_even=0;                            %%��˹�����ľ�ֵΪ0
Noise_var=1e-3;                         %%��˹�����ķ���Ϊ1e-3
Noise=imnoise(zeros(M),'gaussian',Noise_even,Noise_var); %%��imnoise������վ����м���һ����ֵΪ0������Ϊ1e-3�ĸ�˹���������ǲ��������Լ�
Noise_fft=fftshift(fft2(Noise));        %%��˹�����ĸ���Ҷ�任
Pc_vague_No=Pc_vague+Noise_fft;         %%����G��u,v����ģ��
Pc_vagueNoRe=real(ifft2(ifftshift(Pc_vague_No))); %�Լ���������ģ�ͽ�����任

figure(2)
subplot(1,3,1),imshow(uint8(255.*mat2gray(Pc_vagueNoRe))); %%��ʾ����������ͼ��
title('�Ѽ��������˶�ģ��ͼ��');

Pc_VagnoRe=zeros(M);
bestR=5.39;
for X=1:M
        for Y=1:M
            if sqrt((X-M/2).^2+(Y-M/2).^2)<bestR   %%�ж�����λ�þ���ͼ���ĵ�λ��
                Pc_VagnoRe(X,Y)=Pc_vague_No(X,Y)./H(X,Y);
            end
        end
end

Fin_Pc=abs(Pc_VagnoRe);
Fin_Pc1=real(ifft2(ifftshift(Pc_VagnoRe)));  %%����Ҷ��任
subplot(1,3,2),imshow(uint8(255.*mat2gray(Fin_Pc1)));  %%��ʾ����Բ�˲��Ľ��
title(['��Ѱ뾶Ϊ',num2str(bestR),'��Բ�����˲��Ľ��']);
buf=(abs(H)).^2;
bestK=0.05;
Pc_vagnore=Pc_vague_No./H.*buf./(buf+bestK);     %%���Kֵ�µ���任Ƶ��
Pc_vagnore1=real(ifft2(ifftshift(Pc_vagnore)));
subplot(1,3,3),imshow(uint8(255.*mat2gray(Pc_vagnore1)));  %%��ʾά���˲��Ľ��
title(['���ϵ��K',num2str(bestK),'ά���˲��Ľ��']);