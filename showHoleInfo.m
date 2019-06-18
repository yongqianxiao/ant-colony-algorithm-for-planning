%% ����ǰѡ�еĿ׵���Ϣ����ӿ׵��������ʾ����
% holes --- ��ǰ�Ѿ�����˵Ŀ׽ṹ����
% holeNum --- �Ѿ�ѡ�еĿ׵Ŀ׺�
% handles --- ��ǰfigure��ͼ�ξ��
function showHoleInfo( holes,holeNum,handles )
    % ������ӿ׵���塯������ǰ��
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

