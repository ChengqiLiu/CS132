classdef TestMainMenuApp < matlab.uitest.TestCase
    % for presentation
    properties
        App1
        App
        chessboard
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            testCase.chessboard = ChessBoard;
            testCase.App1 = mainMenu(testCase.chessboard);
            testCase.chessboard.mainMenu = testCase.App1;
        end
    end
    methods (Test)
        function test_Choose1(testCase) %T3.1
            % State: Can get 9 basic form and start game with the chosen
            % form
            % Execution:Choose testCase.App1.DropDown '横刀立马'
            % Expected Output: The matrix and chesses's position in
            % chessboard equal to setting, mainInterface id setted
            testCase.choose(testCase.App1.DropDown,'横刀立马');
            testCase.press(testCase.App1.Start);
            testCase.App = testCase.chessboard.mainInterfaceUI;
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.matrix,[1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;1, 0, 0, 1])
            testCase.verifyEqual(testCase.chessboard.Cao_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_row,[3,4])
            testCase.verifyEqual(testCase.chessboard.HuangZhong_row,[3,4])
            testCase.verifyEqual(testCase.chessboard.MaChao_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.GuanYu_row,3)
            testCase.verifyEqual(testCase.chessboard.Soldier_1_row,5)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_row,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_row,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_row,5)
            testCase.verifyEqual(testCase.chessboard.Cao_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_col,1)
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_col,1)
            testCase.verifyEqual(testCase.chessboard.HuangZhong_col,4)
            testCase.verifyEqual(testCase.chessboard.MaChao_col,4)
            testCase.verifyEqual(testCase.chessboard.GuanYu_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.Soldier_1_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_col,2)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_col,3)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_col,4)
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_Choose2(testCase) %T3.2
            % State: Can get 9 basic form 
            % Execution:Choose testCase.App1.DropDown 
            % Expected Output: The matrix and chesses's position in
            % chessboard equal to setting
            testCase.choose(testCase.App1.DropDown,'横刀立马');
            testCase.choose(testCase.App1.DropDown,'左右布兵');
            testCase.press(testCase.App1.Start);
            testCase.App = testCase.chessboard.mainInterfaceUI;
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.matrix,[1, 1, 1, 1;1, 1, 1, 1;0, 1, 1, 0;1, 1, 1, 1;1, 1, 1, 1])
            testCase.verifyEqual(testCase.chessboard.Cao_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.HuangZhong_row,[3,4])
            testCase.verifyEqual(testCase.chessboard.MaChao_row,[3,4])
            testCase.verifyEqual(testCase.chessboard.GuanYu_row,5)
            testCase.verifyEqual(testCase.chessboard.Soldier_1_row,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_row,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_row,5)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_row,5)
            testCase.verifyEqual(testCase.chessboard.Cao_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_col,1)
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_col,4)
            testCase.verifyEqual(testCase.chessboard.HuangZhong_col,2)
            testCase.verifyEqual(testCase.chessboard.MaChao_col,3)
            testCase.verifyEqual(testCase.chessboard.GuanYu_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.Soldier_1_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_col,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_col,4)
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_Choose3(testCase) %T3.3
            % State: Can get 9 basic form 
            % Execution:Choose testCase.App1.DropDown.
            % Expected Output: The matrix and chesses's position in
            % chessboard equal to setting
            testCase.choose(testCase.App1.DropDown,'兵分三路');
            testCase.press(testCase.App1.Start);
            testCase.App = testCase.chessboard.mainInterfaceUI;
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.matrix,[1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;1, 0, 0, 1])
            testCase.verifyEqual(testCase.chessboard.Cao_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_row,[2,3])
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_row,[2,3])
            testCase.verifyEqual(testCase.chessboard.HuangZhong_row,[4,5])
            testCase.verifyEqual(testCase.chessboard.MaChao_row,[4,5])
            testCase.verifyEqual(testCase.chessboard.GuanYu_row,3)
            testCase.verifyEqual(testCase.chessboard.Soldier_1_row,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_row,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_row,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_row,4)
            testCase.verifyEqual(testCase.chessboard.Cao_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_col,1)
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_col,4)
            testCase.verifyEqual(testCase.chessboard.HuangZhong_col,1)
            testCase.verifyEqual(testCase.chessboard.MaChao_col,4)
            testCase.verifyEqual(testCase.chessboard.GuanYu_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.Soldier_1_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_col,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_col,2)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_col,3)
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_Choose4(testCase) %T3.4
            % State: Can get 9 basic form 
            % Execution:Choose testCase.App1.DropDown.
            % Expected Output: The matrix and chesses's position in
            % chessboard equal to setting
            testCase.choose(testCase.App1.DropDown,'兵来将阻');
            testCase.press(testCase.App1.Start);
            testCase.App = testCase.chessboard.mainInterfaceUI;
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.matrix,[1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1; 0, 1, 1, 0])
            testCase.verifyEqual(testCase.chessboard.Cao_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_row,5)
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_row,4)
            testCase.verifyEqual(testCase.chessboard.HuangZhong_row,[2,3])
            testCase.verifyEqual(testCase.chessboard.MaChao_row,[2,3])
            testCase.verifyEqual(testCase.chessboard.GuanYu_row,3)
            testCase.verifyEqual(testCase.chessboard.Soldier_1_row,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_row,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_row,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_row,4)
            testCase.verifyEqual(testCase.chessboard.Cao_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.HuangZhong_col,1)
            testCase.verifyEqual(testCase.chessboard.MaChao_col,4)
            testCase.verifyEqual(testCase.chessboard.GuanYu_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.Soldier_1_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_col,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_col,4)
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_Choose5(testCase) %T3.5
            % State: Can get 9 basic form 
            % Execution:Choose testCase.App1.DropDown.
            % Expected Output: The matrix and chesses's position in
            % chessboard equal to setting
            testCase.choose(testCase.App1.DropDown,'层层设防');
            testCase.press(testCase.App1.Start);
            testCase.App = testCase.chessboard.mainInterfaceUI;
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.matrix,[1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;0, 1, 1, 0])
            testCase.verifyEqual(testCase.chessboard.Cao_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_row,4)
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_row,5)
            testCase.verifyEqual(testCase.chessboard.HuangZhong_row,[3,4])
            testCase.verifyEqual(testCase.chessboard.MaChao_row,[3,4])
            testCase.verifyEqual(testCase.chessboard.GuanYu_row,3)
            testCase.verifyEqual(testCase.chessboard.Soldier_1_row,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_row,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_row,2)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_row,2)
            testCase.verifyEqual(testCase.chessboard.Cao_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_col,[3,4])
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.HuangZhong_col,1)
            testCase.verifyEqual(testCase.chessboard.MaChao_col,2)
            testCase.verifyEqual(testCase.chessboard.GuanYu_col,[3,4])
            testCase.verifyEqual(testCase.chessboard.Soldier_1_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_col,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_col,4)
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_Choose6(testCase) %T3.6
            % State: Can get 9 basic form 
            % Execution:Choose testCase.App1.DropDown.
            % Expected Output: The matrix and chesses's position in
            % chessboard equal to setting
            testCase.choose(testCase.App1.DropDown,'插翅难飞');
            testCase.press(testCase.App1.Start);
            testCase.App = testCase.chessboard.mainInterfaceUI;
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.matrix,[1, 1, 1, 1;1, 1, 1, 1;1, 1, 0, 1;1, 1, 0, 1;1, 1, 1, 1])
            testCase.verifyEqual(testCase.chessboard.Cao_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_row,5)
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.HuangZhong_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.MaChao_row,[3,4])
            testCase.verifyEqual(testCase.chessboard.GuanYu_row,5)
            testCase.verifyEqual(testCase.chessboard.Soldier_1_row,3)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_row,3)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_row,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_row,4)
            testCase.verifyEqual(testCase.chessboard.Cao_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_col,[3,4])
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_col,1)
            testCase.verifyEqual(testCase.chessboard.HuangZhong_col,4)
            testCase.verifyEqual(testCase.chessboard.MaChao_col,2)
            testCase.verifyEqual(testCase.chessboard.GuanYu_col,[1,2])
            testCase.verifyEqual(testCase.chessboard.Soldier_1_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_col,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_col,4)
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_Choose7(testCase) %T3.7
            % State: Can get 9 basic form 
            % Execution:Choose testCase.App1.DropDown.
            % Expected Output: The matrix and chesses's position in
            % chessboard equal to setting
            testCase.choose(testCase.App1.DropDown,'过五关 ');
            testCase.press(testCase.App1.Start);
            testCase.App = testCase.chessboard.mainInterfaceUI;
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.matrix,[1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;0, 1, 1, 0])
            testCase.verifyEqual(testCase.chessboard.Cao_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_row,3)
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_row,3)
            testCase.verifyEqual(testCase.chessboard.HuangZhong_row,4)
            testCase.verifyEqual(testCase.chessboard.MaChao_row,4)
            testCase.verifyEqual(testCase.chessboard.GuanYu_row,5)
            testCase.verifyEqual(testCase.chessboard.Soldier_1_row,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_row,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_row,2)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_row,2)
            testCase.verifyEqual(testCase.chessboard.Cao_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_col,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_col,[3,4])
            testCase.verifyEqual(testCase.chessboard.HuangZhong_col,[3,4])
            testCase.verifyEqual(testCase.chessboard.MaChao_col,[1,2])
            testCase.verifyEqual(testCase.chessboard.GuanYu_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.Soldier_1_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_col,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_col,4)
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_Choose8(testCase) %T3.8
            % State: Can get 9 basic form 
            % Execution:Choose testCase.App1.DropDown.
            % Expected Output: The matrix and chesses's position in
            % chessboard equal to setting
            testCase.choose(testCase.App1.DropDown,'近在咫尺');
            testCase.press(testCase.App1.Start);
            testCase.App = testCase.chessboard.mainInterfaceUI;
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.matrix,[1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;0, 0, 1, 1])
            testCase.verifyEqual(testCase.chessboard.Cao_row,[4,5])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.HuangZhong_row,3)
            testCase.verifyEqual(testCase.chessboard.MaChao_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.GuanYu_row,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_1_row,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_row,2)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_row,3)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_row,3)
            testCase.verifyEqual(testCase.chessboard.Cao_col,[3,4])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_col,2)
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_col,3)
            testCase.verifyEqual(testCase.chessboard.HuangZhong_col,[1,2])
            testCase.verifyEqual(testCase.chessboard.MaChao_col,4)
            testCase.verifyEqual(testCase.chessboard.GuanYu_col,[1,2])
            testCase.verifyEqual(testCase.chessboard.Soldier_1_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_col,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_col,3)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_col,4)
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_Choose9(testCase) %T3.9
            % State: Can get 9 basic form 
            % Execution:Choose testCase.App1.DropDown.
            % Expected Output: The matrix and chesses's position in
            % chessboard equal to setting
            testCase.choose(testCase.App1.DropDown,'前挡后阻');
            testCase.press(testCase.App1.Start);
            testCase.App = testCase.chessboard.mainInterfaceUI;
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.matrix,[1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;1, 1, 1, 1;0, 1, 1, 0])
            testCase.verifyEqual(testCase.chessboard.Cao_row,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_row,5)
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_row,[3,4])
            testCase.verifyEqual(testCase.chessboard.HuangZhong_row,[3,4])
            testCase.verifyEqual(testCase.chessboard.MaChao_row,[2,3])
            testCase.verifyEqual(testCase.chessboard.GuanYu_row,1)
            testCase.verifyEqual(testCase.chessboard.Soldier_1_row,2)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_row,3)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_row,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_row,4)
            testCase.verifyEqual(testCase.chessboard.Cao_col,[1,2])
            testCase.verifyEqual(testCase.chessboard.ZhangFei_col,[2,3])
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_col,1)
            testCase.verifyEqual(testCase.chessboard.HuangZhong_col,2)
            testCase.verifyEqual(testCase.chessboard.MaChao_col,3)
            testCase.verifyEqual(testCase.chessboard.GuanYu_col,[3,4])
            testCase.verifyEqual(testCase.chessboard.Soldier_1_col,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_2_col,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_3_col,4)
            testCase.verifyEqual(testCase.chessboard.Soldier_4_col,3)
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_StartGameOff(testCase) %T3.10
            % State: Can jump to Selfmenu
            % Execution:Press User
            % Expected Output: The selfUI inchessboard setted
            testCase.verifyEqual(testCase.chessboard.selfUI,[]);
            testCase.press(testCase.App1.User);
            testCase.App = testCase.chessboard.selfUI;
            % Check expected output
            testCase.verifyEqual(class(testCase.chessboard.selfUI),class(selfMenu(testCase.chessboard)));
            testCase.addTeardown(@delete,testCase.App);
        end
    end
end