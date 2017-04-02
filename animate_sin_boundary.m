
    for i=0:0.05:1
  
        load(['workspace_step' num2str(i*100) '.mat']);
        pdeplot(model,'XYData',u,'ZData',u)
        xlabel 'x'
        ylabel 'y'
        zlabel 'u(x,y)'
        title 'Minimal surface'
        axis([-1 1 -1 1 -1 1])

        pause(0.0001)
    end
