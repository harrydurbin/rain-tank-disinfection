function [final_u] = pipe_model_rev_1
% note: run the function called pipe calculations_rev_0.m,which runs this
global dosage;

m = 0;

x0=0;
xf=50;
Nx=201;
t0=0;
tf=60*60*24*2;
Nt=201;
x=linspace(x0,xf,Nx);
t=linspace(t0,tf,Nt);


sol = pdepe(m,@pdex1pde,@pdex1ic,@pdex1bc,x,t);
% Extract the first solution component as u.
u = sol(:,:,1); 
final_u = u(end,end);

% A surface plot is often a good way to study a solution.
figure(5);
mesh(x,t,u) 
xlabel('Location on pipe, x [meters]')
ylabel('Time, t [seconds]')
zlabel('u')

% A solution profile can also be illuminating.
figure(1); 
plot(x,u)
xlabel('Location on pipe, x [meters]')
ylabel('Concentration, u(x,t) [ppm]')
grid minor
grid on

% A solution profile can also be illuminating.
figure(2)
plot(x,u(end,:))
axis([0, 100, 0, 7]);
grid on
grid minor
xlabel('Location on pipe, x [meters]')
ylabel('Time, t [seconds]')

% nFrames = length(t)-2;
% 
% % Preallocate movie structure.
% M(1:nFrames) = struct('cdata', [],...
%                         'colormap', []);
% % figure(3)
% G=plot(x,u(10,:),'erase','xor');
% axis([0, 100, 0, 7]);
% xlabel('location along pipe, x [meters]'); ylabel('chlorine conc, u(x,t_k) [ppm]');
% grid on 
% grid minor
% count=1;
% for k = 2:length(t)
% %     title('');
%     set(G,'xdata',x,'ydata',u(k,:)); 
%     M(count)=getframe;
%     count=count+1;
% %     pause(0.1); 
% end
% numtimes=0;
% fps=1;
% movie(M,numtimes,fps)
% movie2avi(M,'C:\Users\Harrison\Desktop\animation1.avi');

% --------------------------------------------------------------
function [c,f,s] = pdex1pde(x,t,u,DuDx)
% a = 0; % m/s advection
% a = (0.083*100); % m/s advection
a = 5e-4; % m/s
r = (1e-5); % [1/s] reaction rate coefficient
D = (1.25e-9); % [m2/s] diffusivity of chlorine
c = 1;
f = D*DuDx;
s = -a*DuDx-r*u;

% --------------------------------------------------------------
function u0 = pdex1ic(x)
% u0 = 4;
u0 = 0.5;

% --------------------------------------------------------------
function [pl,ql,pr,qr] = pdex1bc(xl,ul,xr,ur,t)
global dosage;
pl = ul-dosage;
% pl = ul-4; 
% pl = ul-0; 
ql = 0;
pr = 0; % 
qr = 1;


