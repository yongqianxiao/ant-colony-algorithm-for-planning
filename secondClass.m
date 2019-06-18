%% 在第一次根据工作空间分配孔之后的第二次分配，根据打孔速度和孔深，以及孔数量分配
% 如果各臂的打孔总时间差小于各臂单孔平均时间之和，则认为时间差达到要求
% simulateArray --- 优化分配前和后的钻孔时间、钻孔数量矩阵
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

% 求左臂需要的时间
[ leftTime, leftAveTime, leftHoleArray ] = calBoringTime( lArmHole,v_in,moveTime,1);
% 求中间臂需要的时间
[ midTime, midAveTime, midHoleArray ] = calBoringTime( mArmHole ,v_in,moveTime,1);
% 求右臂需要的时间
[ rightTime, rightAveTime, rightHoleArray ] = calBoringTime( rArmHole ,v_in,moveTime,1);
simulateArray(1,:) = [leftTime midTime rightTime];
simulateArray(2,:) = [size(leftHoleArray,1) size(midHoleArray,1) size(rightHoleArray,1)];
aveTime = leftAveTime + midAveTime + rightAveTime;

% resultTime --- 为优化完各臂的钻孔时间
resultTime = midTime - (leftTime + midTime + rightTime)/3;
% 说明左臂和右臂都缺少孔任务
if (midTime-leftTime > aveTime) && (midTime - rightTime > aveTime)
    % disHoleNum --- 为中间臂要分出来的孔数量
    disHoleNum = floor(resultTime / midAveTime);
    disTime = abs(leftTime - rightTime);
    % 如果左臂和右臂的孔任务相关较大
    if disTime > leftAveTime + rightAveTime     
        % holeNum --- 从中间臂分给左臂或右臂孔较少的一个臂的孔数量
        holeNum = floor(disTime / midAveTime);
        % restHoleNum --- 为左、右臂任务均衡后，用来平分的孔
        restHoleNum = disHoleNum - holeNum;
        leftHoleNum = floor(restHoleNum/2);
        rightHoleNum = restHoleNum - leftHoleNum;
        % 如果左臂的孔任务比右臂大的多
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
    % 输出优化后各臂需要的时间
    [leftTimeEnd,~,~]=calBoringTime( leftHoleArray ,v_in,moveTime,2);
    [midTimeEnd,~,~]=calBoringTime( midHoleArray ,v_in,moveTime,2);
    [rightTimeEnd,~,~]=calBoringTime( rightHoleArray ,v_in,moveTime,2);
    simulateArray(3,:) = [leftTimeEnd midTimeEnd rightTimeEnd];
    simulateArray(4,:) = [size(leftHoleArray,1) size(midHoleArray,1) size(rightHoleArray,1)];
    % 将优化结果显示到表格中
    set(handles.table,'data',simulateArray);
    
    % 绘制各臂的孔
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
% % 说明左臂缺少孔任务
% if leftTime - midTime > aveTime
%     
%     return;
% end
% % 说明右臂缺少孔任务
% if rightTime - midTime > aveTime
%     
%     return;
% end

end

