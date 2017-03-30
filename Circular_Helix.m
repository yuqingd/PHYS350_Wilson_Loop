a = 0.5;
c = 5.0;
t = 0:0.01:10*pi;

x = a*sin(t);
y = a*cos(t);
z = t/(2*pi*c);

figure(1)
plot3(x, y, z); 
xlabel('x'); ylabel('y'); title('Circular helix');
%% 
numberOfPDE = 1;
model = createpde(numberOfPDE);
geometryFromEdges(model,@circleg);
pdegplot(model, 'EdgeLabels', 'on');

a = 0;
f = 0;
cCoef = @(region,state) 1./sqrt(1+state.ux.^2 + state.uy.^2);
specifyCoefficients(model, 'm', 0, 'd', 0, 'c', cCoef, 'a', a, 'f', f);

bcMatrix = @(region,state) atan(region.y./region.x);
applyBoundaryCondition(model, 'edge',1:model.Geometry.NumEdges,'u',bcMatrix);
generateMesh(model,'Hmax',0.1);
figure;
pdemesh(model);
axis equal  

model.SolverOptions.ReportStatistics = 'on';
result = solvepde(model);
u = result.NodalSolution;

figure;
pdeplot(model,'XYData',u,'ZData',u);
xlabel 'x'
ylabel 'y'
zlabel 'u(x,y)'
title 'Minimal surface'