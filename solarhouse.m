function solarhouse()
    h = house();
    s = sun();
    e = environment();
    tm = thermalMass(h);
    function flows = flow(t, U)
        deltaT = h.getTemp(U(1))-e.getTemp(t, 0); %TODO: Fix day of year
        deltaTTmH = h.getTemp(U(1)) - tm.getTemp(U(2));
        convectionTmH = h.convection*tm.area*deltaTTmH;
        sunFlow = (s.getIrradiance(t, 0)*h.getExposedArea(s.getSolarAngle(mod(t,24),floor(t/24)),0));
        houseFlow = sunFlow*tm.albedo...
        -(((h.conductionInsulation*h.areaInsulation)/h.thicknessInsulation)*deltaT)...
        -(((h.conductionGlass*h.areaGlass)/h.thicknessGlass)*deltaT)...
        -convectionTmH;
        tmFlow = sunFlow*(1-tm.albedo)...
            + convectionTmH;
        flows = [houseFlow;tmFlow];
    end
  
    
    [t,U] = ode45(@flow, [0, 24*3], [h.getEnergy(290),tm.getEnergy(290)]);

    t = t./24;
    Temp = [h.getTemp(U(:,1)),tm.getTemp(U(:,2))];
    Temp = Temp - 273;
    plot(t,Temp(:,1),'r*-');
    hold on;
    plot(t,Temp(:,2),'b*-');
    hold off;
    xlabel('Time (days)');
    ylabel('Temperature (C)')
    title('House Temperature Over Time');

end