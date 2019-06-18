%% 根据所给的隧道，重绘隧道轮廓坐标系
function  initTunnelAxes( tunnel,handles )
h=get(handles.axes1,'children');
delete(h);
type=tunnel.type;
R=tunnel.size.R;
t=tunnel.size.t;
a=tunnel.size.a;
l=tunnel.size.l;
r=tunnel.size.r;
switch type
    case 1
        set(handles.tx_tunnelType,'String','输水隧道');
        waterTunnel( R, t, a, l, r,[-t-2,t+2 , -l-r-1, a+R+2] );
        water=imread('waterTunnel.jpg');
        set(handles.pb_Tunnel,'cdata',water); 
    case 2
        set(handles.tx_tunnelType,'String','公路隧道');
        
        roadTunnel(R,a,l,r,[-R-2 R+2 -l-r-1 R+a+2]);
        road=imread('roadTunnel.jpg');
        set(handles.pb_Tunnel,'cdata',road);
    case 3
        set(handles.tx_tunnelType,'String','马蹄形隧道');
        horseshoeTunnel( R,a,l,r,[-R-6 R+6 -l-r-1 R+a+2] );
        horse=imread('horseshoeTunnel.jpg');
        set(handles.pb_Tunnel,'cdata',horse);
end

end

