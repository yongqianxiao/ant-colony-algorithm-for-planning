%% �˺��������Ƕ����С��ұ۽��г��ο׷���
% holes --- �׵����ݽṹ����
% holes.x,y --- �׵�x,y����
% holes.r --- �׵Ŀ׾�
% holes.biasAngle --- �׵�ƫ��
% holes.inclineAngle --- �׵�̽����
% holes.axes --- ��Ҫaxes����ϵ�ϻ���
% holes.color --- �׵���ɫ
function [ lArmHole,mArmHole,rArmHole ] = firstClass( holes, handles)
% �����۵Ŀ׵����
lNum=1;
mNum=1;
rNum=1;
%%  �Կ׽��з��ࣨ�ֳ����ҡ��м�ף�
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
    % ����������̫С����ۺ��ұ�û�з��䵽�ף��򷵻�0
    if lNum==1
        lArmHole=[];
    end
    if rNum==1
        rArmHole=[];
    end
    if mNum==1
        mArmHole=[];
    end
    % ���Ƹ��۵Ŀ�
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



