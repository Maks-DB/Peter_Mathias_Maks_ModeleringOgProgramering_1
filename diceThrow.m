function roll = diceThrow (axes,numDice,rollArray,diceSpacing)

height = 10; %højden af terningen
width = 10; %Bredden af terningen

startPosx= 0; %x positionen af første terning

numRolls = 10; %antal slag

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
    rectangle(axes,Position=[posx posy height width],Curvature=0.3,FaceColor=[1 1 1]);

    %ruller terningerne
    n = randi(6);
    drawDiceFace(axes,n,posx,posy,width,height)

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
end

    
