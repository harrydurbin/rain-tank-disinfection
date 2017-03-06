%% CE 291 - Control and Optimization of Distributed Parameter Systems
%   Chlorine Disinfection
%   Harrison Durbin, SID 26951511
%   Prof. Gomes

% pipe_calculations_rev_1.m

clear; close all;
%% calculating pipe length from tank to faucet
% two flow scenarios

% scenario 1: ensure 5 minutes of contact time
d_pipe = 1.5; % inch
d_pipe = d_pipe*25.4*1e-3; % m
A_pipe = pi*(d_pipe^2)/4; % m2
t_pipe = 5; % min
t_pipe = t_pipe*60; % sec
Q_pipe = 1.5; % gpm max for bathroom faucets
Q_pipe = Q_pipe * 6.30901966667e-5; % m3/s 
v_pipe = Q_pipe/A_pipe; % m/s
L_pipe = v_pipe*t_pipe; % m
L_pipe = L_pipe * 3.28084; % ft
V_pipe = L_pipe * A_pipe; % m3
V_pipe = V_pipe * 264; % gal - 264 gal/m3

% scenario 2: assume fixed flow schedule over 24 hours
d_pipe2 = 1.5; % inch
d_pipe2 = d_pipe2*25.4*1e-3; % m
A_pipe2 = pi*(d_pipe2^2)/4; % m2
t_pipe2 = 60*24*3; % min
t_pipe2 = t_pipe2*60; % sec
Q_pipe2 = 15/24/60; % gpm max for bathroom faucets
Q_pipe2 = Q_pipe2 * 6.30901966667e-5; % m3/s 
v_pipe2 = Q_pipe2/A_pipe2; % m/s
L_pipe2 = 100; % m
V_pipe2 = L_pipe2 * A_pipe2; % m3
V_pipe2 = V_pipe2* 264; % gal - 264 gal/m3

t_dosing = 3/264/A_pipe2/(v_pipe)/60; % min, time of dosing for 3 gal

%%  Proportional controller code

iterations = 20;
y = zeros(iterations,1);
new_u0 = zeros(iterations+1,1);
e = zeros(iterations,1);
global dosage;
dosage = 10; % set initial dosage guess
new_u0(1) = dosage;
Y = pipe_model_rev_1();
K = 1;
set_point = 0.5;
YY = zeros(iterations+1,1);
YY(1) = Y;

for i = (1:iterations)
    y(i) = Y(i);
    e(i) = (y(i)-set_point);
    new_u0(i+1) = new_u0(i)-K*e(i)+0.001;
    global dosage;
    dosage = new_u0(i+1);
    Y(i+1) = pipe_model_rev_1();  
end

%% plot P controller results


plot(new_u0,'LineWidth',2);
hold on
plot(e,'LineWidth',2);
plot(y,'LineWidth',2);
axis([1, 20, 0, 10]);
grid on
grid minor
legend('u_{0}, boundary control', 'e, error', 'y, measured output')
xlabel('Iterations')
ylabel('Concentraion [ppm]')
set(gca,'FontSize',20);
