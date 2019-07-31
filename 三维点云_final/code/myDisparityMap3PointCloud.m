clear
imgDisp = imread('disp1.png');%视差图
imgDisp = double(imgDisp);
imgColor = double(imread('view1.png'));%色彩图
sizeIni = size(imgDisp);%视差图和色彩图应该具有相同的像素点个数
N = sizeIni(1)*sizeIni(2);
f = double(3740);
T = double(160);
d_min = 200;
cx = sizeIni(2)/2;
cy = sizeIni(1)/2;
disparity = double(d_min) + imgDisp;

pnt = zeros(N,3);%初始化pnt
color = zeros(N,3);
for a = 1:sizeIni(1)
    for b = 1:sizeIni(2)
       x = b;
       y = sizeIni(1)-a+1;
       Z = double(f).*double(T)./double(disparity(a,b));
       Z = double(Z);
       X = Z/f *(x-cx);
       Y = Z/f *(y-cy);
       if imgDisp(a,b)~=0
            pnt((x-1)*sizeIni(1)+y,1:3) = [X Y Z];
            color((x-1)*sizeIni(1)+y,1:3) = 2*imgColor(a,b,1:3);%这里我乘了2因为原来的图太暗了，放到meshlab里特别暗
       end
       
      
    end
end
color = uint8(color);
model = pointCloud(pnt); % pnt: N*3
model.Color = color;  % color: N*3 uint8
pcwrite(model, 'model.ply') % 保存模型
pcshow(model) % 显示模型
