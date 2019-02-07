%funkcja wyznaczaj¹ca b³¹d œredniokwadratowy na wyjœciu sieci w ka¿dym
%kroku sprawdzenia pod koniec epoki
function[bladepok, count1] = checkpv2(P,T,W1,W2,W3,W4,W5,count1)

[Y1,Y2,Y3,Y4,Y5] = runpv2(P,W1,W2,W3,W4,W5);

%wyznaczenie b³êdu œredniokwadratowego na wyjœciu sieci w toku sprawdzania 
D5 = T - Y5;
bladepok = 1/2*D5^2;

if D5 > 0.01
   count1 = count1 + 1; 
end

return

