function solarhouse()
    h = house();
    s = sun();
    e = environment();
    function theflow = flow(t, U)
        deltaT = h.getTemp(U)-e.getTemp(t, 0); %TODO: Fix day of year
        theflow = (s.getIrradiance(t, 0)*h.getExposedArea(s.getSolarAngle(mod(t,24),floor(t/24)),0))...
        -(((h.conductionInsulation*h.areaInsulation)/h.thicknessInsulation)*deltaT)...
        -(((h.conductionGlass*h.areaGlass)/h.thicknessGlass)*deltaT);
    end
  
    
    [t,U] = ode45(@flow, [0, 24*364], h.getEnergy(290));
    t = t./24;
    Temp = h.getTemp(U);
    Temp = Temp - 273;
    plot(t,Temp,'r*-');
    xlabel('Time (days)');
    ylabel('Temperature (C)');
    title('House Temperature Over Time');

end