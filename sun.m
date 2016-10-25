function [ s ] = sun( )
%SUN Information about the sun
    s.baseIrradiance = 1000; %W/m^2
    s.getIrradiance = @getIrradiance;
    s.getSolarAngle = @getSolarAngle;
    s.dni           = load('data/DNI/dni.mat');
    s.lat           = deg2rad(s.dni.lat);
    s.dni           = s.dni.dni;
    
    function [i] = getIrradiance (t, d)
        i = s.dni(find(s.dni(:,2) == mod(floor(d + floor(t/24)),364) & s.dni(:,3) == floor(mod(t,24)),1),7);
    end
    
    function [el] = getSolarAngle(t, day)
        d = getDeclinationAngle(day);
        h = getHourAngle(t);
        el = asin(sin(s.lat)*sin(d)+cos(s.lat)*cos(d)*cos(h));
    end

    function [h] = getHourAngle(t)
        h = t-12*deg2rad(15);
    end

    function [d] = getDeclinationAngle(day)
        d = 23.45*(pi/180)*sin(2*pi*(284+day)/(36.25));
    end

    

end

