classdef FloorSensor < handle
    
    properties
        f_e1=1;  %floor sensor of elevator1
        f_e2=1;  %floor sensor of elevator2
    end
    
    methods
        function ret=getFloor(fSensor,enum)
            switch enum
                case 1
                    ret=fSensor.f_e1;
                case 2
                    ret=fSensor.f_e2;
            end
        end
    end
    
end