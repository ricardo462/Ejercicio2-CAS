
Ntest = Nmuestras - Ntrain;

y_val = Salida(Ntrain+3:Nmuestras,2)';
y1_val = Salida(Ntrain+2:Nmuestras-1,2)';
u1_val = Entrada(Ntrain+2:Nmuestras-1,2)';
u2_val = Entrada(Ntrain+1:Nmuestras-2,2)';

data_val = [y_val' y1_val' u1_val' u2_val'];

%%  evaluamos grados de pertenencia de los datos de test a los conjuntos de
% pertenencia entrenados

gauss_y1_1 = gaussmf(data_val(:,2),[sqrt(var_y1_1) med_y1_1]);
gauss_y1_2 = gaussmf(data_val(:,2),[sqrt(var_y1_2) med_y1_2]);


gauss_u1_1 = gaussmf(data_val(:,3),[sqrt(var_u1_1) med_u1_1]);
gauss_u1_2 = gaussmf(data_val(:,3),[sqrt(var_u1_2) med_u1_2]);

gauss_u2_1 = gaussmf(data_val(:,4),[sqrt(var_u2_1) med_u2_1]);
gauss_u2_2 = gaussmf(data_val(:,4),[sqrt(var_u2_2) med_u2_2]);

mu_y1 = [gauss_y1_1, gauss_y1_2];
mu_u1 = [gauss_u1_1, gauss_u1_2];
mu_u2 = [gauss_u2_1, gauss_u2_2];


%% evaluamos los grados de activacion de cada regla en cada dato
ww = zeros(Ntest-2, Nreglas);
w = ww;

for i=1:Ntest-2  % recorremos datos
    for r =1:Nreglas  % recorremos reglas
        ww(i,r) = mu_y1(i,r)*mu_u1(i,r)*mu_u2(i,r);
    end
    % normalizamos
    w(i,:)= ww(i,:)/sum(ww(i,:));
end   

% ahora evaluamos el y indicado por cada regla
ye = zeros(Ntest-2, Nreglas);

for i=1:Ntest-2
    for r=1:Nreglas
       ye(i,r)=p0(r)+p1(r)*data_val(i,2)+p2(r)*data_val(i,3)+p3(r)*data_val(i,4);
    end
end

% ponderamos cada salida por el grado de activacion normalizado de la regla
yee = zeros(Ntest-2,1);
for i=1:Ntest-2 
   yee(i)=ye(i,1)*w(i,1)+ye(i,2)*w(i,2);
end

yee = 1*yee;

hold off
plot(yee, '-r', 'DisplayName', 'estimated')
hold on 
plot(y_val', '-b', 'DisplayName', 'real')
legend('show')
title('Salida real y(k) y salida estimada ye(k)')
xlabel('muestras k')

rms((yee'-y_val)/y_val)*100