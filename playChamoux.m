function playChamoux
clc

%variabler der sendes til diceThrow
numDice = 2; %antal terninger   
rollArray = zeros(1,numDice);
diceSpacing = 1.1;

%varibler der sendes til dicePoints
legalArray = zeros(4,numDice);


%opretter Uifigure
fig = uifigure;
axes = uiaxes(fig);

axis(axes,'off')
axis(axes,'equal')

axisx = 7 * (diceSpacing*10)+2*5;

axes.XLim = [0 axisx];

drawnow

% ------




roll = diceThrow(axes,numDice,rollArray,diceSpacing);
disp(roll)

dicePoints(axes,numDice,roll,legalArray)


end
