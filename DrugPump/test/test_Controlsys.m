classdef test_Controlsys < matlab.uitest.TestCase
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
        function test_countamount(testCase)
            testCase.controlsys.pump.amount=ones(1,60);
            testCase.controlsys.pump.amountd=ones(1,24*60);
            testCase.controlsys.countamount();
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_hour,sum(testCase.controlsys.pump.amount,'all'));
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_day,sum(testCase.controlsys.pump.amountd,'all'));
            testCase.verifyEqual(testCase.controlsys.pump.patient.Amountofhour,testCase.controlsys.pump.amount_of_hour);
            testCase.verifyEqual(testCase.controlsys.pump.patient.Amountofday , testCase.controlsys.pump.amount_of_day);
        end
        function test_countgap_1(testCase)
            testCase.controlsys.pump.gap=1;
            testCase.controlsys.pump.bolusGap=2;
            testCase.controlsys.countgap();
            testCase.verifyEqual(testCase.controlsys.pump.askPress,0);
            testCase.verifyEqual(testCase.controlsys.pump.gap,2);
        end
        function test_countgap_2(testCase)
            testCase.controlsys.pump.gap=2;
            testCase.controlsys.pump.bolusGap=1;
            testCase.controlsys.countgap();
            testCase.verifyEqual(testCase.controlsys.pump.PressGapcheck,1);
            testCase.verifyEqual(testCase.controlsys.pump.gap,0);
        end
        function test_startwoking(testCase)
            testCase.controlsys.startwoking();
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_3.Text,'      Not get bolus');
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color,[0.00,1.00,0.00]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color,[0.00,1.00,0.00]);
        end
        function test_confirm(testCase)
            testCase.controlsys.nurseUI.baselineSpeed=1;
            testCase.controlsys.nurseUI.bolusAmountInfo=2;
            testCase.controlsys.nurseUI.bolusGapInfo=3;
            testCase.controlsys.confirm();
            testCase.verifyEqual(testCase.controlsys.nurseUI.PUMPSwitch.Enable , 1);
            testCase.verifyEqual(testCase.controlsys.pump.baseline , testCase.controlsys.nurseUI.baselineSpeed);
            testCase.verifyEqual(testCase.controlsys.pump.bolus , testCase.controlsys.nurseUI.bolusAmountInfo);
            testCase.verifyEqual(testCase.controlsys.pump.bolusGap , testCase.controlsys.nurseUI.bolusGapInfo);
            testCase.verifyEqual(testCase.controlsys.pump.PressAvailable,1);
            testCase.verifyEqual(testCase.controlsys.pump.gap , 0);
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_4.Text , num2str(testCase.controlsys.nurseUI.baselineSpeed));
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_5.Text , num2str(testCase.controlsys.nurseUI.bolusAmountInfo));
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_6.Text , num2str(testCase.controlsys.nurseUI.bolusGapInfo));
        end
        function test_turnOff(testCase)
            testCase.controlsys.turnOff();
            testCase.verifyEqual(testCase.controlsys.nurseUI.PUMPSwitch.Enable , 0);
                    testCase.verifyEqual(testCase.controlsys.workstatus , 0);
                    testCase.verifyEqual(testCase.controlsys.pump.baseline , 0.01);
                    testCase.verifyEqual(testCase.controlsys.pump.bolus , 0.2);
                    testCase.verifyEqual(testCase.controlsys.pump.bolusGap , 30);
                    testCase.verifyEqual(testCase.controlsys.pump.status , 0);
                    testCase.verifyEqual(testCase.controlsys.pump.amount,zeros(1,60));
                    testCase.verifyEqual(testCase.controlsys.pump.amountd,zeros(1,24*60));
                    testCase.verifyEqual(testCase.controlsys.pump.amount_of_hour , 0);
                    testCase.verifyEqual(testCase.controlsys.pump.amount_of_day , 0);
                    testCase.verifyEqual(testCase.controlsys.pump.gap , 0);
                    
                    testCase.verifyEqual(testCase.controlsys.pump.PressAvailable,1);
                    testCase.verifyEqual(testCase.controlsys.pump.PressGapcheck,1);
                    
                    testCase.verifyEqual(testCase.controlsys.nurseUI.BaselinemlminSpinner.Value , 0.01);
                    testCase.verifyEqual(testCase.controlsys.nurseUI.BolusmlshotSpinner.Value , 0.2);
                    testCase.verifyEqual(testCase.controlsys.nurseUI.BolusGapminSpinner.Value , 30);
                    

                    testCase.verifyEqual(testCase.controlsys.nurseUI.Message.Text , '');
                    testCase.verifyEqual(testCase.controlsys.nurseUI.Message_2.Text , '');
                    testCase.verifyEqual(testCase.controlsys.nurseUI.Message_3.Text , '');
                    testCase.verifyEqual(testCase.controlsys.nurseUI.BaselineAvailableLamp.Color , [0.65,0.65,0.65]);
                    testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color , [0.65,0.65,0.65]);
                    testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color , [0.65,0.65,0.65]);
                    testCase.verifyEqual(testCase.controlsys.delay , 0);
                    testCase.verifyEqual(testCase.controlsys.nurseUI.Message_4.Text , '');
                    testCase.verifyEqual(testCase.controlsys.nurseUI.Message_5.Text , '');
                    testCase.verifyEqual(testCase.controlsys.nurseUI.Message_6.Text , '');
        end
        function test_turnOn(testCase)
            testCase.controlsys.turnOn();
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message.Text , '0');
                    testCase.verifyEqual(testCase.controlsys.nurseUI.Message_2.Text , '0');
                    testCase.verifyEqual(testCase.controlsys.nurseUI.Message_3.Text , '      Not get bolus');
                    testCase.verifyEqual(testCase.controlsys.nurseUI.BaselineAvailableLamp.Color , [0.65,0.65,0.65]);
                    testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color , [0 1 0]);
                    testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color , [0 1 0]);
                    testCase.verifyEqual(testCase.controlsys.nurseUI.controlsys.delay , 0);
                    testCase.verifyEqual(testCase.controlsys.workstatus , 1);
        end
        function test_getamountfunc_1(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.controlsys.pump.indexd = 24*60;
            testCase.controlsys.pump.index = 60;
            testCase.controlsys.pump.PressGapcheck = 0;
            testCase.controlsys.pump.amount_of_hour=1;
            testCase.controlsys.pump.bolus=1;
            testCase.controlsys.pump.hourlimit=0;
            testCase.controlsys.delay=0;
            testCase.controlsys.pump.amount_of_day=5;
            testCase.controlsys.pump.baseline=1;
            testCase.controlsys.pump.daylimit=0;
            testCase.controlsys.nurseUI.pump.status=1;
            testCase.controlsys.getamountfunc();
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 1);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color , [1.00,0.00,0.00]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color , [1.00,0.00,0.00]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_3.Text,' ');
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_13.Text,' ');
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 1);
            testCase.verifyEqual(testCase.controlsys.pump.index , 1);
            testCase.verifyEqual(testCase.controlsys.pump.PressGapcheck , 1);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_hour,0);
            testCase.verifyEqual(testCase.controlsys.pump.bolus,1);
            testCase.verifyEqual(testCase.controlsys.pump.hourlimit,0);
            testCase.verifyEqual(testCase.controlsys.delay,1);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_day,0);
            testCase.verifyEqual(testCase.controlsys.pump.baseline,1);
            testCase.verifyEqual(testCase.controlsys.pump.daylimit,0);
            testCase.verifyEqual(testCase.controlsys.nurseUI.pump.status,0);
        end
        function test_getamountfunc_2(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.controlsys.pump.indexd = 0;
            testCase.controlsys.pump.index = 0;
            testCase.controlsys.pump.PressGapcheck = 0;
            testCase.controlsys.pump.amount_of_hour=0;
            testCase.controlsys.pump.bolus=1;
            testCase.controlsys.pump.hourlimit=0;
            testCase.controlsys.delay=2;
            testCase.controlsys.pump.amount_of_day=0;
            testCase.controlsys.pump.baseline=1;
            testCase.controlsys.pump.daylimit=0;
            testCase.controlsys.nurseUI.pump.status=1;
            testCase.controlsys.getamountfunc();
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 1);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color , [1.00,0.00,0.00]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color , [1.00,0.00,0.00]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_3.Text,' ');
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_13.Text,' ');
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 1);
            testCase.verifyEqual(testCase.controlsys.pump.index , 1);
            testCase.verifyEqual(testCase.controlsys.pump.PressGapcheck , 1);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_hour,0);
            testCase.verifyEqual(testCase.controlsys.pump.bolus,1);
            testCase.verifyEqual(testCase.controlsys.pump.hourlimit,0);
            testCase.verifyEqual(testCase.controlsys.delay,2);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_day,0);
            testCase.verifyEqual(testCase.controlsys.pump.baseline,1);
            testCase.verifyEqual(testCase.controlsys.pump.daylimit,0);
            testCase.verifyEqual(testCase.controlsys.nurseUI.pump.status,0);
        end
        function test_getamountfunc_3(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.controlsys.pump.indexd = 7;
            testCase.controlsys.pump.index = 5;
            testCase.controlsys.pump.PressGapcheck = 6;
            testCase.controlsys.pump.amount_of_hour=3;
            testCase.controlsys.pump.bolus=1;
            testCase.controlsys.pump.hourlimit=99;
            testCase.controlsys.delay=2;
            testCase.controlsys.pump.amount_of_day=0;
            testCase.controlsys.pump.baseline=1;
            testCase.controlsys.pump.daylimit=99;
            testCase.controlsys.nurseUI.pump.status=1;
            testCase.controlsys.getamountfunc();
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 8);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color , [0.65,0.65,0.65]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color , [0.65,0.65,0.65]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_3.Text,' ');
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_13.Text,' ');
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 8);
            testCase.verifyEqual(testCase.controlsys.pump.index , 6);
            testCase.verifyEqual(testCase.controlsys.pump.PressGapcheck , 6);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_hour,1);
            testCase.verifyEqual(testCase.controlsys.pump.bolus,1);
            testCase.verifyEqual(testCase.controlsys.pump.hourlimit,99);
            testCase.verifyEqual(testCase.controlsys.delay,2);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_day,1);
            testCase.verifyEqual(testCase.controlsys.pump.baseline,1);
            testCase.verifyEqual(testCase.controlsys.pump.daylimit,99);
            testCase.verifyEqual(testCase.controlsys.nurseUI.pump.status,1);
        end
        function test_getamountfunc_4(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.controlsys.pump.indexd = 2;
            testCase.controlsys.pump.index = 2;
            testCase.controlsys.pump.PressGapcheck = 2;
            testCase.controlsys.pump.amount_of_hour=2;
            testCase.controlsys.pump.bolus=9;
            testCase.controlsys.pump.hourlimit=20;
            testCase.controlsys.delay=2;
            testCase.controlsys.pump.amount_of_day=3;
            testCase.controlsys.pump.baseline=1;
            testCase.controlsys.pump.daylimit=99;
            testCase.controlsys.nurseUI.pump.status=1;
            testCase.controlsys.getamountfunc();
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 3);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color , [0.65,0.65,0.65]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color , [0.65,0.65,0.65]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_3.Text,' ');
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_13.Text,' ');
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 3);
            testCase.verifyEqual(testCase.controlsys.pump.index , 3);
            testCase.verifyEqual(testCase.controlsys.pump.PressGapcheck , 2);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_hour,1);
            testCase.verifyEqual(testCase.controlsys.pump.bolus,9);
            testCase.verifyEqual(testCase.controlsys.pump.hourlimit,20);
            testCase.verifyEqual(testCase.controlsys.delay,2);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_day,1);
            testCase.verifyEqual(testCase.controlsys.pump.baseline,1);
            testCase.verifyEqual(testCase.controlsys.pump.daylimit,99);
            testCase.verifyEqual(testCase.controlsys.nurseUI.pump.status,1);
        end
        function test_getamountfunc_5(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.controlsys.pump.indexd = 0;
            testCase.controlsys.pump.index = 0;
            testCase.controlsys.pump.PressGapcheck = 0;
            testCase.controlsys.pump.amount_of_hour=0;
            testCase.controlsys.pump.bolus=0;
            testCase.controlsys.pump.hourlimit=0;
            testCase.controlsys.delay=0;
            testCase.controlsys.pump.amount_of_day=0;
            testCase.controlsys.pump.baseline=0;
            testCase.controlsys.pump.daylimit=0;
            testCase.controlsys.nurseUI.pump.status=0;
            testCase.controlsys.getamountfunc();
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 1);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color , [0 1 0]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color , [0 1 0]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_3.Text,' ');
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_13.Text,' ');
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 1);
            testCase.verifyEqual(testCase.controlsys.pump.index , 1);
            testCase.verifyEqual(testCase.controlsys.pump.PressGapcheck , 1);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_hour,0);
            testCase.verifyEqual(testCase.controlsys.pump.bolus,0);
            testCase.verifyEqual(testCase.controlsys.pump.hourlimit,0);
            testCase.verifyEqual(testCase.controlsys.delay,0);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_day,0);
            testCase.verifyEqual(testCase.controlsys.pump.baseline,0);
            testCase.verifyEqual(testCase.controlsys.pump.daylimit,0);
            testCase.verifyEqual(testCase.controlsys.nurseUI.pump.status,1);
        end
        function test_getamountfunc_6(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.controlsys.pump.indexd = 3;
            testCase.controlsys.pump.index = 5;
            testCase.controlsys.pump.PressGapcheck = 9;
            testCase.controlsys.pump.amount_of_hour=33;
            testCase.controlsys.pump.bolus=2;
            testCase.controlsys.pump.hourlimit=2;
            testCase.controlsys.delay=1;
            testCase.controlsys.pump.amount_of_day=4;
            testCase.controlsys.pump.baseline=4;
            testCase.controlsys.pump.daylimit=5;
            testCase.controlsys.nurseUI.pump.status=8;
            testCase.controlsys.getamountfunc();
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 4);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color , [1 0 0]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color , [1 0 0]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_3.Text,' ');
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_13.Text,' ');
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 4);
            testCase.verifyEqual(testCase.controlsys.pump.index , 6);
            testCase.verifyEqual(testCase.controlsys.pump.PressGapcheck , 9);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_hour,0);
            testCase.verifyEqual(testCase.controlsys.pump.bolus,2);
            testCase.verifyEqual(testCase.controlsys.pump.hourlimit,2);
            testCase.verifyEqual(testCase.controlsys.delay,1);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_day,0);
            testCase.verifyEqual(testCase.controlsys.pump.baseline,4);
            testCase.verifyEqual(testCase.controlsys.pump.daylimit,5);
            testCase.verifyEqual(testCase.controlsys.nurseUI.pump.status,0);
        end
        function test_getamountfunc_7(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.controlsys.pump.indexd = 0;
            testCase.controlsys.pump.index = 30;
            testCase.controlsys.pump.PressGapcheck = 30;
            testCase.controlsys.pump.amount_of_hour=2;
            testCase.controlsys.pump.bolus=5;
            testCase.controlsys.pump.hourlimit=8;
            testCase.controlsys.delay=3;
            testCase.controlsys.pump.amount_of_day=0;
            testCase.controlsys.pump.baseline=3;
            testCase.controlsys.pump.daylimit=3;
            testCase.controlsys.nurseUI.pump.status=0;
            testCase.controlsys.getamountfunc();
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 1);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color , [1 0 0]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color , [1 0 0]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_3.Text,' ');
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_13.Text,' ');
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 1);
            testCase.verifyEqual(testCase.controlsys.pump.index , 31);
            testCase.verifyEqual(testCase.controlsys.pump.PressGapcheck , 30);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_hour,0);
            testCase.verifyEqual(testCase.controlsys.pump.bolus,5);
            testCase.verifyEqual(testCase.controlsys.pump.hourlimit,8);
            testCase.verifyEqual(testCase.controlsys.delay,3);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_day,0);
            testCase.verifyEqual(testCase.controlsys.pump.baseline,3);
            testCase.verifyEqual(testCase.controlsys.pump.daylimit,3);
            testCase.verifyEqual(testCase.controlsys.nurseUI.pump.status,0);
        end
        function test_getamountfunc_8(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.controlsys.pump.indexd = 1;
            testCase.controlsys.pump.index = 1;
            testCase.controlsys.pump.PressGapcheck = -1;
            testCase.controlsys.pump.amount_of_hour=-1;
            testCase.controlsys.pump.bolus=-1;
            testCase.controlsys.pump.hourlimit=0;
            testCase.controlsys.delay=-1;
            testCase.controlsys.pump.amount_of_day=-1;
            testCase.controlsys.pump.baseline=-1;
            testCase.controlsys.pump.daylimit=9;
            testCase.controlsys.nurseUI.pump.status=0;
            testCase.controlsys.getamountfunc();
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 2);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color , [0.65,0.65,0.65]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color , [0.65,0.65,0.65]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_3.Text,' ');
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_13.Text,' ');
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 2);
            testCase.verifyEqual(testCase.controlsys.pump.index , 2);
            testCase.verifyEqual(testCase.controlsys.pump.PressGapcheck , -1);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_hour,-1);
            testCase.verifyEqual(testCase.controlsys.pump.bolus,-1);
            testCase.verifyEqual(testCase.controlsys.pump.hourlimit,0);
            testCase.verifyEqual(testCase.controlsys.delay,-1);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_day,-1);
            testCase.verifyEqual(testCase.controlsys.pump.baseline,-1);
            testCase.verifyEqual(testCase.controlsys.pump.daylimit,9);
            testCase.verifyEqual(testCase.controlsys.nurseUI.pump.status,1);
        end
        function test_getamountfunc_9(testCase)
            testCase.type(testCase.passwordUI.StaffIDEditField,'9999');
            testCase.type(testCase.passwordUI.PasswordEditField,'9999');
            testCase.press(testCase.passwordUI.ConfirmButton);
            testCase.controlsys.pump.indexd = 1;
            testCase.controlsys.pump.index = 1;
            testCase.controlsys.pump.PressGapcheck = 3;
            testCase.controlsys.pump.amount_of_hour=1;
            testCase.controlsys.pump.bolus=2;
            testCase.controlsys.pump.hourlimit=0;
            testCase.controlsys.delay=1;
            testCase.controlsys.pump.amount_of_day=5;
            testCase.controlsys.pump.baseline=7;
            testCase.controlsys.pump.daylimit=9;
            testCase.controlsys.nurseUI.pump.status=3;
            testCase.controlsys.getamountfunc();
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 2);
            testCase.verifyEqual(testCase.controlsys.nurseUI.BolusAvailableLamp.Color , [1 0 0]);
            testCase.verifyEqual(testCase.controlsys.patientUI.BolusAvailableLamp.Color , [1 0 0]);
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_3.Text,' ');
            testCase.verifyEqual(testCase.controlsys.nurseUI.Message_13.Text,' ');
            testCase.verifyEqual(testCase.controlsys.pump.indexd , 2);
            testCase.verifyEqual(testCase.controlsys.pump.index , 2);
            testCase.verifyEqual(testCase.controlsys.pump.PressGapcheck , 3);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_hour,0);
            testCase.verifyEqual(testCase.controlsys.pump.bolus,2);
            testCase.verifyEqual(testCase.controlsys.pump.hourlimit,0);
            testCase.verifyEqual(testCase.controlsys.delay,1);
            testCase.verifyEqual(testCase.controlsys.pump.amount_of_day,0);
            testCase.verifyEqual(testCase.controlsys.pump.baseline,7);
            testCase.verifyEqual(testCase.controlsys.pump.daylimit,9);
            testCase.verifyEqual(testCase.controlsys.nurseUI.pump.status,0);
        end
        
    end
    
end