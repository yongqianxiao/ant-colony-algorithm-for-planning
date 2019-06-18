%% 查找是否已经存在有与将要添加的孔位置重复的孔
% 如果存在则返回其在holes中的num号，以便覆盖布孔
% holes --- 表示已经存在的孔的结构数组
% Holes --- 表示需要布孔后，需要判断是否需要覆盖添加的
% 返回值 holes --- 覆盖若直接添加之后的孔的结构数组
function holes = coverHole( holes, Holes )
    for i=1:length(Holes)
        size=length(holes);
        if ~isempty(holes)
            tempNum=find([holes.x]>(Holes(i).x-0.01) & [holes.x]<(Holes(i).x+0.01) & [holes.y]>(Holes(i).y-0.01) & [holes.y]<(Holes(i).y+0.01));
        else
            tempNum=[];
        end
        if isempty(tempNum)
            % 判断holes是否为结构数组，如果不是，则直接把Holes(i)赋给holes，定型holes的结构
            % 如果已经是结构数组（即已经有孔数据了），则把Holes(i)，往最后面添加
            if isstruct(holes)
                holes(size+1) = Holes(i);
                holes(length(holes)).num=length(holes);
            else
                holes=Holes(i);
                holes(1).num=1;
            end
        else
            holes(tempNum)=Holes(i);
            holes(tempNum).num=tempNum;
        end
    end
end

