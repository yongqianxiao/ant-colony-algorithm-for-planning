%% 将当前选中的孔的信息在添加孔的面板上显示出来
% holes --- 当前已经添加了的孔结构数组
% holeNum --- 已经选中的孔的孔号
% handles --- 当前figure的图形句柄
function showHoleInfo( holes,holeNum,handles )
    % 将‘添加孔的面板’调到最前面
    set(handles.panel_addHole,'visible','on');
    set(handles.panel_changeSize,'visible','off');
    set(handles.panel_assignHole,'visible','off');
    set(handles.panel_deleteHole,'visible','off');
if ~isempty(holeNum)
    size=length(holeNum);
    if size==1
        set(handles.et_depth,'string',num2str(holes(holeNum).depth));
        set(handles.et_X,'string',num2str(holes(holeNum).x));
        set(handles.et_Y,'string',num2str(holes(holeNum).y));
        set(handles.et_r,'string',num2str(holes(holeNum).r*1000));
        set(handles.et_biasAngle,'string',num2str(holes(holeNum).biasAngle*180/pi));
        set(handles.et_inclineAngle,'string',num2str(holes(holeNum).inclineAngle));
    else
        set(handles.et_depth,'string','');
        set(handles.et_X,'string','');
        set(handles.et_Y,'string','');
        set(handles.et_r,'string','');
        set(handles.et_biasAngle,'string','');
        set(handles.et_inclineAngle,'string','');
    end
else
    set(handles.et_depth,'string','');
    set(handles.et_X,'string','');
    set(handles.et_Y,'string','');
    set(handles.et_r,'string','');
    set(handles.et_biasAngle,'string','');
    set(handles.et_inclineAngle,'string','');
end
end

