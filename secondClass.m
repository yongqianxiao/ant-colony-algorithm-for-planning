%% �ڵ�һ�θ��ݹ����ռ�����֮��ĵڶ��η��䣬���ݴ���ٶȺͿ���Լ�����������
% ������۵Ĵ����ʱ���С�ڸ��۵���ƽ��ʱ��֮�ͣ�����Ϊʱ���ﵽҪ��
% simulateArray --- �Ż�����ǰ�ͺ�����ʱ�䡢�����������
function [ leftHoleArray,midHoleArray,rightHoleArray ,simulateArray] = secondClass( lArmHole,mArmHole,rArmHole ,handles)
simulateArray = zeros(4,3);
if isfield(handles,'moveTime')
    if handles.moveTime > 0
        moveTime = handles.moveTime;
    else
        moveTime = 20;
    end
else
    moveTime = 20;
end
if isfield(handles, 'drillVelo') 
    if handles.drillVelo > 0
        v_in = handles.drillVelo;
    else
        v_in = 2.5;
    end
else
    v_in = 2.5;
end

if isempty(lArmHole) || isempty(mArmHole) || isempty(rArmHole)
    if isempty(lArmHole)
        leftHoleArray = [];
    else
        [ ~, ~, leftHoleArray ] = calBoringTime( lArmHole,v_in,moveTime);
    end
    if isempty(rArmHole)
        rightHoleArray = [];
    else
        [ ~, ~, rightHoleArray ] = calBoringTime( rArmHole ,v_in,moveTime);
    end
    if isempty(mArmHole)
        midHoleArray = [];
    else
        [ ~, ~, midHoleArray ] = calBoringTime( mArmHole ,v_in,moveTime);
    end
    return
end

% �������Ҫ��ʱ��
[ leftTime, leftAveTime, leftHoleArray ] = calBoringTime( lArmHole,v_in,moveTime,1);
% ���м����Ҫ��ʱ��
[ midTime, midAveTime, midHoleArray ] = calBoringTime( mArmHole ,v_in,moveTime,1);
% ���ұ���Ҫ��ʱ��
[ rightTime, rightAveTime, rightHoleArray ] = calBoringTime( rArmHole ,v_in,moveTime,1);
simulateArray(1,:) = [leftTime midTime rightTime];
simulateArray(2,:) = [size(leftHoleArray,1) size(midHoleArray,1) size(rightHoleArray,1)];
aveTime = leftAveTime + midAveTime + rightAveTime;

% resultTime --- Ϊ�Ż�����۵����ʱ��
resultTime = midTime - (leftTime + midTime + rightTime)/3;
% ˵����ۺ��ұ۶�ȱ�ٿ�����
if (midTime-leftTime > aveTime) && (midTime - rightTime > aveTime)
    % disHoleNum --- Ϊ�м��Ҫ�ֳ����Ŀ�����
    disHoleNum = floor(resultTime / midAveTime);
    disTime = abs(leftTime - rightTime);
    % �����ۺ��ұ۵Ŀ�������ؽϴ�
    if disTime > leftAveTime + rightAveTime     
        % holeNum --- ���м�۷ָ���ۻ��ұۿ׽��ٵ�һ���۵Ŀ�����
        holeNum = floor(disTime / midAveTime);
        % restHoleNum --- Ϊ���ұ�������������ƽ�ֵĿ�
        restHoleNum = disHoleNum - holeNum;
        leftHoleNum = floor(restHoleNum/2);
        rightHoleNum = restHoleNum - leftHoleNum;
        % �����۵Ŀ�������ұ۴�Ķ�
        if leftTime > rightTime 
            rightHoleNum = rightHoleNum + holeNum;            
        else
            leftHoleNum = leftHoleNum + holeNum;            
        end        
    else
        leftHoleNum = floor(disHoleNum/2);
        rightHoleNum = disHoleNum - leftHoleNum;
    end
    [ midHoleArray, rightHoleArray ] = distributeHole( midHoleArray, rightHoleArray, rightHoleNum, 2 );
    [ midHoleArray, leftHoleArray ] = distributeHole( midHoleArray, leftHoleArray, leftHoleNum, 1 );
    % ����Ż��������Ҫ��ʱ��
    [leftTimeEnd,~,~]=calBoringTime( leftHoleArray ,v_in,moveTime,2);
    [midTimeEnd,~,~]=calBoringTime( midHoleArray ,v_in,moveTime,2);
    [rightTimeEnd,~,~]=calBoringTime( rightHoleArray ,v_in,moveTime,2);
    simulateArray(3,:) = [leftTimeEnd midTimeEnd rightTimeEnd];
    simulateArray(4,:) = [size(leftHoleArray,1) size(midHoleArray,1) size(rightHoleArray,1)];
    % ���Ż������ʾ�������
    set(handles.table,'data',simulateArray);
    
    % ���Ƹ��۵Ŀ�
    isChecked=get(handles.simulateMode,'Checked');
    if strcmpi(isChecked,'on')
        newigure1 = figure;
        hold on;
        for i=1:size(leftHoleArray,1)
            plot(leftHoleArray(:,2),leftHoleArray(:,3),'rx');
        end
        hold on;
        for i=1:size(midHoleArray,1)
            plot(midHoleArray(:,2),midHoleArray(:,3),'b*');
        end
        for i=1:size(rightHoleArray,1)
            plot(rightHoleArray(:,2),rightHoleArray(:,3),'go');
        end
    end
end
% % ˵�����ȱ�ٿ�����
% if leftTime - midTime > aveTime
%     
%     return;
% end
% % ˵���ұ�ȱ�ٿ�����
% if rightTime - midTime > aveTime
%     
%     return;
% end

end

