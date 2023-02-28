function playChamoux
clc

%opretter Uifigure
fig = uifigure;
ax = uiaxes(fig);

%variabler der sendes til diceThrow
numDice = 7; %antal terninger   
rollArray = zeros(1,numDice);
legalArray = zeros(4,numDice);

% @Maks tester ny knap
startButton = uibutton(fig,'push','ButtonPushedFcn',@(startButton,event) diceThrow(startButton,ax,numDice,rollArray,legalArray));
%sb.Value = 0;
startButton.Text = "Roll Dice";
%disp(rollArray);
end
