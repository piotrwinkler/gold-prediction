%skrypt odpowiedzialny za wygenerowanie przysz³ych wartoœci kursu z³ota

okres = 26;    %okres na który sieæ ma dokonaæ przewidywañ(im d³u¿szy okres tym mniej dok³adne przewidywania!!!)
norm = 2000;    %!!!
bias = 1;
okresr = 26;

%8063
kurs = tbase(8063:end, 1);
for i = 1 : okres
   [Y1,Y2,Y3,Y4,Y5] = runpv2([bias;(kurs(i:end,1)./norm)], W1, W2, W3, W4, W5);
   kurs = [kurs; Y5*norm];
end
kurs = kurs';
hold on;
plot(kurs(1:301),'b-');
plot(301:300+okres,kurs(301:300+okres),'r-');

real1 = real';
plot(301:300+okresr,real1(1:end),'k-');
xlabel('Dni');
ylabel('Wartoœæ kursu');
legend('Dane','Przewidywanie','Wartoœci rzeczywiste');


