function [ s ] = sun( )
%SUN Information about the sun
    s.baseIrradiance = 1000; %W/m^2
    s.getIrradiance = @getIrradiance;
    s.getSolarAngle = @getSolarAngle;
    
    function [i] = getIrradiance (t, day)
        i = s.baseIrradiance;
    end
    
    function [az,el] = getSolarAngle(t, day)
        az = 90; %deg
        el = 90; %deg
    end

end

