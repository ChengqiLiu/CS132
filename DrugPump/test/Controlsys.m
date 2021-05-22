classdef Controlsys < handle
    properties(Access = public)
        pump
        nurseUI
        passwordUI
        patientUI
        Timer
        
        delay = 0
        workstatus = 0
        
    end
    
    methods(Access = public)
        
        function countamount(controlsys)
            controlsys.pump.amount_of_hour = sum(controlsys.pump.amount,'all');
            controlsys.pump.amount_of_day = sum(controlsys.pump.amountd,'all');
            controlsys.pump.patient.Amountofhour = controlsys.pump.amount_of_hour;
            controlsys.pump.patient.Amountofday = controlsys.pump.amount_of_day;
        end
        
        
        function countgap(controlsys)
            controlsys.pump.askPress = 0;
           if controlsys.pump.gap < controlsys.pump.bolusGap
               controlsys.pump.gap = controlsys.pump.gap + 1;
           else
               controlsys.pump.PressGapcheck = 1;
               controlsys.pump.gap = 0;
           end
        end
        
        function startwoking(controlsys)
            
            controlsys.nurseUI.Message_3.Text = '      Not get bolus';
            controlsys.nurseUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
            controlsys.patientUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
            controlsys.Timer = timer(...
                'ExecutionMode', 'fixedRate', ...    % Run timer repeatedly
                'Period', 0.1, ...                     % Period is 1 second
                'BusyMode', 'queue',...              % Queue timer callbacks when busy
                'TimerFcn', @controlsys.getamountfunc);    % Specify callback function
               start(controlsys.Timer);
        end
        function getamountfunc(controlsys,~,~)
            controlsys.nurseUI.Message.Text = num2str(controlsys.pump.amount_of_hour);
            controlsys.nurseUI.Message_2.Text = num2str(controlsys.pump.amount_of_day);
            
            %Set the index of day(amountd[indexd])
            if controlsys.pump.indexd == 24*60
                controlsys.pump.indexd = 1;
            else
                controlsys.pump.indexd = controlsys.pump.indexd + 1;
            end
            
            %Set the index of hour(amount[index])
            if controlsys.pump.index == 60
                controlsys.pump.index = 1;
            else
                controlsys.pump.index = controlsys.pump.index + 1;
            end
            
            %count gap
            if controlsys.pump.PressGapcheck == 0
                controlsys.nurseUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                controlsys.patientUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                controlsys.countgap;
            end
            
            %Define whether the button is available to be presses by
            %hourlimit
            if (controlsys.pump.amount_of_hour + controlsys.pump.bolus) > (controlsys.pump.hourlimit + 0.001)
                controlsys.pump.PressAvailable = 0;
                controlsys.pump.askPress = 0;
                controlsys.nurseUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                controlsys.patientUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
            else
                if (controlsys.pump.amount_of_day + controlsys.pump.bolus) > (controlsys.pump.daylimit + 0.001)
                    controlsys.pump.PressAvailable = 0;  
                    controlsys.pump.askPress = 0;
                    controlsys.nurseUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                    controlsys.patientUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                else
                    controlsys.pump.PressAvailable = 1;
                end
            end
            
            %Define the working status by the amount(day) of injection
            if controlsys.delay == 0
                if  (controlsys.pump.amount_of_day + controlsys.pump.baseline) <= (controlsys.pump.daylimit + 0.0001) && (controlsys.pump.amount_of_hour + controlsys.pump.baseline) <= (controlsys.pump.hourlimit + 0.0001)
                    controlsys.pump.status=1;
                    controlsys.nurseUI.BaselineAvailableLamp.Color = [0.00,1.00,0.00];
                    if controlsys.pump.PressAvailable==1 && controlsys.pump.PressGapcheck==1
                        controlsys.nurseUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                        controlsys.patientUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                    end
                else
                    if (controlsys.pump.amount_of_day + controlsys.pump.baseline) > (controlsys.pump.daylimit + 0.001)
                        controlsys.delay = 1;
                    end
                    controlsys.pump.status=0;
                    controlsys.nurseUI.BaselineAvailableLamp.Color = [1.00,0.00,0.00];
                    controlsys.nurseUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                    controlsys.patientUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                    controlsys.pump.pauseinjection;
                    controlsys.pump.askPress = 0;
                end
            else
                if  (controlsys.pump.amount_of_day + controlsys.nurseUI.pump.bolus) > (controlsys.pump.daylimit + 0.0001) || (controlsys.pump.amount_of_hour + controlsys.pump.bolus) > (controlsys.pump.hourlimit + 0.0001)
                    controlsys.pump.status=0;
                    controlsys.nurseUI.BaselineAvailableLamp.Color = [1.00,0.00,0.00];
                    controlsys.nurseUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                    controlsys.patientUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                    controlsys.pump.pauseinjection;
                    controlsys.pump.askPress = 0;
                    %controlsys.nurseUI.Message_13.Text = '1';
                elseif (controlsys.pump.amount_of_day + controlsys.pump.bolus) >= controlsys.pump.daylimit && (controlsys.pump.amount_of_day + controlsys.pump.bolus) < (controlsys.pump.daylimit + 0.0001)
                    if (controlsys.pump.amount_of_hour + controlsys.pump.bolus) < (controlsys.pump.hourlimit + 0.0001)
                        controlsys.pump.status=0;
                        controlsys.nurseUI.BaselineAvailableLamp.Color = [1.00,0.00,0.00];
                        controlsys.pump.pauseinjection;
                        controlsys.pump.PressAvailable = 1;
                        if controlsys.pump.PressGapcheck==1
                            controlsys.nurseUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                            controlsys.patientUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                        end
                        if controlsys.pump.askPress == 1 && controlsys.pump.PressAvailable==1 && controlsys.pump.PressGapcheck==1
                            controlsys.nurseUI.Message_3.Text = datestr(now,0);           
                            controlsys.pump.injectBolus;
                            controlsys.nurseUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                            controlsys.npatientUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                        end
                    end
                    %controlsys.nurseUI.Message_13.Text = '2';
                elseif (controlsys.pump.amount_of_hour + controlsys.pump.bolus) >= controlsys.pump.hourlimit && (controlsys.pump.amount_of_hour + controlsys.pump.bolus) < (controlsys.pump.hourlimit + 0.0001)
                    if (controlsys.pump.amount_of_hour + controlsys.pump.bolus) < (controlsys.pump.daylimit + 0.0001)
                        controlsys.pump.status=0;
                        controlsys.nurseUI.BaselineAvailableLamp.Color = [1.00,0.00,0.00];
                        controlsys.pump.pauseinjection;
                        controlsys.pump.PressAvailable = 1;
                        if controlsys.pump.PressGapcheck==1
                            controlsys.nurseUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                            controlsys.patientUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                        end
                        if controlsys.pump.askPress == 1 && controlsys.pump.PressAvailable==1 && controlsys.pump.PressGapcheck==1
                            controlsys.nurseUI.Message_3.Text = datestr(now,0);           
                            controlsys.pump.injectBolus;
                            controlsys.nurseUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                            controlsys.patientUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                        end
                    end
                    %controlsys.nurseUI.Message_13.Text = '3';
                elseif (controlsys.pump.amount_of_hour + controlsys.pump.bolus + controlsys.pump.baseline) > (controlsys.pump.hourlimit + 0.0001) && (controlsys.pump.amount_of_hour + controlsys.pump.bolus) < controlsys.pump.hourlimit
                    if (controlsys.pump.amount_of_day + controlsys.pump.bolus) < (controlsys.pump.daylimit + 0.0001)
                        controlsys.pump.status=0;
                        controlsys.nurseUI.BaselineAvailableLamp.Color = [1.00,0.00,0.00];
                        controlsys.pump.pauseinjection;
                        controlsys.pump.PressAvailable = 1;
                        if controlsys.pump.PressGapcheck==1
                            controlsys.nurseUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                            controlsys.patientUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                        end
                        if controlsys.pump.askPress == 1 && controlsys.pump.PressAvailable==1 && controlsys.pump.PressGapcheck==1
                            controlsys.nurseUI.Message_3.Text = datestr(now,0);           
                            controlsys.pump.injectBolus;
                            controlsys.nurseUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                            controlsys.patientUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                        end
                    end
                    %controlsys.nurseUI.Message_13.Text = '4';
                elseif (controlsys.pump.amount_of_day + controlsys.pump.bolus + controlsys.pump.baseline) > (controlsys.pump.daylimit + 0.0001) && (controlsys.pump.amount_of_day + controlsys.pump.bolus) < controlsys.pump.daylimit
                    if (controlsys.pump.amount_of_hour + controlsys.pump.bolus) < (controlsys.pump.hourlimit + 0.0001)
                        controlsys.pump.status=0;
                        controlsys.nurseUI.BaselineAvailableLamp.Color = [1.00,0.00,0.00];
                        controlsys.pump.pauseinjection;
                        controlsys.pump.PressAvailable = 1;
                        if controlsys.pump.PressGapcheck==1
                            controlsys.nurseUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                            controlsys.patientUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                        end
                        if controlsys.pump.askPress == 1 && controlsys.pump.PressAvailable==1 && controlsys.pump.PressGapcheck==1
                            controlsys.nurseUI.Message_3.Text = datestr(now,0);           
                            controlsys.pump.injectBolus;
                            controlsys.nurseUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                            controlsys.patientUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                        end
                    end
                    %controlsys.nurseUI.Message_13.Text = '5';
                elseif (controlsys.pump.amount_of_hour + controlsys.pump.bolus + controlsys.pump.baseline) > (controlsys.pump.hourlimit + 0.0001) && (controlsys.pump.amount_of_hour + controlsys.pump.bolus) <= controlsys.pump.hourlimit
                    if (controlsys.pump.amount_of_day + controlsys.pump.bolus) < (controlsys.pump.daylimit + 0.0001)
                        controlsys.pump.status=0;
                        controlsys.nurseUI.BaselineAvailableLamp.Color = [1.00,0.00,0.00];
                        controlsys.pump.pauseinjection;
                        controlsys.pump.PressAvailable = 1;
                        if pp.pump.PressGapcheck==1
                            controlsys.nurseUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                            controlsys.patientUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                        end
                        if controlsys.pump.askPress == 1 && controlsys.pump.PressAvailable==1 && controlsys.pump.PressGapcheck==1
                            controlsys.nurseUI.Message_3.Text = datestr(now,0);           
                            controlsys.pump.injectBolus;
                            controlsys.nurseUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                            controlsys.patientUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                        end
                    end
                    %controlsys.nurseUI.Message_13.Text = '6';
                else
                    controlsys.pump.status=1;
                    if controlsys.pump.PressAvailable==1 && controlsys.pump.PressGapcheck==1
                        controlsys.nurseUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                        controlsys.patientUI.BolusAvailableLamp.Color = [0.00,1.00,0.00];
                    end
                    controlsys.nurseUI.BaselineAvailableLamp.Color = [0.00,1.00,0.00];
                    %controlsys.nurseUI.Message_13.Text = '7';
                end
            end

            %The inject func when pump working status = 1
            if controlsys.nurseUI.pump.status==1
                %inject bolus
                %controlsys.nurseUI.Message_13.Text = '8';
                if controlsys.pump.askPress == 1 && controlsys.pump.PressAvailable==1 && controlsys.pump.PressGapcheck==1
                    controlsys.nurseUI.Message_3.Text = datestr(now,0);           
                    controlsys.pump.injectBolus;
                    controlsys.nurseUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                    controlsys.patientUI.BolusAvailableLamp.Color = [1.00,0.00,0.00];
                %inject baseline
                else
                    controlsys.pump.injectbaseline;
                end
            end
            
            %count the amount
            controlsys.countamount;
        end
        
        
        function confirm(controlsys)
            controlsys.nurseUI.PUMPSwitch.Enable = 1;
            controlsys.pump.baseline = controlsys.nurseUI.baselineSpeed;
            controlsys.pump.bolus = controlsys.nurseUI.bolusAmountInfo;
            controlsys.pump.bolusGap = controlsys.nurseUI.bolusGapInfo;
            %controlsys.pump.status = 1;
            controlsys.pump.PressAvailable=1;
            controlsys.pump.gap = 0;
            controlsys.nurseUI.Message_4.Text = num2str(controlsys.nurseUI.baselineSpeed);
            controlsys.nurseUI.Message_5.Text = num2str(controlsys.nurseUI.bolusAmountInfo);
            controlsys.nurseUI.Message_6.Text = num2str(controlsys.nurseUI.bolusGapInfo);
        end
        
        function turnOff(controlsys)
                    controlsys.nurseUI.PUMPSwitch.Enable = 0;
                    controlsys.workstatus = 0;
                    controlsys.pump.baseline = 0.01;
                    controlsys.pump.bolus = 0.2;
                    controlsys.pump.bolusGap = 30;
                    controlsys.pump.status = 0;
                    controlsys.pump.amount=zeros(1,60);
                    controlsys.pump.amountd=zeros(1,24*60);
                    controlsys.pump.amount_of_hour = 0;
                    controlsys.pump.amount_of_day = 0;
                    controlsys.pump.gap = 0;
                    
                    controlsys.pump.PressAvailable=1;
                    controlsys.pump.PressGapcheck=1;
                    
                    controlsys.nurseUI.BaselinemlminSpinner.Value = 0.01;
                    controlsys.nurseUI.BolusmlshotSpinner.Value = 0.2;
                    controlsys.nurseUI.BolusGapminSpinner.Value = 30;
                    
                    delete(controlsys.Timer);
                    controlsys.nurseUI.Message.Text = '';
                    controlsys.nurseUI.Message_2.Text = '';
                    controlsys.nurseUI.Message_3.Text = '';
                    controlsys.nurseUI.BaselineAvailableLamp.Color = [0.65,0.65,0.65];
                    controlsys.nurseUI.BolusAvailableLamp.Color = [0.65,0.65,0.65];
                    controlsys.patientUI.BolusAvailableLamp.Color = [0.65,0.65,0.65];
                    controlsys.delay = 0;
                    controlsys.nurseUI.Message_4.Text = '';
                    controlsys.nurseUI.Message_5.Text = '';
                    controlsys.nurseUI.Message_6.Text = '';
        end
         function turnOn(controlsys)
                    controlsys.nurseUI.Message.Text = '';
                    controlsys.nurseUI.Message_2.Text = '';
                    controlsys.nurseUI.Message_3.Text = '      Not get bolus';
                    controlsys.nurseUI.BaselineAvailableLamp.Color = [0.65,0.65,0.65];
                    controlsys.nurseUI.BolusAvailableLamp.Color = [0.65,0.65,0.65];
                    controlsys.patientUI.BolusAvailableLamp.Color = [0.65,0.65,0.65];
                    controlsys.nurseUI.controlsys.delay = 0;
                    controlsys.workstatus = 1;
                    controlsys.startwoking;
        end
    end
end