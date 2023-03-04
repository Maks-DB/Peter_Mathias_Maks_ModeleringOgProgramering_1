function rollOptions = dicePoints(numDice,rollArray,playerOptionArray)

% playerOptionArray er et array med lovlige valg,
% række 1 antal øjne,
% række 2 lovlige valg(0=ulovlig, 1=enkeltterning, n+10|n+20=fødte, 30=Cameron, 40=3 par, 60=ugyldigt slag, 70= det hele om )
% række 3 valg option. nummerisk fortløbende
% "1 2 0 2 0 2" vælg 1 for pos1(enkeltterning), vælg 2 for pos 2,4,6(fødte)
% række 4 - point for valget i række 3


%numDice = diceThrow(numDice);

%legalArray = zeros(4,numDice);

%rollArray = zeros(1,numDice);

% sætter et nummer på de lovlige valg
selectOption = 0;

%antal at terninger med værdi
diceWithValue = 0;

% array med antal af hver slags "6 0 0 0 0 0" betyder seks ennere
diceCount = zeros(1,6);

% array med fødte(tre af en slags) "0 1 0 0 0 0" betyder fødte toere
bornCount = zeros(1,6);

% variabel med fødte fra sidste slag (0 = ingen fødte, 1 = fødte enere, 2= fødte toere osv)
bornPreviousThrow = 0;

% antal enere der kan vælges
tjekEnere = 0;

% antal femmere der kan vælges
tjekFemmere = 0;

% omslag på grund af at alle terninger tæller gælder kun hvis der kun er en
% mulighed tilbage. f.eks hvis de sidste 3 terninger er 1, 5, 5, så har de
% alle værdi - men man har 3 lovlige valg, havde slaget været 6, 6, 6,
% havde der kun været et lovligt slag da de er fødte og turen slås om.
selectOptionCount = 0;

% tæller antal øjne i slaget og gemmer i diceCount array "0 0 0 7 0 0" er 7 firere
i = 0;
while i < numDice
    i = i + 1;

    if rollArray(i) == 1
        diceCount(1)= diceCount(1)+ 1;
    elseif rollArray(i) == 2
        diceCount(2)= diceCount(2) + 1;
    elseif rollArray(i) == 3
        diceCount(3)= diceCount(3) + 1;
    elseif rollArray(i) == 4
        diceCount(4)= diceCount(4) + 1;
    elseif rollArray(i) == 5
        diceCount(5)= diceCount(5) + 1;
    elseif rollArray(i) == 6
        diceCount(6)= diceCount(6) + 1;
    end
end
%disp("antal af hver")
%disp(diceCount)
%disp("tjek for antal af hver - done")






% tjek for fødte(tre af en slags), og gemmer dem i bourne
% og fjerner de fødte fra diceCount da fødte ikke må bruges til andre slag
j = 0;
%tjek for to sæt af fødte med samme værdien j
while j < 6 %tjek for to sæt af fødte med samme værdi
    j = j + 1;
    if diceCount(j) >= 6
        bornCount(j)= bornCount(j)+ 2;
        diceCount(j)= diceCount(j) - 6;
        j1a = 0; %sørger for at løkken stopper efter tre ens
        %fjerner de fødte fra disponiple terninger, og opdatere legalArray
        for j1 = (1:numDice)
            if j1 == 1
                selectOption = selectOption+1;
                selectOptionCount = selectOptionCount + 1;
            end
            if rollArray(j1) == j && j1a < 3
                playerOptionArray(2,j1) = playerOptionArray(2,j1) + j + 10;
                playerOptionArray(1,j1) = j;
                playerOptionArray(3,j1) = selectOption;
                if j==1
                    playerOptionArray(4,j1) = 10;
                else
                    playerOptionArray(4,j1) = j;
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
                selectOptionCount = selectOptionCount + 1;
            end
            if rollArray(j2) == j && j2a < 3
                playerOptionArray(2,j2) = playerOptionArray(2,j2) + j + 20;
                playerOptionArray(1,j2) = j;
                playerOptionArray(3,j2) = selectOption;
                if j==1
                    playerOptionArray(4,j2) = 10;
                else
                    playerOptionArray(4,j2) = j;
                end
                rollArray(j2) = rollArray(j2) - j;
                j2a = j2a + 1;
            end
        end
        %tjek for fødte med j øjne
    elseif diceCount(j) >= 3
        bornCount(j)= bornCount(j)+ 1;
        diceCount(j)= diceCount(j) - 3;
        j3a = 0; %sørger for at løkken stopper efter tre ens
        %fjerner de fødte fra disponiple terninger, og opdatere legalArray
        for j3 = (1:numDice)
            if j3 == 1
                selectOption = selectOption+1;
                selectOptionCount = selectOptionCount + 1;
            end
            if rollArray(j3) == j && j3a < 3
                playerOptionArray(2,j3) = playerOptionArray(2,j3) + j + 10;
                playerOptionArray(1,j3) = j;
                playerOptionArray(3,j3) = selectOption;
                if j==1
                    playerOptionArray(4,j3) = 10;
                else
                    playerOptionArray(4,j3) = j;
                end
                rollArray(j3) = rollArray(j3) - j;
                j3a = j3a + 1;
            end
        end
    end
end

% skriver hvis der er fødte - kontrol
for m = (1:6)
    if bornCount(m) == 1
        disp("der er fødte");
        diceWithValue = diceWithValue + 3;
    elseif bornCount(m) == 2
        disp("der er fødte");
        diceWithValue = diceWithValue + 6;
    end
end

% disp("antal fødte")
% disp(bornCount)
% disp("tilgængelige terninger")
% disp(rollArray)
% disp("antal disponiple")
% disp(diceCount)

% disp("tjek for fødte - done")

% tjek for Cameron i første slag
if diceCount(1) == 1 && diceCount(1) ~= 0 && diceCount(2) <= 2 && diceCount(2) ~= 0 && diceCount(3) <= 2 && diceCount(3) ~= 0 && diceCount(4) <= 2 && diceCount(4) ~= 0 && diceCount(5) == 1 && diceCount(6) <= 2 && diceCount(6) ~= 0
    playerOptionArray(1,1:numDice) = rollArray(1,1:numDice);
    playerOptionArray(2,1:numDice) = 30;
    playerOptionArray(3,1:numDice) = 1;
    playerOptionArray(4,1:numDice) = 20;
    rollArray(1:numDice) = 0;
    diceWithValue = diceWithValue + 6;
    selectOptionCount =  1;
    disp("!!! CAMERON i første !!!")
end

% disp("tjek Cameron - done")


% tjek for tre par
k = 0;
par = 0;

% tjek for par,
while k < 6
    k = k + 1;
    if diceCount(k) == 2
        par = par + 1;
    end
end

if par == 3
    % fjerner par fra diceCount ved 3 par
    q = 0;
    while q < 6
        q = q + 1;
        if diceCount(q) == 2
            diceCount(q)= diceCount(q) - 2;
        end
    end
    % tjek for tre par hvis der ikke er en ener eller femmer
    if diceCount(1) == 0 && diceCount(5) == 0
        playerOptionArray(1,1:numDice) = rollArray(1,1:numDice);
        playerOptionArray(2,1:numDice) = 40;
        playerOptionArray(3,1:numDice) = 1;
        playerOptionArray(4,1:numDice) = 15;
        rollArray(1:numDice) = 0;
        diceWithValue = diceWithValue + 6;
        selectOptionCount =  1;
        disp("!!! Tre par i første !!!")
    end
end
%disp("antal par i første")
% disp(par)
% disp("tjek par - done")


% Tjek for point til doubling af fødte
for r = (1:6)
    if r == bornPreviousThrow
        disp("de fødte kan fordobles");
        selectOption = selectOption+1;
        for s = (1 : numDice)
            if rollArray(s) == bornPreviousThrow
                diceWithValue = diceWithValue + 1;
                playerOptionArray(1,s) = rollArray(s);
                playerOptionArray(2,s) = 50;
                playerOptionArray(3,s) = selectOption;
                if rollArray(s) == 1
                    playerOptionArray(4,s) = 10;
                else
                    playerOptionArray(4,s) = rollArray(s);
                end
                rollArray(s) = 0;
            end
        end
        bornPreviousThrow = 0;
    end
end


% tjek antal enere der kan vælges
%tjekEnere = diceCount(1);
for m = (1:numDice)
    if rollArray(m) == 1
        disp("Der er en ener")
        selectOption = selectOption+1;
        playerOptionArray(1,m) = 1;
        playerOptionArray(2,m) = 1;
        playerOptionArray(3,m) = selectOption;
        playerOptionArray(4,m) = 1;
        diceWithValue = diceWithValue + 1;
        selectOptionCount =  selectOptionCount + 1;
        tjekEnere = tjekEnere + 1;
    end
end
% disp("antal enere")
% disp(tjekEnere)

% tjek antal femmere der kan vælges
%tjekFemmere = diceCount(5);
for p = (1:numDice)
    if rollArray(p) == 5
        disp("Der er en femmer")
        selectOption = selectOption+1;
        playerOptionArray(1,p) = 5;
        playerOptionArray(2,p) = 1;
        playerOptionArray(3,p) = selectOption;
        playerOptionArray(4,p) = 1/2;
        selectOptionCount = selectOptionCount + 1;
        diceWithValue = diceWithValue + 1;
        tjekFemmere = tjekFemmere + 1;
    end
end
% disp("antal femmere")
% disp(tjekFemmere)

% skal slaget slås om (er værdien 0 og selectOptionCount=1 er der omslag)
tjekOmslag = numDice - diceWithValue;
if tjekOmslag == 0 % && selectOptionCount == 1
    disp("!!! Der er omslag !!!")
    selectOption = 1;
    %clear playerOptionArray
    playerOptionArray = [1 ; 70 ; 1 ; -4];
    diceWithValue = diceWithValue + 1;
    %disp(playerOptionArray)
end

% tjek for ugyldigt slag (-4 point)
if diceWithValue == 0
    disp("Øv Øv øv ugyldigt slag, -4 point")
    selectOption = 1;
    %clear playerOptionArray
    playerOptionArray = [1 ; 60 ; 1 ; 0];
    %disp(playerOptionArray)
end

% disp("antal terninger der ikke tæller")
% disp(tjekOmslag)
% 
% disp("antal af lovlige valg")
% disp(selectOption)
% 
% disp("mulige valg")
% disp("række 1 - n (terningens øjne)")
% disp("række 2 - (0=ulovlig, 1=enkeltterning, n+10|n+20=fødte, 30=Cameron, 40=3 par, 50=fødte fordobles, 60=fejlslag, 70=omslag)")
% disp("række 3 - valgets navn (integer)")
% disp("række 4 - valgets point værdi)")
% disp(playerOptionArray)

rollOptions = playerOptionArray;
