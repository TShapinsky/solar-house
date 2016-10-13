function [ h ] = house( )
%HOUSE Information about the house
    h.length = 5; %m
    h.width  = 5; %m
    h.height = 5; %m
    h.volume = h.length*h.width*h.height; %m^3
    h.specificHeat = 820.4; %J/m^3
    h.heatCapacity = h.volume*h.specificHeat;
    h.area = (h.length*h.width)+(h.width*h.height)*2+(h.length*h.height)*2; %m^2
    h.thickness = .5; %m
    
    function [t] = temp(energy)
        t = energy./c.heatCapacity;
    end

    function [u] = energy(temp)
        u = temp.*c.heatCapacity;
    end
end

