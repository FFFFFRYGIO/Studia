% Radosław Relidzyński WCY20IY4S1 09.06.2022 r.
% Dane do ćwiczenia 8
C1=10;  % [m^2]
C2=5;   % [m^2]
C3=2;   % [m^2]
R1=0.3; % [s/m^2]
R2=2;   % [s/m^2]
R3=3;   % [s/m^2]
P0=1;
x3=3;

A=[-1/(R1*C1), 1/(R1*C1), 0;
   1/(R1*C2), -1/(R1*C2)-1/(R2*C2), 1/(R2*C2);
   0, -1/(R2*C3), -1/(R2*C3)-1/(R3*C3);];
% usage: A(ind1, ind2)
B=[1/C1;0;0];
C=[0,0,1];
D=[0];

k = 100;
