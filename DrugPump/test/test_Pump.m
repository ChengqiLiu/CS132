classdef test_Pump < matlab.uitest.TestCase
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
        function test_injectBolus(testCase)
            testCase.pump.bolus=1;
            testCase.pump.index=2;
            testCase.pump.indexd=3;
            testCase.pump.injectBolus();
            testCase.verifyEqual(testCase.pump.amount(testCase.pump.index),testCase.pump.bolus);
            testCase.verifyEqual(testCase.pump.amountd(testCase.pump.indexd),testCase.pump.bolus);
            testCase.verifyEqual(testCase.pump.askPress , 0);
            testCase.verifyEqual(testCase.pump.PressGapcheck , 0);
        end
        function test_injectbaseline(testCase)
            testCase.pump.baseline=1;
            testCase.pump.index=2;
            testCase.pump.indexd=3;
            testCase.pump.injectbaseline();
            testCase.verifyEqual(testCase.pump.amount(testCase.pump.index),testCase.pump.baseline);
            testCase.verifyEqual(testCase.pump.amountd(testCase.pump.indexd),testCase.pump.baseline);
        end
        function test_pauseinjection(testCase)
            testCase.pump.indexd=1;
            testCase.pump.index=2;
            testCase.pump.pauseinjection();
            testCase.verifyEqual(testCase.pump.amount(testCase.pump.index),0);
            testCase.verifyEqual(testCase.pump.amountd(testCase.pump.indexd),0);
            testCase.verifyEqual(testCase.pump.PressAvailable , 0);
        end
    end
    
end