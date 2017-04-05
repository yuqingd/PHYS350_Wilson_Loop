function Fixed_Sin_Boundary(inline1)
    
numberOfPDE = 1;
model = createpde(numberOfPDE);
geometryFromEdges(model,@squareg);
%pdegplot(model, 'EdgeLabels', 'on');

a = 0;
f = 0;
cCoef = @(region,state) 1./sqrt(1+state.ux.^2 + state.uy.^2); %minimal surface
specifyCoefficients(model, 'm', 0, 'd', 0, 'c', cCoef, 'a', a, 'f', f);

%bcMatrix = @(region,state) square(2.*atan(region.x./region.y)); %static boundary definition
bcMatrix =  inline1;
applyBoundaryCondition(model, 'edge',1:model.Geometry.NumEdges,'u',bcMatrix);
generateMesh(model,'Hmax',0.1);

model.SolverOptions.ReportStatistics = 'on';
result = solvepde(model);
u = result.NodalSolution;

pdeplot(model,'XYData',u,'ZData',u)
xlabel 'x'
ylabel 'y'
zlabel 'u(x,y)'
title 'Minimal surface'
axis([-1 1 -1 1 -1 1])

end
