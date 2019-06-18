function  holes = deleteHoles( holes,tunnel,holeNum,isDeleteAll,handles,axisValue )
% ½«ÒªÉ¾³ýµÄ¿×ºÅ½µÐòÅÅÁÐ
holesNum=sort(holeNum,'descend');
if isDeleteAll==1
    holes=[];
else
    for j=1:length(holesNum)
        for i=holesNum(j):(length(holes)-1)
            holes(i)=holes(i+1);
            holes(i).num=i;
        end
        holes(length(holes))=[];
    end
      
end
% initTunnelAxes( tunnel,handles );
repaint(tunnel, handles, holes, axisValue);
for i=1:length(holes)
    drawSingleCircle( holes(i).x,holes(i).y,holes(i).r,holes(i).biasAngle,holes(i).inclineAngle,handles.axes1,'g' );
end

end

