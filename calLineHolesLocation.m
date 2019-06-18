%% 计算线段上孔的坐标
% x1/y1 x2/y2 --- 线段两端点坐标
% downHole --- 线段上孔的孔距
% x/y --- 输出的孔的坐标
function [ x,y ] = calLineHolesLocation(x1,y1,x2,y2,downHole )
% x1=-5;
% y1=-8;
% x2=2;
% y2=-3;
% downHole=0.5;

% size --- 根据孔距计算线段上应有size个孔
size = sqrt((x1-x2)^2+(y1-y2)^2)/downHole;
if mod(size,(floor(size)))<0.5
    size=floor(size);
else
    size=floor(size)+1;
end
x=ones(size,1);
y=ones(size,1);
for i=1:size
    x(i)=x1+((x2-x1)/size)*(i-1);
    y(i)=y1+((y2-y1)/size)*(i-1);
end

% plot([x1 x2],[y1 y2]);
% hold on;
% plot(x,y,'ro');

end

