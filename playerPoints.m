function pointBox = playerPoints(fig,numPlayers)

width = 200;

pointsCell = {};
for t = 1:numPlayers
    pointsCell(t) =  cellstr(sprintf("Spiller %d",t));
    width = width + 50;
end

disp(pointsCell)

pointsTable = array2table(zeros(1,numPlayers));
pointsTable.Properties.VariableNames = pointsCell;
pointsTable.Properties.RowNames = {'point'};

pointBox = uitable(fig);
pointBox.Position = [580 100 width 50];
pointBox.Data = pointsTable;
pointBox.ColumnWidth = 'auto';

end