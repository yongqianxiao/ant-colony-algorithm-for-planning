%% �����Ƿ��Ѿ��������뽫Ҫ��ӵĿ�λ���ظ��Ŀ�
% ��������򷵻�����holes�е�num�ţ��Ա㸲�ǲ���
% holes --- ��ʾ�Ѿ����ڵĿ׵Ľṹ����
% Holes --- ��ʾ��Ҫ���׺���Ҫ�ж��Ƿ���Ҫ������ӵ�
% ����ֵ holes --- ������ֱ�����֮��Ŀ׵Ľṹ����
function holes = coverHole( holes, Holes )
    for i=1:length(Holes)
        size=length(holes);
        if ~isempty(holes)
            tempNum=find([holes.x]>(Holes(i).x-0.01) & [holes.x]<(Holes(i).x+0.01) & [holes.y]>(Holes(i).y-0.01) & [holes.y]<(Holes(i).y+0.01));
        else
            tempNum=[];
        end
        if isempty(tempNum)
            % �ж�holes�Ƿ�Ϊ�ṹ���飬������ǣ���ֱ�Ӱ�Holes(i)����holes������holes�Ľṹ
            % ����Ѿ��ǽṹ���飨���Ѿ��п������ˣ������Holes(i)������������
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

