function playChamoux

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
axes.YLim = [-5 5];

drawnow

% ------

%Laver en  varible til antal rull i et slag
rollNum = 0;

while numDice >= 1

    % Kalder diceThrow og retunere dit rul
    roll = diceThrow(axes,numDice,rollArray,diceSpacing);

    % Giver rullet til dicepoints
    rollOptions = dicePoints(numDice,roll,legalArray);

    %Giver rollOptions til drawOptionsBox
    selectedDice = drawOptionBox(fig,rollOptions);
    
    cla(axes)

    drawSelectedDice(fig,selectedDice,diceSpacing,rollNum)
    

    numDice = numDice - size(selectedDice,2);
    rollNum = rollNum + 1;

end
