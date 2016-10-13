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
    h.sunarea = 10; %m^2
    h.convection = 100; %W/m^2*K
    h.conduction = 2; %W/mK
    h.getTemp = @getTemp;
    h.getEnergy = @getEnergy;
    
    function [t] = getTemp(energy)
        t = energy./h.heatCapacity;
    end

    function [u] = getEnergy(temp)
        u = temp.*h.heatCapacity;
    end
end

