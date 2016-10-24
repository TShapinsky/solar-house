function [t] = thermalMass(h)
%THERMALMASS information about the thermal mass
%made of paraffin wax
    t.convection = 1; %change value
    t.height = 0.05; %change value
    t.specificheat = 2160*1000; %J/m^3
    t.area = h.length*h.width; 
    t.volume = t.area*t.height;
    t.heatCapacity = t.volume*t.specificheat; 
    t.getEnergy = @getEnergy;
    t.getTemp = @getTemp;
    t.albedo  = 0.04;
    
    function [c] = getTemp(energy)
        c = energy./t.heatCapacity;
    end

    function [u] = getEnergy(temp)
        u = temp.*t.heatCapacity;
    end
end