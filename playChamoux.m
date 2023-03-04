function playChamoux


%variabler til playChamoux
usedDice = 0;
pointsTurn = 0;

%variabler til spillere og point
numPlayers = 2;
activePlayer = 0;
pointPlayers = zeros(2,numPlayers);
pointTurn = 0;
activateTurn = 1;

%variabler der sendes til diceThrow
numDice = 7; %antal terninger
rollArray = zeros(1,numDice);
diceSpacing = 1.1; %Afstand mellem terninger

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
% while løkke for et spil
while numPlayers > 0
    disp('start spil loop')
    numDice = 7; %antal terninger
    activateTurn = 0;


    % while løkke for en runde
    while activateTurn == 0 && numPlayers > 0
        disp('start runde loop')

        if activePlayer > numPlayers
            activePlayer = 1;
        end

        activateTurn = activateTurn + 1;

        activePlayerText = uitextarea(fig, ...
            "Value", {'activePlayer'} ,"Position",[300 450 150 30]);

        % while løkke for en tur
        while numDice >= 1 && activateTurn ~=0

            % Kalder diceThrow og retunere dit rul
            roll = diceThrow(axes,numDice,rollArray,diceSpacing);

            %roll = [1 1 1 1 5 5 4];

            % Giver rullet til dicepoints
            rollOptions = dicePoints(numDice,roll,legalArray);

            %Giver rollOptions til drawOptionsBox
            [selectedDice, pointTurn] = drawOptionBox(fig, rollOptions, diceSpacing, rollNum, pointTurn);

            %Fjerner terninger til næste omgang
            cla(axes)

            % Bliver tegnet af drawOptionBox - pga. nyt brugsmønster
            %drawSelectedDice(fig,selectedDice,diceSpacing,rollNum)

            %Finder antal brugte terninger
            for t = 1:size(selectedDice,2)
                usedDice = usedDice + selectedDice(4);
            end

            %Finder antal point
            for t = 1:size(selectedDice,2)
                pointsTurn = pointsTurn + selectedDice(3);
            end


            %Fjerner brugte terninger og sætter usedDice tilbage til 0 til næste
            %loop
            numDice = numDice - usedDice;
            usedDice = 0;

            %Vi køre et extra rull
            rollNum = rollNum + 1;

            disp("Antal terninger tilbage")
            disp(numDice)

        end
    end
end
