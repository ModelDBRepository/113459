function x = smth_gass_distr(fc, bw, num)
% Takes the desired center frequency, the upper and lower limits of the
% redistribution, and the number of neurons required to be redistributed
% and gives you a Gaussian distribution.
%
% fc = the center frequency (center of the distribution
% bw = the half-octave range of the distribution.  Generally speaking,
% using bw = .35 (so the range of the distribution will be fc-.35octaces to
% fc+.35 octaves) will give you a standard deviation of .1 octave.
% num = number of neurons you want.

n=1;
f1=fc*2^(-bw);
f2=fc*2^bw;
ctr=log2(fc);
x(n)=ctr;
%x(n)=log2(f1);
b=1/(2*(0.125*log2(f2/f1))^2);
stp=0.1*exp(-b*(log2(f1)-ctr)^2);
while x(n)<log2(f2)
   n=n+1;
   x(n)=x(n-1)+stp/exp(-b*(x(n-1)-ctr)^2);
end
onein=((2*(n))/(num));
% try this:
% onein = ceil(2*n/num);
clear x
n=1;
x(n)=ctr;
while x(n)<log2(f2)
    n=n+1;
    x(n)=x(n-1)+onein*stp/exp(-b*(x(n-1)-ctr)^2);
    %x(n)=x(n-1)+(onein*0.125);
end
x(n)=[];
x=[2*min(x)-x, x];
x=2.^x;

diff = length(x) - num;

for i=1:diff
    t = ceil(rand(1) * length(x));
    x(t) = [];
end