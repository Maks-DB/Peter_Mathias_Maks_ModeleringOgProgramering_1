function pointTurn = drawSelectedDice(axesSelectedDice,selectedDice,diceSpacing, rollNum, pointTurn)
%--------------------------------
%Funktionen tegner terningerne fra selectedDice array i axesSelectedDice
%axerne, hvis der er fødte tegner den også en lille firkant om får at
%tydeliggøre at de hænger sammen. Siden der allerede var en switch case for
%hver mulighed findes point også her.

%Funktionen bruger :
% axesSelectedDice som er hvilken axe den skal tegne på
% selectedDice som er en array af valgte terninger
% diceSpacing som er afstanden mellem hver terning
% rollNum som er antal af kast
% pointTurn da den skal opdatere ikke overskrive denne variable

%--------------------------------


%Variabler til højde og bredde, egentlig burde de tages fra playChamoux,
%men da der ikke er planner om at ændre dem er de her "Hard Coded"
height = 10;
width = 10;

% Sætter positionerne på hjørnet af første terning
posx = rollNum*(width*(1.5*diceSpacing));
posy = 0;

for t = 1:size(selectedDice,2)
    n = selectedDice(2,t);

    switch n
        %cameron
        case 30
            for tt = 1:6
                drawDice(tt)
            end
            % sætter point hvis cameron vælges
            pointTurn = pointTurn + 20;

            %3 par
        case 40

            for tt = 1:2
                drawDice(selectedDice(1,t))
            end
             % sætter point hvis 3 par vælges
           pointTurn = pointTurn + 5; %giver 15 men ganges med 3 senere, 
            % fordi hvert par har sin egen søjle og der itteres over dem

            %en enkelt terning
        case 1
            drawDice(selectedDice(1,t))
 
            % sætter point hvis enkeltterning vælges
            if selectedDice(1,t) == 5
                pointTurn = pointTurn + 0.5;
            else
                pointTurn = pointTurn + 1;
            end

            % fejlslag - ingen terninger med værdi
        case 60
            %drawDice(2)

            % sætter point ved fejlslag
           pointTurn = -4 ;


            % omslag - alle terninger har værdi
        case 70
            %drawDice(2)

            % nulstiller point ved omslag
            pointTurn = 0;

            
            %fødte
        otherwise

            %tegner en firkant rundt om de fødte
            heightBornSquare = 3*((diceSpacing)*height);
            widthBornSquare = width * diceSpacing;
            posxBornSquare = posx - (0.5*diceSpacing);
            posyBornSquare = posy - (0.5*diceSpacing);

            rectangle(axesSelectedDice, ...
                Position = [posxBornSquare posyBornSquare widthBornSquare heightBornSquare], ...
                Curvature=0.1,LineWidth=0.8)
            
            %Laver 3 af den samme terning til fødte
            for tt = 1:3
                drawDice(selectedDice(1,t))
            end

            % sætter point ved fødte, tre af en slags
            if selectedDice(1,t) == 1
                pointTurn = pointTurn + 10;
            else
                pointTurn = pointTurn + selectedDice(1,t);
            end

    end

end


% Tegner en firkant og kalder så drawDiceFace med en variable n.
% Opdatere også højden til næste terning
    function drawDice(n)
        rectangle(axesSelectedDice, ...
            Position=[posx posy height width], ...
            Curvature=0.3,FaceColor=[1 1 1]);

        drawDiceFace(axesSelectedDice,n, ...
            posx,posy,width,height)

        posy = posy + height*diceSpacing;
    end

end
