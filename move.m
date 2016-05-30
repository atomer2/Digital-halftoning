
function [Ry,Rx] = move(y,x,Ymax,Xmax)
tranEven =[-1,1;0,1;1,0];
tranOdd = [1,-1;1,0;0,1];
index = 1;
if mod(y+x,2)
    for i=1:3
        if(~outOfrange([y,x]+tranOdd(i,:),Xmax,Ymax))
            break;
        end 
        index=index+1;
    end
    if index == 4
        Ry=0;
        Rx=0;
        return;
    else
        k = [y,x] + tranOdd(index,:);
        Ry=k(1);
        Rx=k(2);
    end
else
    for i=1:3
        if(~outOfrange([y,x]+tranEven(i,:),Xmax,Ymax))
            break;
        end 
        index=index+1;
    end
    if index == 4
        Ry=0;
        Rx=0;
        return;
    else
        k = [y,x] + tranEven(index,:);
        Ry=k(1);
        Rx=k(2);
    end        
end
end

function b = outOfrange(xy,Xmax,Ymax)
if xy(2) < 1 || xy(2) > Xmax || xy(1) < 1 || xy(1) > Ymax
    b = 1;
else
    b= 0;
end
end

