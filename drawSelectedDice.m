function drawSelectedDice(fig,selectedDice,diceSpacing,rollNum)

height = 10;
width = 10;

axesSelectedDice = uiaxes(fig);
axesSelectedDice.Position = [500 150 300 400];

axis(axesSelectedDice,'off')
axis(axesSelectedDice,'equal')

axisy = 7 * (diceSpacing*10);

axesSelectedDice.YLim = [0 axisy];
axesSelectedDice.XLim = [0 5*(width*diceSpacing)];

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

            %3 par
        case 40

            for tt = 1:2
                drawDice(selectedDice(1,t))
            end

            %en enkelt terning
        case 1
            drawDice(selectedDice(1,t))


            % fejlslag - ingen terninger med værdi
        case 60
            drawDice(2)


            % omslag - alle terninger har værdi
        case 70
            drawDice(2)

        case 11
            drawDice(1)
            drawDice(1)
            drawDice(1)
        case 12
            drawDice(2)
            drawDice(2)
            drawDice(2)
        case 13
            drawDice(3)
            drawDice(3)
            drawDice(3)
        case 14
            drawDice(4)
            drawDice(4)
            drawDice(4)
        case 15
            drawDice(5)
            drawDice(5)
            drawDice(5)
        case 16
            drawDice(6)
            drawDice(6)
            drawDice(6)

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
