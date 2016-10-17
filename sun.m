function [ s ] = sun( )
%SUN Information about the sun
    s.baseIrradiance = 1000; %W/m^2
    s.getIrradiance = @getIrradiance;
    s.getSolarAngle = @getSolarAngle;
    s.dni           = load('data/DNI/dni.mat');
    
    function [i] = getIrradiance (t, day)
        i = s.dni(find(s.dni(:,2) == day & s.dni(:,3) == t,1),7);
    end
    
    function [az,el] = getSolarAngle(t, day)
        az = 90; %deg
        el = 90; %deg
    end

end

