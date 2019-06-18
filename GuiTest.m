%% ������������һ����˵����߿���滮
% ���ߣ�Ф��ǰ
% ѧУ�����ϴ�ѧ
% ���䣺shawyongqian@gmail.com
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
% ��ʼ�����ڵ�λ��
handles.output = hObject;
h = get(gcf,'Position');
h = [5 5 h(3:4)];
set(gcf,'Position',h);

% ---------�������ĸ��ؼ�
set(handles.panel_addHole,'Parent',gcf);
set(handles.panel_changeSize,'Parent',gcf);
set(handles.panel_assignHole,'Parent',gcf);
set(handles.panel_deleteHole,'Parent',gcf);
set(handles.panel_drawTunnel,'Parent',gcf);
set(handles.panel_drillSequence,'Parent',gcf);
% ---------������ӿ�Ϊ��ʾ��壬����Ϊ����
set(handles.panel_addHole,'visible','on');
set(handles.panel_changeSize,'visible','off');
set(handles.panel_assignHole,'visible','off');
set(handles.panel_deleteHole,'visible','off');
set(handles.panel_drawTunnel,'visible','off');
set(handles.panel_drillSequence,'visible','off');
% ------------�����ں��Ӵ��ڵ�ͨѶ-----(������Ϊ�Ӵ���)
% ��ø����ڶ��������������ڵ�ǰ���ڵ�handles�ṹ����
%handles.obj=varargin{1};
% ��ø��������пؼ��ľ���б�
%hdl=varargin{2};
% �����������пؼ��ľ�����ڵ�ǰ���ڽṹ��handles�е�handle�ṹ����
%handles.handle=hdl;
% Update handles structure
%% ��ʼ������˵��¿�����ť��Enable
set(handles.optHoleTask,'Enable','off');
set(handles.simulateSequence,'Enable','off');

% ============================================================
% ----------��Ϊ������
H=selectTunnelType(hObject,handles);
handles.tunnelType=H;
% ��ӹ�����
% set(hObject,'toolbar','figure') 
% ��ʼ�����ۿ�Ϊ��
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
% ������
% h=get(handles.axes1,'children');
% delete(h);
global type;
global tunnel;
global holes;
holes=[];
% ����û������ʱû��ѡ��������ͣ����ʼ��һ��
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
%         set(handles.tx_tunnelType,'String','��ˮ���');
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
%         set(handles.tx_tunnelType,'String','��·���');
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
%         set(handles.tx_tunnelType,'String','���������');
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
% ��ȡ�û����ļ���·��
set(handles.pb_Tunnel,'visible','off');
h=get(handles.axes1,'children');
delete(h);
axis([-9 9 -1 11]);

global holes;
[filename, pathname] = ...
     uigetfile({'*.xlsx';'*.xls';'*.mat';'*.txt'},'��ѡ��涨��ʽ�������ļ�');
 % ƴ��·�����ļ���
 filepath=strcat(pathname,filename);
 % �ж�Ҫ�򿪵���ʲô���͵��ļ�
 if ~isempty(strfind(filename,'.xlsx')) || ~isempty(strfind(filename,'.xls'))
     % ��������
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
    %��ͷ,����ʡ�������ܶ�������
%     formatSpec='%s';
%     N=7;
%     header=textscan(fileID,formatSpec,N,'Delimiter',',');
%     holes_cell=textscan(fileID,'%f %f %f %f %f %f %f');
%     holes_array=[holes_cell{1},holes_cell{2},holes_cell{3},holes_cell{4},holes_cell{5},holes_cell{6},holes_cell{7}];
    
    % ������ͷ��txt
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
[filename,pathname]=uiputfile({'*.xlsx';'*.txt'},'��������');
filepath=strcat(pathname,filename);
outHoles=holes;
if isempty(leftHoles) && isempty(midHoles) && isempty(rightHoles)
    % �������ݵ�ƫ���ɻ���תΪ��
    for i=1:length(outHoles)
        outHoles(i).biasAngle=outHoles(i).biasAngle*180/pi;
    end
    % ���ṹ������ת��ΪԪ������
    holes_cell=struct2cell(outHoles);
    % ȡ��Ԫ������ĳߴ磬7x1x����
    holes_size=size(holes_cell);
    % Ԫ������ߴ���м�Ϊ�����ݵ��ֶ���
    property = holes_size(1);
    % ȡԪ������������Ԫ��Ϊ��ͨ����
    holes_data=holes_cell(1:property,:);
    % ת��
    holes_data=holes_data';
% else
%     % �������ݵ�ƫ���ɻ���תΪ��
%     for i=1:length(leftHoles)
%         leftHoles(i).biasAngle=leftHoles(i).biasAngle*180/pi;
%     end
%     for i=1:length(midHoles)
%         midHoles(i).biasAngle=midHoles(i).biasAngle*180/pi;
%     end
%     for i=1:length(rightHoles)
%         rightHoles(i).biasAngle=rightHoles(i).biasAngle*180/pi;
%     end
%     % ���ṹ������ת��ΪԪ������
%     leftHoles_cell=struct2cell(leftHoles);
%     midHoles_cell=struct2cell(midHoles);
%     rightHoles_cell=struct2cell(rightHoles);
%     % ȡ��Ԫ������ĳߴ磬7x1x����
%     leftHoles_size=size(leftHoles_cell);
%     midHoles_size=size(midHoles_cell);
%     rightHoles_size=size(rightHoles_cell);
%     % Ԫ������ߴ���м�Ϊ�����ݵ��ֶ���
%     left_property = leftHoles_size(1);
%     mid_property = midHoles_size(1);
%     right_property = rightHoles_size(1);
%     % ȡԪ������������Ԫ��Ϊ��ͨ����
%     leftHoles_data=leftHoles_cell(1:left_property,:)';
%     midHoles_data=midHoles_cell(1:mid_property,:)';
%     rightHoles_data=rightHoles_cell(1:right_property,:)';
end

% ��ͷ
header={'�׺�','x','y','�׾�r','����','ƫ��','̽����'};

%% �ж�Ҫ�������ʲô��ʽ���ļ�
% ���浽xlsx��xls�ļ���ʽ
if ~isempty(strfind(filename,'.xlsx')) || ~isempty(strfind(filename,'.xls'))
    % д�뵽excel�ļ�,status---����ɹ�����1�����򷵻�0��message---����ʧ�ܵ�ԭ��string����
    if isempty(leftHoles) && isempty(midHoles) && isempty(rightHoles)
        if exist(filepath,'file')
            [~,Sheets,~] = xlsfinfo(filepath);
            if length(Sheets)>1
                delete(filepath);
            end
        end
        % ����ͷ���ڱ����ݵ�һ��
        holes_data=[header ; holes_data];
        [status,~]=xlswrite(filepath,holes_data);
        if status==1
            % ����ɹ�
            msgbox('����ɹ�','Success');
        else
            % ����ʧ��
            errordlg('����ʧ��','Fail');
        end
    else
        % ����ͨ����ת��ΪԪ��������ܱ��浽excel�����
        leftHoles_data=[header ; num2cell(leftHoles)];
        midHoles_data=[header ; num2cell(midHoles)];
        rightHoles_data=[header ; num2cell(rightHoles)];
        [status1,~]=xlswrite(filepath,leftHoles_data,1);
        [status2,~]=xlswrite(filepath,midHoles_data,2);
        [status3,~]=xlswrite(filepath,rightHoles_data,3);
        if status1 && status2 && status3
            % ����ɹ�
            msgbox('����ɹ�','Success');
        else
            % ����ʧ��
            errordlg('����ʧ��','Fail');
        end
    end
    
end
% ���浽txt�ļ�
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
% X --- Ҫ��ӵĿ׵�X���꣬��λm
% Y --- Ҫ��ӵĿ׵�Y���꣬��λm
% r --- Ҫ��ӵĿ׵İ뾶����λmm
% depth --- Ҫ��ӵĿ׵Ŀ����λm
% biasAngle --- Ҫ��ӵĿ׵�ƫ�ǣ���λ��
% inclineAngle --- Ҫ��ӵĿ׵�̽���ǣ���λ��
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
% ------------�޸�����ѡ�п׵Ŀ����׾�
% holeNum --- ѡ�еĿ׵Ŀ׺ŵľ���
holeNum = handles.holesNum;
if length(holeNum) > 1
    % errorflag --- �����ж��Ƿ�������󣬷��򲻽�����볷���İ�ť��
    errorflag = 0 ;
    % rowNum --- ������¼ѡ�еĿ���holes���к�
    rowNum = zeros(1,length(holeNum));
    for i=1:length(holeNum)
        rowNum(i) = find([holes.num] == holeNum(i));
    end 
    if ~isnan(depth) && depth>0 && ~isnan(r) && r>0
        % ͬʱ�޸�ѡ�п׵Ŀ���Ϳ׾�
        for j=1:length(holeNum)
            holes(rowNum(j)).depth = depth;
            holes(rowNum(j)).r=r;
        end
    elseif ~isnan(depth) && depth>0 && (isnan(r) || r<0)
        % ֻ�޸�ѡ�п׵Ŀ���
        for j=1:length(holeNum)
            holes(rowNum(j)).depth = depth;
        end
    elseif ~isnan(r) && r>0 && (isnan(depth) || depth <0)
        % ֻ�޸�ѡ�п׵Ŀ׾�
        for j=1:length(holeNum)
            holes(rowNum(j)).r=r;
        end
    else
        errorflag = 1;
        errordlg('��������ȷ������������','��������');
    end
    if errorflag == 0
        [undo,reundo]=preUndo(holes,undo,reundo,handles);
    end
    refresh_ClickedCallback(hObject, eventdata, handles)
    return;
end
% ----------------------------------
if isnan(X) || isnan(Y) || isnan(r) || isnan(depth) || depth<=0 || r<=0
%     disp('��������ȷ');
    errordlg('��������ȷ������������','��������');
    return;
end
if isnan(biasAngle)
    biasAngle=0;
end
if isnan(inclineAngle)
    biasAngle=0;
    inclineAngle=0;
end

%% ���������
holeData.num=length(holes)+1;
holeData.x=X;
holeData.y=Y;
holeData.r=r;
holeData.depth=depth;
holeData.biasAngle=biasAngle*pi/180;
holeData.inclineAngle=inclineAngle;
% �ж�Ҫ��ӵĸÿ��Ƿ��Ѿ����ڣ��������򸲸����------
% ��õ�ǰ������axis
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
% disp('������ӿ׳���');

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

%% ɾ��ָ����ĳ����
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

% ��ʱ����������ť
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
% flag ������ʾҪ��Ҫ����ҳ��
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
    % ���beforeType==afterType����˵���û�ֻ�ǵ��˰�ť����û��ѡ���µ����
        flag=0;
    else
    % �������ȣ���˵���û�ѡ���µ������������ʱ��Ҫ��տ�����
    holes=[];
    flag=1;
    end
else
    % ���tunnel����Ϊ�գ���˵���û�û��ѡ���µ����������Ҫ��ʼ��һ���������
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


% -------�޸���������ߴ�-----------
function pb_change_Callback(hObject, eventdata, handles)
% hObject    handle to pb_change (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ���������
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
            errordlg('�ߴ粻��Ϊ��','�ߴ����');
            return;
        else
            h=get(handles.axes1,'children');
            delete(h);
            waterTunnel( R, t, a, l, r ,[-t-2,t+2 , -l-r-1, a+R+2]);
        end
    case 2
        if isempty(Rstr) || isempty(astr) || isempty(lstr) || isempty(rstr)
            errordlg('�ߴ粻��Ϊ��','�ߴ����');
            return;
        else
            h=get(handles.axes1,'children');
            delete(h);
            roadTunnel(R,a,l,r,[-R-2 R+2 -l-r-1 R+a+2]);
        end        
    case 3
        if isempty(Rstr) || isempty(astr) || isempty(lstr) || isempty(rstr)
            errordlg('�ߴ粻��Ϊ��','�ߴ����');
            return;
        else
            h=get(handles.axes1,'children');
            delete(h);
            horseshoeTunnel( R,a,l,r,[-R-6 R+6 -l-r-1 R+a+2] );
        end             
end
% ֻ���޸ĳߴ�ɹ����֮�󣬲����޸�ԭ��tunnel��ֵ
tunnel.type=type;
tunnel.size.R=R;
tunnel.size.a=a;
tunnel.size.l=l;
tunnel.size.r=r;
tunnel.size.t=t;


% -----------���װ�ť--------
function pb_assignFloorHole_Callback(hObject, eventdata, handles)
% hObject    handle to pb_assignFloorHole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ------------------------------------
% upHole --- ����ϲ��ֵĿ׾�,��λ��m
% upFloor --- ����ϲ��ֵĲ��,��λ��m
% downHole --- ����²��ֵĿ׾�,��λ��m
% downFloor --- ����²��ֵĲ��,��λ��m
% holesR --- �װ뾶,��λ��mm
% inclineAngle --- ��̽����,��λ����
% holesDepth --- ����,��λ��m 
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
    % ���Բ���׾ࡢ�׾�������С��0���򵯳�����Ի���
    if ~(upHole >0 && holesR > 0 && holesDepth > 0)
        errordlg('������������������','��������');
        return;
    end
    if tunnel.type~=250
        try
            Holes=assignHoles( tunnel, holes,upHole, upHole, downFloor, downFloor, handles.axes1, holesR, inclineAngle, holesDepth);
            holes=Holes;
        catch
            errordlg('���������������','��������');
        end
    else
        [sequences,tunnel]=sequence(tunnel);
        if ~isempty(sequences)
            % ���ز���Ϊ�գ���˵��tunnel�����������������
            try
                tempTunnel=insideProfile( tunnel,sequences,downFloor );
                [ holes ] = assignCustonHoles( tempTunnel, holes, upHole, handles, holesR, inclineAngle, holesDepth );
            catch
                errordlg('���������������','��������');
            end
        end
    end
    % ��������Ϊ������׼��
    [undo,reundo]=preUndo(holes,undo,reundo,handles);


% --------------------------------------------------------------------
function undo_Callback(hObject, eventdata, handles)
% hObject    handle to undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% -----------------����------------
% h --- ��ȡ�������children����
% baseSize --- Ϊ��ǰ����ϵ��ͼ�ξ���ĸ�����ֻ������ϵ���Ѿ����˿ײ��ó�����...
%       ����������ϵ��ԭ������������������������ɾ����
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

% -----------����-----------
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
    % ------------����������ӵ��س���---------
    reundo.reundo7=reundo.reundo6;
    reundo.reundo6=reundo.reundo5;
    reundo.reundo5=reundo.reundo4;
    reundo.reundo4=reundo.reundo3;
    reundo.reundo3=reundo.reundo2;
    reundo.reundo2=reundo.reundo1;
    reundo.reundo1=undo.undo1;
    % Ҫ�Ȱѳ�������֮ǰ�Ŀ����ݸ��س��ṹ����
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
    % �ػ�
    repaint(tunnel, handles, holes);
    % �ָ�����֮�󣬸��¿���������ʾ-------------
    if ~isempty(holes)
        set(handles.tx_totalHole,'string',num2str(length(holes)));
    else
        set(handles.tx_totalHole,'string','0');
    end
    % -----------����������ӵ��ɳ������б���-------
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
%% ɾ��ָ���ף���������Ŀ���ǰ��һλ������Ŀ׵Ŀ׺ż�1
% ��ȡҪɾ���Ŀ׺�
holeNumstr=get(handles.et_deleteHoleNum,'string');
holeNum=str2num(holeNumstr);
% ��ȡ�Ƿ�Ҫɾ�����п�
isDeleteAll=get(handles.cb_deleteAllHoles,'value');
global holes undo reundo;
global tunnel;
axisValue=axis;
holes = deleteHoles( holes,tunnel,holeNum,isDeleteAll,handles ,axisValue);
[undo,reundo]=preUndo(holes,undo,reundo,handles);


% -----------------����滮������------------------------------------
function sequence_Callback(hObject, eventdata, handles)
% hObject    handle to sequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global holes sequenceflag;
global leftHoleArray midHoleArray rightHoleArray;
global tunnel;
if isempty(holes) || length(holes) < 3
    errordlg('��ǰ�������޷����д˲���������','����');
    return;
end
leftHoles = [];
midHoles = [];
rightHoles = [];
% ���handles��û��isInited��isOpted�����ֶΣ���˵���϶�û���ڷ����½��г�ʼ�����Ż������
if ~isfield(handles,'isInited') || ~isfield(handles,'isOpted')
    [ lArmHole,mArmHole,rArmHole ] = firstClass( holes, handles);
    [ leftHoleArray,midHoleArray,rightHoleArray ,simulateArray] = secondClass( lArmHole,mArmHole,rArmHole, handles );
else
    % ���isInited��isOpted��������Ϊtrue����˵���������ڷ����½��п���滮
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
% % ���÷���˵���
% set(handles.optHoleTask,'Enable','off');
% set(handles.simulateSequence,'Enable','off');
% handles.isInited = false;
% handles.isOpted = false;
%text(2,8,'A Simple Plot','Color','red','FontSize',14)
% initTunnelAxes( tunnel,handles );
% ����滮�Ľ�������������
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
    % �ж��Ƿ���Ҫ��ʾ����׺�
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
    % �ж��Ƿ���Ҫ��ʾ����׺�
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
% ��ȡ��ǰ����滮��������ᣨδ��ʾ����׺ŵģ����Ա�����޸���ʾ/���ؿ���׺�
handles.sequAxes = gca;
if ~isempty(rightHoleArray)
    rC=rightHoleArray(:,2:3);
    [Route,rightShortestLength,rightLength_best,rightLength_ave]=myAcatsp(rC,50,floor(0.8*size(rC,1)),1,7,0.2,100,'o-g',3,isSimulate,midHoles(1,2),midHoles(1,3));
    % �ж��Ƿ���Ҫ��ʾ����׺�
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
% ����Ƿ���ģʽ���������½����ڻ���һ��
if isSimulate && ~isempty(leftHoleArray)
    figure;
    plot(leftHoles(:,2),leftHoles(:,3),'x-r');
    text(leftHoles(1,2),leftHoles(1,3),'���');
    text(leftHoles(end,2),leftHoles(end,3),'�յ�');
    set(gcf,'Name','���·��');
    xlabel('��λ������/m');
    ylabel('��λ������/m');
    title(['��̾��룺' num2str(leftShortestLength) ]);
    figure;
    plot(1:50,leftLength_best,'--k',1:50,leftLength_ave,'k:');
    set(gcf,'Name','���Ѱ�Ź���');
    legend('��̾���','ƽ������');
    xlabel('��������');
    ylabel('����L/m');
end
if isSimulate && ~isempty(midHoleArray)
    figure;
    plot(midHoles(:,2),midHoles(:,3),'x-r');
    text(midHoles(1,2),midHoles(1,3),'���');
    text(midHoles(end,2),midHoles(end,3),'�յ�');
    set(gcf,'Name','�м��·��');
    xlabel('��λ������/m');
    ylabel('��λ������/m');
    title(['��̾��룺' num2str(midShortestLength) ]);
    figure;
    plot(1:50,midLength_best,'--k',1:50,midLength_ave,'k:');
    legend('��̾���','ƽ������');
    set(gcf,'Name','�м��Ѱ�Ź���');
    xlabel('��������');
    ylabel('����L/m');
end
if isSimulate && ~isempty(rightHoleArray)
    figure;
    plot(rightHoles(:,2),rightHoles(:,3),'x-r');
    text(rightHoles(1,2),rightHoles(1,3),'���');
    text(rightHoles(end,2),rightHoles(end,3),'�յ�');
    set(gcf,'Name','�ұ�·��');
    xlabel('��λ������/m');
    ylabel('��λ������/m');
    title(['��̾��룺' num2str(rightShortestLength) ]);
    figure;
    plot(1:50,rightLength_best,'--k',1:50,rightLength_ave,'k:');
    set(gcf,'Name','�ұ�Ѱ�Ź���');
    legend('��̾���','ƽ������');
    xlabel('��������');
    ylabel('����L/m');
end 
% if ~isempty(lArmHole)
%     % ���ṹ��ת��Ϊ����(1x(��*��))
%     lArmHoleArray=struct2array(lArmHole);
%     % ����ѡ����ת��Ϊ��*7��
%     lArmHoleArray=reshape(lArmHoleArray(1:end),7,[])';
% %     leftArray=zeros(size(lArmHoleArray));
%     % ����۵ĵ������ȡ������lC�У�n x 2��
%     lC=lArmHoleArray(:,2:3);
%     [Route,~]=myAcatsp(lC,15,int16(0.8*size(lC,1)),1,5,0.2,100,'x-r');
%     % ������滮��Ŀ���Ϣ�������leftArray��
%     for i=1:size(lArmHoleArray,1)
%         leftHoles(i)=lArmHole(Route(i));
%     end
% else
%     leftHoles=[];
% end
% if ~isempty(mArmHole)
%     % ���ṹ��ת��Ϊ����(1x(��*��))
%     mArmHoleArray=struct2array(mArmHole);
%     % ����ѡ����ת��Ϊ��*7��
%     mArmHoleArray=reshape(mArmHoleArray(1:end),7,[])';
% %     midArray=zeros(size(mArmHoleArray));
%     % ���м�۵ĵ������ȡ������lC�У�n x 2��
%     rC=mArmHoleArray(:,2:3);
%     [Route,~]=myAcatsp(rC,15,int16(0.8*size(rC,1)),1,5,0.2,100,'o-y');
%     % ������滮��Ŀ���Ϣ�������leftArray��
%     for i=1:size(mArmHoleArray,1)
%         midHoles(i)=mArmHole(Route(i));
%     end
% else
%     midHoles=[];
% end
% if ~isempty(rArmHole)
%     % ���ṹ��ת��Ϊ����(1x(��*��))
%     rArmHoleArray=struct2array(rArmHole);
%     % ����ѡ����ת��Ϊ��*7��
%     rArmHoleArray=reshape(rArmHoleArray(1:end),7,[])';
% %     rightArray=zeros(size(rArmHoleArray));
%     % ���ұ۵ĵ������ȡ������lC�У�n x 2��
%     rC=rArmHoleArray(:,2:3);
%     [Route,~]=myAcatsp(rC,15,int16(0.8*size(rC,1)),1,5,0.2,100,'x-k'); 
%     % ������滮��Ŀ���Ϣ�������leftArray��
%     for i=1:size(rArmHoleArray,1)
%         rightHoles(i)=rArmHole(Route(i));
%     end
% else
%     rightHoles=[];
% end
sequenceflag=true;
% leftHoles midHoles rightHoles --- Ϊ���������󣬰�����滮˳�����еĸ��۵Ŀ�����(Ϊ��������)
% ���ڱ���
handles.leftHoles=leftHoles;
handles.midHoles=midHoles;
handles.rightHoles=rightHoles;
guidata(hObject, handles);


% --------------------------------------------------------------------
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% �����ͼ��ť�����ж��Ƿ���Խ�����ʾ�������
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
% disp('��figure��buttonDwonFcn')
%% ����������������ϵ����ģ���ֱ��return
% axesPo --- 1x4����[x y width height]
% toPoint --- Ϊ�������mainfigure�е����꣬��������axes�е�����
% tx ty --- �����mainfigure�е�x,y����
% isInAxes --- ����Ƿ������������ڵ�flag����Ϊtrue,����Ϊfalse
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
%    disp('����¼�������������');
    isInAxes=false;
    return;
else
    isInAxes=true;
end
% �Ƿ�����˿���滮��flag
global sequenceflag;
if sequenceflag
    return;
end
%% ----------------
global tunnel holes;
% �ػ���������Ϳ�
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
% tunnel --- ��������ṹ����
% temptunnel --- �ڻ����������棬���������ѡ��ѡ�е��������
global holes undo reundo;
global tunnel temptunnel;
% ���ص�ǰ�������axis��Χ
axisValue=axis;
if strcmp(eventdata.Key,'delete')
    % �����ǰ�������Զ�����������Ľ��棬��ѡ���ˡ����ѡ�������ߡ��ĸ�ѡ��&&holes=[]������£���ѡ�ף�����Ҫѡ���������޸�
    % isPaintTunnel -- �жϵ�ǰҳ���Ƿ��ڻ�������ҳ��
    % isChooseTunnel -- �ж��Ƿ�Ҫ�����ȥѡ�������߶�
    isPaintTunnel=get(handles.panel_drawTunnel,'visible');
    isChooseTunnel=get(handles.cb_mouseProfile,'value');
    if strcmp(isPaintTunnel,'on') && isChooseTunnel && isempty(holes) && tunnel.type==250 && ~isempty(tunnel) && ~isempty(temptunnel)
        % ����tunnel��temptunnel,��tunnel����temptunnel��ͬ���߶λ�Բ��ɾ����
        if isfield(temptunnel,'arc')
            if ~isempty(temptunnel.arc)
                for i=1:length(temptunnel.arc)
                    size=length(tunnel.arc);
                    for j=1:size
                        tempArc=tunnel.arc(size+1-j);
                        if isequal(temptunnel.arc(i),tempArc)
                            % �����ͬ�����tunnel��ɾ��,�Ӻ���ǰ����
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
        % �ػ�ɾ��ѡ������֮���tunnel
        repaint(tunnel, handles, holes, axisValue);
    end
%     disp('������ɾ����')
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
% �ж��Ƿ������������Ѿ������˵��������ִ��
% global isInAxes;
% if ~isInAxes
%     return;
% end
% -------------------
% --------------�����굱ǰ���������ڣ�����״̬����ʾ����-----------
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

%--------------����ѡ������---------

if btDownFlag==1;
    if x~=x0
        if ishandle(h)
            % ����ϴ��л�������ѡ������ϴλ��ľ���ѡ����������
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
% �ж��Ƿ������������Ѿ������˵��������ִ��
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
% x0,y0 --- �����µĳ�ʼ����
% x,y --- ��굱ǰ�ƶ�������
% h --- ����ѡ������ľ��ε�ͼ�ξ��
% rect --- �����ľ��ε�һЩ����
point=get(gca,'CurrentPoint');
global holes tunnel;
global x0 y0 x y;
global btDownFlag h rect;
btDownFlag=0;
x=point(1,1);
y=point(1,2);
%% �����ǰ�������Զ�����������Ľ��棬��ѡ���ˡ����ѡ�������ߡ��ĸ�ѡ��&&holes=[]������£���ѡ�ף�����Ҫѡ���������޸�
% isPaintTunnel -- �жϵ�ǰҳ���Ƿ��ڻ�������ҳ��
% isChooseTunnel -- �ж��Ƿ�Ҫ�����ȥѡ�������߶�
isPaintTunnel=get(handles.panel_drawTunnel,'visible');
isChooseTunnel=get(handles.cb_mouseProfile,'value');
global temptunnel;
if strcmp(isPaintTunnel,'on') && isChooseTunnel && isempty(holes) && tunnel.type==250
    if abs(x-x0)<0.01 && abs(y-y0)<0.01
        % �жϵ���ʱ�Ƿ���ѡ���������
        [ isChosen, chosenLine, chosenArc ] = isChosenTunnel( x0,y0,false,x,y,tunnel );
    else
        % �ж�����ʱ��û��ѡ���������
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
%% �ж�������ѡ���Ƿ�ѡ�п׵Ĵ����
xmin=min([x0,x]);xmax=max([x0,x]);
ymin=min([y0,y]);ymax=max([y0,y]);
if ~isempty(holes)
    if abs(x-x0)<0.01 && abs(y-y0)<0.01
        % ȡ�������Ŀ׺�
        holeNum = find([holes.x]>(x-0.03) & [holes.x]<(x+0.03) & [holes.y]>(y-0.03) & [holes.y]<(y+0.03));
    else
        % ȡ�������еĿ׺�
        holeNum = find([holes.x]>(xmin-0.03) & [holes.x]<(xmax+0.03) & [holes.y]>(ymin-0.03) & [holes.y]<(ymax+0.03));
    end
    % ����Ϣ����ʾ���Ա����޸�-------
    showHoleInfo( holes,holeNum,handles );
    % ״̬����ʾ������
    
    set(handles.tx_totalHole,'string',num2str(length(holes)));
    % -------------
    if ~isempty(holeNum)
        for i=1:length(holeNum)
            drawSingleCircle( holes(holeNum(i)).x,holes(holeNum(i)).y,holes(holeNum(i)).r,...
                holes(holeNum(i)).biasAngle,holes(holeNum(i)).inclineAngle,handles.axes1,'k' );
        end
        handles.holesNum=holeNum;
        % �����ѡ�пף�����Ӧ����״̬����ʾ
        if length(holeNum)==1
            set(handles.tx_selectedHoleNum,'string',num2str(holeNum));
            set(handles.tx_selectedHole,'string','1');
        else
            set(handles.tx_selectedHoleNum,'string','***');
            set(handles.tx_selectedHole,'string',num2str(length(holeNum)));
        end
    else
        handles.holesNum=[];
        % ���û��ѡ���пף���������ѡ�п׺���ʾ***
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


% ---------------------��ʾ�׺�-----------------------
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
% --------------�����굱ǰ���������ڣ�����״̬����ʾ����-----------
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
    % �ػ���������ϵĿ�
    for i=1:length(holes)
        drawSingleCircle( holes(i).x,holes(i).y,holes(i).r,holes(i).biasAngle,holes(i).inclineAngle,handles.axes1,'g' );
    end
end
% ����Ƿ���Ҫ���ƿ׺�
isChecked=get(handles.holeNum,'Checked');
if strcmpi(isChecked,'on')
    paintHoleNum( holes );
end


% --- Executes on button press in pb_draw.
function pb_draw_Callback(hObject, eventdata, handles) 
% hObject    handle to pb_draw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% ��ʼ������
% ��ʼ�����ݽṹ
global tunnel;
global holes;

% ---��ȡԲ������-------
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
% ת��Ϊ����
rangeAngle=rangeAngle*pi/180;
if (length(cenCoord)~=2 || length(rangeAngle)~=2 || length(radiusArc)~=1) && (length(startCoord)~=2 || length(endCoord)~=2 )...
        || ( ~isempty(find(isnan([cenCoord rangeAngle radiusArc]), 1)) && ~isempty(find(isnan([startCoord endCoord]), 1)) )
    errordlg('��������ȷ�Ĳ���','��������');
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
% ����Բ���Ĳ�����ʽ��ȷ���жϰ뾶�ͽǶ��Ƿ����0
    if abs(rangeAngle(1)-rangeAngle(2))<1 || abs(rangeAngle(1)-rangeAngle(2))>360 || radiusArc<=0
        errordlg('�ǶȻ�뾶��������','��������');
        return;
    else
        % ���Բ���������ݵ�tunnel.arc
        if ~isfield(tunnel,'arc')
            tunnel.arc=[];
        end
        size=length(tunnel.arc);
        tempArc.x=cenCoord(1);
        tempArc.y=cenCoord(2);
        tempArc.r=radiusArc;
        tempArc.theta1=rangeAngle(1);
        tempArc.theta2=rangeAngle(2);
        % ���arc�����ݻ�Ϊ�գ��Ͱѵ�ǰ�����ݷŵ�tunnel.arc�ĵ�һ������
        if isempty(tunnel.arc)
            tunnel.arc=tempArc;
        else
            tunnel.arc(size+1)=tempArc;
        end
    end
end

if (length(startCoord)==2 || length(endCoord)==2 ) && isempty(find(isnan([startCoord endCoord]), 1))
    if startCoord(1)==endCoord(1) && startCoord(2)==endCoord(2)
        errordlg('ֱ����ʼ����ֹ���겻��Ϊͬһ����','��������');
        return;
    else
        % ���ֱ���������ݵ�tunnel.line
        if ~isfield(tunnel,'line')
            tunnel.line=[];
        end
        size=length(tunnel.line);
        tempLine.x1=startCoord(1);
        tempLine.y1=startCoord(2);
        tempLine.x2=endCoord(1);
        tempLine.y2=endCoord(2);
        if isempty(tunnel.line)
            % ���line�����ݻ�Ϊ�գ��Ͱѵ�ǰ�����ݷŵ�tunnel.line�ĵ�һ������
            tunnel.line=tempLine;
        else
            % ����������Ųһ��
            tunnel.line(size+1)=tempLine;
        end
    end
end

% ��edit�ı����е���ֵ����ΪĬ��ֵ����ʾֵ
set(handles.et_circleCenter,'string','x;y');
set(handles.et_rangeAngle,'string','th1;the2');
set(handles.et_radiusArc,'string','');
set(handles.et_startCoord,'string',endCoordStr);
set(handles.et_endCoord,'string','x2;y2');
% ����
set(handles.pb_Tunnel,'visible','off');
h=get(gca,'children');
delete(h);
% ����������
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
     uigetfile({'*.xlsx';'*.xls'},'��ѡ��涨��ʽ�������ļ�');
 % ƴ��·�����ļ���
 filepath=strcat(pathname,filename);
 % �ж�Ҫ�򿪵���ʲô���͵��ļ�
 if ~isempty(strfind(filename,'.xlsx')) || ~isempty(strfind(filename,'.xls'))
     % ��������
    [tunnel_array]=xlsread(filepath);
 end
 tunnel.type=tunnel_array(1);
 tunnel.size.R=tunnel_array(2);
 tunnel.size.a=tunnel_array(3);
 tunnel.size.l=tunnel_array(4);
 tunnel.size.r=tunnel_array(5);
 tunnel.size.t=tunnel_array(6);
 % ˢ���ػ�
 refresh_ClickedCallback(hObject, eventdata, handles)

% ���������������
function save_tunnel_Callback(hObject, eventdata, handles)
% hObject    handle to save_tunnel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tunnel;
[filename,pathname]=uiputfile({'*.xlsx'},'������������');
filepath=strcat(pathname,filename);
% ��ͷ
header={'����','R','a','l','r','t'};
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
% ��tunnel_data����ת��ΪԪ������
tunnel_data=num2cell(tunnel_data);
%% �ж�Ҫ�������ʲô��ʽ���ļ�
% ���浽xlsx��xls�ļ���ʽ
if ~isempty(strfind(filename,'.xlsx')) || ~isempty(strfind(filename,'.xls'))
    % ����ͷ���ڱ����ݵ�һ��
    tunnel_data=[header ; tunnel_data];
    % д�뵽excel�ļ�,status---����ɹ�����1�����򷵻�0��message---����ʧ�ܵ�ԭ��string����
    [status,message]=xlswrite(filepath,tunnel_data);
    if status==1
        % ����ɹ�
        msgbox('����ɹ�','Success');
    else
        % ����ʧ��
        errordlg(message,'Fail');
    end
end

% --- Executes on button press in pb_startSequence.
function pb_startSequence_Callback(hObject, eventdata, handles)
% hObject    handle to pb_startSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ʧ�ܷ���˵����Ż�������ť�Ϳ���滮��ť
global holes;
if isempty(holes) || length(holes) < 3
    errordlg('��ǰ�������޷����д˲���������','����');
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
    errordlg('���������������','��������');
    return;
end
guidata(hObject, handles);
% ���÷���˵���
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
    '�������','Gui1');
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
% ��������ͼ
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
    %saveas(newfig2,fullfile(pathname2,filename2));%���Ա����������֮���
    %������벻�����Ա���������⣬�����Ա���figure��axesͼ��ı���
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


% ---------------------------����ģʽ�µĳ�ʼ��������------------------------
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
% ʹ�ܷ���˵����Ż����������ť
set(handles.optHoleTask,'Enable','on');
% ����ʼ���ĸ��ۿ׷���handles�У��Թ��Ż�����
handles.initLeftHole = initLeftHole;
handles.initMidHole = initMidHole;
handles.initRightHole = initRightHole;
guidata(hObject, handles);

% --------------------����ģʽ���Ż�������------------------------------
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
        % ʹ�ܷ���˵��¡�����滮���İ�ť
        set(handles.simulateSequence,'Enable','on');
        guidata(hObject, handles);
    end
else
    errordlg('���Ƚ��г�ʼ�������񣡣���','����');
end


% ------------------����ģʽ�½��п���滮-----------------------------
function simulateSequence_Callback(hObject, eventdata, handles)
% hObject    handle to simulateSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ʧ�ܷ���˵����Ż�������ť�Ϳ���滮��ť
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
% �ж��Ƿ���Ҫ���ƿ���
global tunnel;
initTunnelAxes( tunnel,handles );
isShowSequence = get(handles.show_sequence,'Checked');
leftHoles = handles.leftHoles;
midHoles = handles.midHoles;
rightHoles = handles.rightHoles;
    % ������
    plot(leftHoles(:,2),leftHoles(:,3),'x-r');
    plot(midHoles(:,2),midHoles(:,3),'*--b');
    plot(rightHoles(:,2),rightHoles(:,3),'o-g');
    % �������յ�
    text(leftHoles(1,2),leftHoles(1,3),' ���');
    text(leftHoles(end,2),leftHoles(end,3),' �յ�');
    text(midHoles(1,2),midHoles(1,3),' ���');
    text(midHoles(end,2),midHoles(end,3),' �յ�');
    text(rightHoles(1,2),rightHoles(1,3),' ���');
    text(rightHoles(end,2),rightHoles(end,3),' �յ�');
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
