%%%%% Section D %%%%%
% This m file is used to test your code for Section D
% Ensure that when you run this script file
%--- 1.
I = imread('./letter.bmp');
% Continue your code here.
% 2. compute the edge map
I_edge = edge(I);
% 3. Hough Transform
[y,x]=find(I_edge); 
[sy,sx]=size(I_edge); % 279 * 393

totalpix = length(x); % 676 1s
maxrho = round(sqrt(sx^2 + sy^2)); % 482

HM = zeros(2*maxrho,180); 

for cnt = 1:totalpix % rho
    cnt2 = 1;
    for theta = -pi/2:pi/180:pi/2-pi/180 % theta
        rho = round(x(cnt).*cos(theta) + y(cnt).*sin(theta));
        HM((rho+maxrho),cnt2) = HM(rho+maxrho,cnt2) + 1;
        cnt2 = cnt2 + 1;
    end
end

% make it brighter
%for i = 1:maxrho
%    for j = 1:180
%        HM(i,j) = HM(i,j) * 10;
%    end
%end

%Plot Hough Transform
%theta = rad2deg(-pi/2:pi/180:pi/2-pi/180);
%rho = -maxrho:maxrho-1;
%imshow(uint8(HM),[],'xdata',theta,'ydata',rho);
%xlabel('\theta'),ylabel('\rho')
%axis on, axis normal;
%title('Hough Matrix');

% Transform back & plot
figure;
imshow(I); hold on;
for i = 1:maxrho*2
    for j = 1:180
        if HM(i,j)>33
            ans_rho = i - maxrho;
            ans_x = 0:sx;
            ans_y = (ans_rho - ans_x*cosd(j-90))/sind(j-90);
            plot(ans_x,ans_y);hold on;
            xlim([0 rows])
            axis equal
        end
    end
end

saveas(gcf,'letter_line.bmp')












        