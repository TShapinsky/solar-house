function solarhouse()
    h = house();
    s = sun();
    function theflow = flow()
        deltaT = ;
        theflow = (s.getIrradiance*h.sunarea)-(h.convection*h.area*deltaT)...
        -(((h.conduction*h.area)/h.thickness)*deltaT);
    end
end