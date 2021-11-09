% To compute the features;
% input is the binary thresholded image
% outputs are the feature values
function [P, A, C, xbar, ybar, phione] = features(Iin)
    % Iin is a binary image with only 1s and 0s
    % centralize the image to largest area: bwareafilt(I, n)
    Iin = bwareafilt(Iin,1); 
    % flip image to set origin from top left to bottom left
    I_flip = flip(Iin,1);
    % use built-in function to track the edges
    I_edges = edge(Iin);
    
    % Numer of edge pixels
    P = sum(sum(I_edges)); 
    % Number of pixels within
    A = sum(sum(Iin));
    % Compactness = (perimeter)^2 / (4Pi*area)
    C = P^2 / (4 * pi * A);
    
    % Centroid: xbar = m10/m00, ybar = m01/m00
    % mpq = sum(sum(x^p * y^q * f(x,y)dxdy))
    
    %m00 = summing up all the pixels
    m00 = sum(sum(I_flip)); 
    %m01 = sumall y * f(x,y)
    %m10 = sumall x * f(x,y)
    m01 = 0;
    m10 = 0;
    for y = 1:size(I_flip,1) % row by row (1 - row size)
        for x = 1:size(I_flip,2) % col by col (2 - col size)
            m01 = m01 + y * I_flip(y, x);
            m10 = m10 + x * I_flip(y, x);
        end
    end
    % Centroid: xbar = m10/m00, ybar = m01/m00
    xbar = m10/m00;
    ybar = m01/m00;
    
    % phi1 = eta20 + eta02
    % eta20 = u20/u00^2
    % upq = sumsum (x - xbar)^p * (y - ybar)^q * f(x,y) dxdy
    % u20 = sumsum (x-xbar)^2 * f(x,y); u02 = sumsum (y-ybar)^2 * f(x,y)
    % u00 = m00
    % u20 and u02
    u20 = 0;
    u02 = 0;
    for y = 1:size(I_flip,1) % row
        for x = 1:size(I_flip,2) % col
            u20 = u20 + (x - xbar)^2 * I_flip(y, x);
            u02 = u02 + (y - ybar)^2 * I_flip(y, x);
        end
    end
    
    u00 = m00;
    eta20 = u20 / u00^2; % (2+0)/2+1 = 2
    eta02 = u02 / u00^2;

    phione = eta20 + eta02;
end
