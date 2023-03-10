function [selectedDice, pointTurn, activateTurn] = drawOptionBox(fig, ...
    rollOptions, diceSpacing, rollNum, ...
    pointTurnSave,axesSelectedDice,axes)
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

% starter turen igen med mindre man trykker stop
activateTurn = 1;

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

% vis det sorterede array med muligheder
% disp(rollOptions)

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
            rollOptionsOnlyDuplicate=cat(2, ...
                rollOptionsOnlyDuplicate,rollOptions(:,i));
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
dataTable = table('size',[numCol, 4], ...
    'VariableTypes',{'string','double','double','logical'});
dataTable.Properties.VariableNames = ["Slag","Point","Terninger","Valg"];

%Hver mulighed tilføres til dataArray
for t = 1:numCol
    n = rollOptions(2,t);

    %checker type slag for hver søjle
    switch n

        %enkelt terning
        case 1
            %Indsætter forklarende tekst
            dataTable{t,1} = ...
                sprintf("Du har slået en %d'er ",rollOptions(1,t));

            %indsætter antal point
            dataTable{t,2} = rollOptions(4,t);

            %en terning er en terning :)
            dataTable{t,3} = 1;

            %cameron
        case 30
            %Indsætter forklarende tekst
            dataTable{t,1} = "Tilykke du har slået Cameron";

            %indsætter antal point
            dataTable{t,2} = rollOptions(4,t);

            %cameron er altid 6 terninger
            dataTable{t,3} = 6;

            %Undgå at tilføje alle cameron muligheder
            dataTable(2:numCol,:) =[];

            %Fjerner også unødige rækker fra rollOptions
            rollOptions(:,2:numCol) = [];
            break

            %3 par
        case 40
            %Indsætter forklarende tekst
            dataTable{t,1} = "Tilykke du har slået 3 Par i første slag";

            %indsætter antal point
            dataTable{t,2} = rollOptions(4,t);

            %hver par er 2 terninger
            dataTable{t,3} = 2;

            %Undgå at tilføje alle par
            dataTable(2:numCol,:) =[];
            break

        case 60
            %Indsætter forklarende tekst
            dataTable{t,1} = "ØV ingen terninger kan vælges, -4 point";

            %indsætter antal point
            dataTable{t,2} = -4;

            %Der fratages ingen terninger
            dataTable{t,3} = 0;

            %Turen stopper
            activateTurn = 0;

            break

        case 70
            %Indsætter forklarende tekst
            dataTable{t,1} = "Alle terninger tæller " + ...
                "- du må slå runden om";

            %indsætter antal point
            dataTable{t,2} = 0;

            %Der fratages ingen terninger
            dataTable{t,3} = 0;

            %Slår om
            activateTurn = 2;

            break

        otherwise
            %Indsætter forklarende tekst
            dataTable{t,1} = ...
            sprintf("Du har slået fødte %d'er",rollOptions(1,t));

            %indsætter antal point
            dataTable{t,2} = rollOptions(4,t);

            %Fødte er altid 3 terninger
            dataTable{t,3} = 3;


    end
end


%---------------------%
% laver tabelen over mulige valg

optionBox = uitable(fig);
optionBox.Position = [10 100 500 150];
optionBox.ColumnEditable = [false false false true];

%sætter data til at være dataArray
optionBox.Data = dataTable;

% laver en knap til at vælge slaget
continueButton = uicontrol(fig, ...
    'string', "Tag terninger fra, vælg mindst en mulighed herunder");
continueButton.Position = [20 260 260 30];
continueButton.BackgroundColor = '#90EE90';

% varargin laver en function med variabel antal input argumenter
continueButton.Callback = @continueButtonPushed;

%venter på knappen bliver trykket
uiwait(fig)


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

disp('outputOnlySelected')
disp(outputOnlySelected)



%checker om der er blevet valgt nogen slag
if isempty(outputOnlySelected) == 1
    disp("Da der ingen slag blev valgt har " + ...
        "functionen drawOptionBox sendt denne array ud: ")
    selectedDice = [0;0;-4;0];
    pointTurn = -4;
    activateTurn = 0;
    disp(selectedDice)
    return
end

%Fjerner om man har valgt den eller ej da dette altid nu vil være 1
outputOnlySelected(end,:) = [];
%Fjener om det er et unkikt slag da vi har fjernet alle der ikke er.
outputOnlySelected(3,:) = [];

disp("Functionen drawOptionBox har sendt denne array ud: ")
disp(outputOnlySelected)

%sletter uitable og gemmer knappen
continueButton.Enable = 'off';
delete(optionBox)

%sætter selectedDice værdien til brug i andre funktioner
selectedDice = outputOnlySelected;

% samlede point og tegning af de valgte terninger
pointTurn = drawSelectedDice(axesSelectedDice, ...
    selectedDice,diceSpacing,rollNum,pointTurn);

% points samlet for tur
disp('Tur point')
disp(pointTurn)

%knap til at ende turen og føre point til listen - hvis man har over 3,5
%point
%turPoint = 4;
if pointTurn > 3
    pointButton = uibutton(fig,'push','text', ...
        'overfør point til listen og stop tur',...
        'ButtonPushedFcn', @(pointButton,event) stopAndAddPoints);
    pointButton.Position = [300 260 180 30];
    pointButton.BackgroundColor = '#90EE90';
end

%Ændre continue knappens position og tekst, 
%Samt tænder den igen så den kan ses
continueButton.String = "slå igen";
continueButton.Position = [20 260 260 30];
continueButton.Enable = 'on';

%venter på knappen bliver trykket
uiwait(fig)

if pointTurn > 3
    delete(pointButton)
end

delete(continueButton)
    
    %functionen til stop knappen
    function stopAndAddPoints
        activateTurn = 0;
        uiresume(fig)
        cla(axes)
    end
    
    %Funktionen til slå videre knappen
    function continueButtonPushed(~,~)
        uiresume(fig)
        cla(axes)
    end


end