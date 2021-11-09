% To compute the r-theta plot;
% input is a boundary image ‘test3.bmp’
% output is the array containing the r-theta value
function [r, theta] = rtheta(Iin)
    Iin = Iin > 0; % convert to binary image
    I_flip = flip(Iin,1);
    
    % find centroid
    xbar = 0;
    ybar = 0; 
    for y = 1:size(I_flip,1)
        for x = 1:size(I_flip,2)
            xbar = xbar + x * I_flip(y, x);
            ybar = ybar + y * I_flip(y, x); % sum up all 1s
        end
    end
    % centroid
    xbar = xbar / sum(sum(I_flip));
    ybar = ybar / sum(sum(I_flip));

    r = zeros(0);
    theta = zeros(0); % create 2 lists
    % r = sqrt((x-xbar)^2+(y-ybar)^2)
    % theta = tan-1((y-ybar)/(x-xbar))
    for y = 1:size(I_flip,1)
        for x = 1:size(I_flip,2)
            if I_flip(y, x)
                r(end + 1) = sqrt((x - xbar)^2 + (y - ybar)^2);
                theta(end + 1) = mod(atan2(y - ybar, x - xbar), 2*pi); % no exceed 2pi range
            end
        end
    end
end