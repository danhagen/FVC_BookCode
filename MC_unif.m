clear all;
close all;

x_lb = -2;
x_ub = 5;
y_lb = 3;
y_ub = 10;

n = 1e3;

% SETTING SEED HERE
tstart = clock;
seed = round(sum(1000*tstart));
rand('state',seed);             % NOTE: This sets the seed for the UNIFORM distribution only.
% save tempseed seed -ASCII;    % Saving seed if you want to repeat the exact same simulation later.

x = random('unif', x_lb, x_ub, n, 1);
y = random('unif', y_lb, y_ub, n, 1);

figure;
subplot(211); hist(x);
subplot(212); hist(y);