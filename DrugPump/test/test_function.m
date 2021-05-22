classdef test_function < matlab.uitest.TestCase
    properties
        nur
        pat 
        pump 
        controlsys 
        passwordUI
        paitentUI
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            testCase.nur = Nurse;
            testCase.pat = Patient; 
            testCase.pump = Pump;
            testCase.controlsys = Controlsys;

            testCase.passwordUI = PasswordUI;
            testCase.paitentUI = PatientButton;
                        
            testCase.passwordUI.nurse = testCase.nur;
            testCase.passwordUI.pump = testCase.pump;
            testCase.passwordUI.controlsys = testCase.controlsys;

            testCase.nur.PWUI = testCase.passwordUI;
            testCase.nur.pump = testCase.pump;

            testCase.pump.patient = testCase.pat;
            testCase.pump.PWUI = testCase.passwordUI;
            testCase.pump.controlsys = testCase.controlsys;

            testCase.paitentUI.pump = testCase.pump;
            testCase.paitentUI.patient = testCase.pat;

            testCase.pat.button = testCase.paitentUI;
            testCase.pat.pump = testCase.pump;

            testCase.controlsys.pump = testCase.pump;
            testCase.controlsys.passwordUI = testCase.passwordUI;
            testCase.controlsys.patientUI = testCase.paitentUI;

            testCase.addTeardown(@delete,testCase.nur); 
            testCase.addTeardown(@delete,testCase.pat);
            testCase.addTeardown(@delete,testCase.pump);
            testCase.addTeardown(@delete,testCase.controlsys);
            testCase.addTeardown(@delete,testCase.passwordUI); 
            testCase.addTeardown(@delete,testCase.paitentUI); 
        end
    end
    methods (Test)
        function test_inputPassword(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'abcd');
            testCase.type(testCase.passwordUI.PasswordEditField,'1234');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.verifyEqual(testCase.passwordUI.Label.Text,  'Wrong id or password');
            
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.verifyEqual(testCase.passwordUI.nurse.ID,testCase.passwordUI.id);
            testCase.verifyEqual(testCase.passwordUI.nurse.password,testCase.passwordUI.password);
            testCase.press(testCase.passwordUI.ConfirmButton);
        end
        function setInitialValue(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            
            testCase.press(testCase.nur.nUIapp.BaselinemlminSpinner,'up');
            testCase.verifyEqual(testCase.nur.nUIapp.Message_13.Text , 'Not Confirmed !');
            testCase.press(testCase.nur.nUIapp.BolusmlshotSpinner,'up');
            testCase.verifyEqual(testCase.nur.nUIapp.Message_13.Text , 'Not Confirmed !');
            testCase.press(testCase.nur.nUIapp.BolusGapminSpinner,'up');
            testCase.verifyEqual(testCase.nur.nUIapp.Message_13.Text , 'Not Confirmed !');
            testCase.press(testCase.nur.nUIapp.ConfirmButton);
            testCase.verifyEqual(testCase.controlsys.nurseUI.PUMPSwitch.Enable , 'on');
            testCase.verifyEqual(testCase.controlsys.pump.baseline , testCase.controlsys.nurseUI.baselineSpeed);
            testCase.verifyEqual(testCase.controlsys.pump.bolus , testCase.controlsys.nurseUI.bolusAmountInfo);
            testCase.verifyEqual(testCase.controlsys.pump.bolusGap , testCase.controlsys.nurseUI.bolusGapInfo);
            testCase.verifyEqual(testCase.controlsys.pump.PressAvailable,1);
            testCase.verifyEqual(testCase.controlsys.pump.gap , 0);
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_4.Text , num2str(testCase.controlsys.nurseUI.baselineSpeed));
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_5.Text , num2str(testCase.controlsys.nurseUI.bolusAmountInfo));
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_6.Text , num2str(testCase.controlsys.nurseUI.bolusGapInfo));
        end
        function Inject(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.press(testCase.nur.nUIapp.ConfirmButton);
            testCase.press(testCase.nur.nUIapp.PUMPSwitch);
            
            pause(2);
            %bolus
            testCase.press(testCase.paitentUI.GetBolusButton);
            pause(1);
            testCase.press(testCase.paitentUI.GetBolusButton);
            pause(0.5);
            testCase.press(testCase.paitentUI.GetBolusButton);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color,[1.00,0.00,0.00]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color,[1.00,0.00,0.00]);
            pause(4.5);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color,[0 1 0]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color,[0 1 0]);
            testCase.press(testCase.paitentUI.GetBolusButton);
            pause(0.5);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color,[1 0 0]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color,[1.00,0.00,0.00]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BaselineAvailableLamp.Color,[0 1 0]);
            pause(5);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color,[0 1 0]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color,[0 1 0]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BaselineAvailableLamp.Color,[0 1 0]);
        end
        function changeValue(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.press(testCase.nur.nUIapp.ConfirmButton);
            testCase.press(testCase.nur.nUIapp.PUMPSwitch);
            pause(1);
            %invalid
            testCase.press(testCase.nur.nUIapp.BolusmlshotSpinner,'up');
            testCase.verifyEqual(testCase.nur.nUIapp.Message_13.Text , 'Not Confirmed !');
            pause(4);
            %confirm, valid
            testCase.press(testCase.nur.nUIapp.ConfirmButton);
            pause(2);
        end
        function nextDay(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.press(testCase.nur.nUIapp.ConfirmButton);
            testCase.press(testCase.nur.nUIapp.PUMPSwitch);
            
            %next day, wait for long time£º
            %%%%%%%
            pause(130);
             testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color,[1 0 0]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color,[1 0 0]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BaselineAvailableLamp.Color,[1 0 0]);
            pause(30);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color,[0 1 0]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color,[0 1 0]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BaselineAvailableLamp.Color,[0 1 0]);
            testCase.press(testCase.paitentUI.GetBolusButton);
            pause(0.5);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color,[1 0 0]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color,[1 0 0]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BaselineAvailableLamp.Color,[1 0 0]);
            
            pause(4.5);
            %%%%%%%%
        end
        function stopInjection(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.press(testCase.nur.nUIapp.ConfirmButton);
            testCase.press(testCase.nur.nUIapp.PUMPSwitch);
            pause(2);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color,[0 1 0]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color,[0 1 0]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BaselineAvailableLamp.Color,[0 1 0]);
            pause(3);
            %stop injection
            testCase.press(testCase.nur.nUIapp.PUMPSwitch);
            pause(0.5);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color,[0.65 0.65 0.65 ]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color,[0.65 0.65 0.65 ]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BaselineAvailableLamp.Color,[0.65 0.65 0.65 ]);
        end
        
    end
    
end