function playerPoints(numPlayers)

columnNameArray = strings;
for t = 1:numPlayers
    columnNameArray(t) = sprintf("Spiller %d",t);
end

fig = uifigure;

pointBox = uitable(fig);
pointBox.Position = [10 100 500 150];
pointBox.Data = columnNameArray;

end