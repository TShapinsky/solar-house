function solarhouse()
    h = house();
    s = sun();
    e = environment();
    tm = thermalMass(h);
    c = control();
    lengths = [];
    times   = [];
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
        lengths = [lengths,c.getLength(c, h.getTemp(U(1)),294)];
        times   = [times t];
    end
  
%     days = 0:30:364;
%     lengths = 0:0.1:1;
%     tempMat = zeros(length(days)-1,length(lengths));
%     for d = 1:(length(days)-1)
%         for l = 1:length(lengths)
%             c.length = lengths(l);
%             [t,U] = ode45(@flow, [24*days(d),24*days(d+1)], [h.getEnergy(294),tm.getEnergy(294)]);
%             temp = h.getTemp(U(:,1))-294;
%             tempMat(d,l) = trapz(t,temp)/30;
%         end
%     end
% 
%     imagesc(days(1:length(days)-1),lengths,tempMat');
    options = odeset('MaxStep',1e-1);
    [t,U] = ode45(@flow, [100*24, 24*110], [h.getEnergy(294),tm.getEnergy(294)], options);
    times = times./24;
    lengths = lengths.*100;
    t = t./24;
    Temp = [h.getTemp(U(:,1)),tm.getTemp(U(:,2))];
    Temp = Temp - 273;
    yyaxis left
    plot(t,Temp(:,1),'r-','LineWidth',2);
    hold on;
    plot(t,Temp(:,2),'b-','LineWidth',2);
    ylabel('Temperature (C)');
    yyaxis right
    max(lengths)
    %plot(times,lengths,'LineWidth',2);
    lengths = [min(lengths) lengths min(lengths)];
    times = [min(times) times max(times)];
    h = fill(times, lengths, 'g');
    set(h,'facealpha',.2)
    axis([min(t),max(t),0,100]);
    ylabel('Control coverage (%)');
    hold off;
    xlabel('Time (days)');
    title('House Temperature Over Time');
    legend('Temp in House', 'Temp in Thermal Mass', 'Control is extended');

end