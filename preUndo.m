%% �Կ׽����޸�֮�����Ҫ�ĸ��²��������Էŵ��˺�����
% �Կ׽����޸�֮�󣬽��޸ĵ�������뵽
function [undo,reundo]=preUndo( holes,undo,reundo,handles )
% ��������Ϊ������׼��------------
    undo.undo7=undo.undo6;
    undo.undo6=undo.undo5;
    undo.undo5=undo.undo4;
    undo.undo4=undo.undo3;
    undo.undo3=undo.undo2;
    undo.undo2=undo.undo1;
    undo.undo1=holes;
    % ÿ�Կ׽���һ���޸ĺ���ɳ����Ĵ���+1�����ǲ�����6
    if undo.undoNum<6
        undo.undoNum = undo.undoNum+1;
    end
    if reundo.reundoNum>0
        reundo.reundoNum = reundo.reundoNum - 1;
    end
% �Կ׽����޸�֮�󣬸��¿׵�������ʾ-------------
    if ~isempty(holes)
        set(handles.tx_totalHole,'string',num2str(length(holes)));
    else
        set(handles.tx_totalHole,'string','0');
    end
end

