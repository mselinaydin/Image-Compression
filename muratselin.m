

function varargout = muratselin(varargin)
% MURATSELIN MATLAB code for muratselin.fig
%      MURATSELIN, by itself, creates a new MURATSELIN or raises the existing
%      singleton*.
%
%      H = MURATSELIN returns the handle to a new MURATSELIN or the handle to
%      the existing singleton*.
%
%      MURATSELIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MURATSELIN.M with the given input arguments.
%
%      MURATSELIN('Property','Value',...) creates a new MURATSELIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before muratselin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to muratselin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help muratselin

% Last Modified by GUIDE v2.5 28-Nov-2012 18:35:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @muratselin_OpeningFcn, ...
                   'gui_OutputFcn',  @muratselin_OutputFcn, ...
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


% --- Executes just before muratselin is made visible.
function muratselin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to muratselin (see VARARGIN)

% Choose default command line output for muratselin
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes muratselin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = muratselin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in newImage.
function newImage_Callback(hObject, eventdata, handles)
% hObject    handle to newImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global oldImage;
global newImage;
global oldImageName;
global imageName;
[filename, pathname] = uigetfile('*.ppm', 'Pick a ppm file');
oldImageName = filename;
if isequal(filename,0) | isequal(pathname,0)
    disp('User pressed cancel')
else
    disp(['User selected ', fullfile(pathname, filename)])
end
newImage = 0;
oldImage = imread(filename);
imageName = filename;
axis(handles.axes1);
image(oldImage,'Parent',handles.axes1);

% --- Executes on button press in saveImage.
function saveImage_Callback(hObject, eventdata, handles)
% hObject    handle to saveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global oldImageName;
global newImage;
global imageName;
global newF;
global compressStr;
%[fileName,pathName] = uiputfile('*.ppm','PPM Files(*.ppm)',strcat('output_', oldImageName));
%name = fullfile(pathName,fileName);
%imwrite(newImage,name);

type = ''
if compressStr == 0
	type = '.msf'
elseif compressStr == 1
	type = '.msc'
else
	type = '.msh'
end
fid = fopen(strcat(name,type),'w');
fwrite(fid,newF);


% --- Executes on button press in compressButton.
function compressButton_Callback(hObject, eventdata, handles)
% hObject    handle to compressButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global oldImage;
global newImage;
global newF;
global compressStr;
global imageName;

[newImage,newF,ratio] = compute(oldImage, compressStr,imageName);
axis(handles.axes4);
imshow(newImage,'Parent',handles.axes4);
axis(handles.axes5);
imshow(newF,'Parent',handles.axes5);
set(handles.compRatio,'String',ratio);

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

global compressStr;
compressStr = get(hObject, 'Value');


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
