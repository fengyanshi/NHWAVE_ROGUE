clear all
m=600;
n=500;
dep=zeros([n,m]);
dep(:,:)=30;

save -ASCII wave_flume.txt dep
