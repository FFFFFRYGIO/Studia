% Radosław Relidzyński WCY20IY4S1 25.05.2022 r.
% Dane do ćwiczenia 6
C1=10;  % [m^2]
C2=5;   % [m^2]
R1=1;   % [s/m^2]
R2=1;   % [s/m^2]
q0=1;   % [m^3/s]

a11=-1/(R1*C1);
a12=1/(R1*C1);
a21=1/(R1*C2);
a22=-1/(R1*C2)-1/(R2*C2);
b1=1/C1;

A=[a11,a12;a21,a22];
B=[b1;0];
C=[0,1];
D=[0];
