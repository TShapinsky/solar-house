function [ env ] = environment( )
%ENVIRONMENT information about the Environment
    env.baseTemp = 290; %K
    env.tempRange = 10;
    env.getTemp  = @getTemp;
    env.dni      = load('data/DNI/dni.mat');
    
    function [temp] = getTemp(t,d)
        temp = 270 + env.dni(find(env.dni(:,2) == d & env.dni(:,3) == t,1),13);
    end
end

