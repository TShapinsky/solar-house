function solarhouse()
    h = house();
    s = sun();
    e = environment();
    tm = thermalMass(h);
    c = control();
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
        flows = [houseFlow;tmFlow];
    end
  
    days = 0:30:364;
    lengths = 0:0.1:1;
    tempMat = zeros(length(days)-1,length(lengths));
    for d = 1:(length(days)-1)
        for l = 1:length(lengths)
            c.length = lengths(l);
            [t,U] = ode45(@flow, [24*days(d),24*days(d+1)], [h.getEnergy(294),tm.getEnergy(294)]);
            temp = h.getTemp(U(:,1));
            tempMat(d,l) = range(temp);
        end
    end

    contourf(days(1:length(days)-1),lengths,tempMat');

%     t = t./24;
%     Temp = [h.getTemp(U(:,1)),tm.getTemp(U(:,2))];
%     Temp = Temp - 273;
%     plot(t,Temp(:,1),'r*-');
%     hold on;
%     plot(t,Temp(:,2),'b*-');
%     hold off;
%     xlabel('Time (days)');
%     ylabel('Temperature (C)');
%     title('House Temperature Over Time');

end