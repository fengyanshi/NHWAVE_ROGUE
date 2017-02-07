clear all
m=400;
n=400;
dep=zeros([n,m]);
dep(:,:)=30;

save -ASCII wave_flume.txt dep
