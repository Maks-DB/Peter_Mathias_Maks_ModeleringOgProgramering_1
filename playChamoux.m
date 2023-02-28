function playChamoux
clc

%variabler der sendes til diceThrow
numDice = 7; %antal terninger   
rollArray = zeros(1,numDice);
diceSpacing = 1.1;

%varibler der sendes til dicePoints
legalArray = zeros(4,numDice);


%opretter Uifigure
fig = uifigure;
axes = uiaxes(fig);

fig.Position = [100 100 1000 500];

axes.Position = [0 100 500 500];

axis(axes,'off')
axis(axes,'equal')

axisx = 7 * (diceSpacing*10);

axes.XLim = [0 axisx];
axes.YLim = [-10 10];

drawnow

% ------


% Kalder diceThrow og retunere dit rull
roll = diceThrow(axes,numDice,rollArray,diceSpacing);
disp(roll)

% Giver rullet til dicepoints 
rollOptions = dicePoints(numDice,roll,legalArray);

drawOptionBox(fig,rollOptions)


end
