load dataP2
Nmuestras = 10000;
Ntrain = floor(Nmuestras*0.7);

y=Salida(3:Ntrain);
y1=Salida(2:Ntrain-1);
y2=Salida(1:Ntrain-2);
u1=Entrada(2:Ntrain-1);
u2=Entrada(1:Ntrain-2);

data = [y' y1' y2' u1' u2'];
[center,U] = fcm(data,3); % U: conjuntos de pertenencia

%%

plot(data(:,1),U(1,:),'b+',data(:,1),U(2,:),'r+',data(:,1),U(3,:),'k+')
title('Clusters para la salida y(k)')
xlabel('y(k)')
ylabel('Grado de pertenencia')
pause

plot(data(:,2),U(1,:),'b+',data(:,2),U(2,:),'r+',data(:,2),U(3,:),'k+')
title('Clusters para  y(k-1)')
xlabel('y(k-1)')
ylabel('Grado de pertenencia')
pause

plot(data(:,3),U(1,:),'b+',data(:,3),U(2,:),'r+',data(:,3),U(3,:),'k+')
title('Clusters para y(k-2)')
xlabel('y(k-2)')
ylabel('Grado de pertenencia')
pause

plot(data(:,4),U(1,:),'b+',data(:,4),U(2,:),'r+',data(:,4),U(3,:),'k+')
title('Clusters para u(k-1)')
xlabel('u(k-1)')
ylabel('Grado de pertenencia')
pause

plot(data(:,5),U(1,:),'b+',data(:,5),U(2,:),'r+',data(:,5),U(3,:),'k+')
title('Clusters para u(k-2)')
xlabel('u(k-2)')
ylabel('Grado de pertenencia')
pause

%%  ajustamos gaussianas a lo observado (aprox) -> esto es para las premisas
% y(k-1)
[x, idx] = sort(data(:,2));

sum1 = sum(U(1,:));
sum2 = sum(U(2,:));
sum3 = sum(U(3,:));

med_y1_1 = dot(y1, U(1,:))/sum1;
med_y1_2 = dot(y1, U(2,:))/sum2;
med_y1_3 = dot(y1, U(3,:))/sum3;

var_y1_1 = dot(y1.^2, U(1,:))/sum1 - med_y1_1^2;
var_y1_2 = dot(y1.^2, U(2,:))/sum2 - med_y1_2^2;
var_y1_3 = dot(y1.^2, U(3,:))/sum3 - med_y1_3^2;

gauss_y1_1 = gaussmf(x,[sqrt(var_y1_1) med_y1_1]);
gauss_y1_2 = gaussmf(x,[sqrt(var_y1_2) med_y1_2]);
gauss_y1_3 = gaussmf(x,[sqrt(var_y1_3) med_y1_3]);

plot(x,(U(1,idx))','b+',x,gauss_y1_1,'k-', x,(U(2,idx))','r+',x,gauss_y1_2,'k-',x,(U(3,idx))','g+',x,gauss_y1_3,'k-','LineWidth', 2.0);
title('Aprox. para func.pert y(k-1)')
xlabel('y(k-1)')
ylabel('Grado de pertenencia')


%%
[x, idx] = sort(data(:,3));
med_y2_1 = dot(y2, U(1,:))/sum1;
med_y2_2 = dot(y2, U(2,:))/sum2;
med_y2_3 = dot(y2, U(3,:))/sum3;

var_y2_1 = dot(y2.^2, U(1,:))/sum1 - med_y2_1^2;
var_y2_2 = dot(y2.^2, U(2,:))/sum2 - med_y2_2^2;
var_y2_3 = dot(y2.^2, U(3,:))/sum3 - med_y2_3^2;

gauss_y2_1 = gaussmf(x,[sqrt(var_y2_1) med_y2_1]);
gauss_y2_2 = gaussmf(x,[sqrt(var_y2_2) med_y2_2]);
gauss_y2_3 = gaussmf(x,[sqrt(var_y2_3) med_y2_3]);

plot(x,(U(1,idx))','b+',x,gauss_y2_1,'k-', x,(U(2,idx))','r+',x,gauss_y2_2,'k-',x,(U(3,idx))','g+',x,gauss_y2_3,'k-','LineWidth', 2.0);
title('Aprox. para func.pert y(k-1)')
xlabel('y(k-1)')
ylabel('Grado de pertenencia')

%%
% u(k-1)
[x, idx] = sort(data(:,4));

med_u1_1 = dot(u1, U(1,:))/sum1;
med_u1_2 = dot(u1, U(2,:))/sum2;
med_u1_3 = dot(u1, U(3,:))/sum3;

var_u1_1 = dot(u1.^2, U(1,:))/sum1 - med_u1_1^2;
var_u1_2 = dot(u1.^2, U(2,:))/sum2 - med_u1_2^2;
var_u1_3 = dot(u1.^2, U(3,:))/sum3 - med_u1_3^2;

gauss_u1_1 = gaussmf(x,[sqrt(var_u1_1) med_u1_1]);
gauss_u1_2 = gaussmf(x,[sqrt(var_u1_2) med_u1_2]);
gauss_u1_3 = gaussmf(x,[sqrt(var_u1_3) med_u1_3]);


plot(x,(U(1,idx))','b+',x,gauss_u1_1,'k-',x,(U(2,idx))','r+',x,gauss_u1_2,'k-',x,(U(3,idx))','g+',x,gauss_u1_3,'k-', 'LineWidth', 2.0);
title('Aprox. para func.pert u(k-1)')
xlabel('u(k-1)')
ylabel('Grado de pertenencia')


%%
% u(k-2)
[x, idx] = sort(data(:,5));

med_u2_1 = dot(u2, U(1,:))/sum1;
med_u2_2 = dot(u2, U(2,:))/sum2;
med_u2_3 = dot(u2, U(3,:))/sum3;

var_u2_1 = dot(u2.^2, U(1,:))/sum1 - med_u2_1^2;
var_u2_2 = dot(u2.^2, U(2,:))/sum2 - med_u2_2^2;
var_u2_3 = dot(u2.^2, U(3,:))/sum3 - med_u2_3^2;

gauss_u2_1 = gaussmf(x,[sqrt(var_u2_1) med_u2_1]);
gauss_u2_2 = gaussmf(x,[sqrt(var_u2_2) med_u2_2]);
gauss_u2_3 = gaussmf(x,[sqrt(var_u2_3) med_u2_3]);

plot(x,(U(1,idx))','b+',x,gauss_u2_1,'k-',x,(U(2,idx))','r+',x,gauss_u2_2,'k-', x,(U(3,idx))','g+',x,gauss_u2_3,'k-','LineWidth', 2.0);
title('Aprox. para func.pert u(k-2)')
xlabel('u(k-2)')
ylabel('Grado de pertenencia')


%% construimos matriz MU para usarla despues

MU = [med_y1_1, med_y2_2, med_u1_1, med_u2_1; ...
      med_y1_2, med_y2_2, med_u1_2, med_u2_2; ...
      med_y1_3, med_y2_3, med_u1_3, med_u2_3; ...
      sqrt(var_y1_1), sqrt(var_y2_1), sqrt(var_u1_1), sqrt(var_u2_1); ...
      sqrt(var_y1_2), sqrt(var_y2_2), sqrt(var_u1_2), sqrt(var_u2_2); ...
      sqrt(var_y1_3), sqrt(var_y2_3), sqrt(var_u1_3), sqrt(var_u2_3)];