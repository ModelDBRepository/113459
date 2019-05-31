function x = discrimation_MLE
% function x = discrimination_MLE
% 
% This function uses MLE to estimate the discrimination ability of a given
% population.  The population parameters are taken from a helper function
% (get_params).  Edit get_params to change the basic population and testing
% paramters
%
% The returned parameter includes the following:
% x.CFs  - the distribution of the CFs for this experiment
% x.bw - the bandwidth of all the neurons of interest
% x.spkrate - the evoked spike rate
% x.spont - the spontaneous activity rate
% x.fre - the frequencies at which you want to test discriminability
% x.diff - the delta f of interest
% x.perf - the performance (using the defined 50% threshold)
% x.perf2 - the performance (using a 90% threshold)
%   for perf and perf2, you will get a X by Y matrix, where X is for the
%   number of experiments run and Y is for the various freqencies tested.
%
% This function will also plot the results for you.  Figure should look
% like figure 8B in the paper (blue line).
%
% Bao Lab 2008

clear all

P = get_params;

CF = P.CFs;
BW = P.BW;
SPKRT = P.SPKRT;
SPNT = P.SPNT;
fre = P.fre;
diff = P.diff;

tic
opts = optimset('DerivativeCheck','off','Display','off', ...
    'LargeScale','off','TolX',1e-6,'TolFun',1e-6, ...
    'Diagnostics','off','MaxIter',200);

numoftrials = 100;
global CFs bw spkrate spont R;

CFs = CF;
bw = BW*ones(1,length(CFs));
spkrate = SPKRT*ones(1,length(CFs));
spont = SPNT*ones(1,length(CFs));

for q = 1:50 %repeat--# of experiments
    fprintf(['\tExperiment number is ' num2str(q) '\t' num2str(toc/60) '\n']);
    
    %Go through all the frequencies of interest
    for n = 1:length(fre)
        % Setting treshold
        for m = 1:numoftrials; %# of trials
            R = MNRRS(fre(n),CFs,bw,spkrate,spont); %generate a response
            [fre_est,lik,exit] = fmincon(@likhood,fre(n),[],[],[],[],fre(n)/2,fre(n)*2,[],opts);
            
            R = MNRRS(fre(n),CFs,bw,spkrate,spont); %generate a response
            [fre_est_2,lik,exit] = fmincon(@likhood,fre(n),[],[],[],[],fre(n)/2,fre(n)*2,[],opts);
            thre(m) = abs(log2(fre_est/fre_est_2));
        end

        % Getting Response
        for m = 1:numoftrials; %# of trials
            R = MNRRS(fre(n)/2^(diff/2),CFs,bw,spkrate,spont); %generate a response
            [fre_est,lik,exit] = fmincon(@likhood,fre(n),[],[],[],[],fre(n)/2,fre(n)*2,[],opts);
            R = MNRRS(fre(n)*2^(diff/2),CFs,bw,spkrate,spont); %generate a response
            [fre_est_2,lik,exit] = fmincon(@likhood,fre(n)*2^diff,[],[],[],[],fre(n)/2,fre(n)*2,[],opts);
            lkl(m) = abs(log2(fre_est/fre_est_2));
        end

        perf(q,n) = sum(lkl>median(thre))/length(lkl);
        thre = sort(thre);
        perf2(q,n) = sum(lkl>thre(90))/length(lkl);
 
    end
    
end
x.CFs = CFs;
x.bw = bw;
x.spkrate = spkrate;
x.spont = spont;
x.fre = fre;
x.diff = diff;
x.perf = perf;
x.perf2 = perf2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Highly recommended that you save the ouput! %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% save discr_temp x

%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting the results %
%%%%%%%%%%%%%%%%%%%%%%%%
plot(mean(x.perf),'.-')
ylabel('Discrimination (%)');
xlabel('Frequency');
ylim([.5 1]);
set(gca, 'xtick', [1, 4, 7, 10, 13]);
set(gca, 'xticklabel',{x.fre(1), x.fre(4), x.fre(7), x.fre(10), x.fre(13)});