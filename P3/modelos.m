clear
close all
clc
%%
% Datos entrenamiento
data1 = readtable("DATA1.xlsx");

velocidad = data1(:, "VelocidadReal_m_s_");
Entrada = velocidad{:, 1};

potencia = data1(:, "PotenciaEn23kV_MW_");
Salida = potencia{:, 1};

% Datos Validacion y Test
data2 = readtable("DATA2.xlsx");

velocidad = data2(:, "VelocidadReal_m_s_");
velocidad = velocidad{:, 1};

potencia = data2(:, "PotenciaEn23kV_MW_");
potencia = potencia{:, 1};


%% Salida
figure(1)
hold on
title('Salida Fenomenol�gica')
xlabel('Velocidad')
ylabel('Potencia')
plot(Entrada,Salida, 'bx')
%% Conjuntos de datos de entrenamiento
L=length(velocidad);
L1=round(L*0.5);%->50% datos
%% Entrenamiento
%Se separan los datos en los tres conjuntos.
InTest=Entrada(1:L1);
OutTest=Salida(1:L1);

%Validacion 
IntVal=Entrada(L1:L);
OutVal=Salida(L1:L);

%Generaci�n de objetos iddata. 

IdEnt=iddata(Salida,Entrada,1);
IdTest=iddata(OutTest,InTest,1);
IdVal=iddata(OutVal,IntVal,1);

%% FORMATO XY
%Obtenci�n de las matriz X y el vector Y con los datos de entrada y salida.
L1 = length(Salida);
Y=Salida(4:L1); % Resultado y(t) 
u1=Entrada(3:L1-1); % u(t-1) 
u2=Entrada(2:L1-2); % u(t-2) 

y1=Salida(3:L1-1); % y(t-1)
y2=Salida(2:L1-2); % y(t-2)


X = [y1 y2 u1 u2];

%%
%P = X\Y resuelve el sistema de ecs. lineales X*P = Y.
P = X\Y;
%P=(X'*X)^(-1)*X'*Y;
A = P(1:length(P)/2)';
B = P(length(P)/2+1:length(P))';
%% Compare XY con data
%Compara el polinomio obtenido para el modelo, con la data real.
sys0 = idpoly ([1 -A],B);  %-A?
compare(IdVal,sys0,1)

%% modelo ARX
modelarx = arx(IdEnt,[2 2 1],'IntegrateNoise',[0]);
%% Modelo ARIX
modelarix = arx(IdEnt,[2 2 1],'IntegrateNoise',[1]);
%% Con fines pedag�gicos, se supondr� que el modelo ARX tiene mejores metricas
%% Predicci�n a 1 y 10 pasos.
% Para 1 paso:
figure(3)
[ye,a]=compare(IdVal,modelarx,1); %Se compara el modelarx con los datos de validaci�n.
ye=get(ye);
y=get(IdVal);
ye2=cell2mat(ye.OutputData);
y2=cell2mat(y.OutputData);
hold on
plot([ye2 y2])
legend('Estimado','Real')
title('Salida real y salida estimada modelo ARX a 1 paso')
xlabel('Muestras k')
ylabel('y')
%Se entregan m�tricas para evaluar el desempe�o del modelo.
mae_ARX_1=mae(ye2,y2)
fit_1=a


%%
%Se repite el procedimiento a 10 pasos.
figure(4)
[ye,a]=compare(IdVal,modelarx,10);
ye=get(ye);
y=get(IdVal);
ye2=cell2mat(ye.OutputData);
y2=cell2mat(y.OutputData);
hold on
plot([ye2 y2])
legend('Estimado','Real')
title('Salida real y salida estimada modelo ARX a 10 paso')
xlabel('Muestras k')
ylabel('Y')
mae_ARX_10=mae(ye2,y2)
fit_10=a



