function [ I1new ] = plotTrans( I1 ,P )
%PLOTTRANS 此处显示有关此函数的摘要
%   此处显示详细说明
sizeIni = size(I1);
Pic1ini = ones(3,sizeIni(1)*sizeIni(2));
for i=0:sizeIni(1)-1
    for j=1:sizeIni(2)
        Pic1ini(1,i*sizeIni(2)+j)=i+1;
        Pic1ini(2,i*sizeIni(2)+j)=j;
    end
end
Pic1new = P*Pic1ini;
I1new = zeros(sizeIni(1),sizeIni(2));
for i=0:sizeIni(1)-1
    for j=1:sizeIni(2)
        if Pic1new(1,i*sizeIni(2)+j)<1
            continue
        end
        if Pic1new(1,i*sizeIni(2)+j)>sizeIni(1)
            continue
        end
        if Pic1new(2,i*sizeIni(2)+j)<1
            continue
        end
        if Pic1new(2,i*sizeIni(2)+j)>sizeIni(2)
            continue
        end
        I1new(floor(Pic1new(1,i*sizeIni(2)+j)),floor(Pic1new(2,i*sizeIni(2)+j)))=I1(floor(Pic1ini(1,i*sizeIni(2)+j)),floor(Pic1ini(2,i*sizeIni(2)+j)));
    end
end
imshow(I1new);

