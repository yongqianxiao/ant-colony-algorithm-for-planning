function varargout = selectTunnelType(varargin)
% SELECTTUNNELTYPE MATLAB code for selectTunnelType.fig
%      SELECTTUNNELTYPE, by itself, creates a new SELECTTUNNELTYPE or raises the existing
%      singleton*.
%
%      H = SELECTTUNNELTYPE returns the handle to a new SELECTTUNNELTYPE or the handle to
%      the existing singleton*.
%
%      SELECTTUNNELTYPE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECTTUNNELTYPE.M with the given input arguments.
%
%      SELECTTUNNELTYPE('Property','Value',...) creates a new SELECTTUNNELTYPE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before selectTunnelType_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to selectTunnelType_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help selectTunnelType

% Last Modified by GUIDE v2.5 08-Jul-2017 17:22:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @selectTunnelType_OpeningFcn, ...
                   'gui_OutputFcn',  @selectTunnelType_OutputFcn, ...
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


% --- Executes just before selectTunnelType is made visible.
function selectTunnelType_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to selectTunnelType (see VARARGIN)
%--------------------加载图片
horse=imread('horseshoeTunnel.jpg');
set(handles.pb_horseTunnel,'cdata',horse);
road=imread('roadTunnel.jpg');
set(handles.pb_roadTunnel,'cdata',road);
water=imread('waterTunnel.jpg');
set(handles.pb_waterTunnel,'cdata',water);
% Choose default command line output for selectTunnelType
handles.output = hObject;

handles.tunnelType=0;     % 隧道类型

handles.obj=varargin{1};            % 获得父窗口对象句柄，并保存在当前窗口的handles结构体中
hdl=varargin{2};                     % 获得父窗口所有控件的句柄列表
handles.handle=hdl;                  % 将父窗口所有控件的句柄存在当前窗口结构体handles中的handle结构体中
%-----------------接收父窗口的信息
handles.obj=varargin{1};
sprintf('接收到的type=%d',handles.handle.type);
% Update handles structure
guidata(hObject, handles);
uiwait(handles.figure1);

% UIWAIT makes selectTunnelType wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = selectTunnelType_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
delete(handles.figure1);

function figure1_CloseRequestFcn(hObject, eventdata, handles)

% hObject ? ?handle to figure1 (see GCBO)

% eventdata ?reserved - to be defined in a future versionof MATLAB

% handles ? ?structure with handles and user data (seeGUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
% TheGUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
% TheGUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes on button press in pb_waterTunnel.
function pb_waterTunnel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_waterTunnel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.tunnelType=1;
% disp(handles.tunnelType);
uiresume(handles.figure1);
global type;
type=1;
global tunnel;
tunnel.type=1;
water=imread('waterTunnel.jpg');
set(handles.handle.pb_Tunnel,'visible','on');       % 设置坐标轴上显示标准隧道类型图片的按钮为显示状态
set(handles.handle.pb_Tunnel,'cdata',water);

% --- Executes on button press in pb_roadTunnel.
function pb_roadTunnel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_roadTunnel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.tunnelType=2;
% disp(handles.tunnelType);
uiresume(handles.figure1);
global type;
type=2;
global tunnel;
tunnel.type=2;
road=imread('roadTunnel.jpg');
set(handles.handle.pb_Tunnel,'visible','on');       % 设置坐标轴上显示标准隧道类型图片的按钮为显示状态
set(handles.handle.pb_Tunnel,'cdata',road);

% --- Executes on button press in pb_horseTunnel.
function pb_horseTunnel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_horseTunnel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.tunnelType=3;
disp(handles.tunnelType);
global type;
type=3;
global tunnel;
tunnel.type=3;
uiresume(handles.figure1);
horse=imread('horseshoeTunnel.jpg');
set(handles.handle.pb_Tunnel,'visible','on');       % 设置坐标轴上显示标准隧道类型图片的按钮为显示状态
set(handles.handle.pb_Tunnel,'cdata',horse);
