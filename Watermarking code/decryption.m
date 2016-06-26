function decryption(bx1,t1,t2,t3)
a1=round(bx1*255);
da=t1;db=t2;
ACMK=t3;
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
%axis([-1,2,-1,1])
%plot(x(50:N),y(50:N),'.','MarkerSize',1);
%fsize=15;
%set (gca,'xtick',[-1:1:1],'FontSize',fsize)
%set (gca,'ytick',[-1:1:2],'FontSize',fsize)
%xlabel('\itx','FontSize',fsize)
%ylabel('\ity','FontSize',fsize)
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
acm1=round(t11*255)
bxed=round(bx1*255);
for i=1:256
   for j=1:256
        out_cat(i,j)=bitxor(bxed(i,j),acm1(i,j));
    end
end
out=mat2gray(out_cat);
figure(6);
imshow(out)
a=out;
ACMK1=(192-ACMK);
for t=1:ACMK1
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
figure(7);
bdecrypt=mat2gray(a);
%decypher=imresize(bdecrypt,[128 128]);
imshow(bdecrypt)
end;
check=imread('cameraman.tif');

[mse psn]=PSN(check,bdecrypt)
end