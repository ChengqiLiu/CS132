classdef Elevator < handle
    
    properties
        f1        %ButtonPanel_f1.mlapp
        f2        %ButtonPanel_f2.mlapp
        f3        %ButtonPanel_f3.mlapp
        e1        %ButtonPanel_e.mlapp
        e2        %ButtonPanel_e.mlapp
        control   %ElevatorController.m
        fSensor         %FloorSensor.m
        floor_height=3;  %meter
        speed=3;         %m/s
        dooropentime=2;  %the time (second) of opening door
        etime            %the time (second) of elevator passing half of a floor
    end
    
    methods
        function updateFloor(elevator,enum)
        %This function makes the Gauge value of the given elevator the same to
        %its physical environment.Input is the elevator tag.
            switch enum
                case 1
                    fl1=elevator.fSensor.f_e1;
                    elevator.e1.ElevatorGauge.Value=fl1;
                    elevator.f1.Elevator1Gauge.Value=fl1;
                    elevator.f2.Elevator1Gauge.Value=fl1;
                    elevator.f3.Elevator1Gauge.Value=fl1;
                case 2
                    fl2=elevator.fSensor.f_e2;
                    elevator.e2.ElevatorGauge.Value=fl2;
                    elevator.f1.Elevator2Gauge.Value=fl2;
                    elevator.f2.Elevator2Gauge.Value=fl2;
                    elevator.f3.Elevator2Gauge.Value=fl2;
            end
        end
        
        function openLamp(elevator,enum)
        %This function open the yellow lamp on the floor, given the number of
        %elevator.
            switch enum
                case 1
                    if elevator.fSensor.f_e1<1.01
                        elevator.f1.up1Lamp.Color=[1 1 0];
                    elseif elevator.fSensor.f_e1>1.99 && elevator.fSensor.f_e1<2.01
                        if elevator.control.task(1,3)==1
                            elevator.f2.down1Lamp.Color=[1 1 0];
                        elseif elevator.control.task(1,2)==1
                            elevator.f2.up1Lamp.Color=[1 1 0];
                        end
                    elseif elevator.fSensor.f_e1>2.99
                        elevator.f3.down1Lamp.Color=[1 1 0];
                    end
                case 2
                    if elevator.fSensor.f_e2<1.01
                        elevator.f1.up2Lamp.Color=[1 1 0];
                    elseif elevator.fSensor.f_e2>1.99 && elevator.fSensor.f_e2<2.01
                        if elevator.control.task(2,3)==1
                            elevator.f2.down2Lamp.Color=[1 1 0];
                        elseif elevator.control.task(2,2)==1
                            elevator.f2.up2Lamp.Color=[1 1 0];
                        end
                    elseif elevator.fSensor.f_e2>2.99
                        elevator.f3.down2Lamp.Color=[1 1 0];
                    end
            end
        end
        
        function closeLamp(elevator,enum)
        %This function close the yellow lamp on the floor, given the number of
        %elevator.
            switch enum
                case 1
                    if elevator.fSensor.f_e1<1.01
                        elevator.f1.up1Lamp.Color=[0.65 0.65 0.6];
                    elseif elevator.fSensor.f_e1>1.99 && elevator.fSensor.f_e1<2.01
                        if elevator.control.task(1,3)==1
                            elevator.f2.down1Lamp.Color=[0.65 0.65 0.6];
                        elseif elevator.control.task(1,2)==1
                            elevator.f2.up1Lamp.Color=[0.65 0.65 0.6];
                        end
                    elseif elevator.fSensor.f_e1>2.99
                        elevator.f3.down1Lamp.Color=[0.65 0.65 0.6];
                    end
                case 2
                    if elevator.fSensor.f_e2<1.01
                        elevator.f1.up2Lamp.Color=[0.65 0.65 0.6];
                    elseif elevator.fSensor.f_e2>1.99 && elevator.fSensor.f_e2<2.01
                        if elevator.control.task(2,3)==1
                            elevator.f2.down2Lamp.Color=[0.65 0.65 0.6];
                        elseif elevator.control.task(2,2)==1
                            elevator.f2.up2Lamp.Color=[0.65 0.65 0.6];
                        end
                    elseif elevator.fSensor.f_e2>2.99
                        elevator.f3.down2Lamp.Color=[0.65 0.65 0.6];
                    end
            end
        end
        
        function updateEleLamp(elevator,enum)
        %This function makes the Lamp inside the given elevator the same to
        %its physical environment. Input is the elevator tag.
            switch enum
                case 1
                    switch elevator.e1.status
                        case 0
                            elevator.e1.upLamp.Color=[0.65 0.65 0.6];
                            elevator.e1.downLamp.Color=[0.65 0.65 0.6];
                        case 1
                            elevator.e1.upLamp.Color='g';
                            elevator.e1.downLamp.Color=[0.65 0.65 0.6];
                        case 2
                            elevator.e1.upLamp.Color=[0.65 0.65 0.6];
                            elevator.e1.downLamp.Color='g';
                    end
                case 2
                    switch elevator.e2.status
                        case 0
                            elevator.e2.upLamp.Color=[0.65 0.65 0.6];
                            elevator.e2.downLamp.Color=[0.65 0.65 0.6];
                        case 1
                            elevator.e2.upLamp.Color='g';
                            elevator.e2.downLamp.Color=[0.65 0.65 0.6];
                        case 2
                            elevator.e2.upLamp.Color=[0.65 0.65 0.6];
                            elevator.e2.downLamp.Color='g';
                    end
            end
        end
        
        function openDoor(elevator,enum,floor)
        %This function opens the given floor's door of each elevator. Input
        %is the elevator's tag and its floor.
            switch enum
                case 1
                    elevator.e1.doorImage.ImageSource='open_e.png';
                    switch floor
                        case 1
                            elevator.f1.door1Image.ImageSource='open_f.png';
                        case 2
                            elevator.f2.door1Image.ImageSource='open_f.png';
                        case 3
                            elevator.f3.door1Image.ImageSource='open_f.png';
                    end
                case 2
                    elevator.e2.doorImage.ImageSource='open_e.png';
                    switch floor
                        case 1
                            elevator.f1.door2Image.ImageSource='open_f.png';
                        case 2
                            elevator.f2.door2Image.ImageSource='open_f.png';
                        case 3
                            elevator.f3.door2Image.ImageSource='open_f.png';
                    end
            end
        end
        
        function closeDoor(elevator,enum,floor)
        %This function set the value of doorImage and make the button status
        %and value the same as it haven't been push. Input is the
        %elevator's tag and its floor.
            switch enum
                case 1
                    elevator.e1.doorImage.ImageSource='close_e.png';
                    switch floor
                        case 1
                            elevator.e1.Button_1.Value=0;
                            elevator.e1.Button_1.Enable='on';
                            elevator.f1.door1Image.ImageSource='close_f.png';
                            elevator.f1.upButton.Value=0;
                            elevator.f1.upButton.Enable='on';
                        case 2
                            elevator.e1.Button_2.Value=0;
                            elevator.e1.Button_2.Enable='on';
                            elevator.f2.door1Image.ImageSource='close_f.png';
                            switch elevator.e1.status
                                case 1
                                    elevator.f2.upButton.Value=0;
                                    elevator.f2.upButton.Enable='on';
                                case 2
                                    elevator.f2.downButton.Value=0;
                                    elevator.f2.downButton.Enable='on';
                                case 0
                                    if elevator.f2.downButton.Value==1
                                       elevator.f2.downButton.Value=0;
                                       elevator.f2.downButton.Enable='on';
                                   else
                                       elevator.f2.upButton.Value=0;
                                       elevator.f2.upButton.Enable='on';
                                   end
                            end
                        case 3
                            elevator.e1.Button_3.Value=0;
                            elevator.e1.Button_3.Enable='on';
                           elevator.f3.door1Image.ImageSource='close_f.png';
                            elevator.f3.downButton.Value=0;
                            elevator.f3.downButton.Enable='on';
                    end
                case 2
                    elevator.e2.doorImage.ImageSource='close_e.png';
                    switch floor
                        case 1
                            elevator.e2.Button_1.Value=0;
                            elevator.e2.Button_1.Enable='on';
                            elevator.f1.door2Image.ImageSource='close_f.png';
                            elevator.f1.upButton.Value=0;
                            elevator.f1.upButton.Enable='on';
                        case 2
                            elevator.e2.Button_2.Value=0;
                            elevator.e2.Button_2.Enable='on';
                            elevator.f2.door2Image.ImageSource='close_f.png';
                            switch elevator.e2.status
                                case 1
                                    elevator.f2.upButton.Value=0;
                                    elevator.f2.upButton.Enable='on';
                                case 2
                                    elevator.f2.downButton.Value=0;
                                    elevator.f2.downButton.Enable='on';
                                case 0
                                    if elevator.f2.downButton.Value==1
                                       elevator.f2.downButton.Value=0;
                                       elevator.f2.downButton.Enable='on';
                                   else
                                       elevator.f2.upButton.Value=0;
                                       elevator.f2.upButton.Enable='on';
                                   end
                            end
                        case 3
                            elevator.e2.Button_3.Value=0;
                            elevator.e2.Button_3.Enable='on';
                            elevator.f3.door2Image.ImageSource='close_f.png';
                            elevator.f3.downButton.Value=0;
                            elevator.f3.downButton.Enable='on';
                    end
            end
        end
        
        function move(elevator,enum,inst)
        %This function just change the given elevator's floor. Input is the
        %elevator's tag and its floor.
            switch enum
                case 1
                    switch inst
                        case 1
                            elevator.fSensor.f_e1=elevator.fSensor.f_e1+0.1;
                        case 2
                            elevator.fSensor.f_e1=elevator.fSensor.f_e1-0.1;
                    end
                case 2
                    switch inst
                        case 1
                            elevator.fSensor.f_e2=elevator.fSensor.f_e2+0.1;
                        case 2
                            elevator.fSensor.f_e2=elevator.fSensor.f_e2-0.1;
                    end
            end
        end
        
    end
    
end