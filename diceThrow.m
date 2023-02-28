function roll = diceThrow (axes,numDice,rollArray,diceSpacing)

%numDice = 7; %antal terninger    

height = 10; %højden af terningen
width = 10; %Bredden af terningen

startPosx= 5; %x positionen af første terning

numRolls = 10; %antal slag

%rollArray = zeros(1,numDice);

posx = startPosx; % posx bruges i hele dokumentet til at se positionen af terningen
posy = 0-height/2; %sætter midten af terningen til at være i 0 y

%diceSpacing = 1.1; %afstand scalar mellem terninger. 

%laver akser på koordinat systemet
axisx = numDice * (diceSpacing*width)+2*posx; %x aksen skal være lang nok til alle terningerne
axisy = axisx/2;

% ax.XLim = [0 axisx];
% ax.YLim = [-axisy axisy];

%Tegner terningerne 
for t=1:numRolls

for h = 1:numDice
    rectangle(axes,Position=[posx posy height width],Curvature=0.3);

    %ruller terningerne
    n = randi(6);
    drawDiceFace(n)

    %gemmer terninge slaget
    if t == numRolls
        rollArray(h)=n;
    end

    %Rykker næste terning
    posx = posx+diceSpacing*width;
end

%pause så man kan nå at se noget ske. 
pause(0.1)

%genstarter til næste loop

%undgå at slette til sidst
if t == numRolls
    %disp(rollArray)
    roll = rollArray;
    break
end

posx = startPosx;
cla(axes)
end

disp("Færdig med at kaste")


    %tegner terninge øjne 
    function drawDiceFace(n)
        rad = 1.8; %radius på terning øjne

        midPos = 0.5;
        smallPos = 0.2;
        bigPos = 0.8;
        
        
        %switch i stedet for if else fordi det er hurtigere B)
        switch n
            case 1
                %Tegner en i midten
                cornerx = cornerPos(posx,width,midPos);
                cornery = cornerPos(posy,height,midPos);
                
                %laver øjet 
                drawPip
            case 2
                %tegner en i syd-vest hjørnet agtigt
                cornerx = cornerPos(posx,width,smallPos);
                cornery = cornerPos(posy,height,smallPos);

                drawPip

                %nord-øst hjørne
                cornerx = cornerPos(posx,width,bigPos);
                cornery = cornerPos(posy,height,bigPos);
                
                drawPip

            case 3
                %syd-vesthjørne
                cornerx = cornerPos(posx,width,smallPos);
                cornery = cornerPos(posy,height,smallPos);
                drawPip

                %nord-øst hjørne
                cornerx = cornerPos(posx,width,bigPos);
                cornery = cornerPos(posy,height,bigPos);
                drawPip
                
                %Midten
                cornerx = cornerPos(posx,width,midPos);
                cornery = cornerPos(posy,height,midPos);
                drawPip
            case 4
                %syd-vesthjørne
                cornerx = cornerPos(posx,width,smallPos);
                cornery = cornerPos(posy,height,smallPos);
                drawPip

                %nord-vesthjørne
                cornerx = cornerPos(posx,width,smallPos);
                cornery = cornerPos(posy,height,bigPos);
                drawPip

                %syd-østhjørne
                cornerx = cornerPos(posx,width,bigPos);
                cornery = cornerPos(posy,height,smallPos);
                drawPip

                %nord-østhjørne
                cornerx = cornerPos(posx,width,bigPos);
                cornery = cornerPos(posy,height,bigPos);
                drawPip

            case 5
                %midten
                cornerx = cornerPos(posx,width,midPos);
                cornery = cornerPos(posy,height,midPos);
                drawPip

                %syd-vesthjørne
                cornerx = cornerPos(posx,width,smallPos);
                cornery = cornerPos(posy,height,smallPos);
                drawPip

                %nord-vesthjørne
                cornerx = cornerPos(posx,width,smallPos);
                cornery = cornerPos(posy,height,bigPos);
                drawPip

                %syd-østhjørne
                cornerx = cornerPos(posx,width,bigPos);
                cornery = cornerPos(posy,height,smallPos);
                drawPip

                %nord-østhjørne
                cornerx = cornerPos(posx,width,bigPos);
                cornery = cornerPos(posy,height,bigPos);
                drawPip

            case 6
                %syd-vesthjørne
                cornerx = cornerPos(posx,width,smallPos);
                cornery = cornerPos(posy,height,smallPos);
                drawPip

                %nord-vesthjørne
                cornerx = cornerPos(posx,width,smallPos);
                cornery = cornerPos(posy,height,bigPos);
                drawPip

                %syd-østhjørne
                cornerx = cornerPos(posx,width,bigPos);
                cornery = cornerPos(posy,height,smallPos);
                drawPip

                %nord-østhjørne
                cornerx = cornerPos(posx,width,bigPos);
                cornery = cornerPos(posy,height,bigPos);
                drawPip

                %mid-vest 
                cornerx = cornerPos(posx,width,smallPos);
                cornery = cornerPos(posy,width,midPos);
                drawPip

                %mid-øst 
                cornerx = cornerPos(posx,width,bigPos);
                cornery = cornerPos(posy,width,midPos);
                drawPip
        end
        
        %Tegner øjne
        function drawPip
            r = rectangle(axes,Position=[cornerx cornery rad rad]);
            r.Curvature=[1 1];
            r.FaceColor='black';
        end
        
        % bestemmer hjørnet af øjne.
        function corner = cornerPos(posVar, rectSize,scalar)
            corner = (posVar + rectSize*scalar) - rad*scalar;

        end
        

    end 
%run("dicePoints(numDice, rollArray)")
end

    
