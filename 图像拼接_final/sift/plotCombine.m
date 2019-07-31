function [ img ] = plotCombine( I1,I2,frame1,frame2,matches )
%PLOTCOMBINE �˴���ʾ�йش˺�����ժҪ
%   ����ͼƬƴ��
%   �˴���ʾ��ϸ˵��

%���ȣ�Ϊ�˹��Ƶ�Ӧ�Ծ���ֻ����frame�����ƣ��������õ�һ��3x3�ĵ�Ӧ�Ծ���
%������ƽ�Ʊ任������Ҫһ��2x������ľ����������ʵ���Ͼ���frame��ǰ2��,Ȼ��Ӹ�1�����3�е�
%���Լ򵥵���Ϊ����ƽ����
%%����frame1������Ҫ�ķ���Ҫ��ľ���
frame1Temp = frame1(1:2,:);
size1 = size(frame1);
frame1Temp = [frame1Temp;ones(1,size1(2))];
%%����frame2������Ҫ�ķ���Ҫ��ľ���
frame2Temp = frame2(1:2,:);
size2 = size(frame2);
frame2Temp = [frame2Temp;ones(1,size2(2))];

%ע�⣬���еı任���Ǵ�1��2��

%%�����������������ˣ�����Ҫ֪��tx,ty�Ϳ�����
%ֱ���õ�һ����������
t = frame2Temp(matches(:,1))-frame1Temp(matches(:,1));
Pmove = [1 0 t(1);0 1 t(2);0 0 1];%ƽ�ƾ���get

%%��������һ������
%ֱ���õ�һ����������
%��Ȼ�����㶼����Բ��ʾ�ģ���ôֱ�Ӳ�������x��y�������
S = frame2(3,1)/frame1(3,1);
Psize = [S 0 0 ; 0 S 0 ;0 0 1];%���ž���get

%%��������һ����ת
%ֱ���õ�һ����������
%ֱ���ýǶȻ�,����ԭʼ���ݺ�����ǻ����ƣ�����Ҫת��
rot = frame2(4,1)-frame1(4,1);
Prot = [cos(rot) -sin(rot) 0;sin(rot) cos(rot) 0;0 0 1];%��ת����get


%��Ȼ�����������ˡ��ϲ�һ��
P = Psize*Pmove*Prot;

frame1Final = P*frame1Temp;
%�����Ѿ��õ��任����������ˣ�������Ҫ���±任һ�£��任�ɶ�ά����Ҷ�ͼ����ʽ
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




