%% ���׺���
% tunnel --- �ṹ�����飺������͡�������гߴ�
% upHole --- ���Բ���εĿ׾�
% downHole --- ����ױ߿׾�
% upFloor --- ���Բ���β��
% downFloor --- ����ױ߲��
% axes --- ���׻�ͼ��������
% holesR --- �׾�
% inclineAngle --- ̽����
% depth --- ����

function [ Holes ] = assignHoles( tunnel,holes, upHole, downHole, upFloor, downFloor, axes, holesR, inclineAngle, depth )
    
    tunnelType=tunnel.type;
    R = tunnel.size.R;
    t = tunnel.size.t;
    a = tunnel.size.a;
    l = tunnel.size.l;
    r = tunnel.size.r;
    
    if R-upFloor<=0
        errordlg('�������޷�ʵ�ֲ���','��������');
        return;
    end
    
    switch tunnelType
        case 1
            % theta1/theta1 --- Ϊ��������ϲ���Բ������ʼ�Ǻͽ�����
            % perTheta --- Ϊ�����ϲ���Բ������������֮��ļн�
            theta1=acos((t/2-upFloor)/(R-upFloor));
            theta2=pi-theta1;
            [x1,y1,perTheta] = calCircleHolesLocation( theta1,theta2, 0, a, R-upFloor, upHole ); 

% -------------�����ǲ��
%             [ x2,y2 ] = calLineHolesLocation(-t/2,a+R*sin(theta1),-t/2,0,upHole );
%             [ x3,y3 ] = calLineHolesLocation(-t/2,0,t/2,0,downHole );
%             [ x4,y4 ] = calLineHolesLocation(t/2,0,t/2,a+R*sin(theta1),upHole );
%--------------ֻ�����ϲ�Բ����࣬�����ǽǶ�
%             [ x2,y2 ] = calLineHolesLocation(-t/2+upFloor*cos(theta1),a+(R-upFloor)*sin(theta1),-t/2+upFloor*cos(theta1),downFloor,upHole );
%             [ x3,y3 ] = calLineHolesLocation(-t/2+upFloor*cos(theta1),downFloor,t/2-upFloor*cos(theta1),downFloor,downHole );
%             [ x4,y4 ] = calLineHolesLocation(t/2-upFloor*cos(theta1),downFloor,t/2-upFloor*cos(theta1),a+(R-upFloor)*sin(theta1),upHole );
%--------------���ǽǶȣ����ߺͶ���Բ�����Ĳ��һ��
            [ x2,y2 ] = calLineHolesLocation(-t/2+upFloor,a+(R-upFloor)*sin(theta1),-t/2+upFloor,downFloor-l,upHole );
            [ x3,y3 ] = calLineHolesLocation(-t/2+upFloor,downFloor-l,t/2-upFloor,downFloor-r,downHole );
            [ x4,y4 ] = calLineHolesLocation(t/2-upFloor,downFloor-r,t/2-upFloor,a+(R-upFloor)*sin(theta1),upHole );
            
            Holes = addCircleHoles(length(holes),x1,y1,holesR,depth,perTheta,theta1,inclineAngle);
            holes = coverHole( holes, Holes );
            Holes = addLineHoles( length(holes),x2,y2,holesR,depth,inclineAngle );
            holes = coverHole( holes, Holes );
            Holes = addLineHoles( length(holes),x3,y3,holesR,depth,inclineAngle );
            holes = coverHole( holes, Holes );
            Holes = addLineHoles( length(holes),x4,y4,holesR,depth,inclineAngle );
            Holes=coverHole( holes, Holes );
            
            % ��Բ�����ϵĿ�
            drawCircle( x1, y1, holesR , perTheta, theta1, inclineAngle  ,axes, 'g');
            % ��ֱ�߶��ϵĿ�
            drawLineCircle(x2, y2, holesR, inclineAngle, axes, 'g');
            drawLineCircle(x3, y3, holesR, inclineAngle, axes, 'g');
            drawLineCircle(x4, y4, holesR, inclineAngle, axes, 'g');
        case 2
%             theta1 = -asin((a+r)/R);
%             theta2 = pi + asin((a+l)/R);
            theta1=-asin((a+r-downFloor)/(R-upFloor));
            theta2=pi+asin((a+l-downFloor)/(R-upFloor));
            [x1, y1,perTheta]=calCircleHolesLocation( theta1,theta2, 0, a, R-upFloor, upHole ); 
            [x2, y2]=calLineHolesLocation(-sqrt((R-upFloor)^2-(a+l-downFloor)^2),-l+downFloor, sqrt((R-upFloor)^2-(a+r-downFloor)^2),-r+downFloor,downHole );
            Holes = addCircleHoles(length(holes),x1,y1,holesR,depth,perTheta,theta1,inclineAngle);
            holes = coverHole( holes, Holes );
            Holes = addLineHoles( length(holes),x2,y2,holesR,depth,inclineAngle );
            Holes = coverHole( holes, Holes );
            %Holes=[holes Holes];
                % ���ú������׺�̽����
                drawCircle( x1,y1, holesR ,perTheta, theta1, inclineAngle,axes, 'g');
                drawLineCircle(x2, y2, holesR, inclineAngle, axes, 'g');
        case 3
            theta11=-asin((a+r-downFloor)/(2*R-2*upFloor));
            theta12=0;
            [x1, y1,perTheta1]=calCircleHolesLocation( theta11,theta12, upFloor-R, a, 2*R-2*upFloor, upHole ); 
            theta21=0;
            theta22=pi;
            [x2, y2,perTheta2]=calCircleHolesLocation( theta21,theta22, 0, a, R-upFloor, upHole ); 
            theta31=pi;
            theta32=pi + asin((a+l-downFloor)/(2*R-2*upFloor));
            [x3, y3, perTheta3]= calCircleHolesLocation( theta31,theta32, R-upFloor, a, 2*R-2*upFloor, upHole );
            [x4, y4] = calLineHolesLocation((R-upFloor)-sqrt((2*R-2*upFloor)^2-(a+l-downFloor)^2),downFloor-l,sqrt((2*R-2*upFloor)^2-(a+r-downFloor)^2)-(R-upFloor),downFloor-r,downHole );
            
            % ����������ϲ�������Բ���ϵĿ���ӵ��׵Ľṹ������
            Holes = addCircleHoles(length(holes),x1,y1,holesR,depth,perTheta1,theta11,inclineAngle);
            holes = coverHole( holes, Holes );
            Holes = addCircleHoles(length(holes),x2,y2,holesR,depth,perTheta2,theta21,inclineAngle);
            holes = coverHole( holes, Holes );
            Holes = addCircleHoles(length(holes),x3,y3,holesR,depth,perTheta3,theta31,inclineAngle);
            holes = coverHole( holes, Holes );
            % ����������ױ�ֱ���ϵĿ���ӵ��׵Ľṹ������
            Holes = addLineHoles( length(holes),x4,y4,holesR,depth,inclineAngle );
            Holes = coverHole( holes, Holes );
            
            drawCircle( x1, y1, holesR ,perTheta1, theta11, inclineAngle,axes, 'g');
            drawCircle( x2, y2, holesR ,perTheta2, theta21, inclineAngle,axes, 'g');
            drawCircle( x3, y3, holesR ,perTheta3, theta31, inclineAngle,axes, 'g');
            drawLineCircle(x4, y4, holesR, inclineAngle, axes, 'g');
            
    end
end

