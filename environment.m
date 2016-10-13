function [ env ] = environment( )
%ENVIRONMENT information about the Environment
    env.baseTemp = 290; %K
    env.tempRange = 10;
    env.getTemp  = @getTemp;
    
    function [temp] = getTemp(t,d)
        temp = env.tempRange*cos(t/24*2*pi) + env.baseTemp;
    end
end

