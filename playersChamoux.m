function [numPlayers, activePlayer] = playersChamoux(fig, pointPlayers, activateTurn)
disp("PLAYERS")

playersArray = table('size',[1, 1],'VariableTypes',{'double'});
playersArray.Properties.VariableNames = ["skriv antal spilere"];

playersBox = uitable(fig);
playersBox.Position = [10 430 130 60];
playersBox.ColumnEditable = [true];

%sætter data til at være dataArray
playersBox.Data = playersArray;

%laver en knap til at vælge slaget
numButton = uicontrol(fig,'string', "Start spillet");
numButton.Position = [150 430 80 60];
numButton.BackgroundColor = '#90EE90';
%continueButton.Callback = 'uiresume(gcbf)'; - virker også
%taget fra nettet varargin laver en function med variabel antal input
%argumenter
numButton.Callback = @(varargin) uiresume(fig);

%venter på knappen bliver trykket
uiwait(fig)

numPlayers = table2array(playersBox.Data(1,1));
activePlayer = 1;

disp(numPlayers)

end