function solarhouse()
    h = house();
    s = sun();
    e = environment();
    function theflow = flow(t, U)
        deltaT = h.getTemp(U)-e.getTemp(t, 0); %TODO: Fix day of year
        theflow = (s.getIrradiance(t, 0)*h.getExposedArea(s.getSolarAngle(mod(t,24),floor(t/24)),0))-(h.convection*h.area*deltaT)...
        -(((h.conduction*h.area)/h.thickness)*deltaT);
    end
  
    
    [t,U] = ode45(@flow, [0, 24*364], h.getEnergy(290));
    Temp = h.getTemp(U);
    plot(t/24,Temp,'r*-');
    xlabel('Time (hours)');
    ylabel('Temperature (K)');
    title('House Temperature Over Time');

end