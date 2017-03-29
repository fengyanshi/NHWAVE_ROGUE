clear all
g=9.81;
h=0.6;
nwave=32;

fc=0.88;
df_fc=0.73;  %(fn-f1)/fc
dff=fc*df_fc; 
dff2=dff/2.;
A=0.1084;

xb=8.46;
tb=20.5;


f=fc-dff2+dff2/(nwave/2.0)*[1:nwave];
aawave(1:nwave)=A/nwave;
twave=1.0./f;
phase(1:nwave)=0.0;

om=f.*2*pi;
k=wvnum_omvec(h,om,g);

% -------
dx=0.1;
dt=0.1;
xlength=30.0;
tlength=40.0;
x=[0:dx:xlength];
t=[0:dt:tlength]';
[X T]=meshgrid(x,t);
[m n]=size(X);
ETA(1:m,1:n)=0;
for nw=1:nwave
et=A/nwave*cos(k(nw).*(X-xb)-2.*pi.*f(nw)*(T-tb));
ETA=ETA+et;
end


% write out
Ht_input=2.0*aawave;
Freq_model=f;
Dire_model=0.0;
Phase_model=-k.*xb+2.*pi*f.*tb-pi/2.; % in nhwave, cos(pi/2-wt+phase)


fname='wave2d.txt';

fid=fopen(fname,'w');
fprintf(fid,'%5i %5i   - NumFreq NumDir \n',length(Freq_model),length(Dire_model));
% fprintf(fid,'%10.3f   - PeakPeriod  \n',PeakPeriod); % this is for
% funwave
fprintf(fid,'%10.3f   - Freq \n',Freq_model');
fprintf(fid,'%10.3f   - Dire(deg) \n',Dire_model');
dlmwrite(fname,Ht_input,'delimiter','\t','-append','precision',5);
dlmwrite(fname,Phase_model,'delimiter','\t','-append','precision',5);
fclose(fid)

break


figure(1)
wid=5.0;
len=10;
set(gcf,'units','inches','paperunits','inches','papersize', [wid len],'position',[1 1 wid+1 len+1],'paperposition',[0 0 wid len]);
clf
ts=[0 10 20 30]; % second
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


