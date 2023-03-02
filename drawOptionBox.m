function [selectedDice, pointTurn] = drawOptionBox(fig, rollOptions, diceSpacing, rollNum, pointTurnSave)
%------------------

% function tager en array rollOptions fra dicePoints samt en figur fig, og
% laver en uitable så brugeren kan vælge hvilke terninger der skal beholdes
% og hvilke der blive tilbage, den sender så de valgte slag tilbage i et
% array selectedDice med formen

%   [Øjne;
%    Slag Type;
%    Point;
%    Antal Terninger]

%Array har samme antal søjler som valgte terninger, fødte er kun 1 søjle.

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

%variabel der sender turens point
pointTurn = pointTurnSave;

%Fjerner ens søjler f.eks hvis der er fødte, unique virker kun med rækker
%og vi transponere derfor matricen før og efter. Skal ikke gøres for 3 par
%da de håndteres anderledes

disp(rollOptions)
if rollOptions(2,1) ~= 40
    rollOptions = transpose(rollOptions);
    rollOptionsUnique = unique(rollOptions,"rows");
    rollOptions = transpose(rollOptionsUnique);
else
    %Finder alle IKKE unikke søgler, bruger unique til at finde positionen
    %på de unikke søgler og henter alle andre søgler end dette.
    [~,duplicatePos,~] = unique(rollOptions(1,:));

    %laver en ny array
    rollOptionsOnlyDuplicate = [];

    %tiljøjer de ikke-unikke søjler til den nye array
    for i = 1:size(rollOptions,2)
        if ismember(i,duplicatePos) == 0
            rollOptionsOnlyDuplicate=cat(2,rollOptionsOnlyDuplicate,rollOptions(:,i));
        end
    end

    % Gemmer til sidst den ny array i rollOptions
    rollOptions = rollOptionsOnlyDuplicate;
    clear rollOptionsOnlyDuplicate
end


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
            dataArray(2:numCol,:) =[];

            %Fjerner også unødige rækker fra rollOptions
            rollOptions(:,2:numCol) = [];
            break

            %3 par
        case 40
            %Indsætter forklarende tekst
            dataArray{t,1} = "Tilykke du har slået 3 Par i første slag";

            %indsætter antal point
            dataArray{t,2} = rollOptions(4,t);

            %3 par er altid 6 terninger
            dataArray{t,3} = 6;

            %Undgå at tilføje alle par
            dataArray(2:numCol,:) =[];
            break

        case 60
            %Indsætter forklarende tekst
            dataArray{t,1} = "ØV ingen terninger kan vælges, -4 point";

            %indsætter antal point
            dataArray{t,2} = -4;

            %Der fratages ingen terninger
            dataArray{t,3} = 0;

            break

        case 70
            %Indsætter forklarende tekst
            dataArray{t,1} = "Alle terninger tæller - du må slå runden om";

            %indsætter antal point
            dataArray{t,2} = 0;

            %Der fratages ingen terninger
            dataArray{t,3} = 0;

            break

        otherwise
            %Indsætter forklarende tekst
            dataArray{t,1} = sprintf("Du har slået fødte %d'er",rollOptions(1,t));

            %indsætter antal point
            dataArray{t,2} = rollOptions(4,t);

            %Fødte er altid 3 terninger
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
continueButton = uicontrol(fig,'string', "Tag terninger fra, vælg mindst en mulighed herunder");
continueButton.Position = [20 260 260 30];
continueButton.BackgroundColor = '#90EE90';
%continueButton.Callback = 'uiresume(gcbf)'; - virker også
%taget fra nettet varargin laver en function med variabel antal input
%argumenter
continueButton.Callback = @(varargin) uiresume(fig);

%venter på knappen bliver trykket
uiwait(fig)


%bruger cell2mat til at lave det til en array
%eksData = cell2mat(optionBox.Data);

disp("Tabellen efter valg burde have set sådanne ud: ")
disp(optionBox.Data)

output = table2array(optionBox.Data(:,3:4));
output = transpose(output);

%tjekker om der er 3 par, hvis der er skal output forlænges
if rollOptions(2,1) == 40
    output = [output output output];
end

output = cat(1,rollOptions,output);
disp("------------------------")

%fjerner alle ikke valgte rækker
outputOnlySelected = [];
for t = 1:size(output,2)
    if output(6,t) == 1
        outputOnlySelected = cat(2,output(:,t),outputOnlySelected);
    end
end

disp(outputOnlySelected)



%checker om der er blevet valgt nogen slag
if isempty(outputOnlySelected) == 1
    disp("Da der ingen slag blev valgt har functionen drawOptionBox sendt denne array ud: ")
    selectedDice = [0;0;0;0];
    disp(selectedDice)
    return
end

%Fjerner om man har valgt den eller ej da dette altid nu vil være 1
outputOnlySelected(end,:) = [];
%Fjenrer om det er et unkikt slag da vi har fjernet alle der ikke er.
outputOnlySelected(3,:) = [];

disp("Functionen drawOptionBox har sendt denne array ud: ")
disp(outputOnlySelected)

%sletter knappen og uitable
delete(continueButton)
delete(optionBox)

%sætter selectedDice værdien til brug i andre funktioner
selectedDice = outputOnlySelected;

%Maks tester
pointTurn = drawSelectedDice(fig,selectedDice,diceSpacing,rollNum,pointTurn);

% points samlet for tur
disp('Tur point')
disp(pointTurn)

%knap til at ende turen og føre point til listen - hvis man har over 3,5
%point
%turPoint = 4;
if pointTurn > 3
    pointButton = uibutton(fig,'push','text','overfør point til listen og stop tur',...        
        'ButtonPushedFcn', @(pointButton,event) disp('nogen trykker'));
    pointButton.Position = [300 260 180 30];
    pointButton.BackgroundColor = '#90EE90';
    %continueButton.Callback = 'uiresume(gcbf)'; - virker også
    %taget fra nettet varargin laver en function med variabel antal input
    %argumenter
end


continueButton = uicontrol(fig,'string', "slå igen");
continueButton.Position = [20 260 260 30];
continueButton.BackgroundColor = '#90EE90';
%continueButton.Callback = 'uiresume(gcbf)'; - virker også
%taget fra nettet varargin laver en function med variabel antal input
%argumenter
continueButton.Callback = @(varargin) uiresume(fig);

%venter på knappen bliver trykket
uiwait(fig)

return