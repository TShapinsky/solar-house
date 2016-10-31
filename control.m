function [c] = control()
%information about the control
    c.length = nan;
    c.getLength = @getLength;
    
    function[l] = getLength(self,houseTemp, desiredTemp)
        if isnan(self.length)
            if houseTemp > desiredTemp
                l = 1;
            else if houseTemp == desiredTemp
                l = 1;
            else 
                l = 0;
                end
            end
        else
            l=self.length;
        end
    end

end
    