function varargout = Opcc(varargin)
% OPCC MATLAB code for Opcc.fig
%      OPCC, by itself, creates a new OPCC or raises the existing
%      singleton*.
%
%      H = OPCC returns the handle to a new OPCC or the handle to
%      the existing singleton*.
%
%      OPCC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPCC.M with the given input arguments.
%
%      OPCC('Property','Value',...) creates a new OPCC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Opcc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Opcc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Opcc

% Last Modified by GUIDE v2.5 29-Jan-2016 18:02:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Opcc_OpeningFcn, ...
                   'gui_OutputFcn',  @Opcc_OutputFcn, ...
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


% --- Executes just before Opcc is made visible.
function Opcc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Opcc (see VARARGIN)

% Choose default command line output for Opcc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Opcc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Opcc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function fx_Callback(hObject, eventdata, handles)
% hObject    handle to fx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fx as text
%        str2double(get(hObject,'String')) returns contents of fx as a double


% --- Executes during object creation, after setting all properties.
function fx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%%  Para univariables %%
global f1 f2 x  c
c=get(handles.fx,'string')
x= sym('x','real');
f1=diff(c,x,1);
f2=diff(c,x,2);
set(handles.f1R,'string',char(f1));
set(handles.f2R,'string',char(f2));


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in eval.
function eval_Callback(hObject, eventdata, handles)
%% Evaluar la función
global f2 f1 x
format short
xma= vpa(subs(f2,x,2));
xi= vpa(subs(f2,x,0));
xme= vpa(subs(f2,x,-2));
set(handles.text12,'string',char((xma)));
set(handles.text13,'string',char((xi)));
set(handles.text14,'string',char((xme)));
if xma>0
set(handles.text16,'string','Convexa');   
elseif xma==0
set(handles.text16,'string','Convexa o Cóncava');  
else
set(handles.text16,'string','Cóncava');      
end 
if xi==0
set(handles.text17,'string','Convexa o Cóncava');    
elseif xi>0
set(handles.text17,'string','Convexa');
elseif xi<0
set(handles.text17,'string','Cóncava');      
end 
if xme<0
set(handles.text18,'string','Cóncava');
elseif xme==0
set(handles.text18,'string','Convexa o Cóncava');
elseif xme>0
set(handles.text18,'string','Convexa');      
end 


% hObject    handle to eval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton2'
        
    case 'radiobutton3'
        
end

% hObject    handle to the selected object in uipanel2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
