%function drawOptionBox(fig, rollOptions)
function drawOptionBox

fig = uifigure;

%disp(rollOptions)

fig1 = fig;

d = {'male', 52, true};


optionBox = uitable(fig,'data',d);
optionBox.Position = [10 100 500 150];
optionBox.ColumnEditable = true;
optionBox.ColumnName = ["køn","alder","sandt/falsk"];

continueButton = uicontrol(fig1,'string', "Vælg Slag");
%continueButton.Callback = 'uiresume(gcbf)'; - virker også
%tager fra nettet varargin laver en function med variabel antal input
%argumenter
continueButton.Callback = @(varargin) uiresume(fig);

uiwait(fig)

eksData = optionBox.Data(3);

disp(eksData)

end




%for length(rollOptions)