clc;clear;
close all;

%% 
param.LC.R                      = 0.1;
param.LC.C                      = 220e-6;                                        % [F]
param.LC.L                      = 2*65e-6;                                       % [H]
params.battery.module.n         = 3;                                            % Number of modules
params.cascade_hb.carrier_hz    = 1000;                                          % [Hz] carrier frequency
params.solver.Tsample           = 1;                                         % [s] sample time of solver used in simscape

BalThreshold                    = 1e-3;
Ts                              = params.solver.Tsample;

SoC01 = 0.4;
SoC02 = 0.5;
SoC03 = 0.45;

%% V-Control
V_DC_STR                = 10;                   % Reference DC voltage
parms.Vout_control.Ki   = 0.035*20;             % integral gain
parms.Vout_control.Kp   = 0.15*10;              % proportional gain

% out = sim("Cell_Balancing.slx");
rl;
out = sim("Cell_Balancing.slx");
%% Plots
set(figure(1),'position',[100 200 600 600])
tiledlayout(3,1,'TileSpacing','tight', 'TileIndexing','columnmajor');
fs =17;
t = out.time;
SoC1 = out.SoC(:,1);
SoC2 = out.SoC(:,2);
SoC3 = out.SoC(:,3);
V1 = out.bat_V(:,1);
V2 = out.bat_V(:,2);
V3 = out.bat_V(:,3);
u_passive1 = out.Controls(:,1);
u_passive2 = out.Controls(:,2);
u_passive3 = out.Controls(:,3);

figure(1),
ax1 = nexttile(1);
plot(t,u_passive1,'r','LineWidth',2.5), grid on, hold on
plot(t,u_passive2,'b','LineWidth',2.5), hold on,
plot(t,u_passive3,'m','LineWidth',2.5)
ylabel('$u_{passive}$ [-]','interpreter','latex')
set(gca,'fontsize',fs,'TickLabelInterpreter','latex')
legend('$Cell \#1$','$Cell \#2$','$Cell \#3$','orientation','horizontal','interpreter','latex')

ax2 = nexttile(2);
plot(t,SoC1,'r','LineWidth',2.5), grid on, hold on
plot(t,SoC2,'b','LineWidth',2.5), hold on,
plot(t,SoC3,'m','LineWidth',2.5)
ylabel('$SoC$ [-]','interpreter','latex')
set(gca,'fontsize',fs,'TickLabelInterpreter','latex')

ax3 = nexttile(3);
plot(t,V1,'r','LineWidth',2.5), grid on, hold on
plot(t,V2,'b','LineWidth',2.5), hold on,
plot(t,V3,'m','LineWidth',2.5)
ylabel('$V_{cell}$ [V]','interpreter','latex')
set(gca,'fontsize',fs,'TickLabelInterpreter','latex')

linkaxes([ax1,ax2,ax3],"x")
xlim([0,t(end)])