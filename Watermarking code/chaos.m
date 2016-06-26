function chaos(im)
[i11,i12]=uigetfile('*.*');%Input Image
i12=strcat(i12,i11);
im2=imread(i12);
%im=rgb2gray(im2);
%imshow(im2)
im=imresize(im2,[256 256]);
tic
a1=1.4;b11=0.3;
N=32768;
h=zeros(256,256);
x=zeros(1,N);
y=zeros(1,N);
x(1)=0.1;
y(1)=0;
for i=1:N
    x(i+1)=1+y(i)-a1*(x(i))^2;
    y(i+1)=b11*x(i);
end
count1=1;
count2=1;
for i=1:256
    for j=1:256
        if(mod(j,2)==1)
       h(i,j)=x(1,count1);
        count1=count1+1;
        else
            h(i,j)=y(1,count2);
            count2=count2+1;
        end;
    end;
end;
t=mat2gray(h);
figure(3)
imshow(t)
acm=round(t*255);
%wm=round(b1*255);
for i=1:256
   for j=1:256
        bx(i,j)=bitxor(acm(i,j),im(i,j));
    end
end

bxe=mat2gray(bx);
figure(4);
imshow(bxe)
toc
t1=input('enter key1 for  decryption')
t2=input('input key2  for decryption')
decrypt(bxe,t1,t2);