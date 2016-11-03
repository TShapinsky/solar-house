function solarhouse()
    h = house();
    s = sun();
    e = environment();
    tm = thermalMass(h);
    c = control();
    E = [];
    function flows = flow(t, U)
        deltaT = h.getTemp(U(1))-e.getTemp(t, 0); %TODO: Fix day of year
        deltaTTmH = h.getTemp(U(1)) - tm.getTemp(U(2));
        convectionTmH = h.convection*tm.area*deltaTTmH;
        sunFlow = (s.getIrradiance(t, 0)*h.getExposedArea(s.getSolarAngle(mod(t,24),floor(t/24)),c, h.getTemp(U(1))));
        houseFlow = sunFlow*tm.albedo...
        -(((h.conductionInsulation*h.areaInsulation)/h.thicknessInsulation)*deltaT)...
        -(h.RGlass*deltaT*h.areaGlass)...
        -convectionTmH;
        tmFlow = sunFlow*(1-tm.albedo)...
            + convectionTmH;
        %E = [E; e.getTemp];
        flows = [houseFlow;tmFlow];
    end
  
    options = odeset('MaxStep',1);
    [t,U] = ode45(@flow, [0, 24*364], [h.getEnergy(294),tm.getEnergy(294)], options);

    t = t./24;
    Temp = [h.getTemp(U(:,1)),tm.getTemp(U(:,2))];
    Temp = Temp - 273;
    plot(t,Temp(:,1),'r-','LineWidth',2);
    hold on;
    plot(t,Temp(:,2),'b-','LineWidth',2);
    %plot(t,E,'g*-');
    hold off;
    xlabel('Time (days)');
    ylabel('Temperature (C)');
    title('House Temperature Over Time');
    legend('House Temperature', 'Thermal Mass Temperature');
    axis([0 400 18 25]);

end