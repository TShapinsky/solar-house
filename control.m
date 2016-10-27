function [c] = control()
%information about the control
    c.length = nan;
    c.getLength = @getLength;
    
    function[l] = getLength(houseTemp, desiredTemp)
        if isnan(c.length)         
            if houseTemp > desiredTemp
                l = 1;
            else if houseTemp == desiredTemp
                l = .5;
            else 
                l = 0;
                end
            end
        else
            l=c.length;
        end
    end

end
    