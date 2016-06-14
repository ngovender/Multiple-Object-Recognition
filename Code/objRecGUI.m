function varargout = objRecGUI(varargin)
% OBJRECGUI M-file for objRecGUI.fig
%      OBJRECGUI, by itself, creates a new OBJRECGUI or raises the existing
%      singleton*.
%
%      H = OBJRECGUI returns the handle to a new OBJRECGUI or the handle to
%      the existing singleton*.
%
%      OBJRECGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OBJRECGUI.M with the given input arguments.
%
%      OBJRECGUI('Property','Value',...) creates a new OBJRECGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before objRecGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to objRecGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help objRecGUI

% Last Modified by GUIDE v2.5 17-Nov-2011 12:11:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @objRecGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @objRecGUI_OutputFcn, ...
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


% --- Executes just before objRecGUI is made visible.
function objRecGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to objRecGUI (see VARARGIN)

% Choose default command line output for objRecGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes objRecGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = objRecGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in recognise.
function recognise_Callback(hObject, eventdata, handles)
% hObject    handle to recognise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename1, pathname1] = uigetfile_name('*.bmp;*.jpg;*.gif','Pick an input image')
load_2images(h, eventdata, handles, varargin, filename1, pathname1,filename2, pathname2);




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
