%Francisco Valero-Cuevas
%MAE 479/579, lsqnonolin example with Monte Carlo search

function F = jaggedterrain(x)
%this function calculates the height F of a jagged terrain as a function of
%the X and Y coordenates

X = x(1);
Y = x(2);
R = sqrt(X^2 + Y^2) + 1.5*sin(2*X) + 2* cos(3*Y) + eps;
F = sin(R)/R + + X*.1 + Y * .005; % Z value