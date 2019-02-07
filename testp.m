%skrypt odpowiedzialny za przeprowadzanie testów dzia³ania sieci

norm = 2000;    %!!!
bias = 1;

%{
test = tbase(4501:5800,1);
test = test';
plot(test);
%}

test = [];
for i = 1 : size(tbase) - 301
    X = tbase(i:i+299,1);
   [Y1,Y2,Y3,Y4,Y5] = runpv2([bias; X./norm], W1, W2, W3, W4, W5);
   test = [test,Y5*norm];
end

hold on;
plot(tbase(301:end,1));
plot(test);
xlabel('Dni');
ylabel('Wartoœæ kursu');
legend('Zbiór ucz¹cy','Odpowiedzi sieci');
%}

test1 = [];
for i = 1 : size(chbase) - 301
    Y = chbase(i:i+299,1);
   [Y1,Y2,Y3,Y4,Y5] = runpv2([bias; Y./norm], W1, W2, W3, W4, W5);
   test1 = [test1,Y5*norm];
end
%{
hold on;
plot(chbase(301:end,1));
plot(test1);
xlabel('Dni');
ylabel('Wartoœæ kursu');
legend('Zbiór testowy','Odpowiedzi sieci');
%}
