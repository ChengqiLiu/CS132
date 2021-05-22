classdef TestSelfMenuApp < matlab.uitest.TestCase
    % for presentation
    properties
        App
        chessboard
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            testCase.chessboard = ChessBoard;
            testCase.App = selfMenu(testCase.chessboard);
            testCase.chessboard.selfUI = testCase.App;
        end
    end
    methods (Test)
        function test_Reset(testCase) %T1.1
            % State: Reset the setted chessboard
            % Execution:Place some chess and Reset the chessboard
            % Expected Output: The matrix in chessboard is all zero
            testCase.press(testCase.App.B3_2);
            testCase.press(testCase.App.B1_1);
            testCase.press(testCase.App.B1_4);
            testCase.press(testCase.App.B4_1);
            testCase.press(testCase.App.B3_4);
            % Press Reset
            testCase.press(testCase.App.Reset);
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.matrix,[0,0,0,0;
                          0,0,0,0;
                          0,0,0,0;
                          0,0,0,0;
                          0,0,0,0;]);
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_StartGameOff(testCase) %T1.2
            % State: The StartGame button should not be available before
            % all chess placed 
            % Execution:Place some chess and check StartGame button
            % Expected Output: The StartGame's Enable be 'off'
            testCase.press(testCase.App.B3_2);
            testCase.press(testCase.App.B1_1);
            testCase.press(testCase.App.B1_4);
            testCase.press(testCase.App.B4_1);
            testCase.press(testCase.App.B3_4);
            % Check expected output
            testCase.verifyEqual(testCase.App.StartGame.Enable,'off');
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_StartGameOn(testCase) %T1.3
            % State: The StartGame button should be available after
            % all chess placed 
            % Execution:Place all chess and check StartGame button
            % Expected Output: The StartGame's Enable be 'on'
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
            % Check expected output
            testCase.verifyEqual(testCase.App.StartGame.Enable,'on');
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_PressValidation(testCase) %T1.4
            % State: Check whether the chess is placed when pressing a
            % setted block
            % Check when pressing a unsetted block, whether the chess is
            % placed if there exists enough space and
            % whether the chess is placed if there not exists enough space
            % Execution:Place chess at settled block. Place chess at
            % unsettled block with enough space.  Place chess at
            % unsettled block without enough space
            % Check whether the chess is placed and next chess is going
            % to be placed
            % Expected Output: The chess is still the former chess, if the
            % press is invalid. The chess is the next chess, if the
            % press is valid.
            
            %test Caocao 2*2chess
            %press is invalid
            %Caocao's position is invalid
            testCase.press(testCase.App.B2_4);
            testCase.press(testCase.App.B5_2);
            testCase.press(testCase.App.B5_4);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 曹操');
            %press is valid
            %Caocao's position is valid
            testCase.press(testCase.App.B3_2);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 张飞');
            
            
            %test Macao 1*2chess
            %press is invalid
            %Zhangfei's position is invalid
            testCase.press(testCase.App.B2_2);
            testCase.press(testCase.App.B3_2);
            testCase.press(testCase.App.B4_3);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 张飞');
            %press is valid
            %Zhangfei's position is valid
            testCase.press(testCase.App.B1_1);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 赵云');
            
            
            testCase.press(testCase.App.B1_4);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 黄忠');
            testCase.press(testCase.App.B4_1);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 马超');
            testCase.press(testCase.App.B3_4);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 关羽');
            
            
            %test Guanyu 2*1chess
            %press is invalid
            %Guanyu's position is invalid
            testCase.press(testCase.App.B3_2);
            testCase.press(testCase.App.B3_1);
            testCase.press(testCase.App.B5_1);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 关羽');
            %press is valid
            %Guanyu's position is valid
            testCase.press(testCase.App.B1_2);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 卒1');
            
            
            %test Zu1 1*1chess
            %press is invalid
            %Zu1's position is invalid
            testCase.press(testCase.App.B1_2);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 卒1');
            %press is valid
            %Zu1's position is valid
            testCase.press(testCase.App.B2_2);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 卒2');
            
            
            testCase.press(testCase.App.B2_3);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 卒3');
            testCase.press(testCase.App.B3_1);
            % Check expected output
            testCase.verifyEqual(testCase.App.CurrentRole.Text,'当前角色: 卒4');
            testCase.press(testCase.App.B5_4);
            
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_StartGame_JumpMaininterface(testCase) %T1.5
            % State: Place all chess then can press StartGame to jump to
            % maininterface
            % Execution:Place all chess and press StartGame
            % Expected Output: The maininterface in chessboard is the
            % the handel of mainInterface
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
            % Check expected output
            testCase.verifyEqual(class(testCase.chessboard.mainInterfaceUI),class(mainInterface(testCase.chessboard,1)));
        end
        
        
        function test_placeChess_chessboardUpdate(testCase) %T1.6
            % State: Place chess and chessboard will update 
            % Execution:Place chess and check data
            % Expected Output: The position of chess is the pressed place 
            testCase.press(testCase.App.B3_2);
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.Cao_row,[3,4]);
            testCase.verifyEqual(testCase.chessboard.Cao_col,[2,3]);
            testCase.verifyEqual(testCase.chessboard.matrix,[0,0,0,0;
                          0,0,0,0;
                          0,1,1,0;
                          0,1,1,0;
                          0,0,0,0;]);
            testCase.press(testCase.App.B1_1);
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.ZhangFei_row,[1,2]);
            testCase.verifyEqual(testCase.chessboard.ZhangFei_col,1);
            testCase.verifyEqual(testCase.chessboard.matrix,[1,0,0,0;
                          1,0,0,0;
                          0,1,1,0;
                          0,1,1,0;
                          0,0,0,0;]);
            testCase.press(testCase.App.B1_4);
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_row,[1,2]);
            testCase.verifyEqual(testCase.chessboard.ZhaoYun_col,4);
            testCase.verifyEqual(testCase.chessboard.matrix,[1,0,0,1;
                          1,0,0,1;
                          0,1,1,0;
                          0,1,1,0;
                          0,0,0,0;]);
            testCase.press(testCase.App.B4_1);
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.HuangZhong_row,[4,5]);
            testCase.verifyEqual(testCase.chessboard.HuangZhong_col,1);
            testCase.verifyEqual(testCase.chessboard.matrix,[1,0,0,1;
                          1,0,0,1;
                          0,1,1,0;
                          1,1,1,0;
                          1,0,0,0;]);
            testCase.press(testCase.App.B3_4);
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.MaChao_row,[3,4]);
            testCase.verifyEqual(testCase.chessboard.MaChao_col,4);
            testCase.verifyEqual(testCase.chessboard.matrix,[1,0,0,1;
                          1,0,0,1;
                          0,1,1,1;
                          1,1,1,1;
                          1,0,0,0;]);
            testCase.press(testCase.App.B1_2);
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.GuanYu_row,1);
            testCase.verifyEqual(testCase.chessboard.GuanYu_col,[2,3]);
            testCase.verifyEqual(testCase.chessboard.matrix,[1,1,1,1;
                          1,0,0,1;
                          0,1,1,1;
                          1,1,1,1;
                          1,0,0,0;]);
            testCase.press(testCase.App.B2_2);
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.Soldier_1_row,2);
            testCase.verifyEqual(testCase.chessboard.Soldier_1_col,2);
            testCase.verifyEqual(testCase.chessboard.matrix,[1,1,1,1;
                          1,1,0,1;
                          0,1,1,1;
                          1,1,1,1;
                          1,0,0,0;]);
            testCase.press(testCase.App.B2_3);
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.Soldier_2_row,2);
            testCase.verifyEqual(testCase.chessboard.Soldier_2_col,3);
            testCase.verifyEqual(testCase.chessboard.matrix,[1,1,1,1;
                          1,1,1,1;
                          0,1,1,1;
                          1,1,1,1;
                          1,0,0,0;]);
            testCase.press(testCase.App.B3_1);
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.Soldier_3_row,3);
            testCase.verifyEqual(testCase.chessboard.Soldier_3_col,1);
            testCase.verifyEqual(testCase.chessboard.matrix,[1,1,1,1;
                          1,1,1,1;
                          1,1,1,1;
                          1,1,1,1;
                          1,0,0,0;]);
            testCase.press(testCase.App.B5_4);
            % Check expected output
            testCase.verifyEqual(testCase.chessboard.Soldier_4_row,5);
            testCase.verifyEqual(testCase.chessboard.Soldier_4_col,4);
            testCase.verifyEqual(testCase.chessboard.matrix,[1,1,1,1;
                          1,1,1,1;
                          1,1,1,1;
                          1,1,1,1;
                          1,0,0,1;]);
            testCase.addTeardown(@delete,testCase.App);
        end
        
        function test_RetMainMenu(testCase) %T1.7
            % State: Can return to MainMenu
            % Execution:Press RetainMainMenu button
            % Expected Output: A mainMenu jump out.Chessboard' mainMenu
            % is setted
            testCase.press(testCase.App.RetMainMenu);
            % Check expected output
            testCase.verifyEqual(class(testCase.chessboard.mainMenu),class(mainMenu(testCase.chessboard)));
            testCase.addTeardown(@delete,testCase.chessboard.mainMenu);
        end
    end
end