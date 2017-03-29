clear all
g=9.81;
h=0.62;
nwave=3;

fc=0.88;
df_fc=0.73;  %(fn-f1)/fc
dff=fc*df_fc; 
dff2=dff/2.;
A=0.1084;

xb=0.0;
tb=0.0;


%f=fc-dff2+dff2/(nwave/2.0)*[1:nwave];
%aawave(1:nwave)=A/nwave;
%twave=1.0./f;

f=[0.85 1.0 1.15];
aawave=[0.008688991 0.08688991 0.008688991];

phase(1:length(f))=0.0;

om=f.*2*pi;
k=wvnum_omvec(h,om,g);

% -------
dx=0.1;
dt=1.0;
xlength=200.0;
tlength=210.0;
x=[0:dx:xlength];
t=[0:dt:tlength]';
[X T]=meshgrid(x,t);
[m n]=size(X);
ETA(1:m,1:n)=0;
for nw=1:nwave
et=A/nwave*cos(k(nw).*(X-xb)-2.*pi.*f(nw)*(T-tb));
ETA=ETA+et;
end


figure(1)
wid=5.0;
len=8;
set(gcf,'units','inches','paperunits','inches','papersize', [wid len],'position',[1 1 wid+1 len+1],'paperposition',[0 0 wid len]);
clf
ts=[0 60 136 200]; % second
tn=ceil(ts/dt)+1;
for kk=1:length(ts)
subplot(4,1,kk)
plot(x,ETA(tn(kk),:))
axis([0 xlength -0.11 0.11])
time=num2str(ts(kk));
title(['time = ', time])
grid
xlabel('x (m)')
ylabel('ele (m)')
end


