function x = binornd_sim(P);
% Bernoulli random process.  Bounded by 0 and 1.  Equation 5 in paper.

for j=1:length(P)
    P_1=(P(j)-P(end))/(P(1)-P(end));
    if P_1>1;
        P_1=1;
    end
    if P_1<0
        P_1=0;
    end
    
    for n=1:100;
        trial_1=binornd(1,P_1,1, 100);
        perf_1(n, j)=sum(trial_1);
    end
end
        
for n=1:length(P);
    x(:,n)=sort(perf_1(:,n));
end