classdef test < matlab.uitest.TestCase
    properties
        f1app
        f2app
        f3app
        e1app
        e2app
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            %rename each .m and .mlapp files 
testCase.f1app=ButtonPanel_f1;
testCase.f2app=ButtonPanel_f2;
testCase.f3app=ButtonPanel_f3;
testCase.e1app=ButtonPanel_e;
testCase.e2app=ButtonPanel_e;
c=ElevatorController;
elev=Elevator;
fS=FloorSensor;
dS=DoorSensor;
eS=EmergSensor;

%change e1app's position
testCase.e1app.UIFigure.Position(1)=testCase.e1app.UIFigure.Position(1)-296;

%set ElevatorController.m's properties
c.f1=testCase.f1app;
c.f2=testCase.f2app;
c.f3=testCase.f3app;
c.e1=testCase.e1app;
c.e2=testCase.e2app;
c.elevator=elev;
c.fSensor=fS;
c.dSensor=dS;
c.emSensor=eS;

%set Elevator.m's properties
elev.f1=testCase.f1app;
elev.f2=testCase.f2app;
elev.f3=testCase.f3app;
elev.e1=testCase.e1app;
elev.e2=testCase.e2app;
elev.control=c;
elev.fSensor=fS;

%set the .mlapp files' properties
testCase.f1app.control=c;
testCase.f2app.control=c;
testCase.f3app.control=c;
testCase.e1app.control=c;
testCase.e1app.fSensor=fS;
testCase.e2app.control=c;
testCase.e2app.fSensor=fS;

%set the ButtonPanel_e tags
testCase.e1app.num=1;
testCase.e1app.EditField.Value='Elevator 1';
testCase.e2app.num=2;
testCase.e2app.EditField.Value='Elevator 2';

%set the time of passing half floor to each ButtonPanel_e 
elev.etime=elev.floor_height/2/elev.speed;
            testCase.addTeardown(@delete,testCase.e2app);
            testCase.addTeardown(@delete,testCase.e1app);
            testCase.addTeardown(@delete,testCase.f3app);
            testCase.addTeardown(@delete,testCase.f2app);
            testCase.addTeardown(@delete,testCase.f1app);
        end
    end
    methods (Test)
        function test_elevator(testCase)
            %以电梯1为例，展示电梯1里面按钮的功能。假设测试者站在电梯1里面，依次
            %按下一楼、二楼、三楼、二楼、一楼的按钮，让电梯1走个来回。
            pause(1);
            %由于电梯本来就停在1楼，按1层的按钮是没有反应的。防止乘客发生误操作。
            testCase.press(testCase.e1app.Button_1);
            pause(3);
            testCase.press(testCase.e1app.Button_2);
            testCase.press(testCase.e1app.Button_3);
            testCase.press(testCase.e1app.Button_2);
            testCase.press(testCase.e1app.Button_1);
            %展示分配电梯去接人的效果。先把电梯2升到二楼。
            testCase.press(testCase.e2app.Button_2);
            pause(3);
            %按下三楼的“向下”按钮，比较近的电梯2升到三楼。
            testCase.press(testCase.f3app.downButton);
            %按下二楼的“向上”按钮，电梯1升到二楼。（电梯1在一楼，电梯2在
            %三楼。由于两个电梯离得一样近，移动哪一个都行，这里我默认移动的电梯1。）
            testCase.press(testCase.f2app.upButton);
            %按下一楼的“向上”按钮，比较近的电梯1降到2楼。
            testCase.press(testCase.f1app.upButton);
            pause(1);
            %以电梯1为例，展示当电梯停下时的开门按钮效果。
            testCase.press(testCase.e1app.openButton);
            %以电梯2为例，展示当电梯停下时的紧急按钮效果。
            testCase.press(testCase.e2app.EmergencyButton);
        end
        
    end
    
    
    
end