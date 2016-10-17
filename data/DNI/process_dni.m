day = 0;
for i = 1:length(dni)
    dni(i,2) = day;
    if dni(i,3) == 23 && dni(i,4) == 55
        day = day +1;
    end
end