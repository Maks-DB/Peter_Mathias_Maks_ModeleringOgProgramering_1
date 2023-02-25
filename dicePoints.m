function dicePoints
clc
numDice = 7; %antal terninger
rollArray = zeros(1,numDice);

% array med antal af hver slags "6 0 0 0 0 0" betyder seks ennere
diceCount = zeros(1,6);

% array med fødte(tre af en slags) "0 1 0 0 0 0" betyder fødte toere
bourneCount = zeros(1,6);

% Cameron i første slag
tjekCameron = 0;

% tre par i første
tjekTrePar = 0;

% antal enere der kan vælges
tjekEnere = 0;

% antal femmere der kan vælges
tjekFemmere = 0;

% skal slaget slås om (er værdien 0 efter tjek, er der omslag)
tjekOmslag = 0;

% Terningslag for test
for h = 1:numDice
    %ruller terningerne
    n = randi(6);
    rollArray(h)=n;
end

disp("Wauuu sikke et slag")
disp(rollArray)

% tæller antal øjne
i = 0;
while i < numDice
    i = i + 1;
    %disp(rollArray(i));
    if rollArray(i) == 1; diceCount(1)= diceCount(1)+ 1;
    elseif rollArray(i) == 2; diceCount(2)= diceCount(2) + 1;
    elseif rollArray(i) == 3; diceCount(3)= diceCount(3) + 1;
    elseif rollArray(i) == 4; diceCount(4)= diceCount(4) + 1;
    elseif rollArray(i) == 5; diceCount(5)= diceCount(5) + 1;
    elseif rollArray(i) == 6; diceCount(6)= diceCount(6) + 1;
    end
end
disp("antal af hver")
disp(diceCount)
disp("tjek for antal af hver - done")

% tjek for fødte(tre af en slags) og fjerner de fødte fra diceCount
j = 0;
while j < 6
    j = j + 1;
    %disp(rollArray(i));
    if diceCount(j) >= 6;
        bourneCount(j)= bourneCount(j)+ 2;
        diceCount(j)= diceCount(j) - 6;
    elseif diceCount(j) >= 3;
        bourneCount(j)= bourneCount(j)+ 1;
        diceCount(j)= diceCount(j) - 3;
    end
end
% her bruges en masse if da der kan være to forskelige slags fødte i samme slag. elseif havde sprunget de sidste muligheder over. 
if bourneCount(1) == 1 || bourneCount(1) == 2; disp("der er fødte enere");
end
if bourneCount(2) == 1 || bourneCount(2) == 2 ; disp("der er fødte toere");
end
if bourneCount(3) == 1 || bourneCount(3) == 2; disp("der er fødte treere");
end
if bourneCount(4) == 1 || bourneCount(4) == 2; disp("der er fødte firere");
end
if bourneCount(5) == 1 || bourneCount(5) == 2; disp("der er fødte femmere");
end
if bourneCount(6) == 1 || bourneCount(6) == 2; disp("der er fødte seksere");
end
disp("antal fødte")
disp(bourneCount)
disp("antal disponiple")
disp(diceCount)
disp("tjek for fødte - done")

% tjek for Cameron i første slag
if diceCount(1) == 1 && diceCount(1) ~= 0 && diceCount(2) <= 2 && diceCount(2) ~= 0 && diceCount(3) <= 2 && diceCount(3) ~= 0 && diceCount(4) <= 2 && diceCount(4) ~= 0 && diceCount(5) == 1 && diceCount(6) <= 2 && diceCount(6) ~= 0 ;
    tjekCameron = 1;
    disp("!!! CAMERON i første !!!")
end

disp("antal Cameron i første")
disp(tjekCameron)
disp("tjek Cameron - done")

% tjek for tre par 
k = 0;
par = 0;

while k < 6;
    k = k + 1;
    if diceCount(k) == 2;
        par = par + 1;
        %diceCount(k)= diceCount(k) - 2;
    end
end

% tjek for tre par hvis der ikke er en ener eller femmer
if par == 3 && diceCount(1) == 0 && diceCount(5) == 0;
    tjekTrePar = 1;
    disp(tjekTrePar)
    disp("!!! Tre par i første !!!")
end
disp("antal par i første")
disp(par)
disp("tjek par - done")

% tjek antal enere der kan vælges
tjekEnere = diceCount(1);
disp("antal enere")
disp(tjekEnere)

% tjek antal femmere der kan vælges
tjekFemmere = diceCount(5);
disp("antal femmere")
disp(tjekFemmere)

% tjek for omslag
if diceCount(2) > 0 ; tjekOmslag = tjekOmslag + diceCount(2);
end
if diceCount(3) > 0 ; tjekOmslag = tjekOmslag + diceCount(3);
end
if diceCount(4) > 0 ; tjekOmslag = tjekOmslag + diceCount(4);
end
if diceCount(6) > 0 ; tjekOmslag = tjekOmslag + diceCount(6);
end

if tjekOmslag == 0;
    disp("!!! Der er omslag !!!")
end
disp("antal terninger der ikke tæller")
disp(tjekOmslag)