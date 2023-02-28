function drawOptionBox(fig, rollOptions)
%------------------

%------------------
% Formattere array så den er nemmmere at arbejde med.
clc

format short

%tjekker hvor mange terninger
[~, numCol] = size(rollOptions);

%laver en ny array
rollOptionsNoZero = [];

%fjerner alle nul søjler
for t = 1:numCol
    if rollOptions(1,t) ~= 0
        rollOptionsNoZero = cat(2,rollOptions(:,t),rollOptionsNoZero);
    end
end

%sætter rolloptions til at være den uden nuller og sletter variablen.
rollOptions = rollOptionsNoZero ;
clear rollOptionsNoZero

%Fjerner ens søjler f.eks hvis der er fødte
rollOptions = transpose(rollOptions);
rollOptions = unique(rollOptions,"rows");
rollOptions = transpose(rollOptions);

disp(rollOptions)

[~,numCol] = size(rollOptions);

%-----------------------------
% bygger data array

dataArray = table('size',[numCol, 3],'VariableTypes',{'string','double','logical'});
dataArray.Properties.VariableNames = ["Slag","Point","Valg"];


disp(dataArray)

for t = 1:numCol
    n = rollOptions(2,t);

    %checker type slag for hver søjle
    if n == 1

        dataArray{t,1} = sprintf("Du har slået en %d'er ",rollOptions(1,t));

        %indsætter antal point
        dataArray{t,2} = rollOptions(4,t);

    end
end

disp(dataArray)

%---------------------
% laver tabelen

optionBox = uitable(fig);
optionBox.Position = [10 100 500 150];
optionBox.ColumnEditable = [false false true];

%sætter data til at være dataArray
optionBox.Data = dataArray;

%laver en knap til at vælge slaget
continueButton = uicontrol(fig,'string', "Vælg Slag");
%continueButton.Callback = 'uiresume(gcbf)'; - virker også
%taget fra nettet varargin laver en function med variabel antal input
%argumenter
continueButton.Callback = @(varargin) uiresume(fig);

%venter på knap tryk
uiwait(fig)

%bruger cell2mat til at lave det til en array
%eksData = cell2mat(optionBox.Data);

disp("----------------")
disp(optionBox.Data)

end




%for length(rollOptions)