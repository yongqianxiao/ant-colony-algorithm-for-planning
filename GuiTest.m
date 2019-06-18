%% 该软件用作凿岩机器人的离线孔序规划
% 作者：肖永前
% 学校：中南大学
% 邮箱：shawyongqian@gmail.com
function varargout = GuiTest(varargin)
% GUITEST MATLAB code for GuiTest.fig
%      GUITEST, by itself, creates a new GUITEST or raises the existing
%      singleton*.
%
%      H = GUITEST returns the handle to a new GUITEST or the handle to
%      the existing singleton*.
%
%      GUITEST('CALLBACK',hObject,eventDatda,handles,...) calls the local
%      function named CALLBACK in GUITEST.M with the given input arguments.
%
%      GUITEST('Property','Value',...) creates a new GUITEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GuiTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GuiTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GuiTest

% Last Modified by GUIDE v2.5 15-Aug-2017 16:47:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GuiTest_OpeningFcn, ...
                   'gui_OutputFcn',  @GuiTest_OutputFcn, ...
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


% --- Executes just before GuiTest is made visible.
function GuiTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GuiTest (see VARARGIN)
% Choose default command line output for GuiTest
global undo reundo sequenceflag;
undo=struct('undo1',[],'undo2',[],'undo3',[],'undo4',[],'undo5',[],'undo6',[],'undo7',[],'undoNum',0);
reundo=struct('reundo1',[],'reundo2',[],'reundo3',[],'reundo4',[],'reundo5',[],'reundo6',[],'reundo7',[],'reundoNum',0);
handles.type=0;
sequenceflag = false;
% 初始化窗口的位置
handles.output = hObject;
h = get(gcf,'Position');
h = [5 5 h(3:4)];
set(gcf,'Position',h);

% ---------设置面板的父控件
set(handles.panel_addHole,'Parent',gcf);
set(handles.panel_changeSize,'Parent',gcf);
set(handles.panel_assignHole,'Parent',gcf);
set(handles.panel_deleteHole,'Parent',gcf);
set(handles.panel_drawTunnel,'Parent',gcf);
set(handles.panel_drillSequence,'Parent',gcf);
% ---------设置添加孔为显示面板，其他为隐藏
set(handles.panel_addHole,'visible','on');
set(handles.panel_changeSize,'visible','off');
set(handles.panel_assignHole,'visible','off');
set(handles.panel_deleteHole,'visible','off');
set(handles.panel_drawTunnel,'visible','off');
set(handles.panel_drillSequence,'visible','off');
% ------------父窗口和子窗口的通讯-----(测试作为子窗口)
% 获得父窗口对象句柄，并保存在当前窗口的handles结构体中
%handles.obj=varargin{1};
% 获得父窗口所有控件的句柄列表
%hdl=varargin{2};
% 将父窗口所有控件的句柄存在当前窗口结构体handles中的handle结构体中
%handles.handle=hdl;
% Update handles structure
%% 初始化仿真菜单下孔任务按钮的Enable
set(handles.optHoleTask,'Enable','off');
set(handles.simulateSequence,'Enable','off');

% ============================================================
% ----------作为父窗口
H=selectTunnelType(hObject,handles);
handles.tunnelType=H;
% 添加工具条
% set(hObject,'toolbar','figure') 
% 初始化各臂孔为空
handles.leftHoles=[];
handles.midHoles=[];
handles.rightHoles=[];
set(hObject,'toolbar','none') ;
guidata(hObject, handles);

% UIWAIT makes GuiTest wait for user response (see UIRESUME)
% uiwait(handles.mainfigure);


% --- Outputs from this function are returned to the command line.
function varargout = GuiTest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% 
% 先清屏
% h=get(handles.axes1,'children');
% delete(h);
global type;
global tunnel;
global holes;
holes=[];
% 如果用户进软件时没有选择隧道类型，则初始化一个
if isempty(type)
    type=2;
end
switch type
    case 1
        tunnel.type=1;
        tunnel.size.R=3.31;
        tunnel.size.t=5;
        tunnel.size.a=2.16;
        tunnel.size.l=0;
        tunnel.size.r=0;
        initTunnelAxes( tunnel,handles );
    case 2
        tunnel.type=2;
        tunnel.size.R=8;
        tunnel.size.a=4;
        tunnel.size.l=0;
        tunnel.size.r=0;
        tunnel.size.t=0;
        initTunnelAxes( tunnel,handles );
    case 3
        tunnel.type=3;
        tunnel.size.R=8;
        tunnel.size.a=4;
        tunnel.size.l=0;
        tunnel.size.r=0;
        tunnel.size.t=0;
        initTunnelAxes( tunnel,handles );
end
% switch type
%     case 1
%         set(handles.tx_tunnelType,'String','输水隧道');
%         waterTunnel( 3.31, 5, 2.16, 0, 0 );
%         water=imread('waterTunnel.jpg');
%         set(handles.pb_Tunnel,'cdata',water);
%         tunnel.type=1;
%         tunnel.size.R=3.31;
%         tunnel.size.t=5;
%         tunnel.size.a=2.16;
%         tunnel.size.l=0;
%         tunnel.size.r=0;
%     case 2
%         set(handles.tx_tunnelType,'String','公路隧道');
%         roadTunnel(4.79, 1.53, 0, 0);
%         road=imread('roadTunnel.jpg');
%         set(handles.pb_Tunnel,'cdata',road);
%         tunnel.type=2;
%         tunnel.size.R=4.79;
%         tunnel.size.a=1.53;
%         tunnel.size.l=0;
%         tunnel.size.r=0;
%         tunnel.size.t=0;
%     case 3
%         set(handles.tx_tunnelType,'String','马蹄形隧道');
%         horseshoeTunnel( 4, 3.8, 1, 0.5 );
%         horse=imread('horseshoeTunnel.jpg');
%         set(handles.pb_Tunnel,'cdata',horse);
%         tunnel.type=3;
%         tunnel.size.R=4;
%         tunnel.size.a=3.8;
%         tunnel.size.l=1;
%         tunnel.size.r=0.5;
%         tunnel.size.t=0;
% end

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 获取用户打开文件的路径
set(handles.pb_Tunnel,'visible','off');
h=get(handles.axes1,'children');
delete(h);
axis([-9 9 -1 11]);

global holes;
[filename, pathname] = ...
     uigetfile({'*.xlsx';'*.xls';'*.mat';'*.txt'},'请选择规定格式的数据文件');
 % 拼接路径和文件名
 filepath=strcat(pathname,filename);
 % 判断要打开的是什么类型的文件
 if ~isempty(strfind(filename,'.xlsx')) || ~isempty(strfind(filename,'.xls'))
     % 加载数据
     [~,Sheets,~] = xlsfinfo(filepath);
     if length(Sheets) == 3
         [holes_array]=xlsread(filepath,1);
         [midHoles_array]=xlsread(filepath,2);
         [rightHoles_array]=xlsread(filepath,3);
         holes_array=[holes_array;midHoles_array;rightHoles_array];
     elseif length(Sheets) == 1
         holes_array = xlsread(filepath);
     end
 end
if ~isempty(strfind(filename,'.txt')) || ~isempty(strfind(filename,'.text'))
%    fileID=fopen(filepath);
    %表头,不能省，否则不能读出数据
%     formatSpec='%s';
%     N=7;
%     header=textscan(fileID,formatSpec,N,'Delimiter',',');
%     holes_cell=textscan(fileID,'%f %f %f %f %f %f %f');
%     holes_array=[holes_cell{1},holes_cell{2},holes_cell{3},holes_cell{4},holes_cell{5},holes_cell{6},holes_cell{7}];
    
    % 不含表头的txt
    holes_array=load(filepath);
end
holeNums=size(holes_array,1);
for i=1:holeNums
%     holes(i).num=holes_array(i,1);
    holes(i).num=i;
    holes(i).x=holes_array(i,2);
    holes(i).y=holes_array(i,3);
    holes(i).r=holes_array(i,4);
    holes(i).depth=holes_array(i,5);
    holes(i).biasAngle=holes_array(i,6)*pi/180;
    holes(i).inclineAngle=holes_array(i,7);
%     drawSingleCircle( holes(i).x,holes(i).y,holes(i).r,...
%         holes(i).biasAngle,holes(i).inclineAngle,handles.axes1,'g' );                               
end
refresh_ClickedCallback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global holes;
isSimulating = get(handles.simulateMode,'Checked');
if isfield(handles,'leftHoles') && isfield(handles,'midHoles') && isfield(handles,'rightHoles') && strcmpi(isSimulating,'on')
    leftHoles=handles.leftHoles;
    midHoles=handles.midHoles;
    rightHoles=handles.rightHoles;
else
    leftHoles = [];
    midHoles = [];
    rightHoles = [];
end
[filename,pathname]=uiputfile({'*.xlsx';'*.txt'},'保存数据');
filepath=strcat(pathname,filename);
outHoles=holes;
if isempty(leftHoles) && isempty(midHoles) && isempty(rightHoles)
    % 将孔数据的偏角由弧度转为度
    for i=1:length(outHoles)
        outHoles(i).biasAngle=outHoles(i).biasAngle*180/pi;
    end
    % 将结构体数组转换为元胞数组
    holes_cell=struct2cell(outHoles);
    % 取得元胞数组的尺寸，7x1x孔数
    holes_size=size(holes_cell);
    % 元胞数组尺寸的行即为孔数据的字段数
    property = holes_size(1);
    % 取元胞数组中所有元素为普通数组
    holes_data=holes_cell(1:property,:);
    % 转置
    holes_data=holes_data';
% else
%     % 将孔数据的偏角由弧度转为度
%     for i=1:length(leftHoles)
%         leftHoles(i).biasAngle=leftHoles(i).biasAngle*180/pi;
%     end
%     for i=1:length(midHoles)
%         midHoles(i).biasAngle=midHoles(i).biasAngle*180/pi;
%     end
%     for i=1:length(rightHoles)
%         rightHoles(i).biasAngle=rightHoles(i).biasAngle*180/pi;
%     end
%     % 将结构体数组转换为元胞数组
%     leftHoles_cell=struct2cell(leftHoles);
%     midHoles_cell=struct2cell(midHoles);
%     rightHoles_cell=struct2cell(rightHoles);
%     % 取得元胞数组的尺寸，7x1x孔数
%     leftHoles_size=size(leftHoles_cell);
%     midHoles_size=size(midHoles_cell);
%     rightHoles_size=size(rightHoles_cell);
%     % 元胞数组尺寸的行即为孔数据的字段数
%     left_property = leftHoles_size(1);
%     mid_property = midHoles_size(1);
%     right_property = rightHoles_size(1);
%     % 取元胞数组中所有元素为普通数组
%     leftHoles_data=leftHoles_cell(1:left_property,:)';
%     midHoles_data=midHoles_cell(1:mid_property,:)';
%     rightHoles_data=rightHoles_cell(1:right_property,:)';
end

% 表头
header={'孔号','x','y','孔径r','孔深','偏角','探出角'};

%% 判断要保存的是什么格式的文件
% 保存到xlsx或xls文件格式
if ~isempty(strfind(filename,'.xlsx')) || ~isempty(strfind(filename,'.xls'))
    % 写入到excel文件,status---保存成功返回1，否则返回0；message---保存失败的原因，string类型
    if isempty(leftHoles) && isempty(midHoles) && isempty(rightHoles)
        if exist(filepath,'file')
            [~,Sheets,~] = xlsfinfo(filepath);
            if length(Sheets)>1
                delete(filepath);
            end
        end
        % 将表头置于表数据第一行
        holes_data=[header ; holes_data];
        [status,~]=xlswrite(filepath,holes_data);
        if status==1
            % 保存成功
            msgbox('保存成功','Success');
        else
            % 保存失败
            errordlg('保存失败','Fail');
        end
    else
        % 将普通数组转化为元胞数组才能保存到excel表格中
        leftHoles_data=[header ; num2cell(leftHoles)];
        midHoles_data=[header ; num2cell(midHoles)];
        rightHoles_data=[header ; num2cell(rightHoles)];
        [status1,~]=xlswrite(filepath,leftHoles_data,1);
        [status2,~]=xlswrite(filepath,midHoles_data,2);
        [status3,~]=xlswrite(filepath,rightHoles_data,3);
        if status1 && status2 && status3
            % 保存成功
            msgbox('保存成功','Success');
        else
            % 保存失败
            errordlg('保存失败','Fail');
        end
    end
    
end
% 保存到txt文件
if ~isempty(strfind(filename,'.text')) || ~isempty(strfind(filename,'.txt'))
    holes_array=cell2mat(holes_data);
    dlmwrite(filepath,holes_array,'precision','%.3f','newline','pc');
%    dlmwrite(filepath,header,'newline','pc','precision','%ss');
%    dlmwrite(filepath,holes_array,'-append','precision','%.3f','newline','pc');
%     fileID=fopen(filepath,'w');
%     fprintf(fileID,'%d %f %f %f %f %f %f \r',holes_array);
end


% --- Executes on button press in pb_addSingleHole.
function pb_addSingleHole_Callback(hObject, eventdata, handles) 
% hObject    handle to pb_addSingleHole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp(handles.tunnelType);

global holes undo reundo tunnel;

% ===========================
% X --- 要添加的孔的X坐标，单位m
% Y --- 要添加的孔的Y坐标，单位m
% r --- 要添加的孔的半径，单位mm
% depth --- 要添加的孔的孔深，单位m
% biasAngle --- 要添加的孔的偏角，单位度
% inclineAngle --- 要添加的孔的探出角，单位度
depthstr=get(handles.et_depth,'string');
Xstr=get(handles.et_X,'string');
Ystr=get(handles.et_Y,'string');
rstr=get(handles.et_r,'string');
biasAnglestr=get(handles.et_biasAngle,'string');
inclineAnglestr=get(handles.et_inclineAngle,'string');
depth=str2double(depthstr);
X=str2double(Xstr);
Y=str2double(Ystr);
r=str2double(rstr)/1000;
biasAngle=str2double(biasAnglestr);
while(biasAngle>360)
    biasAngle=biasAngle-360;
end
inclineAngle=str2double(inclineAnglestr);
while(inclineAngle>360)
    inclineAngle=inclineAngle-360;
end
% ------------修改拉框选中孔的孔深或孔径
% holeNum --- 选中的孔的孔号的矩阵
holeNum = handles.holesNum;
if length(holeNum) > 1
    % errorflag --- 用来判断是否参数有误，否则不将其放入撤销的按钮中
    errorflag = 0 ;
    % rowNum --- 用来记录选中的孔在holes中行号
    rowNum = zeros(1,length(holeNum));
    for i=1:length(holeNum)
        rowNum(i) = find([holes.num] == holeNum(i));
    end 
    if ~isnan(depth) && depth>0 && ~isnan(r) && r>0
        % 同时修改选中孔的孔深和孔径
        for j=1:length(holeNum)
            holes(rowNum(j)).depth = depth;
            holes(rowNum(j)).r=r;
        end
    elseif ~isnan(depth) && depth>0 && (isnan(r) || r<0)
        % 只修改选中孔的孔深
        for j=1:length(holeNum)
            holes(rowNum(j)).depth = depth;
        end
    elseif ~isnan(r) && r>0 && (isnan(depth) || depth <0)
        % 只修改选中孔的孔径
        for j=1:length(holeNum)
            holes(rowNum(j)).r=r;
        end
    else
        errorflag = 1;
        errordlg('参数不正确，请重新输入','参数错误');
    end
    if errorflag == 0
        [undo,reundo]=preUndo(holes,undo,reundo,handles);
    end
    refresh_ClickedCallback(hObject, eventdata, handles)
    return;
end
% ----------------------------------
if isnan(X) || isnan(Y) || isnan(r) || isnan(depth) || depth<=0 || r<=0
%     disp('参数不正确');
    errordlg('参数不正确，请重新输入','参数错误');
    return;
end
if isnan(biasAngle)
    biasAngle=0;
end
if isnan(inclineAngle)
    biasAngle=0;
    inclineAngle=0;
end

%% 储存孔数据
holeData.num=length(holes)+1;
holeData.x=X;
holeData.y=Y;
holeData.r=r;
holeData.depth=depth;
holeData.biasAngle=biasAngle*pi/180;
holeData.inclineAngle=inclineAngle;
% 判断要添加的该孔是否已经存在，若存在则覆盖添加------
% 获得当前坐标轴axis
axisValue=axis;
holes = isSingleHoleExist( holes,holeData,tunnel,handles ,axisValue);
drawSingleCircle( X, Y, r,biasAngle, inclineAngle, handles.axes1,'g');
[undo,reundo]=preUndo(holes,undo,reundo,handles);

%disp(holes);
% global totalHoles;
% holeSize=size(totalHoles);
% totalHoles.holeNum=holeSize+1;
% totalHoles.X=X;
% totalHoles.Y=Y;
% totalHoles.r=r;
% totalHoles.biasAngle=biasAngle;
% totalHoles.inclineAngle=inclineAngle;
% totalHoles.depth=depth;
% x(1)=totalHoles;


% plot(X,Y,'go');
% theta = 0:0.01*pi:2*pi;
% x=r*cos(theta)+X;
% y=r*sin(theta)+Y;
% plot(handles.axes1, x, y,'g');
% disp('进入添加孔程序');

% --- Executes on button press in pb_addHole.
function pb_addHole_Callback(hObject, eventdata, handles)
% hObject    handle to pb_addHole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_addHole,'visible','on');
set(handles.panel_changeSize,'visible','off');
set(handles.panel_assignHole,'visible','off');
set(handles.panel_deleteHole,'visible','off');
set(handles.panel_drawTunnel,'visible','off');
set(handles.panel_drillSequence,'visible','off');

% --- Executes on button press in pb_changeSize.
function pb_changeSize_Callback(hObject, eventdata, handles)
% hObject    handle to pb_changeSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_changeSize,'visible','on');
set(handles.panel_addHole,'visible','off');
set(handles.panel_assignHole,'visible','off');
set(handles.panel_deleteHole,'visible','off');
set(handles.panel_drawTunnel,'visible','off');
set(handles.panel_drillSequence,'visible','off');

% --- Executes on button press in pb_assignHole.
function pb_assignHole_Callback(hObject, eventdata, handles)
% hObject    handle to pb_assignHole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_deleteHole,'visible','off');
set(handles.panel_changeSize,'visible','off');
set(handles.panel_addHole,'visible','off');
set(handles.panel_assignHole,'visible','on');
set(handles.panel_drawTunnel,'visible','off');
set(handles.panel_drillSequence,'visible','off');

%% 删除指定的某个孔
function pb_deleteHole_Callback(hObject, eventdata, handles)
% --- Executes on button press in pb_deleteHole.
% hObject    handle to pb_deleteHole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_deleteHole,'visible','on');
set(handles.panel_changeSize,'visible','off');
set(handles.panel_addHole,'visible','off');
set(handles.panel_assignHole,'visible','off');
set(handles.panel_drawTunnel,'visible','off');
set(handles.panel_drillSequence,'visible','off');

% 临时绘制轮廓按钮
function pb_drwaTunnel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_drwaTunnel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_drawTunnel,'visible','on');
set(handles.panel_deleteHole,'visible','off');
set(handles.panel_changeSize,'visible','off');
set(handles.panel_addHole,'visible','off');
set(handles.panel_assignHole,'visible','off');
set(handles.panel_drillSequence,'visible','off');

% --- Executes on button press in pb_sequence.
function pb_sequence_Callback(hObject, eventdata, handles)
% hObject    handle to pb_sequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_drawTunnel,'visible','off');
set(handles.panel_deleteHole,'visible','off');
set(handles.panel_changeSize,'visible','off');
set(handles.panel_addHole,'visible','off');
set(handles.panel_assignHole,'visible','off');
set(handles.panel_drillSequence,'visible','on');

% --- Executes on button press in pb_Tunnel.
function pb_Tunnel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Tunnel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global holes;
global type;
global tunnel;
% flag 用来表示要不要更新页面
flag=0;
if ~isempty(tunnel)
    beforeType=tunnel.type;
else
    beforeType=0;
end
H=selectTunnelType(hObject,handles);
if ~isempty(tunnel)
    afterType=tunnel.type;
    if beforeType == afterType
    % 如果beforeType==afterType，则说明用户只是点了按钮，并没有选择新的隧道
        flag=0;
    else
    % 如果不相等，则说明用户选了新的隧道轮廓，此时需要清空孔数据
    holes=[];
    flag=1;
    end
else
    % 如果tunnel还是为空，则说明用户没有选择新的隧道，且需要初始化一个隧道轮廓
    flag=1;
    type=2;
end
if flag==0
    return;
end
switch type
    case 1
        tunnel.type=1;
        tunnel.size.R=3.31;
        tunnel.size.t=5;
        tunnel.size.a=2.16;
        tunnel.size.l=0;
        tunnel.size.r=0;
        initTunnelAxes( tunnel,handles );
    case 2
        tunnel.type=2;
        tunnel.size.R=8;
        tunnel.size.a=4;
        tunnel.size.l=0;
        tunnel.size.r=0;
        tunnel.size.t=0;
        initTunnelAxes( tunnel,handles );
    case 3
        tunnel.type=3;
        tunnel.size.R=8;
        tunnel.size.a=4;
        tunnel.size.l=0;
        tunnel.size.r=0;
        tunnel.size.t=0;
        initTunnelAxes( tunnel,handles );
end


% -------修改隧道轮廓尺寸-----------
function pb_change_Callback(hObject, eventdata, handles)
% hObject    handle to pb_change (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 清除孔数据
global holes tunnel;
holes=[];
global type;
Rstr=get(handles.et_RCircle,'string');
astr=get(handles.et_aCenter,'string');
lstr=get(handles.et_lHeight,'string');
rstr=get(handles.et_rHeight,'string');
tstr=get(handles.et_tWidth,'string');
R=str2double(Rstr);
a=str2double(astr);
l=str2double(lstr);
r=str2double(rstr);
t=str2double(tstr);

switch type
    case 1
        if isempty(Rstr) || isempty(astr) || isempty(tstr) || isempty(lstr) || isempty(rstr)
            errordlg('尺寸不能为空','尺寸错误');
            return;
        else
            h=get(handles.axes1,'children');
            delete(h);
            waterTunnel( R, t, a, l, r ,[-t-2,t+2 , -l-r-1, a+R+2]);
        end
    case 2
        if isempty(Rstr) || isempty(astr) || isempty(lstr) || isempty(rstr)
            errordlg('尺寸不能为空','尺寸错误');
            return;
        else
            h=get(handles.axes1,'children');
            delete(h);
            roadTunnel(R,a,l,r,[-R-2 R+2 -l-r-1 R+a+2]);
        end        
    case 3
        if isempty(Rstr) || isempty(astr) || isempty(lstr) || isempty(rstr)
            errordlg('尺寸不能为空','尺寸错误');
            return;
        else
            h=get(handles.axes1,'children');
            delete(h);
            horseshoeTunnel( R,a,l,r,[-R-6 R+6 -l-r-1 R+a+2] );
        end             
end
% 只有修改尺寸成功完成之后，才能修改原来tunnel的值
tunnel.type=type;
tunnel.size.R=R;
tunnel.size.a=a;
tunnel.size.l=l;
tunnel.size.r=r;
tunnel.size.t=t;


% -----------布孔按钮--------
function pb_assignFloorHole_Callback(hObject, eventdata, handles)
% hObject    handle to pb_assignFloorHole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ------------------------------------
% upHole --- 隧道上部分的孔距,单位：m
% upFloor --- 隧道上部分的层距,单位：m
% downHole --- 隧道下部分的孔距,单位：m
% downFloor --- 隧道下部分的层距,单位：m
% holesR --- 孔半径,单位：mm
% inclineAngle --- 孔探出角,单位：度
% holesDepth --- 孔深,单位：m 
global undo reundo;
    global holes tunnel;
    upHolestr=get(handles.et_upHoleDis,'string');
%     downHolestr=get(handles.et_downHoleDis,'string');
%     upFloorstr=get(handles.et_upFloorDis,'string');
    downFloorstr=get(handles.et_downFloorDis,'string');
    holesRstr=get(handles.et_holesR,'string');
    inclineAnglestr=get(handles.et_holesInclineAngle,'string');
    holesDepthstr=get(handles.et_holesDepth,'string');
    upHole=str2double(upHolestr);
%     downHole=str2double(downHolestr);
%     upFloor=str2double(upFloorstr);
    downFloor=str2double(downFloorstr);
    holesR=str2double(holesRstr)/1000;
    holesDepth=str2double(holesDepthstr);
    if isempty(inclineAnglestr)
        inclineAngle=0;
    else
        inclineAngle=str2double(inclineAnglestr);
    end
    % 如果圆弧孔距、孔径、孔深小于0，则弹出错误对话框
    if ~(upHole >0 && holesR > 0 && holesDepth > 0)
        errordlg('参数错误，请重新输入','参数错误');
        return;
    end
    if tunnel.type~=250
        try
            Holes=assignHoles( tunnel, holes,upHole, upHole, downFloor, downFloor, handles.axes1, holesR, inclineAngle, holesDepth);
            holes=Holes;
        catch
            errordlg('参数错误，请检查参数','参数错误');
        end
    else
        [sequences,tunnel]=sequence(tunnel);
        if ~isempty(sequences)
            % 返回不是为空，则说明tunnel中有完整的隧道轮廓
            try
                tempTunnel=insideProfile( tunnel,sequences,downFloor );
                [ holes ] = assignCustonHoles( tempTunnel, holes, upHole, handles, holesR, inclineAngle, holesDepth );
            catch
                errordlg('参数错误，请检查参数','参数错误');
            end
        end
    end
    % 保存数据为撤销做准备
    [undo,reundo]=preUndo(holes,undo,reundo,handles);


% --------------------------------------------------------------------
function undo_Callback(hObject, eventdata, handles)
% hObject    handle to undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% -----------------撤销------------
% h --- 获取坐标轴的children属性
% baseSize --- 为当前坐标系中图形句柄的个数，只有坐标系上已经画了孔才让撤销，...
%       否则会把坐标系上原来的隧道轮廓、坐标轴给撤销删除掉
% global type;
% h=get(handles.axes1,'children');
% handles.reundo=h;
% baseSize=length(h);
% switch type
%     case 1
%         if baseSize>4
%             delete(h(1));          
%         end
%     case 2
%         if baseSize>6
%             delete(h(1));
%         end
%     case 3
%         if baseSize>6
%             delete(h(1));
%         end
% end
% guidata(hObject, handles);

% -----------撤销-----------
global undo reundo holes tunnel;
axisValue=axis;
if undo.undoNum>0
    holes=undo.undo2;
    undo.undo2=undo.undo3;
    undo.undo3=undo.undo4;
    undo.undo4=undo.undo5;
    undo.undo5=undo.undo6;
    undo.undo6=undo.undo7;
    undo.undo7=[];
    repaint(tunnel, handles, holes, axisValue);
    undo.undoNum = undo.undoNum - 1;
    % ------------将撤销的添加到回撤中---------
    reundo.reundo7=reundo.reundo6;
    reundo.reundo6=reundo.reundo5;
    reundo.reundo5=reundo.reundo4;
    reundo.reundo4=reundo.reundo3;
    reundo.reundo3=reundo.reundo2;
    reundo.reundo2=reundo.reundo1;
    reundo.reundo1=undo.undo1;
    % 要先把撤销操作之前的孔数据给回撤结构数组
    undo.undo1=undo.undo2;
    if reundo.reundoNum<6
        reundo.reundoNum = reundo.reundoNum + 1;
    end
end
% --------------------------------------------------------------------
function reundo_Callback(hObject, eventdata, handles)
% hObject    handle to reundo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global holes undo reundo tunnel;
if reundo.reundoNum>0
    holes=reundo.reundo1;
    reundo.reundo1 = reundo.reundo2;
    reundo.reundo2 = reundo.reundo3;
    reundo.reundo3 = reundo.reundo4;
    reundo.reundo4 = reundo.reundo5;
    reundo.reundo5 = reundo.reundo6;
    reundo.reundo6 = reundo.reundo7;
    reundo.reundo7=[];
    % 重绘
    repaint(tunnel, handles, holes);
    % 恢复撤销之后，更新孔总数的显示-------------
    if ~isempty(holes)
        set(handles.tx_totalHole,'string',num2str(length(holes)));
    else
        set(handles.tx_totalHole,'string','0');
    end
    % -----------将孔数据添加到可撤销的列表中-------
    [undo,reundo]=preUndo( holes,undo,reundo,handles );
end

% --------------------------------------------------------------------
function undoKey_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to undoKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
undo_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function reundoKey_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to reundoKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
reundo_Callback(hObject, eventdata, handles);

% --- Executes on button press in pb_delete.
function pb_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pb_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 删除指定孔，并将后面的孔往前移一位，后面的孔的孔号减1
% 获取要删除的孔号
holeNumstr=get(handles.et_deleteHoleNum,'string');
holeNum=str2num(holeNumstr);
% 获取是否要删除所有孔
isDeleteAll=get(handles.cb_deleteAllHoles,'value');
global holes undo reundo;
global tunnel;
axisValue=axis;
holes = deleteHoles( holes,tunnel,holeNum,isDeleteAll,handles ,axisValue);
[undo,reundo]=preUndo(holes,undo,reundo,handles);


% -----------------孔序规划主函数------------------------------------
function sequence_Callback(hObject, eventdata, handles)
% hObject    handle to sequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global holes sequenceflag;
global leftHoleArray midHoleArray rightHoleArray;
global tunnel;
if isempty(holes) || length(holes) < 3
    errordlg('当前孔数量无法进行此操作！！！','错误');
    return;
end
leftHoles = [];
midHoles = [];
rightHoles = [];
% 如果handles中没有isInited和isOpted两个字段，则说明肯定没有在仿真下进行初始化和优化分配孔
if ~isfield(handles,'isInited') || ~isfield(handles,'isOpted')
    [ lArmHole,mArmHole,rArmHole ] = firstClass( holes, handles);
    [ leftHoleArray,midHoleArray,rightHoleArray ,simulateArray] = secondClass( lArmHole,mArmHole,rArmHole, handles );
else
    % 如果isInited和isOpted都存在且为true，则说明现在是在仿真下进行孔序规划
    if handles.isInited && handles.isOpted
        leftHoleArray = handles.optLeftHole;
        midHoleArray = handles.optMidHole;
        rightHoleArray = handles.optRightHole;  
%         figure;
        hold on;
    else
        [ lArmHole,mArmHole,rArmHole ] = firstClass( holes, handles);
        [ leftHoleArray,midHoleArray,rightHoleArray ,simulateArray] = secondClass( lArmHole,mArmHole,rArmHole, handles );
    end
end
% % 重置仿真菜单栏
% set(handles.optHoleTask,'Enable','off');
% set(handles.simulateSequence,'Enable','off');
% handles.isInited = false;
% handles.isOpted = false;
%text(2,8,'A Simple Plot','Color','red','FontSize',14)
% initTunnelAxes( tunnel,handles );
% 孔序规划的结果不画隧道轮廓
% currentAxis = handles.axes1.axis;
h=get(handles.axes1,'children');
delete(h);
% axis(currentAxis);
isSimulate = get(handles.simulateMode,'Checked');
if strcmpi(isSimulate,'on')
    isSimulate = true;
else
    isSimulate = false;
end
if ~isempty(midHoleArray)
    mC=midHoleArray(:,2:3);
    [Route,midShortestLength,midLength_best,midLength_ave]=myAcatsp(mC,50,floor(0.8*size(mC,1)),1,7,0.2,100,'*--b',2,isSimulate,0,0);
    % 判断是否需要显示孔序孔号
    if strcmpi(get(handles.show_sequence,'Checked'),'on')
        for i=1:size(midHoleArray,1)
            text(midHoleArray(i,1),midHoleArray(i,2),num2str(i));
        end
    end
    midHoles =  zeros(size(midHoleArray));
    for i=1:size(midHoleArray,1)
        midHoles(i,:)=midHoleArray(Route(i),:);
    end
end
if ~isempty(leftHoleArray)
    lC=leftHoleArray(:,2:3);
    [Route,leftShortestLength,leftLength_best,leftLength_ave]=myAcatsp(lC,50,floor(0.8*size(lC,1)),1,7,0.2,100,'x-r',1,isSimulate,midHoles(end,2),midHoles(end,3));
    % 判断是否需要显示孔序孔号
    if strcmpi(get(handles.show_sequence,'Checked'),'on')
        for i=1:size(leftHoleArray,1)
            text(leftHoleArray(i,1),leftHoleArray(i,2),num2str(i));
        end
    end
    leftHoles =  zeros(size(leftHoleArray));
    for i=1:size(leftHoleArray,1)
        leftHoles(i,:)=leftHoleArray(Route(i),:);
    end
end
% 获取当前孔序规划后的坐标轴（未显示孔序孔号的），以便后面修改显示/隐藏孔序孔号
handles.sequAxes = gca;
if ~isempty(rightHoleArray)
    rC=rightHoleArray(:,2:3);
    [Route,rightShortestLength,rightLength_best,rightLength_ave]=myAcatsp(rC,50,floor(0.8*size(rC,1)),1,7,0.2,100,'o-g',3,isSimulate,midHoles(1,2),midHoles(1,3));
    % 判断是否需要显示孔序孔号
    if strcmpi(get(handles.show_sequence,'Checked'),'on')
        for i=1:size(rightHoleArray,1)
            text(rightHoleArray(i,1),rightHoleArray(i,2),num2str(i));
        end
    end
    rightHoles =  zeros(size(rightHoleArray));
    for i=1:size(rightHoleArray,1)
        rightHoles(i,:)=rightHoleArray(Route(i),:);
    end
end
% 如果是仿真模式，则另外新建窗口绘制一份
if isSimulate && ~isempty(leftHoleArray)
    figure;
    plot(leftHoles(:,2),leftHoles(:,3),'x-r');
    text(leftHoles(1,2),leftHoles(1,3),'起点');
    text(leftHoles(end,2),leftHoles(end,3),'终点');
    set(gcf,'Name','左臂路径');
    xlabel('孔位横坐标/m');
    ylabel('孔位纵坐标/m');
    title(['最短距离：' num2str(leftShortestLength) ]);
    figure;
    plot(1:50,leftLength_best,'--k',1:50,leftLength_ave,'k:');
    set(gcf,'Name','左臂寻优过程');
    legend('最短距离','平均距离');
    xlabel('迭代次数');
    ylabel('距离L/m');
end
if isSimulate && ~isempty(midHoleArray)
    figure;
    plot(midHoles(:,2),midHoles(:,3),'x-r');
    text(midHoles(1,2),midHoles(1,3),'起点');
    text(midHoles(end,2),midHoles(end,3),'终点');
    set(gcf,'Name','中间臂路径');
    xlabel('孔位横坐标/m');
    ylabel('孔位纵坐标/m');
    title(['最短距离：' num2str(midShortestLength) ]);
    figure;
    plot(1:50,midLength_best,'--k',1:50,midLength_ave,'k:');
    legend('最短距离','平均距离');
    set(gcf,'Name','中间臂寻优过程');
    xlabel('迭代次数');
    ylabel('距离L/m');
end
if isSimulate && ~isempty(rightHoleArray)
    figure;
    plot(rightHoles(:,2),rightHoles(:,3),'x-r');
    text(rightHoles(1,2),rightHoles(1,3),'起点');
    text(rightHoles(end,2),rightHoles(end,3),'终点');
    set(gcf,'Name','右臂路径');
    xlabel('孔位横坐标/m');
    ylabel('孔位纵坐标/m');
    title(['最短距离：' num2str(rightShortestLength) ]);
    figure;
    plot(1:50,rightLength_best,'--k',1:50,rightLength_ave,'k:');
    set(gcf,'Name','右臂寻优过程');
    legend('最短距离','平均距离');
    xlabel('迭代次数');
    ylabel('距离L/m');
end 
% if ~isempty(lArmHole)
%     % 将结构体转换为矩阵(1x(行*列))
%     lArmHoleArray=struct2array(lArmHole);
%     % 将单选矩阵转换为行*7列
%     lArmHoleArray=reshape(lArmHoleArray(1:end),7,[])';
% %     leftArray=zeros(size(lArmHoleArray));
%     % 将左臂的点的坐标取出放于lC中（n x 2）
%     lC=lArmHoleArray(:,2:3);
%     [Route,~]=myAcatsp(lC,15,int16(0.8*size(lC,1)),1,5,0.2,100,'x-r');
%     % 将孔序规划后的孔信息矩阵放于leftArray中
%     for i=1:size(lArmHoleArray,1)
%         leftHoles(i)=lArmHole(Route(i));
%     end
% else
%     leftHoles=[];
% end
% if ~isempty(mArmHole)
%     % 将结构体转换为矩阵(1x(行*列))
%     mArmHoleArray=struct2array(mArmHole);
%     % 将单选矩阵转换为行*7列
%     mArmHoleArray=reshape(mArmHoleArray(1:end),7,[])';
% %     midArray=zeros(size(mArmHoleArray));
%     % 将中间臂的点的坐标取出放于lC中（n x 2）
%     rC=mArmHoleArray(:,2:3);
%     [Route,~]=myAcatsp(rC,15,int16(0.8*size(rC,1)),1,5,0.2,100,'o-y');
%     % 将孔序规划后的孔信息矩阵放于leftArray中
%     for i=1:size(mArmHoleArray,1)
%         midHoles(i)=mArmHole(Route(i));
%     end
% else
%     midHoles=[];
% end
% if ~isempty(rArmHole)
%     % 将结构体转换为矩阵(1x(行*列))
%     rArmHoleArray=struct2array(rArmHole);
%     % 将单选矩阵转换为行*7列
%     rArmHoleArray=reshape(rArmHoleArray(1:end),7,[])';
% %     rightArray=zeros(size(rArmHoleArray));
%     % 将右臂的点的坐标取出放于lC中（n x 2）
%     rC=rArmHoleArray(:,2:3);
%     [Route,~]=myAcatsp(rC,15,int16(0.8*size(rC,1)),1,5,0.2,100,'x-k'); 
%     % 将孔序规划后的孔信息矩阵放于leftArray中
%     for i=1:size(rArmHoleArray,1)
%         rightHoles(i)=rArmHole(Route(i));
%     end
% else
%     rightHoles=[];
% end
sequenceflag=true;
% leftHoles midHoles rightHoles --- 为孔任务分配后，按孔序规划顺序排列的各臂的孔数据(为矩阵类型)
% 用于保存
handles.leftHoles=leftHoles;
handles.midHoles=midHoles;
handles.rightHoles=rightHoles;
guidata(hObject, handles);


% --------------------------------------------------------------------
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 点击视图按钮，则判断是否可以进行显示孔序操作
isChecked = get(handles.simulateMode,'Checked');
global sequenceflag;
if sequenceflag == 1 && strcmpi(isChecked,'off')
    set(handles.show_sequence,'Enable','on');
    set(handles.holeNum,'Enable','off');
else
    set(handles.show_sequence,'Enable','off');
    set(handles.holeNum,'Enable','on');
end

% --------------------------------------------------------------------
function grid_Callback(hObject, eventdata, handles)
% hObject    handle to grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
isChecked=get(handles.grid,'Checked');
if strcmpi(isChecked,'off')
    set(handles.grid,'Checked','on');
    grid on;
    set(gca,'xtick',-10:1:10);
    set(gca,'ytick',-5:1:12);
else
    set(handles.grid,'Checked','off');
    grid off;
end


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function mainfigure_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to mainfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% disp('主figure的buttonDwonFcn')
%% 如果鼠标点击的是坐标系以外的，则直接return
% axesPo --- 1x4矩阵，[x y width height]
% toPoint --- 为鼠标点击在mainfigure中的坐标，而不是在axes中的坐标
% tx ty --- 鼠标在mainfigure中的x,y坐标
% isInAxes --- 电击是否发生在坐标轴内的flag，在为true,不在为false
% [x,y,button]=ginput(1);
global isInAxes;
global hand;
hand=handles;
% disp(handles.output.SelectionType);
toPoint=get(gcf,'CurrentPoint');
axesPo=get(gca,'Position');
tx=toPoint(1,1);
ty=toPoint(1,2);
if ~(tx>=axesPo(1) && tx<=axesPo(1)+axesPo(3) && ty >= axesPo(2) && ty <= axesPo(2)+axesPo(4))
%    disp('点击事件不在坐标轴内');
    isInAxes=false;
    return;
else
    isInAxes=true;
end
% 是否进行了孔序规划的flag
global sequenceflag;
if sequenceflag
    return;
end
%% ----------------
global tunnel holes;
% 重绘隧道轮廓和孔
axisValue=axis;
repaint(tunnel, handles, holes,axisValue);

point=get(gca,'CurrentPoint');
global x0 y0;
global btDownFlag;
btDownFlag=1;
x0=point(1,1);
y0=point(1,2);
guidata(hObject, handles);


% --- Executes on key press with focus on mainfigure or any of its controls.
function mainfigure_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mainfigure (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
% tunnel --- 隧道轮廓结构数组
% temptunnel --- 在绘制轮廓界面，鼠标点击或拉选框选中的隧道轮廓
global holes undo reundo;
global tunnel temptunnel;
% 返回当前坐标轴的axis范围
axisValue=axis;
if strcmp(eventdata.Key,'delete')
    % 如果当前正处于自定义绘制轮廓的界面，且选中了‘鼠标选中轮廓线’的复选框&&holes=[]的情况下，不选孔，而是要选轮廓线做修改
    % isPaintTunnel -- 判断当前页面是否在绘制轮廓页面
    % isChooseTunnel -- 判断是否要用鼠标去选中轮廓线段
    isPaintTunnel=get(handles.panel_drawTunnel,'visible');
    isChooseTunnel=get(handles.cb_mouseProfile,'value');
    if strcmp(isPaintTunnel,'on') && isChooseTunnel && isempty(holes) && tunnel.type==250 && ~isempty(tunnel) && ~isempty(temptunnel)
        % 遍历tunnel和temptunnel,将tunnel中与temptunnel相同的线段或圆弧删除掉
        if isfield(temptunnel,'arc')
            if ~isempty(temptunnel.arc)
                for i=1:length(temptunnel.arc)
                    size=length(tunnel.arc);
                    for j=1:size
                        tempArc=tunnel.arc(size+1-j);
                        if isequal(temptunnel.arc(i),tempArc)
                            % 如果相同，则从tunnel中删除,从后往前遍历
                            tunnel.arc(size+1-j)=[];
                        end
                    end
                end
            end
        end
        if isfield(temptunnel,'line')
            if ~isempty(temptunnel.line)
                for i=1:length(temptunnel.line)
                    size=length(tunnel.line);
                    for j=1:size
                        tempLine=tunnel.line(size+1-j);
                        if isequal(temptunnel.line(i),tempLine)
                            tunnel.line(size+1-j)=[];
                        end
                    end
                end
            end
        end
        % 重绘删除选中轮廓之后的tunnel
        repaint(tunnel, handles, holes, axisValue);
    end
%     disp('按下了删除键')
    if ~isempty(holes)
        isDeleteAll=false;
        holesNum=handles.holesNum;
        holes = deleteHoles( holes,tunnel,holesNum,isDeleteAll,handles,axisValue );
        [undo,reundo]=preUndo(holes,undo,reundo,handles);
    end
end
guidata(hObject, handles);

% --- Executes on mouse motion over figure - except title and menu.
function mainfigure_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to mainfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%-----------------------
% 判断是否在坐标轴内已经发生了点击，否则不执行
% global isInAxes;
% if ~isInAxes
%     return;
% end
% -------------------
% --------------如果鼠标当前在坐标轴内，则在状态栏显示坐标-----------
global x0 y0 x y;
global h rect btDownFlag;
point=get(gca,'CurrentPoint');
x=point(1,1);
y=point(1,2);

toPoint=get(gcf,'CurrentPoint');
axesPo=get(gca,'Position');
tx=toPoint(1,1);
ty=toPoint(1,2);
if (tx>=axesPo(1) && tx<=axesPo(1)+axesPo(3) && ty >= axesPo(2) && ty <= axesPo(2)+axesPo(4))
    nowLocation=sprintf('%.4f,%.4f',x,y);
    set(handles.tx_mouseLocation,'string',nowLocation);
end

%--------------拉框选择多个孔---------

if btDownFlag==1;
    if x~=x0
        if ishandle(h)
            % 如果上次有画过矩形选框，则把上次画的矩形选框隐藏起来
            set(h,'visible','off');
        end
        rect = [min([x0,x]) min([y0,y]) abs(x-x0) abs(y-y0)];
        if rect(3)*rect(4)~=0
            h=rectangle('Position',rect,'LineStyle',':','EdgeColor',[0 0 0]);
        end
    end
end
guidata(hObject, handles);

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function mainfigure_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to mainfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 判断是否在坐标轴内已经发生了点击，否则不执行
global isInAxes sequenceflag;
if ~isInAxes
    return;
end
if sequenceflag
    return;
end
% -------------------

%     
% end
% x0,y0 --- 鼠标点下的初始坐标
% x,y --- 鼠标当前移动的坐标
% h --- 拉出选孔区域的矩形的图形句柄
% rect --- 拉出的矩形的一些参数
point=get(gca,'CurrentPoint');
global holes tunnel;
global x0 y0 x y;
global btDownFlag h rect;
btDownFlag=0;
x=point(1,1);
y=point(1,2);
%% 如果当前正处于自定义绘制轮廓的界面，且选中了‘鼠标选中轮廓线’的复选框&&holes=[]的情况下，不选孔，而是要选轮廓线做修改
% isPaintTunnel -- 判断当前页面是否在绘制轮廓页面
% isChooseTunnel -- 判断是否要用鼠标去选中轮廓线段
isPaintTunnel=get(handles.panel_drawTunnel,'visible');
isChooseTunnel=get(handles.cb_mouseProfile,'value');
global temptunnel;
if strcmp(isPaintTunnel,'on') && isChooseTunnel && isempty(holes) && tunnel.type==250
    if abs(x-x0)<0.01 && abs(y-y0)<0.01
        % 判断单击时是否有选中隧道轮廓
        [ isChosen, chosenLine, chosenArc ] = isChosenTunnel( x0,y0,false,x,y,tunnel );
    else
        % 判断拉框时有没有选中隧道轮廓
        [ isChosen, chosenLine, chosenArc ] = isChosenTunnel( x0,y0,true,x,y,tunnel );
    end   
    if isChosen
        temptunnel=[];
        if ~isempty(chosenLine)
            temptunnel.line=chosenLine;
        end
        if ~isempty(chosenArc)
            temptunnel.arc=chosenArc;
        end
        paintChosenTunnel(temptunnel);
    end
end
%% 判断拉出的选框是否选中孔的代码块
xmin=min([x0,x]);xmax=max([x0,x]);
ymin=min([y0,y]);ymax=max([y0,y]);
if ~isempty(holes)
    if abs(x-x0)<0.01 && abs(y-y0)<0.01
        % 取出单击的孔号
        holeNum = find([holes.x]>(x-0.03) & [holes.x]<(x+0.03) & [holes.y]>(y-0.03) & [holes.y]<(y+0.03));
    else
        % 取出拉框中的孔号
        holeNum = find([holes.x]>(xmin-0.03) & [holes.x]<(xmax+0.03) & [holes.y]>(ymin-0.03) & [holes.y]<(ymax+0.03));
    end
    % 孔信息的显示，以便于修改-------
    showHoleInfo( holes,holeNum,handles );
    % 状态栏显示孔总数
    
    set(handles.tx_totalHole,'string',num2str(length(holes)));
    % -------------
    if ~isempty(holeNum)
        for i=1:length(holeNum)
            drawSingleCircle( holes(holeNum(i)).x,holes(holeNum(i)).y,holes(holeNum(i)).r,...
                holes(holeNum(i)).biasAngle,holes(holeNum(i)).inclineAngle,handles.axes1,'k' );
        end
        handles.holesNum=holeNum;
        % 如果有选中孔，则相应设置状态栏显示
        if length(holeNum)==1
            set(handles.tx_selectedHoleNum,'string',num2str(holeNum));
            set(handles.tx_selectedHole,'string','1');
        else
            set(handles.tx_selectedHoleNum,'string','***');
            set(handles.tx_selectedHole,'string',num2str(length(holeNum)));
        end
    else
        handles.holesNum=[];
        % 如果没有选中有孔，则设置先选中孔号显示***
        set(handles.tx_selectedHoleNum,'string','***');
        set(handles.tx_selectedHole,'string','0');
    end
end
if ishandle(h)
    set(h,'visible','off');
    h=[];
    if rect(3)*rect(4)~=0
        h=rectangle('Position',rect,'EdgeColor',[0 0 0]);
        set(h,'visible','off');
        h=[];
    end
end
guidata(hObject, handles);


% ---------------------显示孔号-----------------------
function holeNum_Callback(hObject, eventdata, handles)
% hObject    handle to holeNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global holes tunnel;
axisValue=axis;
isChecked=get(handles.holeNum,'Checked');
if strcmpi(isChecked,'off')
    set(handles.holeNum,'Checked','on');
    paintHoleNum( holes );
else
    set(handles.holeNum,'Checked','off');
    repaint(tunnel, handles, holes,axisValue);
end


% --- Executes on scroll wheel click while the figure is in focus.
function mainfigure_WindowScrollWheelFcn(hObject, eventdata, handles)
% hObject    handle to mainfigure (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click
% handles    structure with handles and user data (see GUIDATA)
% --------------如果鼠标当前在坐标轴内，则在状态栏显示坐标-----------
global x0 y0 x y;
point=get(gca,'CurrentPoint');
x=point(1,1);
y=point(1,2);
toPoint=get(gcf,'CurrentPoint');
axesPo=get(gca,'Position');
tx=toPoint(1,1);
ty=toPoint(1,2);
if (tx>=axesPo(1) && tx<=axesPo(1)+axesPo(3) && ty >= axesPo(2) && ty <= axesPo(2)+axesPo(4))
end


% --------------------------------------------------------------------
function refresh_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global holes tunnel sequenceflag;
sequenceflag=false;
if tunnel.type ~= 250
    initTunnelAxes( tunnel,handles );
else
    drawTunnel(tunnel, 'r');
end
if ~isempty(holes)
    % 重绘隧道断面上的孔
    for i=1:length(holes)
        drawSingleCircle( holes(i).x,holes(i).y,holes(i).r,holes(i).biasAngle,holes(i).inclineAngle,handles.axes1,'g' );
    end
end
% 检查是否需要绘制孔号
isChecked=get(handles.holeNum,'Checked');
if strcmpi(isChecked,'on')
    paintHoleNum( holes );
end


% --- Executes on button press in pb_draw.
function pb_draw_Callback(hObject, eventdata, handles) 
% hObject    handle to pb_draw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 初始化操作
% 初始化数据结构
global tunnel;
global holes;

% ---获取圆弧参数-------
cenCoordStr=get(handles.et_circleCenter,'string');
rangeAngleStr=get(handles.et_rangeAngle,'string');
radiusArcStr=get(handles.et_radiusArc,'string');
startCoordStr=get(handles.et_startCoord,'string');
endCoordStr=get(handles.et_endCoord,'string');
cenCoord=str2double(regexp(cenCoordStr,';','split'));
rangeAngle=str2double(regexp(rangeAngleStr,';','split'));
radiusArc=str2double(radiusArcStr);
startCoord=str2double(regexp(startCoordStr,';','split'));
endCoord=str2double(regexp(endCoordStr,';','split'));
% 转换为弧度
rangeAngle=rangeAngle*pi/180;
if (length(cenCoord)~=2 || length(rangeAngle)~=2 || length(radiusArc)~=1) && (length(startCoord)~=2 || length(endCoord)~=2 )...
        || ( ~isempty(find(isnan([cenCoord rangeAngle radiusArc]), 1)) && ~isempty(find(isnan([startCoord endCoord]), 1)) )
    errordlg('请输入正确的参数','参数错误');
    return;   
end
if tunnel.type~=250
    tunnel=[];
    holes=[];
%     arc=struct('x',[],'y',[],'r',[],'theta1',[],'theta2',[]);
%     line=struct('x1',[],'y1',[],'x2',[],'y2',[]);
    arc=[];
    line=[];
    tunnel=struct('type',250,'arc',arc,'line',line);
end

if ((length(cenCoord)==2 || length(rangeAngle)==2 || length(radiusArc)==1)) && isempty(find(isnan([cenCoord rangeAngle radiusArc]), 1))
% 绘制圆弧的参数格式正确，判断半径和角度是否大于0
    if abs(rangeAngle(1)-rangeAngle(2))<1 || abs(rangeAngle(1)-rangeAngle(2))>360 || radiusArc<=0
        errordlg('角度或半径参数错误','参数错误');
        return;
    else
        % 添加圆弧轮廓数据到tunnel.arc
        if ~isfield(tunnel,'arc')
            tunnel.arc=[];
        end
        size=length(tunnel.arc);
        tempArc.x=cenCoord(1);
        tempArc.y=cenCoord(2);
        tempArc.r=radiusArc;
        tempArc.theta1=rangeAngle(1);
        tempArc.theta2=rangeAngle(2);
        % 如果arc的数据还为空，就把当前的数据放到tunnel.arc的第一行数据
        if isempty(tunnel.arc)
            tunnel.arc=tempArc;
        else
            tunnel.arc(size+1)=tempArc;
        end
    end
end

if (length(startCoord)==2 || length(endCoord)==2 ) && isempty(find(isnan([startCoord endCoord]), 1))
    if startCoord(1)==endCoord(1) && startCoord(2)==endCoord(2)
        errordlg('直线起始和终止坐标不能为同一坐标','参数错误');
        return;
    else
        % 添加直线轮廓数据到tunnel.line
        if ~isfield(tunnel,'line')
            tunnel.line=[];
        end
        size=length(tunnel.line);
        tempLine.x1=startCoord(1);
        tempLine.y1=startCoord(2);
        tempLine.x2=endCoord(1);
        tempLine.y2=endCoord(2);
        if isempty(tunnel.line)
            % 如果line的数据还为空，就把当前的数据放到tunnel.line的第一行数据
            tunnel.line=tempLine;
        else
            % 否则往后面挪一行
            tunnel.line(size+1)=tempLine;
        end
    end
end

% 将edit文本框中的数值设置为默认值的提示值
set(handles.et_circleCenter,'string','x;y');
set(handles.et_rangeAngle,'string','th1;the2');
set(handles.et_radiusArc,'string','');
set(handles.et_startCoord,'string',endCoordStr);
set(handles.et_endCoord,'string','x2;y2');
% 清屏
set(handles.pb_Tunnel,'visible','off');
h=get(gca,'children');
delete(h);
% 绘制坐标轴
plot([-100,100],[0,0],'k--');
hold on;
plot([0 0],[-100,100],'k--');
drawTunnel(tunnel,'r');

% --------------------------------------------------------------------
function standardTunnel_Callback(hObject, eventdata, handles)
% hObject    handle to standardTunnel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pb_Tunnel_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function open_tunnel_Callback(hObject, eventdata, handles)
% hObject    handle to open_tunnel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tunnel;
[filename, pathname] = ...
     uigetfile({'*.xlsx';'*.xls'},'请选择规定格式的数据文件');
 % 拼接路径和文件名
 filepath=strcat(pathname,filename);
 % 判断要打开的是什么类型的文件
 if ~isempty(strfind(filename,'.xlsx')) || ~isempty(strfind(filename,'.xls'))
     % 加载数据
    [tunnel_array]=xlsread(filepath);
 end
 tunnel.type=tunnel_array(1);
 tunnel.size.R=tunnel_array(2);
 tunnel.size.a=tunnel_array(3);
 tunnel.size.l=tunnel_array(4);
 tunnel.size.r=tunnel_array(5);
 tunnel.size.t=tunnel_array(6);
 % 刷新重绘
 refresh_ClickedCallback(hObject, eventdata, handles)

% 保存隧道轮廓数据
function save_tunnel_Callback(hObject, eventdata, handles)
% hObject    handle to save_tunnel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tunnel;
[filename,pathname]=uiputfile({'*.xlsx'},'保存轮廓数据');
filepath=strcat(pathname,filename);
% 表头
header={'类型','R','a','l','r','t'};
tunnel_data=zeros(1,6);
tunnel_data(1)=tunnel.type;
if ~isempty(tunnel.size.R)
    tunnel_data(2)=tunnel.size.R;
else
    tunnel_data(2) = 0;
end
if ~isempty(tunnel.size.a)
    tunnel_data(3)=tunnel.size.a;
else
    tunnel_data(3) = 0;
end
if ~isempty(tunnel.size.l)
    tunnel_data(4)=tunnel.size.l;
else
    tunnel_data(4) = 0;
end
if ~isempty(tunnel.size.r)
    tunnel_data(5)=tunnel.size.r;
else
    tunnel_data(5) = 0;
end
if ~isempty(tunnel.size.t)
    tunnel_data(6)=tunnel.size.t;
else
    tunnel_data(6) = 0;
end
% 将tunnel_data矩阵转换为元胞数组
tunnel_data=num2cell(tunnel_data);
%% 判断要保存的是什么格式的文件
% 保存到xlsx或xls文件格式
if ~isempty(strfind(filename,'.xlsx')) || ~isempty(strfind(filename,'.xls'))
    % 将表头置于表数据第一行
    tunnel_data=[header ; tunnel_data];
    % 写入到excel文件,status---保存成功返回1，否则返回0；message---保存失败的原因，string类型
    [status,message]=xlswrite(filepath,tunnel_data);
    if status==1
        % 保存成功
        msgbox('保存成功','Success');
    else
        % 保存失败
        errordlg(message,'Fail');
    end
end

% --- Executes on button press in pb_startSequence.
function pb_startSequence_Callback(hObject, eventdata, handles)
% hObject    handle to pb_startSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 失能仿真菜单下优化孔任务按钮和孔序规划按钮
global holes;
if isempty(holes) || length(holes) < 3
    errordlg('当前孔数量无法进行此操作！！！','错误');
    return;
end
set(handles.optHoleTask,'Enable','off');
set(handles.simulateSequence,'Enable','off');
moveTimestr=get(handles.et_moveTime,'string');
drillVelostr=get(handles.et_drillVelo,'string');
moveTime=str2double(moveTimestr);
drillVelo=str2double(drillVelostr);
if moveTime > 0 || drillVelo > 0
    if moveTime>0
        handles.moveTime = moveTime;
    else
        handles.moveTime=[];
    end
    if drillVelo > 0
        handles.drillVelo = drillVelo;        
    else
        handles.drillVelo = [];
    end
else
    errordlg('参数错误，请检查参数','参数错误');
    return;
end
guidata(hObject, handles);
% 重置仿真菜单栏
% set(handles.optHoleTask,'Enable','off');
% set(handles.simulateSequence,'Enable','off');
% handles.isInited = false;
% handles.isOpted = false;
sequence_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function saveas_fig_Callback(hObject, eventdata, handles)
% hObject    handle to saveas_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hp3=getframe(gcf);
hp3= frame2im(hp3);
[filename,pathname]=uiputfile({'*.jpg','JPEG(*.jpg)';...
    '*.bmp','Bitmap(*.bmp)';...
    '*.gif','GIF(*.gif)';...
    '*.*','All Files (*.*)'},...
    '保存界面','Gui1');
if filename == 0
    return;
else
    filepath=strcat(pathname,filename);
%     saveas(gcf,filepath);
    imwrite(hp3,filepath);
end

% --------------------------------------------------------------------
function imwritePic_Callback(hObject, eventdata, handles)
% hObject    handle to imwritePic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 保存曲线图
newfig1 = figure;
set(newfig1,'Visible','off');
new_h1 = copyobj(handles.axes1, newfig1);
set(new_h1,'Units','default','Position','default');
[filename,pathname] = uiputfile({'*.jpg','JPEG(*.jpg)';...
    '*.bmp','Bitmap(*.bmp)';...
    '*.gif','GIF(*.gif)';...
    '*.*','All Files (*.*)'},...
    'Save Picture2','Picture2_1');
if filename == 0
    close(newfig1);
    return;
else
    %saveas(newfig2,fullfile(pathname2,filename2));%可以保存坐标标题之类的
    %下面代码不仅可以保存坐标标题，还可以保存figure中axes图像的背景
    hp = getframe(newfig1);
    hp = frame2im(hp);
    imwrite(hp,fullfile(pathname,filename));
    close(newfig1);
end


% --------------------------------------------------------------------
function simulateMode_Callback(hObject, eventdata, handles)
% hObject    handle to simulateMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tunnel;
if tunnel.type ==1 || tunnel.type == 2 || tunnel.type == 3
    hideflag = true;
else
    hideflag = false;
end
isChecked=get(handles.simulateMode,'Checked');
if strcmpi(isChecked,'off')
    set(handles.simulateMode,'Checked','on');
    if hideflag
        set(handles.pb_Tunnel,'Visible','off');
    end
else
    set(handles.simulateMode,'Checked','off');
    if hideflag
        set(handles.pb_Tunnel,'Visible','on');
    end
end


% ---------------------------仿真模式下的初始化孔任务------------------------
function initHoleTask_Callback(hObject, eventdata, handles)
% hObject    handle to initHoleTask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global holes tunnel;
if tunnel.type ==1 || tunnel.type == 2 || tunnel.type == 3
    hideflag = true;
else
    hideflag = false;
end
isChecked=get(handles.simulateMode,'Checked');
if strcmpi(isChecked,'off')
    set(handles.simulateMode,'Checked','on');
    if hideflag
        set(handles.pb_Tunnel,'Visible','off');
    end
end
[ initLeftHole,initMidHole,initRightHole ] = firstClass( holes, handles);
handles.isInited = true;
% 使能仿真菜单下优化分配孔任务按钮
set(handles.optHoleTask,'Enable','on');
% 将初始化的各臂孔放入handles中，以供优化分配
handles.initLeftHole = initLeftHole;
handles.initMidHole = initMidHole;
handles.initRightHole = initRightHole;
guidata(hObject, handles);

% --------------------仿真模式下优化孔任务------------------------------
function optHoleTask_Callback(hObject, eventdata, handles)
% hObject    handle to optHoleTask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'isInited')
    if handles.isInited
        initLeftHole = handles.initLeftHole;
        initMidHole = handles.initMidHole;
        initRightHole = handles.initRightHole;
        [ optLeftHole,optMidHole,optRightHole ,simulateArray] = secondClass( initLeftHole,initMidHole,initRightHole, handles );
        handles.isOpted = true;
        handles.optLeftHole = optLeftHole;
        handles.optMidHole = optMidHole;
        handles.optRightHole = optRightHole;
        % 使能仿真菜单下‘孔序规划’的按钮
        set(handles.simulateSequence,'Enable','on');
        guidata(hObject, handles);
    end
else
    errordlg('请先进行初始化孔任务！！！','错误');
end


% ------------------仿真模式下进行孔序规划-----------------------------
function simulateSequence_Callback(hObject, eventdata, handles)
% hObject    handle to simulateSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 失能仿真菜单下优化孔任务按钮和孔序规划按钮
sequence_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function simulate_Callback(hObject, eventdata, handles)
% hObject    handle to simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global holes;
if isempty(holes) || length(holes) < 3
    set(handles.initHoleTask,'Enable','off');
else
    set(handles.initHoleTask,'Enable','on');
end
leftHoles = handles.leftHoles;
midHoles = handles.midHoles;
rightHoles = handles.rightHoles;
if ~isempty(leftHoles) || ~isempty(midHoles) || ~isempty(rightHoles)
    set(handles.simulateSequence,'Enable','on');
end


% --------------------------------------------------------------------
function show_sequence_Callback(hObject, eventdata, handles)
% hObject    handle to show_sequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 判断是否需要绘制孔序
global tunnel;
initTunnelAxes( tunnel,handles );
isShowSequence = get(handles.show_sequence,'Checked');
leftHoles = handles.leftHoles;
midHoles = handles.midHoles;
rightHoles = handles.rightHoles;
    % 画出点
    plot(leftHoles(:,2),leftHoles(:,3),'x-r');
    plot(midHoles(:,2),midHoles(:,3),'*--b');
    plot(rightHoles(:,2),rightHoles(:,3),'o-g');
    % 画起点和终点
    text(leftHoles(1,2),leftHoles(1,3),' 起点');
    text(leftHoles(end,2),leftHoles(end,3),' 终点');
    text(midHoles(1,2),midHoles(1,3),' 起点');
    text(midHoles(end,2),midHoles(end,3),' 终点');
    text(rightHoles(1,2),rightHoles(1,3),' 起点');
    text(rightHoles(end,2),rightHoles(end,3),' 终点');
if strcmpi(isShowSequence,'off')
    set(handles.show_sequence,'Checked','on');
    for i=1:size(leftHoles,1)
        text(leftHoles(i,2),leftHoles(i,3),num2str(i));
    end
    for i=1:size(midHoles,1)
        text(midHoles(i,2),midHoles(i,3),num2str(i));
    end
    for i=1:size(rightHoles,1)
        text(rightHoles(i,2),rightHoles(i,3),num2str(i));
    end
else
    set(handles.show_sequence,'Checked','off');
end
