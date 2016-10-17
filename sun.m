function [ s ] = sun( )
%SUN Information about the sun
    s.baseIrradiance = 1000; %W/m^2
    s.getIrradiance = @getIrradiance;
    s.getSolarAngle = @getSolarAngle;
    s.dni           = load('data/DNI/dni.mat');
    s.dni           = s.dni.dni;
    
    function [i] = getIrradiance (t, d)
        i = s.dni(find(s.dni(:,2) == (d + floor(t/24)) & s.dni(:,3) == mod(t,24),1),7);
    end
    
    function [az,el] = getSolarAngle(t, day)
        az = 90; %deg
        el = 90; %deg
    end

end

