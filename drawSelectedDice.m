function pointTurn = drawSelectedDice(fig,selectedDice,diceSpacing,rollNum, pointTurn)

% slagets point
pointTurn = pointTurn;

height = 10;
width = 10;

axesSelectedDice = uiaxes(fig);
axesSelectedDice.Position = [500 150 300 400];

axis(axesSelectedDice,'off')
axis(axesSelectedDice,'equal')

axisy = 7 * (diceSpacing*10);

axesSelectedDice.YLim = [-5 axisy];
axesSelectedDice.XLim = [-5 5*(width*diceSpacing)];

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
            pointTurn = pointTurn + 20;

            %3 par
        case 40

            for tt = 1:2
                drawDice(selectedDice(1,t))
            end
            pointTurn = pointTurn + 15;

            %en enkelt terning
        case 1
            drawDice(selectedDice(1,t))
            if selectedDice(1,t) == 5
                pointTurn = pointTurn + 0.5;
            else
                pointTurn = pointTurn + 1;
            end

            % fejlslag - ingen terninger med værdi
        case 60
            drawDice(2)
            pointTurn = -4 ;


            % omslag - alle terninger har værdi
        case 70
            drawDice(2)
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

            for tt =1:3
                drawDice(selectedDice(1,t))
            end
            if selectedDice(1,t) == 1
                pointTurn = pointTurn + 10;
            else
                pointTurn = pointTurn + selectedDice(1,t);
            end

    end

end

% Tegner en firkant og kalder så drawDiceFace med en variable n.
% Opdatere også højden
    function drawDice(n)
        rectangle(axesSelectedDice, ...
            Position=[posx posy height width], ...
            Curvature=0.3,FaceColor=[1 1 1]);

        drawDiceFace(axesSelectedDice,n, ...
            posx,posy,width,height)

        posy = posy + height*diceSpacing;
    end

end
