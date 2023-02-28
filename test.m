numPlayer = input("hvor mange spillere");

if numPlayer ==1
    numPlayerCol = 2;
else
    numPlayerCol = numPlayer;
end

playerArray = 1:numPlayerCol;

playerArray = [playerArray;zeros(size(playerArray));zeros(size(playerArray))];

disp(playerArray)

