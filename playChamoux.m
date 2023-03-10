function playChamoux
clc

%variabler til playChamoux
usedDice = 0;
quitGame = 0;

%variabler der sendes til diceThrow
numDiceStart = 7; %antal terninger
diceSpacing = 1.1; %Afstand mellem terninger
width = 10;

%varibler der sendes til dicePoints (inputvariabel sendes til dicePoints)
legalArray = zeros(4,numDiceStart);

%opretter Uifigure
fig = uifigure;
axes = uiaxes(fig);

fig.Position = [100 100 1000 500];

%Terning axis
%---------
axes.Position = [0 100 500 500];

axis(axes,'off')
axis(axes,'equal')

axisx = numDiceStart * (diceSpacing*10);

axes.XLim = [0 axisx];
axes.YLim = [-5 5];
%---------

% Gemte terninger axis
%--------
axesSelectedDice = uiaxes(fig);
axesSelectedDice.Position = [500 150 500 400];

axis(axesSelectedDice,'off')
axis(axesSelectedDice,'equal')

axisy = 7 * (diceSpacing*10);

axesSelectedDice.YLim = [-5 axisy];
axesSelectedDice.XLim = [-5 8*(width*diceSpacing)];
%--------


drawnow


% funktion hvor man vælger antal spillere og starter spillet
[numPlayers] = playersChamoux(fig);

%Tjekker om der ingen spillere er og lukker programmet
if numPlayers <= 0
    uialert(fig, ...
        "Du har ingen spillere, dette er altså ikke et 0 player spil" ...
        ,"Du skal vælge et korrekt antal spillere",'Icon','warning', ...
        'CloseFcn',@(varargin) close(fig));
    return
end

%Laver en uitable til point pr spiller
pointBox = playerPoints(fig,numPlayers);

% while løkke for et spil
while quitGame == 0

    % vælger om der skal spilles en tur
    activateTurn = 0;

    % forløkke for spillerunder
    for activePlayerRound = 1:numPlayers

        % tekst der viser den aktive spiller
        activePlayerArray = table(activePlayerRound);
        activePlayerArray.Properties.VariableNames = "Spilleren der har turen";

        activePlayerBox = uitable(fig);
        activePlayerBox.Position = [300 430 170 60];
        activePlayerBox.ColumnEditable = false;

        %sætter data til at være dataArray
        activePlayerBox.Data = activePlayerArray;

        activateTurn = activateTurn + 1;

        % Sætter point til 0, til næste spiller
        pointTurn = 0;
        rollNum = 0;
        numDice = numDiceStart;

        % while løkke for en tur
        while numDice >= 1 && activateTurn ~=0

            %Hvis activateTurn er 2 betyder det at der ska slås helt om
            if activateTurn == 2
                activateTurn = 1;
                numDice = numDiceStart;
                rollNum = 0;
                pointTurn = 0;
                cla(axesSelectedDice)
            end


            % Kalder diceThrow og retunere dit rul
            roll = diceThrow(axes,numDice,diceSpacing);

            % Giver rullet til dicepoints
            rollOptions = dicePoints(numDice,roll,legalArray);

            %Giver rollOptions til drawOptionsBox
            [selectedDice, pointTurn, activateTurn] = drawOptionBox(fig, ...
                rollOptions, diceSpacing, rollNum, pointTurn, axesSelectedDice,axes);

            %Finder antal brugte terninger
            for t = 1:size(selectedDice,2)
                usedDice = usedDice + selectedDice(4);
            end

            %Fjerner brugte terninger og sætter usedDice tilbage til 0 til næste
            %loop
            numDice = numDice - usedDice;
            usedDice = 0;

            % Tæller hvor mange gange der er blevet slået i turen, bruges
            % blandt andet til at at tegne de valgte terninger
            rollNum = rollNum + 1;

            disp("Antal terninger tilbage")
            disp(numDice)

            disp(pointBox.Data)

        end



        %Tilføjer antal point til point tablellen
        if numDice <= 0
            pointBox.Data{1,activePlayerRound} =... 
                pointBox.Data{1,activePlayerRound}-4;
        else
            pointBox.Data{1,activePlayerRound} = ...
                pointBox.Data{1,activePlayerRound} + pointTurn;

            %Fjerner de tidligere valgte terninger
            cla(axesSelectedDice)
            disp("Runden er slut")
        end
    end
    clc

    disp(pointBox.Data)

    %Finder hvilken spiller har flest point, og hvor mange point det så er
    [highestPoint,winner] = max(table2array(pointBox.Data));

    disp(highestPoint)

    %Tjekker om nogen har vundet
    if highestPoint >= 43.5
        quitGame = 1;
    end

end

%Viser vinderen
disp(winner)
disp(highestPoint)

%Laver en alertbox når nogen vinder, og lukker figuren når der trykkes ok
winnerMessage = sprintf("AND THE WINNER ISSS..... spiller %d med %.1f point!!",winner,highestPoint);

uialert(fig,winnerMessage,"Tilykke!",'Icon','success','CloseFcn',@(varargin) close(fig));

