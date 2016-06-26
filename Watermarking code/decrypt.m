function decrypt(bx1,t1,t2)
tic
a1=round(bx1*255);
da=t1;db=t2;
N=32768;
h1=zeros(256,256);
x=zeros(1,N);
y=zeros(1,N);
x1(1)=0.1;
y1(1)=0;
for i=1:N
    x1(i+1)=1+y1(i)-da*(x1(i))^2;
    y1(i+1)=db*x1(i);
end
count1=1;
count2=1;
for i=1:256
    for j=1:256
        if(mod(j,2)==1)
       h1(i,j)=x1(1,count1);
        count1=count1+1;
        else
            h1(i,j)=y1(1,count2);
            count2=count2+1;
        end;
    end;
end;
t11=mat2gray(h1);
figure(5)
imshow(t11)
acm1=round(t11*255);
bxed=round(bx1*255);
for i=1:256
   for j=1:256
        out(i,j)=bitxor(bxed(i,j),acm1(i,j));
    end
end
out2=mat2gray(out);
figure(6);
imshow(out)
toc
 secfn = input('Enter File Name for Image + Message:\n','s');
    nametest = ischar(secfn);
    if nametest == 1
        msgtest = ischar(out);
        if msgtest == 1
           
            fid = fopen(strcat(secfn,'.txt'),'w');
            fwrite(fid,out,'char');
            fclose(fid);
        else
          
            imwrite(out,strcat(secfn,'.bmp'));
        end
    else
        error('Invalid File Name');
    end