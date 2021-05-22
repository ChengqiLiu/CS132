classdef ElevatorController < handle
    
    properties
        f1              %ButtonPanel_f1.mlapp
        f2              %ButtonPanel_f2.mlapp
        f3              %ButtonPanel_f3.mlapp
        e1              %ButtonPanel_e.mlapp
        e2              %ButtonPanel_e.mlapp
        elevator        %Elevator.m
        fSensor         %FloorSensor.m
        dSensor         %DoorSensor.m
        emSensor        %EmergSensor.m
        task=[0 0 0 0;  %for elevator1: task(1,1):floor1_up; task(1,2):floor2_up; task(1,3):floor2_down; task(1,4):floor3_down; 
            0 0 0 0]    %for elevator2: task(2,1):floor1_up; task(2,2):floor2_up; task(2,3):floor2_down; task(2,4):floor3_down;
        managestatus=0  %If the while(1) in manage() is going on, it's 1, otherwise it's 0.
        wait1=0;
        wait2=0;
        %temporary variables to store the elevator status in an emergency:
        e1_t1;e1_t2;e1_t3;e1_t4;e1_t5;e1_t6;e1_t7;e1_t8;  %elevator1 in emergency
        e2_t1;e2_t2;e2_t3;e2_t4;e2_t5;e2_t6;e2_t7;e2_t8;  %elevator2 in emergency
    end
    
    methods
        
        function ret=giveIns(control,enum)
        %This function gives the instruction to the given elevator.Input is
        %the elevator's tag. Output is 1(up), 2(down), or 0(stop). It will
        %also set the elevator's status in elevator.mlapp.
            switch enum
                case 1
                    if control.fSensor.f_e1<1.01
                            if control.task(1,1)==1
                                ret=0;
                            else
                               if control.task(1,2)==1||control.task(1,3)==1||control.task(1,4)==1
                                  ret=1;
                               else
                                  ret=0;
                               end
                            end
                            control.e1.status=ret;
                            return;
                    elseif control.fSensor.f_e1>1.99 && control.fSensor.f_e1<2.01
                            if (control.task(1,2)==1 && (control.e1.status==1||control.e1.status==0))||(control.task(1,3)==1 && (control.e1.status==2||control.e1.status==0))
                                ret=0;
                            else
                              if control.task(1,1)==1
                                  ret=2;
                              elseif control.task(1,4)==1
                                  ret=1;
                              else
                                  ret=0;
                              end
                            end
                            control.e1.status=ret;
                            return;
                    elseif control.fSensor.f_e1>2.99
                            if control.task(1,4)==1
                                ret=0;
                            else
                              if control.task(1,1)==1||control.task(1,2)==1||control.task(1,3)==1
                                   ret=2;
                              else
                                  ret=0;
                              end
                            end
                            control.e1.status=ret;
                            return;
                    else
                        ret=control.e1.status;
                        return;
                    end
                case 2
                    if control.fSensor.f_e2<1.01
                            if control.task(2,1)==1
                                ret=0;
                            else
                              if control.task(2,2)==1||control.task(2,3)==1||control.task(2,4)==1
                                  ret=1;
                              else
                                  ret=0;
                              end
                            end
                            control.e2.status=ret;
                            return;
                    elseif control.fSensor.f_e2>1.99 && control.fSensor.f_e2<2.01
                            if (control.task(2,2)==1 && (control.e2.status==1||control.e2.status==0))||(control.task(2,3)==1 && (control.e2.status==2||control.e2.status==0))
                                ret=0;
                            else
                              if control.task(2,1)==1
                                ret=2;
                              elseif control.task(2,4)==1
                                ret=1;
                              else
                                  ret=0;
                              end
                            end
                            control.e2.status=ret;
                            return;
                    elseif control.fSensor.f_e2>2.99
                            if control.task(2,4)==1
                                ret=0;
                            else
                              if control.task(2,3)==1||control.task(2,2)==1||control.task(2,1)==1
                                  ret=2;
                              else
                                  ret=0;
                              end
                            end
                            control.e2.status=ret;
                            return;
                    else
                        ret=control.e2.status;
                        return;
                    end
            end
        end
        
        function manage(control)
        %This function controls the behavior of the two elevators. It
        %contains a while(1) loop as a timer of 0.1s. If the task becomes 
        %[0 0 0 0; 0 0 0 0], the loop will break.
            control.managestatus=1;
            while(1)
                pause(0.1);
                fl1=control.fSensor.f_e1;
                fl2=control.fSensor.f_e2;
                i1=control.giveIns(1);
                i2=control.giveIns(2);
                
                %manage elevator1
                stop1=0; %check if elevator1 needs to stop
                if control.emSensor.s_emerg1>1 %in emergency
                    control.emSensor.s_emerg1=control.emSensor.s_emerg1-1;
                    stop1=1;
                elseif control.emSensor.s_emerg1==1 %in end of emergency
                    control.emSensor.s_emerg1=0;
                    control.cancelEmerg(1);
                else %in normal situation
                if fl1<1.01
                             if control.task(1,1)==1 || control.wait1==1
                                if control.dSensor.s_door1==0
                                    control.dSensor.s_door1=30;
                                    control.elevator.openLamp(1);
                                    control.elevator.openDoor(1,1);
                                    stop1=1;
                                elseif control.dSensor.s_door1==10
                                    control.dSensor.s_door1=control.dSensor.s_door1-1;
                                    control.elevator.closeLamp(1);
                                    control.elevator.closeDoor(1,1);
                                    control.cancelTask(1,1);
                                    control.wait1=1;
                                    stop1=1;
                                elseif control.dSensor.s_door1==1
                                    control.dSensor.s_door1=0;
                                    control.wait1=0;
                                else
                                    control.dSensor.s_door1=control.dSensor.s_door1-1;
                                    stop1=1;
                                end
                            end
                elseif fl1>1.99 && fl1<2.01
                            if (control.task(1,2)==1 && (control.e1.status==1||control.e1.status==0))||(control.task(1,3)==1 && (control.e1.status==2||control.e1.status==0)) || control.wait1==1
                                if control.dSensor.s_door1==0
                                    control.dSensor.s_door1=30;
                                    control.elevator.openLamp(1);
                                    control.elevator.openDoor(1,2);
                                    stop1=1;
                                elseif control.dSensor.s_door1==10
                                    control.dSensor.s_door1=control.dSensor.s_door1-1;
                                    control.elevator.closeLamp(1);
                                    control.elevator.closeDoor(1,2);
                                    control.cancelTask(1,2);
                                    control.wait1=1;
                                    stop1=1;
                                elseif control.dSensor.s_door1==1
                                    control.dSensor.s_door1=0;
                                    control.wait1=0;
                                else
                                    control.dSensor.s_door1=control.dSensor.s_door1-1;
                                    stop1=1;
                                end
                            end
                elseif fl1>2.99
                            if control.task(1,4)==1 || control.wait1==1
                                if control.dSensor.s_door1==0
                                    control.dSensor.s_door1=30;
                                    control.elevator.openLamp(1);
                                    control.elevator.openDoor(1,3);
                                    stop1=1;
                                elseif control.dSensor.s_door1==10
                                    control.dSensor.s_door1=control.dSensor.s_door1-1;
                                    control.elevator.closeLamp(1);
                                    control.elevator.closeDoor(1,3);
                                    control.cancelTask(1,3);
                                    control.wait1=1;
                                    stop1=1;
                                elseif control.dSensor.s_door1==1
                                    control.dSensor.s_door1=0;
                                    control.wait1=0;
                                else
                                    control.dSensor.s_door1=control.dSensor.s_door1-1;
                                    stop1=1;
                                end
                            end
                end
                end
                if stop1==0
                    control.elevator.move(1,i1);
                end
                if control.emSensor.s_emerg1==0 %in normal situation
                    control.elevator.updateEleLamp(1);
                    control.elevator.updateFloor(1);
                end
                
                %manage elevator2
                stop2=0; %check if elevator2 needs to stop
                if control.emSensor.s_emerg2>1 %in emergency
                    control.emSensor.s_emerg2=control.emSensor.s_emerg2-1;
                    stop2=1;
                elseif control.emSensor.s_emerg2==1 %in the end of emergency
                    control.emSensor.s_emerg2=0;
                    control.cancelEmerg(2);
                else %in normal situation
                if fl2<1.01
                            if control.task(2,1)==1 || control.wait2==1
                                if control.dSensor.s_door2==0
                                    control.dSensor.s_door2=30;
                                    control.elevator.openLamp(2);
                                    control.elevator.openDoor(2,1);
                                    stop2=1;
                                elseif control.dSensor.s_door2==10
                                    control.dSensor.s_door2=control.dSensor.s_door2-1;
                                    control.elevator.closeLamp(2);
                                    control.elevator.closeDoor(2,1);
                                    control.cancelTask(2,1);
                                    control.wait2=1;
                                    stop2=1;
                                elseif control.dSensor.s_door2==1
                                    control.dSensor.s_door2=0;
                                    control.wait2=0;
                                else
                                    control.dSensor.s_door2=control.dSensor.s_door2-1;
                                    stop2=1;
                                end
                            end
                elseif fl2>1.99 && fl2<2.01
                            if (control.task(2,2)==1 && (control.e2.status==1||control.e2.status==0))||(control.task(2,3)==1 && (control.e2.status==2||control.e2.status==0)) || control.wait2==1
                                if control.dSensor.s_door2==0
                                    control.dSensor.s_door2=30;
                                    control.elevator.openLamp(2);
                                    control.elevator.openDoor(2,2);
                                    stop2=1;
                                elseif control.dSensor.s_door2==10
                                    control.dSensor.s_door2=control.dSensor.s_door2-1;
                                    control.elevator.closeLamp(2);
                                    control.elevator.closeDoor(2,2);
                                    control.cancelTask(2,2);
                                    control.wait2=1;
                                    stop2=1;
                                elseif control.dSensor.s_door2==1
                                    control.dSensor.s_door2=0;
                                    control.wait2=0;
                                else
                                    control.dSensor.s_door2=control.dSensor.s_door2-1;
                                    stop2=1;
                                end
                            end
                elseif fl2>2.99
                            if control.task(2,4)==1 || control.wait2==1
                                if control.dSensor.s_door2==0
                                    control.dSensor.s_door2=30;
                                    control.elevator.openLamp(2);
                                    control.elevator.openDoor(2,3);
                                    stop2=1;
                                elseif control.dSensor.s_door2==10
                                    control.dSensor.s_door2=control.dSensor.s_door2-1;
                                    control.elevator.closeLamp(2);
                                    control.elevator.closeDoor(2,3);
                                    control.cancelTask(2,3);
                                    control.wait2=1;
                                    stop2=1;
                                elseif control.dSensor.s_door2==1
                                    control.dSensor.s_door2=0;
                                    control.wait2=0;
                                else
                                    control.dSensor.s_door2=control.dSensor.s_door2-1;
                                    stop2=1;
                                end
                            end
                end
                end
                if stop2==0
                    control.elevator.move(2,i2);
                end
                if control.emSensor.s_emerg2==0 %in normal situation
                    control.elevator.updateEleLamp(2);
                    control.elevator.updateFloor(2);
                end
                
                %break while(1) if all tasks are finished
                if control.task==[0 0 0 0;0 0 0 0] & (control.dSensor.s_door1==0  && control.dSensor.s_door2==0 && control.emSensor.s_emerg1==0 && control.emSensor.s_emerg2==0)
                   control.managestatus=0;
                   return;
                end
            end
        end
        
        function cancelTask(control,enum,floor)
        %This function set the consistent value in task[] to 0. Input
        %is the elevator tag and its floor.
            switch enum
                case 1
                    switch floor
                        case 1
                            control.task(1,1)=0;
                        case 2
                            switch control.e1.status
                                case 1
                                    control.task(1,2)=0;
                                case 2
                                    control.task(1,3)=0;
                                case 0
                                    if control.task(1,3)==1
                                        control.task(1,3)=0;
                                    else
                                        control.task(1,2)=0;
                                    end
                            end
                        case 3
                            control.task(1,4)=0;
                    end
                case 2
                    switch floor
                        case 1
                            control.task(2,1)=0;
                        case 2
                            switch control.e2.status
                                case 1
                                    control.task(2,2)=0;
                                case 2
                                    control.task(2,3)=0;
                                case 0
                                    if control.task(2,3)==1
                                        control.task(2,3)=0;
                                    else
                                        control.task(2,2)=0;
                                    end
                            end
                        case 3
                            control.task(2,4)=0;
                    end
            end
        end
        
        function setTask_f(control,numt)
        %This function sets two places in the task[] to 1. Input is the task
        %number. It can be called by any floor app.
            if control.task(1,numt)==1 || control.task(2,numt)==1
                return;
            end
            switch numt
                case 1
                    if control.e1.status==0||control.e1.status==2
                        value1=6-control.fSensor.f_e1;
                    else
                        value1=control.fSensor.f_e1;
                    end
                    if control.e2.status==0||control.e2.status==2
                        value2=6-control.fSensor.f_e2;
                    else
                        value2=control.fSensor.f_e2;
                    end
                case 2
                    if control.e1.status==0||control.e1.status==1
                        if control.fSensor.f_e1<=2.01
                            value1=control.fSensor.f_e1+3;
                        else
                            value1=control.fSensor.f_e1-1;
                        end
                    else
                        value1=5-control.fSensor.f_e1;
                    end
                    if control.e2.status==0||control.e2.status==1
                        if control.fSensor.f_e2<=2.01
                            value2=control.fSensor.f_e2+3;
                        else
                            value2=control.fSensor.f_e2-1;
                        end
                    else
                        value2=5-control.fSensor.f_e2;
                    end
                case 3
                    if control.e1.status==0||control.e1.status==2
                        if control.fSensor.f_e1>=1.99
                            value1=7-control.fSensor.f_e1;
                        else
                            value1=3-control.fSensor.f_e1;
                        end
                    else
                        value1=control.fSensor.f_e1+1;
                    end
                    if control.e2.status==0||control.e2.status==2
                        if control.fSensor.f_e2>=1.99
                            value2=7-control.fSensor.f_e2;
                        else
                            value2=3-control.fSensor.f_e2;
                        end
                    else
                        value2=control.fSensor.f_e2+1;
                    end
                case 4
                    if control.e1.status==2
                        value1=4-control.fSensor.f_e1;
                    else
                        value1=control.fSensor.f_e1+2;
                    end
                    if control.e2.status==2
                        value2=4-control.fSensor.f_e2;
                    else
                        value2=control.fSensor.f_e2+2;
                    end
            end
            if value1==1
                value1=5;
             end
             if value2==1
                 value2=5;
             end
             if value1>=value2
                 control.task(1,numt)=1;
             else
                 control.task(2,numt)=1;
             end
        end
        
        function setTask_e(control,enum,floor)
        %This function sets two places in the task[] to 1. Input is the task
        %number. It can be called by any elevator app.
            if floor==1
                control.task(enum,floor)=1;
            elseif floor==3
                control.task(enum,floor+1)=1;
            else
                switch enum
                    case 1
                        if control.fSensor.f_e1<=2
                            control.task(enum,2)=1;
                        else
                            control.task(enum,3)=1;
                        end
                    case 2
                        if control.fSensor.f_e2<=2
                            control.task(enum,2)=1;
                        else
                            control.task(enum,3)=1;
                        end
                end
            end
        end
        
        function emerg(control,enum)
        %This function is called when you push the emergency button in the
        %elevator. Input is the number of elevator. Store the elevator's
        %situation in the temporary variables in the property.
            switch enum
                case 1
                    control.emSensor.s_emerg1=40;
                    control.e1_t1=control.e1.upLamp.Color;
                    control.e1_t2=control.e1.downLamp.Color;
                    control.e1_t3=control.f1.up1Lamp.Color;
                    control.e1_t5=control.f2.up1Lamp.Color;
                    control.e1_t6=control.f2.down1Lamp.Color;
                    control.e1_t8=control.f3.down1Lamp.Color;
                    control.e1.upLamp.Color=[1 0.2 0.2];
                    control.e1.downLamp.Color=[1 0.2 0.2];
                    control.f1.up1Lamp.Color=[1 0.2 0.2];
                    control.f2.up1Lamp.Color=[1 0.2 0.2];
                    control.f2.down1Lamp.Color=[1 0.2 0.2];
                    control.f3.down1Lamp.Color=[1 0.2 0.2];
                    [x, Fs] = audioread('emergency.wav');
                    sound(x, Fs); 
                case 2
                    control.emSensor.s_emerg2=40;
                    control.e2_t1=control.e2.upLamp.Color;
                    control.e2_t2=control.e2.downLamp.Color;
                    control.e2_t3=control.f1.up2Lamp.Color;
                    control.e2_t5=control.f2.up2Lamp.Color;
                    control.e2_t6=control.f2.down2Lamp.Color;
                    control.e2_t8=control.f3.down2Lamp.Color;
                    control.e2.upLamp.Color=[1 0.2 0.2];
                    control.e2.downLamp.Color=[1 0.2 0.2];
                    control.f1.up2Lamp.Color=[1 0.2 0.2];
                    control.f2.up2Lamp.Color=[1 0.2 0.2];
                    control.f2.down2Lamp.Color=[1 0.2 0.2];
                    control.f3.down2Lamp.Color=[1 0.2 0.2];
                    [x, Fs] = audioread('emergency.wav');
                    sound(x, Fs); 
            end
        end
        
        function cancelEmerg(control,enum)
        %This function set the given elevator's condition back using the 
        %temporary variables in the property, so that it will act normally 
        %as before the emergency.
            switch enum
                case 1
                    control.e1.upLamp.Color=control.e1_t1;
                    control.e1.downLamp.Color=control.e1_t2;
                    control.f1.up1Lamp.Color=control.e1_t3;
                    control.f2.up1Lamp.Color=control.e1_t5;
                    control.f2.down1Lamp.Color=control.e1_t6;
                    control.f3.down1Lamp.Color=control.e1_t8;
                case 2
                    control.e2.upLamp.Color=control.e2_t1;
                    control.e2.downLamp.Color=control.e2_t2;
                    control.f1.up2Lamp.Color=control.e2_t3;
                    control.f2.up2Lamp.Color=control.e2_t5;
                    control.f2.down2Lamp.Color=control.e2_t6;
                    control.f3.down2Lamp.Color=control.e2_t8;
            end
        end
        
        function e_open(control,enum)
        %This function is called when you push the <|> button in the
        %elevator. It will extend the opening time or reopen the elevator 
        %door. Input is the number of elevator.
            switch enum
                case 1
                    if strcmp(control.e1.doorImage.ImageSource,'open_e.png')
                        %extend the opening time
                        control.dSensor.s_door1=30;
                    elseif control.e1.status==0 || control.wait1==1
                        %reopen the elevator door
                        F=control.fSensor.f_e1;
                        control.dSensor.s_door1=30;
                        if F<1.01
                            control.elevator.openDoor(1,1);
                            control.task(1,1)=1;
                        elseif F>1.99 && F<2.01
                            control.elevator.openDoor(1,2);
                            if control.task(1,1)==1
                                control.task(1,3)=1;
                            else
                                control.task(1,2)=1;
                            end
                        elseif F>2.99
                            control.elevator.openDoor(1,3);
                            control.task(1,4)=1;
                        end
                    end
                case 2
                    if strcmp(control.e2.doorImage.ImageSource,'open_e.png')
                        %extend the opening time
                        control.dSensor.s_door2=30;
                    elseif control.e2.status==0 || control.wait2==1
                        %reopen the elevator door
                        F=control.fSensor.f_e2;
                        control.dSensor.s_door2=30;
                        if F<1.01
                            control.elevator.openDoor(2,1);
                            control.task(2,1)=1;
                        elseif F>1.99 && F<2.01
                            control.elevator.openDoor(2,2);
                            if control.task(2,1)==1
                                control.task(2,3)=1;
                            else
                                control.task(2,2)=1;
                            end
                        elseif F>2.99
                            control.elevator.openDoor(2,3);
                            control.task(2,4)=1;
                        end
                    end
            end
        end
            
        function e_close(control,enum)
        %This function is called when you push the >|< button in the
        %elevator. Input is the number of elevator.
            switch enum
                case 1
                    if strcmp(control.e1.doorImage.ImageSource,'open_e.png')
                        control.dSensor.s_door1=10;
                    end
                case 2
                    if strcmp(control.e2.doorImage.ImageSource,'open_e.png')
                        control.dSensor.s_door2=10;
                    end
            end
        end
    end
end