classdef PlayAPP < matlab.uitest.TestCase
    % for presentation
    properties
        App
        App1
        chessboard
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            testCase.chessboard = ChessBoard;
            testCase.App1 = mainMenu(testCase.chessboard);
            testCase.App1.m_chessboard = testCase.chessboard;
        end
    end
    methods (Test)
        function test_PutInAll(testCase) %T2.1
            pause(0.7);
            testCase.choose(testCase.App1.DropDown,'×óÓÒ²¼±ø');
            pause(1);
            testCase.press(testCase.App1.Start);
            pause(2);
            testCase.addTeardown(@delete,testCase.chessboard.mainInterfaceUI);
            testCase.press(testCase.chessboard.mainInterfaceUI.RetMain);
        end
        function test_self(testCase)
            pause(2);
            testCase.press(testCase.App1.User);
            pause(0.3);
            testCase.App = testCase.chessboard.selfUI;
            
            testCase.press(testCase.App.B3_2);
            pause(0.8);
            testCase.press(testCase.App.B1_1);
            pause(0.8);
            testCase.press(testCase.App.Reset);
            pause(0.8);
            
            testCase.press(testCase.App.B3_2);
            pause(0.8);
            testCase.press(testCase.App.B1_1);
            pause(0.8);
            testCase.press(testCase.App.B1_4);
            pause(0.8);
            testCase.press(testCase.App.B4_1);
            pause(0.8);
            testCase.press(testCase.App.B3_4);
            pause(0.8);
            testCase.press(testCase.App.B1_2);
            pause(0.8);
            testCase.press(testCase.App.B3_1);
            pause(0.8);
            testCase.press(testCase.App.B5_4);
            pause(1);
            testCase.press(testCase.App.B1_3);
            pause(1.5);
            testCase.press(testCase.App.B2_3);
            pause(0.8);
            testCase.press(testCase.App.B2_2);
            pause(0.8);
            
            testCase.press(testCase.App.StartGame);
            pause(0.8);
            
            testCase.press(testCase.chessboard.mainInterfaceUI.Soldier_2);
            pause(0.8);
            testCase.press(testCase.chessboard.mainInterfaceUI.Right);
            pause(0.8);
            testCase.press(testCase.chessboard.mainInterfaceUI.Left);
            pause(0.8);
            
            testCase.press(testCase.chessboard.mainInterfaceUI.MaChao);
            pause(0.8);
            testCase.press(testCase.chessboard.mainInterfaceUI.Down);
            pause(0.8);
            
            testCase.press(testCase.chessboard.mainInterfaceUI.Reset);
            pause(0.8);
            
            testCase.press(testCase.chessboard.mainInterfaceUI.Cao);
            pause(0.8);
            testCase.press(testCase.chessboard.mainInterfaceUI.Down);
            pause(1);
            
            testCase.addTeardown(@delete,testCase.chessboard.mainInterfaceUI);
        end
    end
end