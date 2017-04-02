j = 1;
i = 0;
while 1
    j = j+1;
   
    for k=0:0.05:1
        if mod(j,2) == 0
            i = 1-k;
        else 
            i = k;
        end
  
        load(['workspace_step' num2str(i*100) '.mat']);
        pdeplot(model,'XYData',u,'ZData',u)
        xlabel 'x'
        ylabel 'y'
        zlabel 'u(x,y)'
        title 'Minimal surface'
        axis([-1 1 -1 1 -1 1])

        pause(0.0001)
    end
end