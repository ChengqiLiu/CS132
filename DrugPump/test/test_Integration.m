classdef test_Integration < matlab.uitest.TestCase
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
        function test_SelectButtonPushed(testCase)
            %输错密码
            testCase.type(testCase.passwordUI.StaffIDEditField,'abcd');
            pause(0.5);
            testCase.type(testCase.passwordUI.PasswordEditField,'1234');
            pause(0.5);
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.verifyEqual(testCase.passwordUI.Label.Text,  'Wrong id or password');
            %输对密码，打开NurseUI
            pause(0.5);
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            pause(0.5);
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.verifyEqual(testCase.passwordUI.nurse.ID,testCase.passwordUI.id);
            testCase.verifyEqual(testCase.passwordUI.nurse.password,testCase.passwordUI.password);
            pause(0.5);
            testCase.press(testCase.passwordUI.ConfirmButton);
            pause(1);
            %可以修改数值。按下Confirm之后，设定数值，此时开关才能按下
            testCase.press(testCase.nur.nUIapp.BaselinemlminSpinner,'up');
            testCase.verifyEqual(testCase.nur.nUIapp.Message_13.Text , 'Not Confirmed !');
            pause(0.5);
            testCase.press(testCase.nur.nUIapp.BolusmlshotSpinner,'up');
            testCase.verifyEqual(testCase.nur.nUIapp.Message_13.Text , 'Not Confirmed !');
            pause(0.5);
            testCase.press(testCase.nur.nUIapp.BolusGapminSpinner,'up');
            testCase.verifyEqual(testCase.nur.nUIapp.Message_13.Text , 'Not Confirmed !');
            pause(0.5);
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
            pause(1);
            %打开开关之后，开始注射
            testCase.press(testCase.nur.nUIapp.PUMPSwitch);
            pause(2);
            %按一下bolus，注射更多止痛药，但是在bolus gap时间内就不能再按,过了这段时间之后就又可以了
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
            pause(15);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color,[1.00,0.00,0.00]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color,[1.00,0.00,0.00]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BaselineAvailableLamp.Color,[1.00,0.00,0.00]);
            %注射中途发生修改——确认前无效
            testCase.press(testCase.nur.nUIapp.BaselinemlminSpinner,'down');
            testCase.verifyEqual(testCase.nur.nUIapp.Message_13.Text , 'Not Confirmed !');
            pause(4);
            %按下confirm，有效
            testCase.press(testCase.nur.nUIapp.ConfirmButton);
            pause(6);
            
            %继续展示第二天、第三天的注射情况：
            %%%%%%%
            pause(140);
            testCase.press(testCase.paitentUI.GetBolusButton);
            pause(4.5);
            %%%%%%%%
            
            %关掉开关，注射停止。
            testCase.press(testCase.nur.nUIapp.PUMPSwitch);
            pause(3);
        end
        
    end
    
end