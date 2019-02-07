%funkcja przeprowadza sygna³y przez sieæ i zwraca wyjœcia poszczególnych
%jej warstw; funkcja aktywacji neuronów -> liniowa
function[Y1,Y2,Y3,Y4,Y5] = runpv2(X1, W1, W2, W3, W4, W5)

K1 = 60;         
K2 = 60;         
K3 = 32;        
K4 = 16;         
K5 = 1; 
bias = 1;

U1 = W1'*X1;
%{
Y1 = K1;
for i = 1: K1
    if U1(i,1)>0
    Y1(i,1) = U1(i,1);
    else
    Y1(i,1) = 0;
    end
%end
    %}
    Y1 = U1;


X2 = [bias; Y1];
U2 = W2'*X2;
%{
Y2 = K2;
for i = 1: K2
    if U2(i,1)>0
    Y2(i,1) = U2(i,1);
    else
    Y2(i,1) = 0;
    end
    %}
%end
    Y2 = U2;


X3 = [bias; Y2];
U3 = W3'*X3;
%{
Y3 = K3;
for i = 1: K3
    if U3(i,1)>0
    Y3(i,1) = U3(i,1);
    else
    Y3(i,1) = 0;
    end
    %}
%end
    Y3 = U3;

    
X4 = [bias; Y3];
U4 = W4'*X4;
%{
Y4 = K4;
for i = 1: K4
    if U4(i,1)>0
    Y4(i,1) = U4(i,1);
    else
    Y4(i,1) = 0;
    end
    %}
%end
    Y4 = U4;


X5 = [bias; Y4];
U5 = W5'*X5;
%{
Y5 = K5;
for i = 1: K5
    if U5(i,1)>0
    Y5(i,1) = U5(i,1);
    else
    Y5(i,1) = 0;
    end
    %}
%end
    Y5 = U5;
return

%X1,X2,X3,X4,X5 -> macierze wejœæ poszczególnych warstw sieci neuronowej
%Y1,Y2,Y3,Y4,Y5 -> macierze wyjœæ poszczególnych warstw sieci
%U1,U2,U3,U4,U5 -> macierze argumentów funkcji aktywacji poszczególnych
%neuronów w warstwach sieci