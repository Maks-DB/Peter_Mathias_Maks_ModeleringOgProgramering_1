function selectedDice = drawOptionBox(fig, rollOptions)
%------------------

% function tager en array rollOptions fra dicePoints samt en figur fig, og
% laver en uitable så brugeren kan vælge hvilke terninger der skal beholdes
% og hvilke der blive tilbage, den sender så de valgte slag tilbage i et 
% array selectedDice med formen

%   [Øjne;
%    Slag Type;
%    Point;
%    Antal Terninger]
    
%Array har samme antal søgler som valgte terninger, fødte er kun 1 søjle.

%------------------
% Formattere array så den er nemmmere at arbejde med.

%forhåbentlig fjerner den alt for mange nuller?, ikke helt sikker.
format short

%tjekker hvor mange terninger
numCol = size(rollOptions,2);

%laver en ny array
rollOptionsNoZero = [];

%fjerner alle nul søjler
for t = 1:numCol
    if rollOptions(1,t) ~= 0
        % cat er concatenate, så vi tilføjer alle søjler der ikke
        % indeholder et 0, den tager 1 eller 2 som arugment alt efter
        % om den skal på under eller på siden.
        rollOptionsNoZero = cat(2,rollOptions(:,t),rollOptionsNoZero);
    end
end

%sætter rolloptions til at være den uden nuller og sletter variablen.
rollOptions = rollOptionsNoZero ;
clear rollOptionsNoZero

%Fjerner ens søjler f.eks hvis der er fødte, unique virker kun med rækker
%og vi transponere derfor matricen før og efter.
rollOptions = transpose(rollOptions);
rollOptions = unique(rollOptions,"rows");
rollOptions = transpose(rollOptions);

numCol = size(rollOptions,2);

%-----------------------------
% bygger data array

%vi laver et table og giver variablerne navne.
dataArray = table('size',[numCol, 4],'VariableTypes',{'string','double','double','logical'});
dataArray.Properties.VariableNames = ["Slag","Point","Terninger","Valg"];


%Hver mulighed tilføres til dataArray
for t = 1:numCol
    n = rollOptions(2,t);

    %checker type slag for hver søjle
    switch n

        %enkelt terning
        case 1
            %Indsætter forklarende tekst
            dataArray{t,1} = sprintf("Du har slået en %d'er ",rollOptions(1,t));

            %indsætter antal point
            dataArray{t,2} = rollOptions(4,t);

            %en terning er en terning :)
            dataArray{t,3} = 1;

        %cameron
        case 30
            %Indsætter forklarende tekst
            dataArray{t,1} = "Tilykke du har slået Cameron";

            %indsætter antal point
            dataArray{t,2} = rollOptions(4,t);

            %cameron er altid 6 terninger
            dataArray{t,3} = 6;
            
            %Undgå at tilføje alle cameron muligheder
            dataArray(2:6,:) =[];
            break

        %3 par
        case 40
            %Indsætter forklarende tekst
            dataArray{t,1} = "Tilykke du har slået 3 Par i første slag";

            %indsætter antal point
            dataArray{t,2} = rollOptions(4,t);

            %3 par er altid 6 terninger
            dataArray{t,3} = 6;

        
        otherwise
            %Indsætter forklarende tekst
            dataArray{t,1} = sprintf("Du har slået fødte %d'er",rollOptions(1,t));

            %indsætter antal point
            dataArray{t,2} = rollOptions(4,t);

            %Fødte er altdi 3 terninger
            dataArray{t,3} = 3;


    end
end


%---------------------
% laver tabelen

optionBox = uitable(fig);
optionBox.Position = [10 100 500 150];
optionBox.ColumnEditable = [false false false true];

%sætter data til at være dataArray
optionBox.Data = dataArray;

%laver en knap til at vælge slaget
continueButton = uicontrol(fig,'string', "Vælg Slag");
continueButton.Position = [210 260 100 30];
continueButton.BackgroundColor = '#90EE90';
%continueButton.Callback = 'uiresume(gcbf)'; - virker også
%taget fra nettet varargin laver en function med variabel antal input
%argumenter
continueButton.Callback = @(varargin) uiresume(fig);

%venter på knappen bliver trykket
uiwait(fig)

%bruger cell2mat til at lave det til en array
%eksData = cell2mat(optionBox.Data);

disp("Din Tabel burde vise: ")
disp(optionBox.Data)

output = table2array(optionBox.Data(:,3:4));
output = transpose(output);

output = cat(1,rollOptions,output);
disp("------------------------")


%fjerner alle ikke valgte rækker
outputOnlySelected = [];
for t = 1:size(output,2)
    if output(6,t) == 1
        outputOnlySelected = cat(2,output(:,t),outputOnlySelected);
    end
end

%Fjerner om man har valgt den eller ej da dette altid nu vil være 1
outputOnlySelected(end,:) = [];
outputOnlySelected(3,:) = [];

disp("Functionen drawOptionBox Har sendt denne array ud: ")
disp(outputOnlySelected)

selectedDice = outputOnlySelected;