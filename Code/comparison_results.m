

% elephant
X1 = [0.1339 0.2461 0.3360 0.4272];
X2 = [0.1339 0.1737 0.2672 0.3581];

%Curry2
X3 = [0.03813 0.7038 0.8356 0.8985];
X4 = [0.3813 0.5546 0.6501 0.7047];

%Cup

X5 = [0.2036 0.7173 0.8371 0.9325];
X6 = [ 0.2036 0.4295 0.5558 0.6056];


% battery

X7 = [0.0923 0.6721 0.7975 0.9];
X8 = [ 0.0923 0.3451 0.4721 0.6223];

%spice ginger - full2

X9 = [ 0.1393 0.1967 0.2810 0.4165];
X10 = [ 0.1393 0.1537 0.1788 0.18];

Y = [ 0.999 0.6223; 0.9325 0.6056; 0.8985 0.7047; 0.4165 0.18];
x = [1 2 3 4 ]


% 
% bar(Y,'grouped');
% legend('Our method', 'Random');
% ylabel('Belief')
% xlabel('Object');
% %title('Results after 4 views');
% text(1,0.7,'Battery');
% text(2,0.7,'Cup');
% text(3,0.8,'Curry Box');
% text(3.7,0.45,'Spice Bottle');
%colormap summer
% figure;
% 
% hold on;
% plot(x,X7,'r');
% plot(x,X8,'b');
% plot(X7,'k*');
% %set(h,'XTickLabel',x);
% plot(X8,'k*');
% ylabel('Belief')
% xlabel('Battery');
% legend('Our method', 'Random','Location','NorthWest');
%title('Results after 4 views of the Battery');

% Y1 = [0.999 0.998 0.9806 0.6113 0.1509 0.9995 0.9755 0.3841 0.9648 0.97   0.9989 0.9998 0.6721 0.0974 0.0558 0.0825 0.9106 1 ];
% Y2= [ 0.789 0.8   0.85   0.3841 0.0739 0.03   0.92   0.0483 0.9    0.0205 0.0205 0.9027 0.0511 0.0603 0.1509 0.0904 0.8316 0.84];
% %x = [0 20 40 60 80 100 120 140 160 180 200 220 240 260 280 300 320 340]
% x1 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
% % t = 0:20:340; 
%   figure;
% 
% hold on;
% plot(Y1,'r');
% plot(Y2,'b');
% %set(gca,'XTick',0);
% %set(gca,'XTickLabel',x1);
% 
% %bar(1:18, Y1, 1:18, Y2);
% 
% %Y = [Y1' Y2'];
% %bar(Y,'grouped');
% 
% 
% ylabel('Belief')
% xlabel('Battery ');
% legend('Our method', 'Random','Location','SouthWest');
% %title('Results after 2 views: Each pose is ');
% 
