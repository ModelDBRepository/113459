function R = MNRRS (fre, cf, bw, max_amp, spont)
% function R = MNRRS(fre,cf,bw,max_amp,spont)
%
% Generation of a response by a model AI to a specific tone (fre).  The
% model AI has specific best frequency (cf), bandwidth (bw), maximum
% firing rate (max_amp), and spontaneous firing rate (spont) distributions
% fre and cf in the range of 1 to 30 kHz; bw in Octaves max_amp in
% spikes/stimulus
% Helper function for discrimination_MLR and categorization_llikhd.m
% 
% Bao Lab

fre = log2(fre);
cf = log2(cf);
bw(find(bw==0))=1;
R=max_amp.*exp(-(fre-cf).^2./(2*bw.^2));
R = poissrnd(R+spont);
