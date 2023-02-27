function playChamoux
clc

%ved ikke hvad jeg laver haha, forsøg på at bruge uifigure 
fig = uifigure;
ax = uiaxes(fig);

% @Peter knap - udkommenteret da @Maks tester ny knap
%sb = uibutton(fig,'state','ValueChangedFcn','uiresume()');
%sb.Value = 0;
%sb.Text = "Roll Dice";

% @Maks tester ny knap
startButton = uibutton(fig,'push','ButtonPushedFcn',@(startButton,event) diceThrow(startButton,ax));
%sb.Value = 0;
startButton.Text = "Roll Dice";
end
