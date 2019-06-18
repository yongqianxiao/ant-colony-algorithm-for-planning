%% 布孔函数
% tunnel --- 结构体数组：隧道类型、隧道所有尺寸
% upHole --- 隧道圆弧段的孔距
% downHole --- 隧道底边孔距
% upFloor --- 隧道圆弧段层距
% downFloor --- 隧道底边层距
% axes --- 布孔绘图的坐标轴
% holesR --- 孔径
% inclineAngle --- 探出角
% depth --- 孔深

function [ Holes ] = assignHoles( tunnel,holes, upHole, downHole, upFloor, downFloor, axes, holesR, inclineAngle, depth )
    
    tunnelType=tunnel.type;
    R = tunnel.size.R;
    t = tunnel.size.t;
    a = tunnel.size.a;
    l = tunnel.size.l;
    r = tunnel.size.r;
    
    if R-upFloor<=0
        errordlg('层距过大，无法实现布孔','参数错误');
        return;
    end
    
    switch tunnelType
        case 1
            % theta1/theta1 --- 为隧道轮廓上部分圆弧的起始角和结束角
            % perTheta --- 为轮廓上部分圆弧上相邻两孔之间的夹角
            theta1=acos((t/2-upFloor)/(R-upFloor));
            theta2=pi-theta1;
            [x1,y1,perTheta] = calCircleHolesLocation( theta1,theta2, 0, a, R-upFloor, upHole ); 

% -------------不考虑层距
%             [ x2,y2 ] = calLineHolesLocation(-t/2,a+R*sin(theta1),-t/2,0,upHole );
%             [ x3,y3 ] = calLineHolesLocation(-t/2,0,t/2,0,downHole );
%             [ x4,y4 ] = calLineHolesLocation(t/2,0,t/2,a+R*sin(theta1),upHole );
%--------------只考虑上层圆弧层距，不考虑角度
%             [ x2,y2 ] = calLineHolesLocation(-t/2+upFloor*cos(theta1),a+(R-upFloor)*sin(theta1),-t/2+upFloor*cos(theta1),downFloor,upHole );
%             [ x3,y3 ] = calLineHolesLocation(-t/2+upFloor*cos(theta1),downFloor,t/2-upFloor*cos(theta1),downFloor,downHole );
%             [ x4,y4 ] = calLineHolesLocation(t/2-upFloor*cos(theta1),downFloor,t/2-upFloor*cos(theta1),a+(R-upFloor)*sin(theta1),upHole );
%--------------考虑角度，两边和顶层圆弧处的层距一致
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
            
            % 画圆弧段上的孔
            drawCircle( x1, y1, holesR , perTheta, theta1, inclineAngle  ,axes, 'g');
            % 画直线段上的孔
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
                % 调用函数画孔和探出角
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
            
            % 将隧道轮廓上部分三道圆弧上的孔添加到孔的结构数组中
            Holes = addCircleHoles(length(holes),x1,y1,holesR,depth,perTheta1,theta11,inclineAngle);
            holes = coverHole( holes, Holes );
            Holes = addCircleHoles(length(holes),x2,y2,holesR,depth,perTheta2,theta21,inclineAngle);
            holes = coverHole( holes, Holes );
            Holes = addCircleHoles(length(holes),x3,y3,holesR,depth,perTheta3,theta31,inclineAngle);
            holes = coverHole( holes, Holes );
            % 将隧道轮廓底边直线上的孔添加到孔的结构数组中
            Holes = addLineHoles( length(holes),x4,y4,holesR,depth,inclineAngle );
            Holes = coverHole( holes, Holes );
            
            drawCircle( x1, y1, holesR ,perTheta1, theta11, inclineAngle,axes, 'g');
            drawCircle( x2, y2, holesR ,perTheta2, theta21, inclineAngle,axes, 'g');
            drawCircle( x3, y3, holesR ,perTheta3, theta31, inclineAngle,axes, 'g');
            drawLineCircle(x4, y4, holesR, inclineAngle, axes, 'g');
            
    end
end

