function [ heatmap ] = heatmap( input )
    minVal = min(min(input));
    maxVal = max(max(input));
    rangeVal = maxVal - minVal;
    heatmap = zeros(10,3);
    zeroPos = floor(abs(minVal/rangeVal)*length(heatmap)) + 1;
    heatmap(zeroPos,:) = [.7 1 .7];
    for i = (zeroPos+1):length(heatmap)
        otherColors = 1 - (i - (zeroPos))/(length(heatmap)+1-(zeroPos));
        heatmap(i,:) = [1 otherColors otherColors];
    end
    
    for i = 1:(zeroPos - 1)
        otherColors = i/(zeroPos);
        heatmap(i,:) = [otherColors otherColors 1];
    end
end

