function dicePoints
clc
numDice = 7; %antal terninger
rollArray = zeros(1,numDice);

% array med lovlige valg,
% række 1 antal øjne,
% række 2 lovlige valg(0=ulovlig, 1=enkeltterning, n+10|n+20=fødte, 30=Cameron, 40=3 par)
% række 3 valg option. nummerisk fortløbende
% "1 2 0 2 0 2" vælg 1 for pos1(enkeltterning), vælg 2 for pos 2,4,6(fødte)
% række 4 - point for valget i række 3
legalArray = zeros(4,numDice);

% tæller der vokser med antal af valgmuligheder
selectOption = 0;

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

% tæller antal øjne i et nyt array "0 0 0 7 0 0" er 7 firere
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
    if diceCount(j) >= 6;
        bourneCount(j)= bourneCount(j)+ 2;
        diceCount(j)= diceCount(j) - 6;
        j1a = 0; %sørger for at løkken stopper efter tre ens
        %fjerner de fødte fra disponiple terninger, og opdatere legalArray
        for j1 = (1:numDice)
            if j1 == 1
                selectOption = selectOption+1;
            end
            if rollArray(j1) == j && j1a < 3 ;
                legalArray(2,j1) = legalArray(2,j1) + j + 10;
                legalArray(1,j1) = j;
                legalArray(3,j1) = selectOption;
                if j==1
                    legalArray(4,j1) = 10;
                else
                    legalArray(4,j1) = j;
                end
                rollArray(j1) = rollArray(j1) - j;
                j1a = j1a + 1;
            end
        end
        j2a = 0; %sørger for at løkken stopper efter tre ens
        %fjerner de fødte fra disponiple terninger, og opdatere legalArray
        for j2 = (1:numDice)
            if j2 == 1
                selectOption = selectOption+1;
            end
            if rollArray(j2) == j && j2a < 3 ;
                legalArray(2,j2) = legalArray(2,j2) + j + 20;
                legalArray(1,j2) = j;
                legalArray(3,j2) = selectOption;
                if j==1
                    legalArray(4,j2) = 10;
                else
                    legalArray(4,j2) = j;
                end
                rollArray(j2) = rollArray(j2) - j;
                j2a = j2a + 1;
            end
        end
    elseif diceCount(j) >= 3;
        bourneCount(j)= bourneCount(j)+ 1;
        diceCount(j)= diceCount(j) - 3;
        j3a = 0; %sørger for at løkken stopper efter tre ens
        %fjerner de fødte fra disponiple terninger, og opdatere legalArray
        for j3 = (1:numDice)
            if j3 == 1
                selectOption = selectOption+1;
            end
            if rollArray(j3) == j && j3a < 3;
                legalArray(2,j3) = legalArray(2,j3) + j + 10;
                legalArray(1,j3) = j;
                legalArray(3,j3) = selectOption;
                if j==1
                    legalArray(4,j3) = 10;
                else
                    legalArray(4,j3) = j;
                end
                rollArray(j3) = rollArray(j3) - j;
                j3a = j3a + 1;
            end
        end
    end
end

for m = (1:6)
    if bourneCount(m) == 1 || bourneCount(m) == 2; disp("der er fødte");
    end
end

disp("antal fødte")
disp(bourneCount)
disp("tilgængelige terninger")
disp(rollArray)
disp("antal disponiple")
disp(diceCount)
disp("tjek for fødte - done")

% tjek for Cameron i første slag
if diceCount(1) == 1 && diceCount(1) ~= 0 && diceCount(2) <= 2 && diceCount(2) ~= 0 && diceCount(3) <= 2 && diceCount(3) ~= 0 && diceCount(4) <= 2 && diceCount(4) ~= 0 && diceCount(5) == 1 && diceCount(6) <= 2 && diceCount(6) ~= 0 ;
    tjekCameron = 1;
    legalArray(1,1:numDice) = rollArray(1,1:numDice);
    legalArray(2,1:numDice) = 30;
    legalArray(3,1:numDice) = 1;
    legalArray(4,1:numDice) = 20;
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
        diceCount(k)= diceCount(k) - 2;
    end
end

% tjek for tre par hvis der ikke er en ener eller femmer
if par == 3 && diceCount(1) == 0 && diceCount(5) == 0;
    tjekTrePar = 1;
    disp(tjekTrePar)
    legalArray(1,1:numDice) = rollArray(1,1:numDice);
    legalArray(2,1:numDice) = 40;
    legalArray(3,1:numDice) = 1;
    legalArray(4,1:numDice) = 15;
    disp("!!! Tre par i første !!!")
end
disp("antal par i første")
disp(par)
disp("tjek par - done")

% tjek antal enere der kan vælges
tjekEnere = diceCount(1);
for m = (1:numDice)
    if rollArray(m) == 1;
        selectOption = selectOption+1;
        legalArray(1,m) = 1;
        legalArray(2,m) = 1;
        legalArray(3,m) = selectOption;
        legalArray(4,m) = 1;
    end
end
disp("antal enere")
disp(tjekEnere)

% tjek antal femmere der kan vælges
tjekFemmere = diceCount(5);
for p = (1:numDice)
    if rollArray(p) == 5;
        selectOption = selectOption+1;
        legalArray(1,p) = 5;
        legalArray(2,p) = 1;
        legalArray(3,p) = selectOption;
        legalArray(4,p) = 1/2;
    end
end
disp("antal femmere")
disp(tjekFemmere)

% tjek for omslag
for l = [2,3,4,6]
    if diceCount(l) > 0 ; tjekOmslag = tjekOmslag + diceCount(l);
    end
end

if tjekOmslag == 0;
    disp("!!! Der er omslag !!!")
end
disp("antal terninger der ikke tæller")
disp(tjekOmslag)
disp("mulige valg")
disp("række 1 - n (terningens øjne)")
disp("række 2 - (0=ulovlig, 1=enkeltterning, n+10|n+20=fødte, 30=Cameron, 40=3 par)")
disp("række 3 - valgets navn (integer)")
disp("række 4 - valgets point værdi)")
disp(legalArray)