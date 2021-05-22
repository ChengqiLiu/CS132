close all
clear all 

nur = Nurse;
pat = Patient; 
pump = Pump;
controlsys = Controlsys;

passwordUI = PasswordUI;
paitentUI = PatientButton;

passwordUI.nurse = nur;
passwordUI.pump = pump;
passwordUI.controlsys = controlsys;

nur.PWUI = passwordUI;
nur.pump = pump;

pump.patient = pat;
pump.PWUI = passwordUI;
pump.controlsys = controlsys;

paitentUI.pump = pump;
paitentUI.patient = pat;

pat.button = paitentUI;
pat.pump = pump;

controlsys.pump = pump;
controlsys.passwordUI = passwordUI;
controlsys.patientUI = paitentUI;
