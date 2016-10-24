function [ h ] = house( )
%HOUSE Information about the house
    h.length = 5; %m
    h.width  = 5; %m
    h.height = 5; %m
    h.volume = h.length*h.width*h.height; %m^3
    h.specificHeat = 820.4; %J/m^3
    h.heatCapacity = h.volume*h.specificHeat;
    h.areaInsulation = (h.length*h.width)+(h.width*h.height)*2+(h.length*h.height); %m^2
    h.areaGlass      = h.length*h.height; %m^2
    h.thicknessInsulation = .5; %m
    h.thicknessGlass      = 0.02; %m
    h.sunarea = 10; %m^2
    h.convection = 100; %W/m^2*K
    h.conductionInsulation = .029; %W/mK
    h.conductionGlass      = 1.05; %W/mK
    h.RGlass = 12.5^-1; %W/Km^2
    h.getTemp = @getTemp;
    h.getEnergy = @getEnergy;
    h.getExposedArea = @getExposedArea;
    
    function [t] = getTemp(energy)
        t = energy./h.heatCapacity;
    end

    function [u] = getEnergy(temp)
        u = temp.*h.heatCapacity;
    end

    function [a] = getExposedArea(elevation,control, houseTemp)
        if sin(elevation) > 0
            a = h.length*min(sin(elevation)*(h.height-h.height*control.getLength(houseTemp, 294)),h.width)
        else
            a = 0;
        end
    end
end

