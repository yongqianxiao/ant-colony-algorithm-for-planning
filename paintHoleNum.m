% ���ƿ׺�
function paintHoleNum( holes )
    for i=1:length(holes)
        % ÿ��5���׻���һ��
        if i==1 || mod(i,5)==0
            text(holes(i).x+holes(i).r, holes(i).y-holes(i).r, num2str(holes(i).num),'Color','red','FontSize',10);
        end
    end
end

