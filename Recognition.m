function varargout = Recognition(varargin)
% Recognition MATLAB code for Recognition.fig
%      Recognition, by itself, creates a new Recognition or raises the existing
%      singleton*.
%
%      H = Recognition returns the handle to a new Recognition or the handle to
%      the existing singleton*.
%
%      Recognition('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Recognition.M with the given input arguments.
%
%      Recognition('Property','Value',...) creates a new Recognition or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Recognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Recognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Recognition

% Last Modified by GUIDE v2.5 29-Jun-2023 06:03:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Recognition_OpeningFcn, ...
                   'gui_OutputFcn',  @Recognition_OutputFcn, ...
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


% --- Executes just before Recognition is made visible.
function Recognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Recognition (see VARARGIN)

% Choose default command line output for Recognition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%---------------------
% UIWAIT makes Recognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%set(handles.text9, 'Visible', 'off');

% --- Outputs from this function are returned to the command line.
function varargout = Recognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

%set(handles.text11, 'Visible', 'off');
%set(handles.text12, 'Visible', 'off');
%set(handles.text13, 'Visible', 'off');
%set(handles.text14, 'Visible', 'off');
%set(handles.text15, 'Visible', 'off');
varargout{1} = handles.output;




% --- Executes on button press in pushbutton3.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% P = str2num(get(handles.edit1,'string'));
 global   myDatabase1 minmax;
  % cla('reset');   
%set(handles.text11, 'Visible', 'off');
%set(handles.text12, 'Visible', 'off');
%set(handles.axes5, 'Visible', 'off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q = str2num(get(handles.edit5,'string'));
 
%R =(strcat(int2str(Q)));
%disp(Q)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [file_name file_path] = uigetfile ({'Test/*.png'});
            if file_path ~= 0
                filename = [file_path,file_name];                
               % facerec (filename,myDatabase,minmax);  
                
            end
            a = imread(filename);
      axes(handles.axes4)
imshow(a);
title('Input-Sign','Color','white','FontSize',16);
 %cla(handles.axes5)
 
 
 I=a;
try
    I = rgb2gray(I);   

end

%imwrite(I,'1.pgm');
%figure(1),

 % subplot(1,2,1),imshow(I)
%title('Grayscale Image','Color','blue','FontSize',15);
axes(handles.axes5)
imshow(I);
title('Pre-Processing','Color','white','FontSize',16);
% cla(handles.axes5)
pout_imadjust = imadjust(I);

%pout=I;

pout=imhist(pout_imadjust);

axes(handles.axes6)
plot(pout);
title('Histogram ','Color','white','FontSize',16);


axes(handles.axes7)
imshow(pout_imadjust)
title('Enhanced Image','Color','white','FontSize',16);

imwrite(pout_imadjust,'1.pgm')


I2 = imadjust(I);


I2 = imresize(I2,[56 46]);
I2 = ordfilt2(I2,1,true(3));

min_coeffs = minmax(1,:);
max_coeffs = minmax(2,:);
delta_coeffs = minmax(3,:);
seq = zeros(1,52);
for blk_begin=1:52    
    blk = I2(blk_begin:blk_begin+4,:);    
    [U,S,V] = svd(double(blk));
    blk_coeffs = [U(1,1) S(1,1) S(2,2)];
    blk_coeffs = max([blk_coeffs;min_coeffs]);        
    blk_coeffs = min([blk_coeffs;max_coeffs]);                    
    qt = floor((blk_coeffs-min_coeffs)./delta_coeffs);
    label = qt(1)*7*10+qt(2)*7+qt(3)+1;                   
    seq(1,blk_begin) = label;
end     


%% number_of_persons_in_database 

number_of_persons_in_database = size(myDatabase1,2);
results = zeros(1,number_of_persons_in_database);

for i=1:Q    
    TRANS = myDatabase1{6,i}{1,1};
    EMIS = myDatabase1{6,i}{1,2};

    [ignore,logpseq] = hmmdecode(seq,TRANS,EMIS); 
    v=hmmdecode(seq,TRANS,EMIS);
    %set(handles.text10, 'Visible', 'on');
   % set(handles.text11, 'Visible', 'off');
   % axes(handles.axes4)
 %plot(seqmat);
  %  plot(v)
  
 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %  plot(v)
    P=exp(logpseq);
    results(1,i) = P;

end




[maxlogpseq,person_index] = max(results);
disp('HELLO: ')
  disp(person_index)

%set(handles.text11, 'Visible', 'off');
   % set(handles.text12, 'Visible', 'on');

if ((person_index==Q) && (Q==1))
    axes(handles.axes8)
imshow('1.pgm');
 title('Matched Sign: Harsha','Color','white','FontSize',18);
 drawnow;
 %msgbox('FERTILIZER :: Boon Fugicide ' )
 % hold on


%set(handles.text11, 'Visible', 'off');
%set(handles.text12, 'Visible', 'off');

elseif((person_index==Q) && (Q==2))
    axes(handles.axes8)
imshow('1.pgm');
 title('Matched Sign: Nichitha','Color','white','FontSize',16);
 drawnow;
 % msgbox('FERTILIZER :: Jeevamrut' )
elseif((person_index==Q) && (Q==3))
    axes(handles.axes8)
imshow('1.pgm');
 title('Varshini','Color','white','FontSize',16);
 drawnow;
  % msgbox('FERTILIZER :: Humic Acid' )
elseif((person_index==Q) && (Q==4))
    axes(handles.axes8)
imshow('Vikas.jpg');
 title('Matched Sign: Vikas ','Color','white','FontSize',16);
 drawnow;
%title('Apple -- Good','Color','white','FontSize',16);
 %msgbox('APPLE --' )
  %hold on
 


%set(handles.text11, 'Visible', 'off');
%set(handles.text12, 'Visible', 'off');


else
axes(handles.axes8)
imshow('x.png');
 title('Signature Mismatch','Color','white','FontSize',16);
 
drawnow;

     
end
    




    % --- Executes on button press in pushbutton3.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global   myDatabase1 minmax;
% Q = str2num(get(handles.edit2,'string'));

%axes(handles.axes5)
%imshow(a);
 % hold on

%fprintf(['This person is ',myDatabase{1,person_index},'.\n']);    
    
   

 
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;







% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 % cla('reset');  
% cla reset
delete(findall(findall(gcf,'Type','axe'),'Type','text'));
cla(handles.axes4)
cla(handles.axes5)
cla(handles.axes6)
cla(handles.axes7)
cla(handles.axes8)



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
