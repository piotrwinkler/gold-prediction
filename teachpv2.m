%funkcja wyznacza wartoœci poprawek wag poszczególnych warstw sieci
%wykorzystuj¹c algorytm wstecznej propagacji b³êdów
function[dW1,dW2,dW3,dW4,dW5,bladpok] = teachpv2(P,T,W1,W2,W3,W4,W5,bladpok)
%wyznaczenie odpowiedzi na pobudzenie siedzi zbiorem ucz¹cym P
[Y1,Y2,Y3,Y4,Y5] = runpv2(P,W1,W2,W3,W4,W5);
bias = 1;
X2 = [bias; Y1];
X3 = [bias; Y2];
X4 = [bias; Y3];
X5 = [bias; Y4];
%==========================================================================
step = 0.00001;       %d³ugoœæ kroku uczenia !!!
%==========================================================================

%Obliczenie macierzy poprawek wag dla warstwy pi¹tej 
D5 = Y5 - T;
dW5 = step*X5*D5';
%wyznaczanie b³êdu œredniokwadratowego na wyjœciu sieci na pocz¹tku ka¿dgo
%pokazu ucz¹cego; zapis do macierzy w celu wyœwietlenia w formie wykresu
%!!!bladpok = [bladpok,1/2*D5^2];
%Obliczenie macierzy poprawek wag dla warstwy czwartej
D40 = W5*D5;
D4 = D40(2:end,1:end);
dW4 = step*X4*D4';

%Obliczenie macierzy poprawek wag dla warstwy trzeciej 
D30 = W4*D4;
D3 = D30(2:end,1:end);
dW3 = step*X3*D3';

%Obliczenie macierzy poprawek wag dla warstwy drugiej 
D20 = W3*D3;
D2 = D20(2:end,1:end);
dW2 = step*X2*D2';

%Obliczenie macierzy poprawek wag dla warstwy pierwszej 
D10 = W2*D2;
D1 = D10(2:end,1:end);
dW1 = step*P*D1';

%Dodanie poprawek do istniêj¹cych macierzy wag
%W1t = W1 + dW1;
%W2t = W2 + dW2;
%W3t = W3 + dW3;
%W4t = W4 + dW4;
%W5t = W5 + dW5;

return