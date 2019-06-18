% �˺����������������������Բ�����߶ε�˳��
% ��sequence����Ϊ�գ����ʾ����������������ж����߶�
function  [sequence,tunnel]=sequence( tunnel )
if ~isfield(tunnel,'arc')
    tunnel.arc=[];
end
if ~isfield(tunnel,'line')
    tunnel.line=[];
end
arc=tunnel.arc;
line=tunnel.line;
arcPoint=zeros(length(arc)*2,2);
linePoint=zeros(length(line)*2,2);
point=[arcPoint;linePoint];
n=size(point,1);
D=zeros(n,n);
sequence=zeros(length(point),1);
% ��Բ����ֱ�ߵ���β�����������
if ~isempty(arc)
    for i=1:length(arc)
        arcPoint(2*i-1,1)=arc(i).x + arc(i).r * cos(arc(i).theta1);
        arcPoint(2*i-1,2)=arc(i).y + arc(i).r * sin(arc(i).theta1);
        arcPoint(2*i,1)=arc(i).x + arc(i).r * cos(arc(i).theta2);
        arcPoint(2*i,2)=arc(i).y + arc(i).r * sin(arc(i).theta2);
    end
end
if ~isempty(line)
    for i=1:length(line)
        linePoint(2*i-1,1)=line(i).x1;
        linePoint(2*i-1,2)=line(i).y1;
        linePoint(2*i,1)=line(i).x2;
        linePoint(2*i,2)=line(i).y2;
    end
end
point=[arcPoint;linePoint];
% �ֱ���������ľ���
for i=1:n
    for j=1:n
        if i~=j
            D(i,j)=((point(i,1)-point(j,1))^2+(point(i,2)-point(j,2))^2)^0.5;
        else
            D(i,j)=NaN;
        end
            D(j,i)=D(i,j);
    end
end
for i=1:length(point)/2
    if i==1
        sequence(i)=1;
    else
        temp=find(D(:,sequence(2*i-2))>=0 & D(:,sequence(2*i-2))<=0.01);
        if isempty(temp) || temp==1 || temp==2 || length(temp)~=1
            errordlg('���Ϊ���������','������������');
            sequence=[];
            return;
        else
            sequence(2*i-1)=temp;
        end
    end
    if mod(sequence(2*i-1),2)==1
        sequence(2*i)=sequence(2*i-1)+1;
    else
        sequence(2*i)=sequence(2*i-1)-1;
    end
end
% �ж�sequence��β�����Ƿ���ӣ�����Ϊ���������
if D(sequence(1),sequence(length(sequence)))>0.01
    errordlg('���Ϊ���������','������������');
    sequence=[];
    return;
end
% ��sequence��Բ�����߶ΰ�1��2��β��ӣ�����������1��2����λ���໻
% ����1��2��4��3��8��7��6��5--��1��2��3��4��7��8��5��6
for i=1:length(sequence)/2
    cuSequ=sequence(2*i-1)/2;
    if mod(sequence(2*i-1),2)==0
        if sequence(2*i-1)<=length(arc)*2
            temp=tunnel.arc(cuSequ).theta1;
            tunnel.arc(cuSequ).theta1=tunnel.arc(cuSequ).theta2;
            tunnel.arc(cuSequ).ththa2=temp;
        else
            temp1=tunnel.line(cuSequ-length(arc)).x1;
            temp2=tunnel.line(cuSequ-length(arc)).y1;
            tunnel.line(cuSequ-length(arc)).x1=tunnel.line(cuSequ-length(arc)).x2;
            tunnel.line(cuSequ-length(arc)).y1=tunnel.line(cuSequ-length(arc)).y2;
            tunnel.line(cuSequ-length(arc)).x2=temp1;
            tunnel.line(cuSequ-length(arc)).y2=temp2;
        end
        tempS=sequence(2*i-1);
        sequence(2*i-1)=sequence(2*i);
        sequence(2*i)=tempS;
    end
end

% ��˳����ǰŲһλ
% temp=sequence(1);
% for i=1:length(sequence)
%     if i~=length(sequence)
%         sequence(i)=sequence(i+1);
%     else
%         sequence(i)=temp;
%     end
% end

end

