%% 此函数功能是对左、中、右臂进行初次孔分配
% holes --- 孔的数据结构数组
% holes.x,y --- 孔的x,y坐标
% holes.r --- 孔的孔径
% holes.biasAngle --- 孔的偏角
% holes.inclineAngle --- 孔的探出角
% holes.axes --- 在要axes坐标系上画孔
% holes.color --- 孔的颜色
function [ lArmHole,mArmHole,rArmHole ] = firstClass( holes, handles)
% 三个臂的孔的序号
lNum=1;
mNum=1;
rNum=1;
%%  对孔进行分类（分出左、右、中间孔）
    for i=1:length(holes)
        if(holes(i).x<=-6.36)
           lArmHole(lNum)= holes(i);
           lArmHole(lNum).num=lNum;
           lNum=lNum+1;
        elseif(holes(i).x<=-5.2)
            if(holes(i).y<sqrt(11.28^2-(holes(i).x-4.78)^2)+1.64);
                mArmHole(mNum)=holes(i);
                mArmHole(mNum).num=mNum;
                mNum=mNum+1;
            else
                lArmHole(lNum)=holes(i);
                lArmHole(lNum).num=lNum;
                lNum=lNum+1;
            end
        elseif(holes(i).x<=0)
            if(holes(i).y<0.4231*holes(i).x+9.1)
                mArmHole(mNum)=holes(i);
                mArmHole(mNum).num=mNum;
                mNum=mNum+1;
            else
                lArmHole(lNum)=holes(i);
                lArmHole(lNum).num=lNum;
                lNum=lNum+1;
            end
        elseif(holes(i).x<=5.2)
            if(holes(i).y<-0.4231*holes(i).x+9.1)
                mArmHole(mNum)=holes(i);
                mArmHole(mNum).num=mNum;
                mNum=mNum+1;
            else
                rArmHole(rNum)=holes(i);
                rArmHole(rNum).num=rNum;
                rNum=rNum+1;
            end
        elseif(holes(i).x<=6.36)
            if(holes(i).y<sqrt(11.28^2-(holes(i).x+4.78)^2)+1.64)
                mArmHole(mNum)=holes(i);
                mArmHole(mNum).num=mNum;
                mNum=mNum+1;
            else
                rArmHole(rNum)=holes(i);
                rArmHole(rNum).num=rNum;
                rNum=rNum+1;
            end
        else
            rArmHole(rNum)=holes(i);
            rArmHole(rNum).num=rNum;
            rNum=rNum+1;
        end
    end
    % 如果隧道轮廓太小，左臂和右臂没有分配到孔，则返回0
    if lNum==1
        lArmHole=[];
    end
    if rNum==1
        rArmHole=[];
    end
    if mNum==1
        mArmHole=[];
    end
    % 绘制各臂的孔
    isChecked=get(handles.simulateMode,'Checked');
    if strcmpi(isChecked,'on')
        figure;
        hold on;
        for i=1:length(lArmHole)
            plot(lArmHole(i).x,lArmHole(i).y,'rx');
        end
        hold on;
        for i=1:length(mArmHole)
            plot(mArmHole(i).x,mArmHole(i).y,'b*');
        end
        for i=1:length(rArmHole)
            plot(rArmHole(i).x,rArmHole(i).y,'go');
        end
    end



