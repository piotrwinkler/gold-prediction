%Autor: Piotr Winkler 165504
%MATLAB: R2017b

%G��wna funcja zbieraj�ca dane i przeprowadzaj�ca uczenie sieci, a tak�e
%sprawdzaj�ca jako�� jej dzia�ania
%Parametry sieci neuronowej
S = 300;        %ilo�� wej�� sieci bez biasu
K1 = 60;        %ilo�� neuron�w w pierwszej wartswie sieci 
K2 = 60;        %ilo�� neuron�w w drugiej wartswie sieci  
K3 = 32;        %ilo�� neuron�w w trzeciej wartswie sieci 
K4 = 16;        %ilo�� neuron�w w czwartej wartswie sieci 
K5 = 1;         %ilo�� neuron�w w pi�tej wartswie sieci 
amtbase = 8362;
amchbase = 1500;
bladpok = [];
bladepok = [];
norm = 2000;   %!!!warto�� przez kt�r� dzielone s� warto�ci wej�ciowe sieci w celu dopasowania do przedzia�u <0,1>
bias = 1;       
%==========================================================================
%{
bladepok2 = [];
bladepok3 = [];
%}
%==========================================================================
pokazy = 1;                     %ilo�� pokaz�w w obr�bie jednego kroku algorytmu ucz�cego
kroki = amtbase - 300;          %ilo�� krok�w w obr�bie jednej epoki
%==========================================================================
epoki = 100;                   %ilo�� epok uczenia sieci
%==========================================================================
sprawdzenia = amchbase - 300;   %ilo�� pokaz�w podczas sprawdzania dzia�ania sieci na koniec ka�dej epoki
blad = 0.00001;                 %dopuszczalny b��d �redniokwadratowy na ci�gu sprawdzaj�cym wyznaczaj�cy granic� zako�czenia uczenia

%==========================================================================
%Inicjalizacja sieci neuronowej i nadanie jej losowo pocz�tkowych wag
%[W1, W2, W3, W4, W5] = initpv2(S, K1, K2, K3, K4 ,K5);
%==========================================================================

%p�tla epoki -> w niej wywo�uj� si� wszystkie kroki i pokazy ucz�ce sie�  
for k = 1 : epoki 
    %"wyzerowanie" warto�ci licznika odpowiadaj�cego za uczenie
    %chronologiczne na pocz�tku ka�dej epoki
    count3 = 1;
    %p�tla kroku -> w niej wywo�uj� si� wszystkie pokazy ucz�ce sie�  
    for j = 1 : kroki
    %==============================================================
    %[dW1z,dW2z,dW3z,dW4z,dW5z] = fillinpv2(S, K1, K2, K3, K4 ,K5);
    %==============================================================
        %p�tla pokazu -> wywo�uje si� ile� razy w obr�bie jendego kroku;
        %poprawki wag z ka�dego pokazu s� sumowane i dodawane do wag po
        %normalizacji na koniec ka�dego kroku 
        for i = 1 : pokazy
        %{
        %wybieranie przyk�ad�w ze zbioru ucz�cego -> uczenie losowe
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
        %wybieranie przyk�ad�w ze zbioru ucz�cego -> uczenie chronologiczne
        P = tbase(count3:count3+299,1)./norm;
        P = [bias;P];
        T = tbase(count3+300,1)./norm;
        %wywowa�nie funkcji przeprowadzaj�cej uczenie; zwraca poprawki wag
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
        %zwi�kszanie warto�ci licznika odpowiadaj�cego za uczenie
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
count = 1;      %licznik odpowiedzialny za przesuwanie punktu odczytu danych ze zbioru sprawdzaj�cego
count1 = 0;     %licznik odpowiedzialny za zliczanie ilo�ci b��dnych przypo��dkowa� w danym ci�gu sprawdzaj�cym 

%sprawdzenie wielko�ci b��du wyj�ciowego sieci na bazie zbioru sprawdzaj�cego "chbase" pod
%koniec ka�dej epoki; wnioskowanie o zakonczeniu uczenia w przypadku
%zadowalaj�cych rezultat�w
for l = 1 : sprawdzenia
    P = chbase(count:count+299,1)./norm;
    P = [bias;P];
    T = chbase(count+300,1)./norm;
    [bladepok,count1] = checkpv2(P,T,W1,W2,W3,W4,W5,count1);
    bladepok1 = bladepok1 + bladepok;
    count = count + 1;
end
%normalizacja b��du �redniokwadratowego na wyj�ciu sieci na koniec danej
%epoki; na bazie zbioru sprawdzaj�cego
bladepok1 = bladepok1/sprawdzenia;
disp(bladepok1);
bladepok2 = [bladepok2, bladepok1];
bladepok3 = [bladepok3, count1];
%warunek zako�czenia uczenia sieci
if bladepok1 <= blad
   break;
end
end
%Wyrysowanie wykres�w b��d�w na ci�gu sprawdzaj�cym pod koniec ka�dej epoki
plot(bladepok2);
%}
%wymagane jest do��czenie zbior�w ucz�cych i sprawdzaj�cych; 