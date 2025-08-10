function varargout = Code_Book(varargin)
% CODE_BOOK MATLAB code for Code_Book.fig
%      CODE_BOOK, by itself, creates a new CODE_BOOK or raises the existing
%      singleton*.
%
%      H = CODE_BOOK returns the handle to a new CODE_BOOK or the handle to
%      the existing singleton*.
%
%      CODE_BOOK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CODE_BOOK.M with the given input arguments.
%
%      CODE_BOOK('Property','Value',...) creates a new CODE_BOOK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Code_Book_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Code_Book_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Code_Book

% Last Modified by GUIDE v2.5 28-Apr-2015 14:20:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Code_Book_OpeningFcn, ...
                   'gui_OutputFcn',  @Code_Book_OutputFcn, ...
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


% --- Executes just before Code_Book is made visible.
function Code_Book_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Code_Book (see VARARGIN)

% Choose default command line output for Code_Book
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%---------------------
% UIWAIT makes Code_Book wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%set(handles.text9, 'Visible', 'off');

% --- Outputs from this function are returned to the command line.
function varargout = Code_Book_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
set(handles.text9, 'Visible', 'off');
set(handles.text10, 'Visible', 'off');

set(handles.text12, 'Visible', 'off');
set(handles.text13, 'Visible', 'off');
set(handles.axes4, 'Visible', 'off');
%axes(handles.axes4)
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  minmax  myDatabase1 myDatabase2 myDatabase3 myDatabase4 myDatabase5  myDatabase6;

%axes(handles.axes4)
%cla
%set(handles.text9, 'Visible', 'on');
%set(handles.text10, 'Visible', 'on');

%set(handles.text9, 'Visible', 'on');
h = msgbox('Loading Database............' )
set(handles.text13, 'Visible', 'off');
set(handles.text12, 'Visible', 'on');

hold on
 P = str2num(get(handles.edit1,'string'));
 Q = str2num(get(handles.edit2,'string'));
 %R = str2num(get(handles.edit3,'string'));
% S = get(handles.popupmenu2, 'value');

     

eps= 0.000001;
ufft = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];  %% ufft = [1 5 6 8 10];
fprintf ('Loading Database 1...\n');

data_folder_contents = dir ('./Train');
myDatabase1 = cell(0,0);
person_index = 0;
max_coeffs = [-Inf -Inf -Inf];
min_coeffs = [ Inf  0  0];
for person=1:size(data_folder_contents,1);
    if (strcmp(data_folder_contents(person,1).name,'.') || ...
        strcmp(data_folder_contents(person,1).name,'..') || ...
        (data_folder_contents(person,1).isdir == 0))
        continue;
    end
    person_index = person_index+1;
    person_name = data_folder_contents(person,1).name;
    myDatabase1{1,person_index} = person_name;
    fprintf([person_name,' ']);
    person_folder_contents = dir(['./Train/',person_name,'/*.pgm']);    
    blk_cell = cell(0,0);
    for face_index=1:P
        I = imread(['./Train/',person_name,'/',person_folder_contents(ufft(face_index),1).name]);
       
        I = imresize(I,[100 46]);
       
        
        I = ordfilt2(I,1,true(3));        
        blk_index = 0;
        for blk_begin=1:16
            blk_index=blk_index+1;
            blk = I(blk_begin:blk_begin+4,:);            
            [U,S,V] = svd(double(blk));
            blk_coeffs = [U(1,1) S(1,1) S(2,2)];
            max_coeffs = max([max_coeffs;blk_coeffs]);
            min_coeffs = min([min_coeffs;blk_coeffs]);
            blk_cell{blk_index,face_index} = blk_coeffs;
        end
    end
    myDatabase1{2,person_index} = blk_cell;
    if (mod(person_index,10)==0)
        fprintf('\n');
    end
end
delta = (max_coeffs-min_coeffs)./([18 10 7]-eps);
minmax = [min_coeffs;max_coeffs;delta];
for person_index=1:Q
    for image_index=1:P
        for block_index=1:16
            blk_coeffs = myDatabase1{2,person_index}{block_index,image_index};
            min_coeffs = minmax(1,:);
            delta_coeffs = minmax(3,:);
            qt = floor((blk_coeffs-min_coeffs)./delta_coeffs);
            myDatabase1{3,person_index}{block_index,image_index} = qt;
            label = qt(1)*10*7+qt(2)*7+qt(3)+1;            
            myDatabase1{4,person_index}{block_index,image_index} = label;
        end
        myDatabase1{5,person_index}{1,image_index} = cell2mat(myDatabase1{4,person_index}(:,image_index));
    end
end

TRGUESS = ones(7,7) * eps;
TRGUESS(7,7) = 1;
for r=1:6
        TRGUESS(r,r) = 0.6;
        TRGUESS(r,r+1) = 0.4;    
end

EMITGUESS = (1/1260)*ones(7,1260);

fprintf('\nTraining ...\n');
for person_index=1:Q
   fprintf([myDatabase1{1,person_index},' ']);
    seqmat = cell2mat(myDatabase1{5,person_index})';
    %axes(handles.axes4)
% plot(seqmat);

 [ESTTR,ESTEMIT]=hmmtrain(seqmat,TRGUESS,EMITGUESS,'Tolerance',.01,'Maxiterations',20,'Algorithm', 'BaumWelch');
    
  
 ESTTR = max(ESTTR,eps);
    ESTEMIT = max(ESTEMIT,eps);

    myDatabase1{6,person_index}{1,1} = ESTTR;
    myDatabase1{6,person_index}{1,2} = ESTEMIT;
   if (mod(person_index,10)==0)
       fprintf('\n');
    end
end
fprintf('Database Loaded 1\n');
% msgbox('Database Loaded 1' )

save DATABASE myDatabase1 minmax


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
