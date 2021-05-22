classdef Pump < handle
    properties(Access = public)
        controlsys
        
        status = 0
        baseline
        bolus
        bolusGap
        
        amount=zeros(1,60)
        amountd=zeros(1,24*60)
        amount_of_hour = 0
        amount_of_day = 0
        
        button
        askPress=0          
        PressGapcheck=1
        PressAvailable=0
        
        pumpClock
        
        patient
        nUIapp
        PWUI
        
        index = 0
        indexd = 0
        gap = 0
        
        hourlimit = 1
        daylimit = 3
    end
    
    methods(Access = public)
        
        function injectBolus(pump)
            pump.amount(pump.index)=pump.bolus;
            pump.amountd(pump.indexd)=pump.bolus;
            pump.askPress = 0;
            pump.PressGapcheck = 0;
        end
        
        function injectbaseline(pump)
            pump.amount(pump.index)=pump.baseline;
            pump.amountd(pump.indexd)=pump.baseline;
        end
        
        function pauseinjection(pump)
            pump.amount(pump.index)=0;
            pump.amountd(pump.indexd)=0;
            pump.PressAvailable = 0;
        end
        
    end
end