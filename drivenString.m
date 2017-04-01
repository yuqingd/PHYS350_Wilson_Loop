N = 20;
L = 10;
xStep = 100;
tStep = 100;
maxTime = 100;
x = linspace(0,L,xStep);
t = linspace(0,maxTime,tStep);
omega = 3;
c = 3;
w = @(x,t) x*sin(omega*t)/L;
X = @(x,n) sin(n*x*pi/L);
C = @(n)(L/(n*pi*c))*((2*omega/(n*pi))*((-1)^n-1) - 2*(-1)^n*omega^3*L^2/(n*pi*(L^2*omega^2 - n^2*pi^2*c^2)));
D = @(n) 2*(-1)^n*omega^2*L^2/(n*pi*(L^2*omega^2-n^2*pi^2*c^2));
T = @(t,n) C(n)*sin(n*pi*c*t/L) + D(n)*sin(omega*t);
u = zeros(xStep,tStep);

for a = 1:xStep
    for b = 1:tStep
        u(a,b) = w(x(a),t(b));
        for i = 1:N
            u(a,b) = u(a,b) + X(x(a),i)*T(t(b),i);
        end
    end
end
    
for i = 1:tStep
    plot(x,u(:,i));
    axis([0,L,-3,3]);
    pause(0.1)
end