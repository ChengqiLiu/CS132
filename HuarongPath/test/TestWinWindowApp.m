classdef TestWinWindowApp < matlab.uitest.TestCase
    % for presentation
    properties
        App
        chessboard
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            testCase.chessboard = ChessBoard;
            testCase.chessboard.matrix=[1,1,1,1;
                          1,1,1,1;
                          1,1,1,1;
                          1,0,0,1;
                          1,1,1,1;];
            testCase.chessboard.Cao_row=[4,5];
            testCase.chessboard.Cao_col=[2,3];
            testCase.chessboard.ZhangFei_row=[1,2];
            testCase.chessboard.ZhangFei_col=1;
            testCase.chessboard.ZhaoYun_row=[1,2];
            testCase.chessboard.ZhaoYun_col=4;
            testCase.chessboard.HuangZhong_row=[4,5];
            testCase.chessboard.HuangZhong_col=1;
            testCase.chessboard.MaChao_row=[3,4];
            testCase.chessboard.MaChao_col=4;
            testCase.chessboard.GuanYu_row=1;
            testCase.chessboard.GuanYu_col=[2,3];
            testCase.chessboard.Soldier_1_row=2;
            testCase.chessboard.Soldier_1_col=2;
            testCase.chessboard.Soldier_2_row=2;
            testCase.chessboard.Soldier_2_col=3;
            testCase.chessboard.Soldier_3_row=3;
            testCase.chessboard.Soldier_3_col=1;
            testCase.chessboard.Soldier_4_row=5;
            testCase.chessboard.Soldier_4_col=4;
            testCase.App = WinWindow(mainInterface(testCase.chessboard,1),testCase.chessboard);
            testCase.chessboard.WinUI = testCase.App;
            %testCase.press(testCase.maininterface.);
        end
    end
    methods (Test)
        function test_Yes(testCase) %T3.1
            % State: Press button can play another round
            % Execution:Press yes
            % Expected Output: Show mainMenu
            testCase.press(testCase.App.Button);
            testCase.verifyEqual(class(testCase.chessboard.mainMenu),class(mainMenu(testCase.chessboard)))
        end
        function test_No(testCase) %T3.2
            % State: Press button_2 can leave
            % Execution:Press no
            % Expected Output: Delete winWindow 
            testCase.press(testCase.App.Button_2);
            testCase.verifyEqual(testCase.chessboard.WinUI,delete(testCase.App));
        end
    end
end