function playChamoux


%variabler til playChamoux
usedDice = 0;

%variabler til spillere og point
numPlayers = 2;
%activePlayer = 0;
pointPlayers = zeros(2,numPlayers);
%pointTurn = 0;
activateTurn = 1;

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

% funktion hvor man vælger antal spillere og starter spillet
[numPlayers, activePlayer] = playersChamoux(fig, pointPlayers, activateTurn);
disp('antal spillere')
disp(numPlayers)
disp('den aktive spiller')
disp(activePlayer)

%Laver en  varible til antal rull i et slag
rollNum = 0;

while numDice >= 1 && activateTurn ~=0

    % Kalder diceThrow og retunere dit rul
    roll = diceThrow(axes,numDice,rollArray,diceSpacing);


    roll = [1 1 1 1 5 5 4];

    % Giver rullet til dicepoints
    rollOptions = dicePoints(numDice,roll,legalArray);

    %Giver rollOptions til drawOptionsBox
    [selectedDice, pointTurn] = drawOptionBox(fig, rollOptions, diceSpacing, rollNum);

    cla(axes)

    % Bliver tegnet af drawOptionBox - pga. nyt brugsmønster
    %drawSelectedDice(fig,selectedDice,diceSpacing,rollNum)
    
    for t = 1:size(selectedDice,2)
        if selectedDice(2,1) <= 16 && selectedDice(2,1) >= 10
            usedDice = usedDice + 3;
        else
            usedDice = usedDice + 1;
        end
    end
    
    clc
    disp("Brugte Terninger")
    disp(selectedDice)

    numDice = numDice - usedDice;
    usedDice = 0;

    rollNum = rollNum + 1;

    disp("Antal terninger tilbage")
    disp(numDice)

end
