close all;
clear all;
%rename each .m and .mlapp files 
f1app=ButtonPanel_f1;
f2app=ButtonPanel_f2;
f3app=ButtonPanel_f3;
e1app=ButtonPanel_e;
e2app=ButtonPanel_e;
c=ElevatorController;
elev=Elevator;
fS=FloorSensor;
dS=DoorSensor;
eS=EmergSensor;

%change e1app's position
e1app.UIFigure.Position(1)=e1app.UIFigure.Position(1)-296;

%set ElevatorController.m's properties
c.f1=f1app;
c.f2=f2app;
c.f3=f3app;
c.e1=e1app;
c.e2=e2app;
c.elevator=elev;
c.fSensor=fS;
c.dSensor=dS;
c.emSensor=eS;

%set Elevator.m's properties
elev.f1=f1app;
elev.f2=f2app;
elev.f3=f3app;
elev.e1=e1app;
elev.e2=e2app;
elev.control=c;
elev.fSensor=fS;

%set the .mlapp files' properties
f1app.control=c;
f2app.control=c;
f3app.control=c;
e1app.control=c;
e1app.fSensor=fS;
e2app.control=c;
e2app.fSensor=fS;

%set the ButtonPanel_e tags
e1app.num=1;
e1app.EditField.Value='Elevator 1';
e2app.num=2;
e2app.EditField.Value='Elevator 2';

%set the time of passing half floor to each ButtonPanel_e 
elev.etime=elev.floor_height/2/elev.speed;