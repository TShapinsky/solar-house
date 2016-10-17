function [ env ] = environment( )
%ENVIRONMENT information about the Environment
    env.baseTemp = 290; %K
    env.tempRange = 10;
    env.getTemp  = @getTemp;
    env.dni      = load('data/DNI/dni.mat');
    env.dni      = env.dni.dni;
    
    function [temp] = getTemp(t,d)
        temp = 270 + env.dni(find(env.dni(:,2) == (d + floor(t/24)) & env.dni(:,3) == mod(t,24),1),13);
    end
end

