function pointBox = playerPoints(fig,numPlayers)
%-------------------------
%funktionen tegner en kasse til at holde styr på spillernes point. Den
%retunere pointBox så antal point kan ændres i andre funktioner.
%-------------------------

%bredden defineres
width = 200;

%laver et tomt cell array
pointsCell = {};

%Fylder cell array ud med spiller nr og gør bredden større nu flere
%spillere der er
for t = 1:numPlayers
    pointsCell(t) =  cellstr(sprintf("Spiller %d",t));
    width = width + 50;
end

% laver et table til pointBox, sætter variable navne til den tidligere
% byggede cell array, og fylder 0 ud.
pointsTable = array2table(zeros(1,numPlayers));
pointsTable.Properties.VariableNames = pointsCell;
pointsTable.Properties.RowNames = {'Point'};

%Laver point uitable
pointBox = uitable(fig);
pointBox.Position = [580 100 width 50];
pointBox.Data = pointsTable;
pointBox.ColumnWidth = 'auto';

end