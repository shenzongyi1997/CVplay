function [ img ] = plotCombine( I1,I2,frame1,frame2,matches )
%PLOTCOMBINE 此处显示有关此函数的摘要
%   试试图片拼接
%   此处显示详细说明

%首先，为了估计单应性矩阵，只能用frame来估计，我期望得到一个3x3的单应性矩阵
%首先是平移变换。我需要一个2x特征点的矩阵，这个矩阵实际上就是frame的前2行,然后加个1扩充成3行的
%可以简单的认为整体平移了
%%生成frame1的我需要的符合要求的矩阵
frame1Temp = frame1(1:2,:);
size1 = size(frame1);
frame1Temp = [frame1Temp;ones(1,size1(2))];
%%生成frame2的我需要的符合要求的矩阵
frame2Temp = frame2(1:2,:);
size2 = size(frame2);
frame2Temp = [frame2Temp;ones(1,size2(2))];

%注意，所有的变换都是从1向2变

%%现在我有两个矩阵了，我需要知道tx,ty就可以了
%直接用第一个特征点算
t = frame2Temp(matches(:,1))-frame1Temp(matches(:,1));
Pmove = [1 0 t(1);0 1 t(2);0 0 1];%平移矩阵get

%%接下来看一下缩放
%直接用第一个特征点算
%既然特征点都是用圆表示的，那么直接不用区分x和y方向的了
S = frame2(3,1)/frame1(3,1);
Psize = [S 0 0 ; 0 S 0 ;0 0 1];%缩放矩阵get

%%接下来看一下旋转
%直接用第一个特征点算
%直接用角度换,这里原始数据好像就是弧度制，不需要转换
rot = frame2(4,1)-frame1(4,1);
Prot = [cos(rot) -sin(rot) 0;sin(rot) cos(rot) 0;0 0 1];%旋转矩阵get


%既然三个矩阵都有了。合并一下
P = Psize*Pmove*Prot;

frame1Final = P*frame1Temp;
%现在已经得到变换后的特征点了，但是需要重新变换一下，变换成二维矩阵灰度图的形式
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
        if Pic1new(2,i*sizeIni(2)+j)sizeIni(2)
            continue
        end
        I1new(floor(Pic1new(1,i*sizeIni(2)+j)),floor(Pic1new(2,i*sizeIni(2)+j)))=I1(floor(Pic1ini(1,i*sizeIni(2)+j)),floor(Pic1ini(2,i*sizeIni(2)+j)));
    end
end
a=1;
b=2;

imshow(I1new);




