%function drawOptionBox(fig, rollOptions)
%------------------
function drawOptionBox
fig = uifigure;

rollOptions = [1 2 3 4 5 6 4;
              30 30 30 30 30 30 30;
               1 1 1 1 1 1 1;
               20 20 20 20 20 20 20];


%------------------
% Formattere array så den er nemmmere at arbejde med.

%forhåbentlig fjerner den alt for mange nuller?, ikke helt sikker.
format short

%tjekker hvor mange terninger
[~, numCol] = size(rollOptions);

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

disp(rollOptions)

[~,numCol] = size(rollOptions);

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

disp(dataArray)

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
continueButton.BackgroundColor = 'g';
%continueButton.Callback = 'uiresume(gcbf)'; - virker også
%taget fra nettet varargin laver en function med variabel antal input
%argumenter
continueButton.Callback = @(varargin) uiresume(fig);

%venter på knappen bliver trykket
uiwait(fig)

%bruger cell2mat til at lave det til en array
%eksData = cell2mat(optionBox.Data);

disp("----------------")
disp(optionBox.Data)

end




%for length(rollOptions)