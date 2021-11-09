% To calculate the intermeans threshold;
% input is the gray level image ‘test1.bmp’
% output is the threshold value T and the binary thresholded
% image Iout.
function [T,Iout] = intermeans(Iin)

    T_old = 0; %initilize threshold variable
    T = mean(mean(Iin)); % start with initial T = average intensity
    while T_old ~= T % while not equal, end when Threshold stablized
        T_old = T;
        mean_1 = mean(mean(Iin(Iin < T_old)));
        mean_2 = mean(mean(Iin(Iin > T_old)));
        T = (mean_1 + mean_2) / 2; % update new Threshold value 
    end
    T = ceil(T); % floor the Threshold
    Iout = Iin > T; % for those pixels with value greater than threshold, display
end
