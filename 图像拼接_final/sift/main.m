I1 = 'panorama_image1.jpg';
I2 = 'panorama_image2.jpg';
img1 = imreadbw(I1);
img2 = imreadbw(I2);
S=3;
[frames1,descr1,gss1,dogss1] = sift( img1, 'Verbosity', 1, 'Threshold', ...
                                     0.005, 'NumLevels', S ) ;
%figure(11) ; clf ; plotss(dogss1) ; colormap gray ;
[frames2,descr2,gss2,dogss2] = sift( img2, 'Verbosity', 1, 'Threshold', ...
                                     0.005, 'NumLevels', S ) ;
%     每一个fram由一个圆表示，4x4179的矩阵，格式如下
%     FRAMES(1:2,k)  center (X,Y) of the frame k,
%     FRAMES(3,k)    scale SIGMA of the frame k,
%     FRAMES(4,k)    orientation THETA of the frame k.
                                 
                                 
                                 
                                 
                                 
img1=img1-min(img1(:)) ;
img1=img1/max(img1(:)) ;
img2=img2-min(img2(:)) ;
img2=img2/max(img2(:)) ;
figure(1)  
imshow(img1);
hold on
plotsiftframe(frames1);
title('第1张图的特征点检测');
figure(2)
imshow(img2);
hold on
plotsiftframe(frames2);
title('第2张图的特征点检测');
descr1=uint8(512*descr1) ;
descr2=uint8(512*descr2) ;
%每一个descr是一个128*特征点数的矩阵
%128就是特征描述子


matches = siftmatch( descr1, descr2 ) ;

%match每一列两个元素，代表frame1和frame2里两个下标的列表示的特征点匹配
figure(3)
plotmatches(img1,img2,frames1(1:2,:),frames2(1:2,:),matches,...
  'Stacking','v') ;
title('两章图的特征点连线');


figure(4)
sizeMatches = size(matches);
P1=zeros(sizeMatches(2),2);
P2=zeros(sizeMatches(2),2);
for i=1:sizeMatches(2)
    P1(i,1)=frames1(1,matches(1,i));
    P1(i,2)=frames1(2,matches(1,i));
    P2(i,1)=frames2(1,matches(2,i));
    P2(i,2)=frames2(2,matches(2,i));
end
[tform, inlierPoints1, inlierPoints2, status]=estimateGeometricTransform(P1,P2,'similarity');
img1new = plotTrans(img1,tform.T);
title('准备拼接的图像');

figure
xWorldLimits = [0 8];
yWorldLimits = [0 6];
R = imref2d(size(img1new),xWorldLimits,yWorldLimits);
img1new2 = imwarp(img1,tform,'FillValues',255);
imshow(img1new2);
title('用wrap形成的周边的白色的图像');
figure
R2 = imref2d(size(img2),[8 16],[6 12]);
 imshow(img2,R2);
image_stitching2(I1,I2);
 %imshow(imageFinal);