classdef TestMainInterfaceApp < matlab.uitest.TestCase
    % for presentation
    properties
        App
        maininterface
        chessboard
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            testCase.chessboard = ChessBoard;
            testCase.App = selfMenu(testCase.chessboard);
            testCase.chessboard.selfUI = testCase.App;
            testCase.press(testCase.App.B3_2);
            testCase.press(testCase.App.B1_1);
            testCase.press(testCase.App.B1_4);
            testCase.press(testCase.App.B4_1);
            testCase.press(testCase.App.B3_4);
            testCase.press(testCase.App.B1_2);
            testCase.press(testCase.App.B2_2);
            testCase.press(testCase.App.B2_3);
            testCase.press(testCase.App.B3_1);
            testCase.press(testCase.App.B5_4);
            testCase.press(testCase.App.StartGame);
            testCase.maininterface = testCase.chessboard.mainInterfaceUI;
            %testCase.press(testCase.maininterface.);
        end
    end
    methods (Test)
        function test_Chess_not_Moveout(testCase) %T2.1
            % State: Chess cannot move out of chessboard
            % Execution:Move chess at bound out of chessboard
            % Expected Output: The matrix in chessboard is all zero
            testCase.press(testCase.maininterface.Soldier_4);
            testCase.press(testCase.maininterface.Down);
            testCase.verifyEqual(testCase.chessboard.Soldier_4_row,5);
            testCase.verifyEqual(testCase.chessboard.Soldier_4_col,4);
            
            testCase.press(testCase.maininterface.GuanYu);
            testCase.press(testCase.maininterface.Up);
            testCase.verifyEqual(testCase.chessboard.GuanYu_row,1);
            testCase.verifyEqual(testCase.chessboard.GuanYu_col,[2,3]);
            
            testCase.press(testCase.maininterface.ZhangFei);
            testCase.press(testCase.maininterface.Left);
            testCase.verifyEqual(testCase.chessboard.ZhangFei_row,[1,2]);
            testCase.verifyEqual(testCase.chessboard.ZhangFei_col,1);
            
            testCase.press(testCase.maininterface.MaChao);
            testCase.press(testCase.maininterface.Right);
            testCase.verifyEqual(testCase.chessboard.MaChao_row,[3,4]);
            testCase.verifyEqual(testCase.chessboard.MaChao_col,4);
            
            
            testCase.press(testCase.maininterface.Soldier_3);
            testCase.press(testCase.maininterface.Left);
            testCase.verifyEqual(testCase.chessboard.Soldier_3_row,3);
            testCase.verifyEqual(testCase.chessboard.Soldier_3_col,1);
            
            
            testCase.press(testCase.maininterface.HuangZhong);
            testCase.press(testCase.maininterface.Right);
            
            testCase.verifyEqual(testCase.chessboard.HuangZhong_row,[4,5]);
            testCase.verifyEqual(testCase.chessboard.HuangZhong_col,1);
            testCase.press(testCase.maininterface.Down);
            testCase.verifyEqual(testCase.chessboard.HuangZhong_row,[4,5]);
            testCase.verifyEqual(testCase.chessboard.HuangZhong_col,1);
            
            testCase.addTeardown(@delete,testCase.maininterface);
        end
        
        function test_Success(testCase) %T2.2
            % State: Cao move to [4,2][4,2][5,2][5,3], player wins
            % Execution:Press Cao, press down
            % Expected Output: Show WinWindow
            testCase.press(testCase.maininterface.Cao);
            testCase.press(testCase.maininterface.Down);
            testCase.verifyEqual(class(testCase.chessboard.WinUI),class(WinWindow(testCase.maininterface,testCase.chessboard)));
            testCase.addTeardown(@delete,testCase.maininterface);
        end
    end
end
        
        