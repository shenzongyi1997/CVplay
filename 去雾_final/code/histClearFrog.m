%function In = removeFogByGlobalHisteq(I)
%removeFogByGlobalHisteq ͨ��ȫ��ƽ��ֱ��ͼ��ͼ��ȥ����
%  I ����ͼ��
%�����ԭɫ
I = imread('canon.jpg');
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
%ȡֱ��ͼƽ��
M=histeq(R);
L=histeq(G);
N=histeq(B);
%�ں�ֱ��ͼ
In=cat(3,M,L,N);
%����Ĵ������ȥ���õ�
%-----------------------
%����Ĵ��붼��������ʾ��
    figure;
    subplot(2,2,1);imshow(I);title('ԭͼ' ,'FontWeight','Bold');
    subplot(2,2,2);imshow(In);title('������ͼ' ,'FontWeight','Bold');
    Q=rgb2gray(I);%��ȡ��ͼֱ��ͼ
    W=rgb2gray(In);%��ȡ��ͼֱ��ͼ

    subplot(2,2,3);imhist(Q,64);title('ԭͼֱ��ͼ' ,'FontWeight','Bold');
    subplot(2,2,4);imhist(W,64);title('�����ֱ��ͼ' ,'FontWeight','Bold');