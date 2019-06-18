%% ����ӵ�����ʱ���ж�Ҫ��ӵĿ��Ƿ��Ѿ����ڣ������򸲸ǣ���֮�����
% holes --- ��ǰ�Ѿ�����˵Ŀ׽ṹ����
% holeData --- ��Ҫ�ж���ӻ򸲸ǵĵ����׽ṹ����
% tunnel --- ��������ṹ����
% handles --- ��ǰfigure��ͼ�ξ��
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

