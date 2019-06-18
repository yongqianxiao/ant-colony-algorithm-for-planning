%% 根据type从中间臂分出holeNum个孔给左臂或右臂
% holeNum --- 要从中间臂分出的孔数量
% type --- type=1:从中间臂分给左臂；type=2:从中间臂分给右臂
% mArmHole --- 中间臂的孔，array类型
% ArmHole --- 需要增加孔的臂上的孔，array类型
function [ mArmHole, ArmHole ] = distributeHole( mArmHole, ArmHole, holeNum, type )
%% 按离原点距离和y和x分配，分配原则：
% 将mArmHole分成x<=0和x>0两个矩阵
% 当type=1时，即为左臂优化分配孔，在x<=0的矩阵最右增加一列floor(sqrt(x^2+y^2))
% 将x<=0的矩阵将最右列排序 sortrows(mArmHole(x<=0),8)
mArmHole_1 = mArmHole(mArmHole(:,2) <= 0, :);
mArmHole_2 = mArmHole(mArmHole(:,2) > 0, :);
if type == 1
%     sqrt = zeros(size(mArmHole_1,1),1);
    % disCircle --- 到原点的距离矩阵
    disCircle = sqrt(mArmHole_1(:,2).^2 + mArmHole_1(:,3).^2);
    mArmHole_1 = [mArmHole_1 disCircle];
    mArmHole_1 = sortrows(mArmHole_1, 8);
    % 去掉第8列
    mArmHole_1(:,8)=[];
    % 将mArmHole_1的最后holeNum个孔放到ArmHole后面
    start = size(mArmHole_1,1) - holeNum + 1;
    ArmHole = [ArmHole ; mArmHole_1(start:end , :)];
    % 将放到ArmHole里的孔删除掉
    mArmHole_1(start:end ,:)=[];
    % 将mArmHole_1近照孔从小到大重新排列
    mArmHole_1 = sortrows(mArmHole_1 , 1);
elseif type == 2
    % disCircle --- 到原点的距离矩阵
    disCircle = sqrt(mArmHole_2(:,2).^2 + mArmHole_2(:,3).^2);
    mArmHole_2 = [mArmHole_2 disCircle];
    mArmHole_2 = sortrows(mArmHole_2, 8);
    % 去掉第8列
    mArmHole_2(:,8)=[];     
    % 将mArmHole_2的最后holeNum个孔放到ArmHole后面
    start = size(mArmHole_2,1) - holeNum + 1;
    ArmHole = [ArmHole ; mArmHole_2(start:end,:)];
    % 将放到ArmHole里的孔删除掉
    mArmHole_2(start:end ,:)=[];
    % 将mArmHole_2近照孔从小到大重新排列
    mArmHole_2 = sortrows(mArmHole_2 , 1);
end
mArmHole = [mArmHole_1 ; mArmHole_2];
% 将mArmHole的孔序号重新排序
mArmHole(:,1)=1:1:size(mArmHole,1);
% 将ArmHole的孔序号重新排序
ArmHole(:,1)=1:1:size(ArmHole,1);
%% 按x轴方向分，左臂从x轴负方向开始，右臂从x轴正方向开始
% % 将mArmHole按坐标x排序，其他行也跟着变动
% mArmHole=sortrows(mArmHole,2);
% ArmHole = sortrows(ArmHole,1);
% % 将mArmHole排序后的最后holeNum个孔分配给ArmHole
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

