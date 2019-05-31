function P = get_params
% function P = get_params
% This function returns the appropriate parameters for discrimination_MLE
% and categorization_llikhd.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CF distribution:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The lower "over-represented" frequency
CF1 = 5 * 2^ -.5;   %3.5355
% The higher "over-represented" frequency
CF2 = 5 * 2^ 1.5;   %14.142
% The exact middle between the 2 over-represented frequencies
mid = 5 * 2^ 0.5;   %7.0711

% The number of neurons in the model
popu=800;
% An even distribution of the CFs of the neurons (CF range: 1-50kHz)
CFs=2.^((0:(1/(popu-1)):1).*log2(50));

% Redistributed CFs, to account for correct over-representation
CFsup=smth_gass_distr(CF1,0.35, length(find(CFs>(CF1/2)&CFs<(mid))));
CFsup2=smth_gass_distr(CF2,0.35, length(find(CFs>=(mid)&CFs<(CF2*2))));
CFs(find(CFs>(CF1/2)&CFs<(CF2*2)))=[];
CFs=sort([CFs,CFsup, CFsup2]);
clear CFsup CFsup2;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bandwidth, SpikeRate, Spontaneous Activity:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BW = .5;
SPKRT = 1;
SPNT = 0.05;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Testing Parameters:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Frequecies where discrimination will be tested:
fre = 5*2.^(-1:0.25:2.0);
% The delta-frequency to be tested in the discrimination
diff = [.1];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P.CFs = CFs;
P.BW = BW;
P.SPKRT = SPKRT;
P.SPNT = SPNT;
P.fre = fre;
P.diff = diff;