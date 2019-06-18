% 绘制孔号
function paintHoleNum( holes )
    for i=1:length(holes)
        % 每隔5个孔绘制一个
        if i==1 || mod(i,5)==0
            text(holes(i).x+holes(i).r, holes(i).y-holes(i).r, num2str(holes(i).num),'Color','red','FontSize',10);
        end
    end
end

