function [c] = control()
%information about the control
    c.getLength = @getLength;
    
    function[l] = getLength(houseTemp, desiredTemp)
        if houseTemp > desiredTemp
            l = 1;
        else if houseTemp == desiredTemp
            l = .5;
        else 
            l = 0;
            end
        end
    end

end
    