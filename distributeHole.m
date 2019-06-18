%% ����type���м�۷ֳ�holeNum���׸���ۻ��ұ�
% holeNum --- Ҫ���м�۷ֳ��Ŀ�����
% type --- type=1:���м�۷ָ���ۣ�type=2:���м�۷ָ��ұ�
% mArmHole --- �м�۵Ŀף�array����
% ArmHole --- ��Ҫ���ӿ׵ı��ϵĿף�array����
function [ mArmHole, ArmHole ] = distributeHole( mArmHole, ArmHole, holeNum, type )
%% ����ԭ������y��x���䣬����ԭ��
% ��mArmHole�ֳ�x<=0��x>0��������
% ��type=1ʱ����Ϊ����Ż�����ף���x<=0�ľ�����������һ��floor(sqrt(x^2+y^2))
% ��x<=0�ľ������������� sortrows(mArmHole(x<=0),8)
mArmHole_1 = mArmHole(mArmHole(:,2) <= 0, :);
mArmHole_2 = mArmHole(mArmHole(:,2) > 0, :);
if type == 1
%     sqrt = zeros(size(mArmHole_1,1),1);
    % disCircle --- ��ԭ��ľ������
    disCircle = sqrt(mArmHole_1(:,2).^2 + mArmHole_1(:,3).^2);
    mArmHole_1 = [mArmHole_1 disCircle];
    mArmHole_1 = sortrows(mArmHole_1, 8);
    % ȥ����8��
    mArmHole_1(:,8)=[];
    % ��mArmHole_1�����holeNum���׷ŵ�ArmHole����
    start = size(mArmHole_1,1) - holeNum + 1;
    ArmHole = [ArmHole ; mArmHole_1(start:end , :)];
    % ���ŵ�ArmHole��Ŀ�ɾ����
    mArmHole_1(start:end ,:)=[];
    % ��mArmHole_1���տ״�С������������
    mArmHole_1 = sortrows(mArmHole_1 , 1);
elseif type == 2
    % disCircle --- ��ԭ��ľ������
    disCircle = sqrt(mArmHole_2(:,2).^2 + mArmHole_2(:,3).^2);
    mArmHole_2 = [mArmHole_2 disCircle];
    mArmHole_2 = sortrows(mArmHole_2, 8);
    % ȥ����8��
    mArmHole_2(:,8)=[];     
    % ��mArmHole_2�����holeNum���׷ŵ�ArmHole����
    start = size(mArmHole_2,1) - holeNum + 1;
    ArmHole = [ArmHole ; mArmHole_2(start:end,:)];
    % ���ŵ�ArmHole��Ŀ�ɾ����
    mArmHole_2(start:end ,:)=[];
    % ��mArmHole_2���տ״�С������������
    mArmHole_2 = sortrows(mArmHole_2 , 1);
end
mArmHole = [mArmHole_1 ; mArmHole_2];
% ��mArmHole�Ŀ������������
mArmHole(:,1)=1:1:size(mArmHole,1);
% ��ArmHole�Ŀ������������
ArmHole(:,1)=1:1:size(ArmHole,1);
%% ��x�᷽��֣���۴�x�Ḻ����ʼ���ұ۴�x��������ʼ
% % ��mArmHole������x����������Ҳ���ű䶯
% mArmHole=sortrows(mArmHole,2);
% ArmHole = sortrows(ArmHole,1);
% % ��mArmHole���������holeNum���׷����ArmHole
% if type == 1
%     ArmHole = [ArmHole ; mArmHole(1:holeNum,:)];
%     mArmHole(1:holeNum,:)=[];
% elseif type ==2
%     start = size(mArmHole,1) - holeNum + 1;
%     ArmHole = [ArmHole ; mArmHole(start:end,:)];
%     mArmHole(start:end,:)=[];
% end
% mArmHole=sortrows(mArmHole,1);
% mArmHole(:,1)=1:1:size(mArmHole,1);
% ArmHole(:,1)=1:1:size(ArmHole,1);
end

