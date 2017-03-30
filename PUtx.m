function [X,S] = PUtx(M,samples,txPower, Pr)

% Get the PU transmission
%
% PUtx(M,samples,txPower, Pr_1)
% M - Number of PUs
% samples - Number of transmission samples
% txPower - Average transmission power for each PU
% Pr - Active probability for each PU

S = zeros(1,M); % PU states
X = zeros(M,samples); % Signal at PU transmitters

for i=1:M
    p = rand(1);
    if (p <= Pr(i))
        S(i) = 1;
    end
end

X(S'==1,:) = randn(sum(S),samples) + 1i*randn(sum(S),samples);
    
for j=1:M
    power = rms(X(j,:));
    if (power>0)
        X(j,:) = X(j,:)/power; % Normalized power
    end
    X(j,:) = X(j,:)*sqrt(txPower(j));
end

end