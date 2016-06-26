function bifur_Henonmap()
%This function takes as its input the alpha and beta values of the Henon
%map and plots the bifurcation diagram of the x-values versus the alpha
%values.

itermax=3000;min=itermax-9;
a=1.4;
b=0.3;
for alpha=a-.4:0.001:a
    x=0.1;
    x0=x;
    y=0;
    y0=y;
    for n=1:itermax
    xn=1+y0-alpha*(x0)^2;
    yn=b*x0;
    x=[x xn];
    x0=xn;
    y=[y yn];
    y0=yn;
end
plot(alpha*ones(10),x(min:itermax),'.','MarkerSize',1)
hold on
end
    
    fsize=15;
    set(gca,'xtick',[a-1.3,a],'FontSize',fsize)
    set(gca,'ytick',[-1 2],'FontSize',fsize)
    xlabel('{\alpha}','FontSize',fsize)
    ylabel('\itx','FontSize',fsize)
    hold off

end

