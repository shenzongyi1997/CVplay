function [ result,hist1,hist2 ] = histC( I )
%HISTC 此处显示有关此函数的摘要
%   此处显示详细说明
%function In = removeFogByGlobalHisteq(I)
%removeFogByGlobalHisteq 通过全局平衡直方图对图像去雾处理
%  I 输入图像
%拆分三原色
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
%取直方图平衡
M=histeq(R);
L=histeq(G);
N=histeq(B);
%融合直方图
In=cat(3,M,L,N);
%上面的代码就是去雾用的
%-----------------------
%下面的代码都是用于显示的
   % figure;
    %subplot(2,2,1);imshow(I);title('原图' ,'FontWeight','Bold');
   % subplot(2,2,2);imshow(In);title('处理后的图' ,'FontWeight','Bold');
   result = In; 
   Q=rgb2gray(I);%获取该图直方图
    W=rgb2gray(In);%获取该图直方图

   % subplot(2,2,3);imhist(Q,64);title('原图直方图' ,'FontWeight','Bold');
    %subplot(2,2,4);imhist(W,64);title('处理后直方图' ,'FontWeight','Bold');
    hist1 = Q;
    hist2 = W;
end

