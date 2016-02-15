function varargout = testGUI(varargin)
% TESTGUI MATLAB code for testGUI.fig
%      TESTGUI, by itself, creates a new TESTGUI or raises the existing
%      singleton*.
%
%      H = TESTGUI returns the handle to a new TESTGUI or the handle to
%      the existing singleton*.
%
%      TESTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTGUI.M with the given input arguments.
%
%      TESTGUI('Property','Value',...) creates a new TESTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testGUI

% Last Modified by GUIDE v2.5 15-Feb-2016 17:11:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @testGUI_OutputFcn, ...
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


% --- Executes just before testGUI is made visible.
function testGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testGUI (see VARARGIN)

% Choose default command line output for testGUI
handles.output = hObject;

 % set the sample rate (Hz)
 handles.Fs       = 8192;
 handles.y        = zeros(1024, 1, 'double');
 % create the recorder
 handles.player = audioplayer(handles.y, handles.Fs);   
 handles.recorder = audiorecorder(handles.Fs,16,1); % audiorecorder(Fs,nBits,nChannels) 
 % assign a timer function to the recorder
% set(handles.recorder,'TimerPeriod',1,'TimerFcn',{@audioTimer,hObject});

 % save the handles structure
  handles.filename = [datestr(now,'yyyy-mm-dd_HHMMSS') '.wav'];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{2} = handles.output;


% --- Executes on button press in Start_Recording.
function Start_Recording_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Recording (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
disp('start recording');
record(handles.recorder,5);
guidata(hObject,handles);


% Hint: get(hObject,'Value') returns toggle state of Start_Recording


% --- Executes on button press in Finish_Recording.
function Finish_Recording_Callback(hObject, eventdata, handles)
% hObject    handle to Finish_Recording (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 % save the recorder to file
handles = guidata(hObject);
disp('End of Recording.');
stop(handles.recorder);
audiowrite(handles.filename,handles.y,handles.Fs);
% audiowrite(filename,y,Fs)
info = audioinfo(handles.filename);
disp(info);




% --- Executes on button press in Filtering.
function Filtering_Callback(hObject, eventdata, handles)
% hObject    handle to Filtering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in Playback.
function Playback_Callback(hObject, eventdata, handles)
% hObject    handle to Playback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
[y,Fs] = audioread(handles.filename);
sound(y,Fs);

disp('sound played');



function audioTimer(hObject,varargin)
% get the handle to the figure/GUI  (this is the handle we passed in 
 % when creating the timer function in myGuiName_OpeningFcn)
 hFigure = varargin{2};
 % get the handles structure so we can access the plots/axes
 handles = guidata(hFigure);
 % get the audio samples
 samples = getaudiodata(hObject);
