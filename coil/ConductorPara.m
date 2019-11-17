clear;clc;
Qs=36;p=3;m=3;
rpm=10000;

Coil.Nc=15;
Coil.layer=2;
Coil.NumPare=1;
Coil.Lend=30;
Coil.Kcu=0.45;

Stator.Do=150;
Stator.SlotA=40.3;
Stator.Lstk=80;

Current.Irms=9;
Temp=500;
RatioCu=1.75*1e-05*(1+0.004*(Temp-20));

ElecLoad=Qs*Coil.Nc*Coil.layer*Current.Irms/Coil.NumPare/(pi*Stator.Do)*10;
Current.Density=Coil.layer*Coil.Nc*Current.Irms/Coil.NumPare/(Stator.SlotA*Coil.Kcu);
ThermLoad=ElecLoad*Current.Density;
Rs=(Stator.Lstk+Coil.Lend)*2*Coil.Nc*(Qs*Coil.layer/2/m)/(Stator.SlotA*Coil.Kcu/(Coil.Nc*Coil.layer))*RatioCu/(Coil.NumPare^2);
