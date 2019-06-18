%% 对孔进行修改之后就需要的更新操作，可以放到此函数下
% 对孔进行修改之后，将修改的情况加入到
function [undo,reundo]=preUndo( holes,undo,reundo,handles )
% 保存数据为撤销做准备------------
    undo.undo7=undo.undo6;
    undo.undo6=undo.undo5;
    undo.undo5=undo.undo4;
    undo.undo4=undo.undo3;
    undo.undo3=undo.undo2;
    undo.undo2=undo.undo1;
    undo.undo1=holes;
    % 每对孔进行一次修改后，则可撤销的次数+1，但是不大于6
    if undo.undoNum<6
        undo.undoNum = undo.undoNum+1;
    end
    if reundo.reundoNum>0
        reundo.reundoNum = reundo.reundoNum - 1;
    end
% 对孔进行修改之后，更新孔的总数显示-------------
    if ~isempty(holes)
        set(handles.tx_totalHole,'string',num2str(length(holes)));
    else
        set(handles.tx_totalHole,'string','0');
    end
end

