%% �˺���������������ArmHoles�Ŀ���Ҫ��ʱ��
% v --- ����ٶ�
% type --- ��ʾ�����Ż���ʱ�仹��ģ����׵�ʱ��
    % 1--- ��ʾ������Ҫ�Ż���ʱ�䣺����ٶȲ���
    % 2--- ��ʾģ�������Ҫ��ʱ�䣺ÿ���׵�����ٶȲ��ף�v=v-rand(0~0.5)
function [ tolTime, aveTime ,holes_data] = calBoringTime( ArmHoles,v,mvTime,type )
    v_in=v;     % ��λ��m/min
    mv_time=mvTime;      % ʱ�䵥λ����
    
    if isstruct(ArmHoles)
        % �������ݵ�ƫ���ɻ���תΪ��
        for i=1:length(ArmHoles)
            ArmHoles(i).biasAngle=ArmHoles(i).biasAngle*180/pi;
        end
        % ���ṹ������ת��ΪԪ������
        holes_cell=struct2cell(ArmHoles);
        % ȡ��Ԫ������ĳߴ磬7x1x����
        holes_size=size(holes_cell);
        % Ԫ������ߴ���м�Ϊ�����ݵ��ֶ���
        property = holes_size(1);
        % ȡԪ������������Ԫ��Ϊ��ͨ����
        holes_data=holes_cell(1:property,:);
        % ת��
        holes_data=holes_data';
        holes_data=cell2mat(holes_data);
    else
        holes_data=ArmHoles;
    end
    % ����ƶ�ʱ��
    mvTime = (size(holes_data,1) -1) * mv_time;  % ʱ�䵥λ����
    
    % ������ʱ��
    % �׾�����
    if type == 1
        tolDepth = sum(holes_data(:,5));
        boreTime = tolDepth / v_in; %ʱ�䵥λ������
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

