function [numPlayers] = playersChamoux(fig, pointPlayers, activateTurn)
%function [numPlayers, activePlayer] = playersChamoux(fig, pointPlayers, activateTurn, activePlayer)

% active player er både input og output - virker ikke uden denne 
%activePlayer=activePlayer;

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

% % tekst der viser den aktive spiller
% activePlayerText = uitextarea(fig, ...
%     "Value", {'active player'} ,"Position",[300 450 150 30]);

disp('Player')
disp('activePlayer')




%venter på knappen bliver trykket
uiwait(fig)

numPlayers = table2array(playersBox.Data(1,1));
activePlayer = 1;

disp(numPlayers)

end