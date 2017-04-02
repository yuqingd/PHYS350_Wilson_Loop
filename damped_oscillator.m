clear all; 
close all;

numberOfPDE = 1;
model = createpde(numberOfPDE);
geometryFromEdges(model,@squareg);
pdegplot(model, 'EdgeLabels', 'on');

a = 0;
f = 0;
beta = 0;
c = 1;

cCoef = @(region,state) c^2./sqrt(1+state.ux.^2 + state.uy.^2);
specifyCoefficients(model, 'm', 1, 'd', 0, 'c', cCoef, 'a', a, 'f', f);

bcMatrix = @(region,~)region.x.^2;
applyBoundaryCondition(model, 'edge', 1:model.Geometry.NumEdges,'u', bcMatrix);

u0 = @(locations)atan(cos(pi/2*locations.x));
ut0 = @(locations)3*sin(pi*locations.x).*exp(sin(pi/2*locations.y));
setInitialConditions(model, u0, ut0);

n = 30;
tlist = linspace(0,5,n);

generateMesh(model, 'Hmax', 0.1);
figure;
pdemesh(model);
axis equal  

model.SolverOptions.ReportStatistics = 'on';
result = solvepde(model, tlist);
u = result.NodalSolution;

%results = assembleFEMatrices(model)

umax = max(max(u));
umin = min(min(u));

figure;
M = moviein(n);
for i=1:n,
    pdeplot(model,'XYData',u(:,i),'ZData',u(:,i),...
    'XYGrid','on','ColorBar','off');
    axis([-1 1 -1 1 umin umax]);
    caxis([umin umax]);
    M(:,i) = getframe;
end


