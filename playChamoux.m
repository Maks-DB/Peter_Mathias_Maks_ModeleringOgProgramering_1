function playChamoux


%variabler til playChamoux
usedDice = 0;
quitGame = 0;

%variabler til spillere og point
numPlayers = 2;
activePlayer = 0;
pointPlayers = zeros(2,numPlayers);
activateTurn = 1;

%variabler der sendes til diceThrow
numDiceStart = 7; %antal terninger
rollArray = zeros(1,numDiceStart);
diceSpacing = 1.1; %Afstand mellem terninger
width = 10;
height = 10;

%varibler der sendes til dicePoints
legalArray = zeros(4,numDiceStart);

%opretter Uifigure
fig = uifigure;
axes = uiaxes(fig);

fig.Position = [100 100 1000 500];

%Terninge axis
%---------
axes.Position = [0 100 500 500];

axis(axes,'off')
axis(axes,'equal')

axisx = 7 * (diceSpacing*10);

axes.XLim = [0 axisx];
axes.YLim = [-5 5];
%---------

%gemte terninger axis
%--------
axesSelectedDice = uiaxes(fig);
axesSelectedDice.Position = [500 150 300 400];

axis(axesSelectedDice,'off')
axis(axesSelectedDice,'equal')

axisy = 7 * (diceSpacing*10);

axesSelectedDice.YLim = [-5 axisy];
axesSelectedDice.XLim = [-5 5*(width*diceSpacing)];
%--------


drawnow

% ------

% funktion hvor man vælger antal spillere og starter spillet
[numPlayers, activePlayer] = playersChamoux(fig, pointPlayers, activateTurn, activePlayer);
disp('antal spillere')
disp(numPlayers)
disp('den aktive spiller')
disp(activePlayer)


if numPlayers <= 0
    disp("Du har ingen spillere, dette er altså ikke et 0 player spil din pap cykel.")
    return
end

%Laver en uitable til point pr spiller
pointBox = playerPoints(fig,numPlayers);


% while løkke for et spil
while quitGame == 0
    disp('start spil loop')
    numDice = 7; %antal terninger
    activateTurn = 0;


    % while løkke for en runde
    % while activateTurn == 0 && numPlayers > 0

    for activePlayerRound = 1:numPlayers
        disp('start runde loop')

        if activePlayer > numPlayers
            activePlayer = 1;
        end

        activateTurn = activateTurn + 1;

        % Sætter point til 0, til næste spiller
        pointTurn = 0;
        rollNum = 0;
        numDice = numDiceStart;

        % while løkke for en tur
        while numDice >= 1 && activateTurn ~=0

            % Kalder diceThrow og retunere dit rul
            roll = diceThrow(axes,numDice,rollArray,diceSpacing);

            %roll = [1 1 1 1 5 5 4];

            % Giver rullet til dicepoints
            rollOptions = dicePoints(numDice,roll,legalArray);

            %Giver rollOptions til drawOptionsBox
            [selectedDice, pointTurn,activateTurn] = drawOptionBox(fig, ...
                rollOptions, diceSpacing, rollNum, pointTurn,axesSelectedDice);

            %Fjerner terninger til næste omgang

            % Bliver tegnet af drawOptionBox - pga. nyt brugsmønster
            %drawSelectedDice(fig,selectedDice,diceSpacing,rollNum)

            %Finder antal brugte terninger
            for t = 1:size(selectedDice,2)
                usedDice = usedDice + selectedDice(4);
            end
            

            %Fjerner brugte terninger og sætter usedDice tilbage til 0 til næste
            %loop
            numDice = numDice - usedDice;
            usedDice = 0;

            %Vi køre et extra rull
            rollNum = rollNum + 1;

            disp("Antal terninger tilbage")
            disp(numDice)
            
            disp(pointBox.Data)

            

        end
        
        %Tilføjer antal point til point tablellen 
        pointBox.Data{1,activePlayerRound} = ...
            pointBox.Data{1,activePlayerRound} + pointTurn;
        
        cla(axesSelectedDice)
        clc
        disp("Runden er slut")
    end
    clc

    disp(pointBox.Data)
    
    %Finder hvilken spiller har flest point, og hvor mange point det så er
    [highestPoint,winner] = max(table2array(pointBox.Data));

    disp(highestPoint)
    
    %Tjekker om nogen har vundet
    if highestPoint >= 43
        quitGame = 1;
    end

end

clc

%Viser vinderen
disp(winner)
disp(highestPoint)

fprintf("AND THE WINNER ISSS..... spiller %d med %.1f point!!",winner,highestPoint);
