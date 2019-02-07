function[dW1z,dW2z,dW3z,dW4z,dW5z] = fillinpv2(S, K1, K2, K3, K4 ,K5)
dW1z = [S+1, K1];
dW2z = [K1+1, K2];
dW3z = [K2+1, K3];
dW4z = [K3+1, K4];
for i = 1:S+1
   for j = 1:K1 
    dW1z(i,j) = 0;
   end
end
for i = 1:K1+1
   for j = 1:K2 
    dW2z(i,j) = 0;
   end
end
for i = 1:K2+1
   for j = 1:K3 
    dW3z(i,j) = 0;
   end
end
for i = 1:K3+1
   for j = 1:K4 
    dW4z(i,j) = 0;
   end
end
dW5z = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
return

%funckja wype³niaj¹ca zerami macierze pomocnicze dW1z,dW2z,dW3z,dW4z,dW5z
%przechowuj¹ce zbiorowe wartoœci poprawek wag sieci w obrêbie ka¿dego kroku