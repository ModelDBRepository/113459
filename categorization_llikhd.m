function x = categorization_likhd
% function x = categorization_likhd
% 
% This function uses log-likelihood ratio and a Bernoulli-stochastic 
% process and to estimate the identification ability of a given population.
% The population parameters are taken from a helper function (get_params). 
% Edit get_params to change the basic population and testing paramters
%
% The returned parameter includes the following:
% x.CFs  - the distribution of the CFs for this experiment
% x.bw - the bandwidth of all the neurons of interest
% x.spkrate - the evoked spike rate
% x.spont - the spontaneous activity rate
% x.fre - the frequencies at which you want to test identification
% x.llr - the log likelihood ratio for each tested frequency
% x.perf - the performance
%   for perf and perf2, you will get a X by Y matrix, where X is for the
%   number of experiments run and Y is for the various freqencies tested.
%
% This function will also plot the results for you.  Figure should look
% like figure 8B in the paper (red line).
%
% Bao Lab 2008

clear
global CFs bw spkrate spont R perf;

P = get_params;
CFs = P.CFs;
BW = P.BW;
SKR = P.SPKRT;
SPT = P.SPNT;
fre = P.fre;

numoftrials=100;

opts=optimset('DerivativeCheck','off','Display','off', ...
                'LargeScale','off','TolX',1e-6,'TolFun',1e-6, ...
                'Diagnostics','off','MaxIter',200);
warning('off');

bw=BW*ones(1,length(CFs));
spkrate=SKR*ones(1,length(CFs));
spont=SPT*ones(1,length(CFs));
success=0;

tic

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the log likelihood measures, equation 4 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for q=1:50 %repeat--# of experiments
    fprintf(['\tExperiment number is ' num2str(q) '\t' num2str(toc/60) '\n']);
    for f=1:length(fre)
        for n=1:numoftrials; %# of trials
            R=MNRRS(fre(f),CFs,bw,spkrate,spont); %generate a response
            lik_low(n)=-likhood(fre(1));
            lik_high(n)=-likhood(fre(end));
        end
        llr(q, f)=mean(lik_low-lik_high);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate identification (Bernouli) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
llr_mean = mean(llr);
perf = binornd_sim(llr_mean);


x.CFs = CFs;
x.bw = bw;
x.spkrate = spkrate;
x.spont = spont;
x.fre = fre;
x.llr = llr;
x.perf = perf;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Highly recommended that you save the ouput! %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% save ident_temp x

%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting the results %
%%%%%%%%%%%%%%%%%%%%%%%%
plot(mean(x.perf),'.-r')
ylabel('Identification (%)');
xlabel('Frequency');
ylim([-10 110]);
set(gca, 'xtick', [1, 4, 7, 10, 13]);
set(gca, 'xticklabel',{x.fre(1), x.fre(4), x.fre(7), x.fre(10), x.fre(13)});