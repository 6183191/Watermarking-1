clc;
clear all;
warning off;
chos=0;
possibility=11;

while chos~=possibility,
    chos=menu('Chaos based watermarking','select the cover image','select the watermark image to be encrypted','show watermarked image','show extracted image','show  decrypted watermark','Calculate MSE for embedding');
    if chos==1
        [fname pname]=uigetfile('*.jpg','select the Cover Image');
        %eval('imageinput=imread(fname)');
        imageinput=imread(fname);
        

A=rgb2gray(imageinput);
P1=im2double(A);
P=imresize(P1,[2048 2048]);
%imshow(P);
%figure(1);
%title('original image');

[F1,F2]= wfilters('haar', 'd');
[LL,LH,HL,HH] = dwt2(P,'haar','d');
[LL1,LH1,HL1,HH1] = dwt2(LL,'haar','d');
[LL2,LH2,HL2,HH2] = dwt2(LL1,'haar','d');
%figure(2)
%imshow(LL2,'DisplayRange',[]), title('3 level dwt of cover image');
    end
    if chos==2
    clear all;
%[i11,i12]=uigetfile('*.*');%Input Image
%i12=strcat(i12,i11);
%a=imread(i12);
a=imread('cameraman.tif');
figure(1);
imshow(a)
a=imresize(a,[256 256]);
for t=1:10
for i=1:256
    for j=1:256
        x=i+j;
        y=x+i;
        b(x,y)=a(j,i);
    end;
end;
c=mat2gray(b);

count=257;
for x=129:257
    for y=257:count
        b(x,y-256)=b(x,y);
    end;
      count=count+2;
        if(count==513)
            break;
        end;
end;
for y=257:512
    for x=257:385
        if(b(x,y)==0)
            continue;
        end;
        b(x-256,y-256)=b(x,y);
    end;
end;
for x=257:512
    for y=513:768
        if(b(x,y)==0)
            continue;
        end;
        b(x-256,y-512)=b(x,y);
    end;
end;
for i=1:256
    for j=1:256
        a(i,j)=b(i,j);
    end;
end;
figure(2);
b1=mat2gray(a);
imshow(b1)
end;
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
wm=round(b1*255);
for i=1:256
   for j=1:256
        bx(i,j)=bitxor(acm(i,j),wm(i,j));
    end
end

bxe=mat2gray(bx);
figure(4);
imshow(bxe)
 secfn = input('Enter File Name for Image + Message:\n','s');
    nametest = ischar(secfn);
    if nametest == 1
        msgtest = ischar(bxe);
        if msgtest == 1
           
            fid = fopen(strcat(secfn,'.txt'),'w');
            fwrite(fid,bxe,'char');
            fclose(fid);
        else
          
            imwrite(bxe,strcat(secfn,'.bmp'));
        end
    else
        error('Invalid File Name');
    end
        
        
        
        
        
        
        
 if chaos==3
   [fname pname]=uigetfile('*.jpg','select the Watermark');
    %eval('imageinput=imread(fname)');
    %imageinput=imread(fname);
    imw2=imread(fname);
    imw=rgb2gray(imw2);
watermark=im2double(imw);
watermark=imresize(watermark,[2048 2048]);
%figure(3)
%imshow(uint8(watermark));title('watermark image')
[WF1,WF2]= wfilters('haar', 'd');
[L_L,L_H,H_L,H_H] = dwt2(watermark,'haar','d');
[L_L1,L_H1,H_L1,H_H1] = dwt2(L_L,'haar','d');
[L_L2,L_H2,H_L2,H_H2] = dwt2(L_L1,'haar','d');
%figure(4)
%imshow(L_L2,'DisplayRange',[]), title('3 level dwt of watermark image');
    end
   
    if chos==4
        Watermarkedimage=LL2+0.0001*L_L2;



%computing level-1 idwt2
Watermarkedimage_level1= idwt2(Watermarkedimage,LH2,HL2,HH2,'haar');
%figure(5)
%imshow(Watermarkedimage_level1,'DisplayRange',[]), title('Watermarkedimage level1');

%computing level-2 idwt2
Watermarkedimage_level2=idwt2(Watermarkedimage_level1,LH1,HL1,HH1,'haar');
%figure(6)
%imshow(Watermarkedimage_level2,'DisplayRange',[]), title('Watermarkedimage level2');


%computing level-3 idwt2
Watermarkedimage_final=idwt2(Watermarkedimage_level2,LH,HL,HH,'haar');
%figure(7)
imshow(Watermarkedimage_final,'DisplayRange',[]), title('Watermarkedimage final')
    end
    if chos==5
        [F11,F22]= wfilters('haar', 'd');
[a b c d]=dwt2(Watermarkedimage_final,'haar','d');
[aa bb cc dd]=dwt2(a,'haar','d');
[aaa bbb ccc ddd]=dwt2(aa,'haar','d');

recovered_image=aaa-LL2;
%figure(8)
imshow(recovered_image,[]);
%title('extracted watermark')
    end
   if chos==6
       t1=input('enter key1 for  decryption')
t2=input('input key2  for decryption')
t3=input('input key for arnold catmap decryption')


decryption(bxe,t1,t2,t3)
if chaos==7
       
        pic1= P;
    pic2= Watermarkedimage_final;
       mse=MSE(pic1,pic2)
   end

end
