clear all; 
close all;

numberOfPDE = 1;
model = createpde(numberOfPDE);
geometryFromEdges(model,@squareg);
pdegplot(model, 'EdgeLabels', 'on');

a = 0;
f = 0;
beta = 200.*eye(725);
c = 1;

d = @(region,state)dcoeffunction(region,state);
cCoef = 1;% c^2./sqrt(1+state.ux.^2 + state.uy.^2);
specifyCoefficients(model, 'm', 1, 'd', 0, 'c', cCoef, 'a', a, 'f', f);

applyBoundaryCondition(model, 'edge', 1:model.Geometry.NumEdges,'u', 0);

u0 = @(locations)atan(cos(pi/2*locations.x));
ut0 = @(locations)3*sin(pi*locations.x).*exp(sin(pi/2*locations.y));
setInitialConditions(model, u0, ut0);

n = 100;
tlist = linspace(0,20,n);

generateMesh(model);
figure;
pdemesh(model);
axis equal  
model.SolverOptions.ReportStatistics = 'on';
result = solvepde(model, tlist);
u = result.NodalSolution;

results = assembleFEMatrices(model);

specifyCoefficients(model, 'm', 1, 'd', 0, 'c', cCoef, 'a', a, 'f', f);

applyBoundaryCondition(model, 'edge', 1:model.Geometry.NumEdges,'u', 0);

u0 = @(locations)atan(cos(pi/2*locations.x));
ut0 = @(locations)5*sin(pi*locations.x).*exp(sin(pi/2*locations.y));
setInitialConditions(model, u0, ut0);

n = 10;
tlist = linspace(0,10,n);

generateMesh(model);
figure;
pdemesh(model);
axis equal  
model.SolverOptions.ReportStatistics = 'on';
result = solvepde(model, tlist);
u = result.NodalSolution;


umax = max(max(u));
umin = min(min(u));

figure;
M = moviein(n);
for i=1:n,
    fig = pdeplot(model,'XYData',u(:,i),'ZData',u(:,i),...
    'XYGrid','on','ColorBar','off');
    axis([-1 1 -1 1 umin umax]);
    caxis([umin umax]);
    M(:,i) = getframe;
    if mod(n,100) == 0 
         saveas(fig, ['damped_wave_' num2str(n) '.pdf']);
    end
end

