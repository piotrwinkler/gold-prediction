%Autor: Piotr Winkler 165504
%MATLAB: R2017b

%G³ówna funcja zbieraj¹ca dane i przeprowadzaj¹ca uczenie sieci, a tak¿e
%sprawdzaj¹ca jakoœæ jej dzia³ania
%Parametry sieci neuronowej
S = 300;        %iloœæ wejœæ sieci bez biasu
K1 = 60;        %iloœæ neuronów w pierwszej wartswie sieci 
K2 = 60;        %iloœæ neuronów w drugiej wartswie sieci  
K3 = 32;        %iloœæ neuronów w trzeciej wartswie sieci 
K4 = 16;        %iloœæ neuronów w czwartej wartswie sieci 
K5 = 1;         %iloœæ neuronów w pi¹tej wartswie sieci 
amtbase = 8362;
amchbase = 1500;
bladpok = [];
bladepok = [];
norm = 2000;   %!!!wartoœæ przez któr¹ dzielone s¹ wartoœci wejœciowe sieci w celu dopasowania do przedzia³u <0,1>
bias = 1;       
%==========================================================================
%{
bladepok2 = [];
bladepok3 = [];
%}
%==========================================================================
pokazy = 1;                     %iloœæ pokazów w obrêbie jednego kroku algorytmu ucz¹cego
kroki = amtbase - 300;          %iloœæ kroków w obrêbie jednej epoki
%==========================================================================
epoki = 100;                   %iloœæ epok uczenia sieci
%==========================================================================
sprawdzenia = amchbase - 300;   %iloœæ pokazów podczas sprawdzania dzia³ania sieci na koniec ka¿dej epoki
blad = 0.00001;                 %dopuszczalny b³¹d œredniokwadratowy na ci¹gu sprawdzaj¹cym wyznaczaj¹cy granicê zakoñczenia uczenia

%==========================================================================
%Inicjalizacja sieci neuronowej i nadanie jej losowo pocz¹tkowych wag
%[W1, W2, W3, W4, W5] = initpv2(S, K1, K2, K3, K4 ,K5);
%==========================================================================

%pêtla epoki -> w niej wywo³uj¹ siê wszystkie kroki i pokazy ucz¹ce sieæ  
for k = 1 : epoki 
    %"wyzerowanie" wartoœci licznika odpowiadaj¹cego za uczenie
    %chronologiczne na pocz¹tku ka¿dej epoki
    count3 = 1;
    %pêtla kroku -> w niej wywo³uj¹ siê wszystkie pokazy ucz¹ce sieæ  
    for j = 1 : kroki
    %==============================================================
    %[dW1z,dW2z,dW3z,dW4z,dW5z] = fillinpv2(S, K1, K2, K3, K4 ,K5);
    %==============================================================
        %pêtla pokazu -> wywo³uje siê ileœ razy w obrêbie jendego kroku;
        %poprawki wag z ka¿dego pokazu s¹ sumowane i dodawane do wag po
        %normalizacji na koniec ka¿dego kroku 
        for i = 1 : pokazy
        %{
        %wybieranie przyk³adów ze zbioru ucz¹cego -> uczenie losowe
        a = 1 + (4)*rand;
        a = round(a);
            if a == 1 || a == 2
                b = 1 + (5439)*rand;
                b = round(b);
                P = tbase(b:b+299,1)./norm;
                P = [bias;P];
                T = tbase(b+300,1)./norm;
            else
                b = 1+(1192)*rand;%5743 + (1234)*rand;
                b = round(b);
                P = chbase(b:b+299,1)./norm;%tbase
                P = [bias;P];
                T = chbase(b+300,1)./norm;%tbase
            end
        %}    
        %wybieranie przyk³adów ze zbioru ucz¹cego -> uczenie chronologiczne
        P = tbase(count3:count3+299,1)./norm;
        P = [bias;P];
        T = tbase(count3+300,1)./norm;
        %wywowa³nie funkcji przeprowadzaj¹cej uczenie; zwraca poprawki wag
        %w danym pokazie
        [dW1,dW2,dW3,dW4,dW5,bladpok] = teachpv2(P,T,W1,W2,W3,W4,W5,bladpok);
        %====================================================================
        %{
        dW1z = dW1 + dW1z;
        dW2z = dW2z + dW2;
        dW3z = dW3z + dW3;
        dW4z = dW4z + dW4;
        dW5z = dW5z + dW5;
        %}
        %====================================================================
        %zwiêkszanie wartoœci licznika odpowiadaj¹cego za uczenie
        %chronologiczne
        count3 = count3 + 1;
        end
    %dodanie poprawek wag do macierzy wag sieci na koniec kroku
    W1 = W1 - dW1;   %z./pokazy;
    W2 = W2 - dW2;   %z./pokazy;
    W3 = W3 - dW3;   %z./pokazy;
    W4 = W4 - dW4;   %z./pokazy;
    W5 = W5 - dW5;   %z./pokazy;
    end
bladepok1 = 0;
bladepok = 0;
count = 1;      %licznik odpowiedzialny za przesuwanie punktu odczytu danych ze zbioru sprawdzaj¹cego
count1 = 0;     %licznik odpowiedzialny za zliczanie iloœci b³êdnych przypo¿¹dkowañ w danym ci¹gu sprawdzaj¹cym 

%sprawdzenie wielkoœci b³êdu wyjœciowego sieci na bazie zbioru sprawdzaj¹cego "chbase" pod
%koniec ka¿dej epoki; wnioskowanie o zakonczeniu uczenia w przypadku
%zadowalaj¹cych rezultatów
for l = 1 : sprawdzenia
    P = chbase(count:count+299,1)./norm;
    P = [bias;P];
    T = chbase(count+300,1)./norm;
    [bladepok,count1] = checkpv2(P,T,W1,W2,W3,W4,W5,count1);
    bladepok1 = bladepok1 + bladepok;
    count = count + 1;
end
%normalizacja b³êdu œredniokwadratowego na wyjœciu sieci na koniec danej
%epoki; na bazie zbioru sprawdzaj¹cego
bladepok1 = bladepok1/sprawdzenia;
disp(bladepok1);
bladepok2 = [bladepok2, bladepok1];
bladepok3 = [bladepok3, count1];
%warunek zakoñczenia uczenia sieci
if bladepok1 <= blad
   break;
end
end
%Wyrysowanie wykresów b³êdów na ci¹gu sprawdzaj¹cym pod koniec ka¿dej epoki
plot(bladepok2);
%}
%wymagane jest do³¹czenie zbiorów ucz¹cych i sprawdzaj¹cych; 