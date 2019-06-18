%% 此函数用来计算钻完ArmHoles的孔需要的时间
% v --- 钻孔速度
% type --- 表示计算优化的时间还是模拟钻孔的时间
    % 1--- 表示计算需要优化的时间：钻孔速度不变
    % 2--- 表示模拟钻孔需要的时间：每个孔的钻孔速度不孔，v=v-rand(0~0.5)
function [ tolTime, aveTime ,holes_data] = calBoringTime( ArmHoles,v,mvTime,type )
    v_in=v;     % 单位：m/min
    mv_time=mvTime;      % 时间单位：秒
    
    if isstruct(ArmHoles)
        % 将孔数据的偏角由弧度转为度
        for i=1:length(ArmHoles)
            ArmHoles(i).biasAngle=ArmHoles(i).biasAngle*180/pi;
        end
        % 将结构体数组转换为元胞数组
        holes_cell=struct2cell(ArmHoles);
        % 取得元胞数组的尺寸，7x1x孔数
        holes_size=size(holes_cell);
        % 元胞数组尺寸的行即为孔数据的字段数
        property = holes_size(1);
        % 取元胞数组中所有元素为普通数组
        holes_data=holes_cell(1:property,:);
        % 转置
        holes_data=holes_data';
        holes_data=cell2mat(holes_data);
    else
        holes_data=ArmHoles;
    end
    % 钻臂移动时间
    mvTime = (size(holes_data,1) -1) * mv_time;  % 时间单位：秒
    
    % 计算打孔时间
    % 孔径总深
    if type == 1
        tolDepth = sum(holes_data(:,5));
        boreTime = tolDepth / v_in; %时间单位：分钟
    elseif type == 2 
        v_in = ones(length(holes_data),1)*v_in;
        randV = rand(length(holes_data),1);
        randV(randV>0.5) = randV(randV>0.5) - 0.5;
        v_in = v_in - randV;
        boreTime = sum(holes_data(:,5)./v_in);
    end
    
    tolTime = mvTime/60 + boreTime;
    aveTime = tolTime / size(holes_data,1);
end

