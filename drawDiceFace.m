function drawDiceFace(axes,n,posx,posy,width,height)
%-------------------------
%Funktionen tegner øjne på en terning

%Funktionen bruger:
%axes som er den axe der tegnes på
% n som er det slag der er lavet og derved det antal øjne der skal tegnes
% posx og posy er positionen af terning øjnene skal laves på
% width og height er højden og bredden på terningen

%-------------------------


dia = 1.8; %radius på terning øjne


midPos = 0.5;
smallPos = 0.25;
bigPos = 0.75;


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
        r = rectangle(axes,Position=[cornerx cornery dia dia]);
        r.Curvature=[1 1];
        r.FaceColor='black';
    end

% bestemmer hjørnet af øjne.
    function corner = cornerPos(posVar, rectSize,scalar)
        corner = (posVar + rectSize*scalar) - dia*0.5;

    end


end