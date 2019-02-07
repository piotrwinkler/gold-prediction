function[W1, W2, W3, W4, W5] = initpv2(S, K1, K2, K3, K4 ,K5)
W1 = [S+1, K1];
W2 = [K1+1, K2];
W3 = [K2+1, K3];
W4 = [K3+1, K4];
for i = 1:S+1
   for j = 1:K1
        if i == 1
        W1(i,j) = 0;
        else
        W1(i,j) = -0.1 + (0.2)*rand;
        end
   end
end
for i = 1:K1+1
   for j = 1:K2 
        if i == 1
        W2(i,j) = 0;
        else
        W2(i,j) = -0.1 + (0.2)*rand;
        end
   end
end
for i = 1:K2+1
   for j = 1:K3
       if i == 1
       W3(i,j) = 0;
       else
       W3(i,j) = -0.1 + (0.2)*rand;
       end
   end
end
for i = 1:K3+1
   for j = 1:K4
        if i == 1
        W4(i,j) = 0;
        else
        W4(i,j) = -0.1 + (0.2)*rand;
        end
   end
end
W5 = [0; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand;-0.1 + (0.2)*rand; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand; -0.1 + (0.2)*rand];

return

%W1,W2,W3,W4,W5 -> macierze wag poszczególnych warstw sieci neuronowej 
%K1,K2,K3,K4,K5 -> iloœæ neuronów w poszczególnych warstwach sieci
%S -> iloœæ wejœæ sieci bez biasu