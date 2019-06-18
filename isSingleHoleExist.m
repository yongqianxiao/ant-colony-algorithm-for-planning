%% 在添加单个孔时，判断要添加的孔是否已经存在，存在则覆盖，反之新添加
% holes --- 当前已经添加了的孔结构数组
% holeData --- 需要判断添加或覆盖的单个孔结构数组
% tunnel --- 隧道参数结构数组
% handles --- 当前figure的图形句柄
function holes = isSingleHoleExist( holes,holeData,tunnel,handles,axisValue )
    size=length(holes);
    if isempty(holes)
        tempNum=[];
    else
        tempNum=find([holes.x]>(holeData.x-0.01) & [holes.x]<(holeData.x+0.01) & [holes.y]>(holeData.y-0.01) & [holes.y]<(holeData.y+0.01));
    end
    if isempty(tempNum)
        if isstruct(holes)
            holes(size+1)=holeData;
        else
            holes=holeData;
        end
    else
        holes(tempNum)=holeData;
        holes(tempNum).num=tempNum;
        repaint(tunnel, handles, holes, axisValue);
    end
end

