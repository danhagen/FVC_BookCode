clear all;
close all;
UB = 10;
LB = -10;
[X,Y] = meshgrid(LB:.1:UB);
R = sqrt(X.^2 + Y.^2) + 1.5*sin(2*X) + 2* cos(3*Y) + eps;
Z = sin(R)./R + X*.1 + Y * .005;

hold on
mesh(X,Y,Z)
% fig3 = surf(X,Y,Z,'FaceColor','interp',...
%     'EdgeColor','none',...
%     'FaceLighting','phong')
% daspect([5 5 1])
% axis tight
% view(-50,30)
% camlight left

x = [3 4];
% figure(fig3)
line([x(1) x(1)], [x(2) x(2)], [jaggedterrain2(x) 3], 'Color','k','LineWidth',2)
hold off