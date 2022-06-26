% ejecutar despues de iden_prem.m
% data = [y' y1' y2' u1' u2'];

% construimos matrices de grados de pertenencia para cada regresor,
% conteniendo los grados de pertenencia a los 3 clusters
mu_y1 = [gauss_y1_1, gauss_y1_2, gauss_y1_3];
mu_y2 = [gauss_y2_1, gauss_y2_2, gauss_y2_3];
mu_u1 = [gauss_u1_1, gauss_u1_2, gauss_u1_3];
mu_u2 = [gauss_u2_1, gauss_u2_2, gauss_u2_3];


Nreglas = 3;

ww = zeros(Ntrain-2, Nreglas);
w = ww;

% Matriz B
for i=1:Ntrain-2  % recorremos datos
    for r =1:Nreglas  % recorremos reglas
        ww(i,r) = mu_y1(i,r)*mu_y2(i,r)*mu_u1(i,r)*mu_u2(i,r);
    end
    % normalizamos
    w(i,:)= ww(i,:)/sum(ww(i,:));
end   

X1 = zeros(Ntrain-2, Nreglas);
X2 = zeros(Ntrain-2, Nreglas);
X3 = zeros(Ntrain-2, Nreglas);
X4 = zeros(Ntrain-2, Nreglas);

% construimos la matriz de datos gigante
for i=1:Ntrain-2
    for r=1:Nreglas
		X1(i,r)=data(i,2)*w(i,r); %y(K-1)
        X2(i,r)=data(i,3)*w(i,r); %y(K-2)
		X3(i,r)=data(i,4)*w(i,r); %u(k-1)
		X4(i,r)=data(i,5)*w(i,r); %u(k-2)
    end
end
Y=data(:,1);
X = [w X1 X2 X3 X4];     
P=X\Y;                    % solucion de Y = X*P

p0=P(1:2);
p1=P(3:4);
p2=P(5:6);
p3=P(7:8);


