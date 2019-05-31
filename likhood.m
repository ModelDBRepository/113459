function LL = likhood (freq)
% function LL = likhood(freq)
%
% Equation number 2 in the paper.
% Helper function for discrimination_MLE and categorization_llikhd.m
% fre and cf in the range of 1 to 30 kHz; bw in Octaves max_amp in
% spikes/stimulus
%
% Bao Lab

global CFs bw spkrate spont R;
freq = log2(freq);
cf = log2(CFs);
bws=bw;
bws(find(bw==0))=1;
RR=spkrate.*exp(-(freq-cf).^2./(2*bws.^2));
LL=-1*sum(R.*log(RR+spont)-RR-spont);

