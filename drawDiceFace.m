%tegner terninge øjne
function drawDiceFace(axes,n,posx,posy,width,height)
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