clear all

% get data
spec_data=load('sdmat100204o.spec');

[NumFreq,NumDir]=size(spec_data);
    NumFreq=NumFreq-1;
    NumDir=NumDir-1;
    Freq=spec_data(2:end,1);
    Dire=spec_data(1,2:end);
    Amp=spec_data(2:end,2:end);
    dfreq=(Freq(end)-Freq(1))/(length(Freq)-1); % Hz
    ddire=(Dire(end)-Dire(1))/(length(Dire)-1); % degree

Amp_Dir=sum(Amp)*dfreq;
Amp_Frq=sum(Amp,2)*ddire;

f_range=[0.04 0.32];
d_range=[-90 90];

figure(1)
subplot(2,2,1)
plot(Amp_Frq,Freq)
ylabel('S(f)/Hz')
xlabel('Freq(Hz)')
grid
axis([0 3 f_range(1) f_range(2)])


subplot(2,2,4)
plot(Dire,Amp_Dir)
ylabel('S(\theta)/deg')
xlabel('Dire(deg)')
grid
axis([d_range(1) d_range(2) 0 0.004]);

subplot(2,2,2)
v=[0.005 0.01:0.01:0.1];
c=contour(Dire,Freq,Amp,v);
clabel(c,v)
xlabel('Dire(deg)')
ylabel('Freq(Hz)')
grid
axis([d_range(1) d_range(2) f_range(1) f_range(2)]);
title('m^2/Hz/Deg')

totalE=sum(sum(Amp*dfreq*ddire));
Hrms=sqrt(totalE*8);



% truncate
[v1,ind1]=max(max(Amp));
[peakf,peakd]=find(Amp==v1);
MaxFreqNum = 50;
MaxDireNum = 40;
NFreq = min(NumFreq,MaxFreqNum);
NDir  = min(NumDir,MaxDireNum);
n_peakf=[max(1,peakf-floor(NFreq/2)):min(NumFreq,peakf+floor(NFreq/2))];
n_peakd=[max(1,peakd-floor(NDir/2)):min(NumDir,peakd+floor(NDir/2))];

Freq_model=Freq(n_peakf);
Dire_model=Dire(n_peakd);
Amp_model=Amp(n_peakf,n_peakd);

PeakFreq = Freq(peakf)

Amp_Dir_model=sum(Amp_model)*dfreq;
Amp_Frq_model=sum(Amp_model,2)*ddire;


figure(2)



subplot(2,2,1)
plot(Amp_Frq_model,Freq_model)
ylabel('S(f)/Hz')
xlabel('Freq(Hz)')
grid
axis([0 3 f_range(1) f_range(2)])


subplot(2,2,4)
plot(Dire_model,Amp_Dir_model)
ylabel('S(\theta)/deg')
xlabel('Dire(deg)')
grid
axis([d_range(1) d_range(2) 0 0.004]);

subplot(2,2,2)
v=[0.005 0.01:0.01:0.1];
c=contour(Dire_model,Freq_model,Amp_model,v);
clabel(c,v)
xlabel('Dire(deg)')
ylabel('Freq(Hz)')
grid
axis([d_range(1) d_range(2) f_range(1) f_range(2)]);
title('m^2/Hz/Deg')

totalE_model=sum(sum(Amp_model*dfreq*ddire));
Hrms_model=sqrt(totalE_model*8);

% write out

Amp_input=sqrt(Amp_model*dfreq*ddire*8.0)/2.0;
Amp_input=Amp_input';

PeakPeriod = 1.0/PeakFreq;

Ht_input=2.0*Amp_input;

fname='wave2d.txt';

% write data
fid=fopen(fname,'w');
fprintf(fid,'%5i %5i   - NumFreq NumDir \n',length(Freq_model),length(Dire_model));
% fprintf(fid,'%10.3f   - PeakPeriod  \n',PeakPeriod); % this is for
% funwave
fprintf(fid,'%10.3f   - Freq \n',Freq_model');
fprintf(fid,'%10.3f   - Dire \n',Dire_model');
dlmwrite(fname,Ht_input,'delimiter','\t','-append','precision',5);

fclose(fid)



