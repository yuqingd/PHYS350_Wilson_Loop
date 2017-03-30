%%
clear all; 
numberOfPDE = 1;
model = createpde(numberOfPDE);
geometryFromEdges(model,@circleg);
pdegplot(model, 'EdgeLabels', 'on');

a = 0;
f = 0;
cCoef = @(region,state) 1./sqrt(1+state.ux.^2 + state.uy.^2);
specifyCoefficients(model, 'm', 0, 'd', 0, 'c', cCoef, 'a', a, 'f', f);

bcMatrix = @(region,state) sin(2.*atan(region.x./region.y));
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