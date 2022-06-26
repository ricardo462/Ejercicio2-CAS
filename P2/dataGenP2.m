clear, clc

%% Generación de señal APRBS
N = 10000; % Numero de datos
y(1) = 0; y(2) = 0; % c.i. de regresores de y

minu=-2; maxu=2; % límites de amplitud
levels = [minu maxu];
prbs = idinput(N, 'prbs', [0 1/15], levels);   % Generar PRBS

seed = 1;                                       % Initialise seed value
range = abs(maxu-minu);                       % Calculate level range
for i = 1:length(prbs) - 1
    if prbs(i) == prbs(i+1)                   % If being on the same level
        rng(seed);                            % use same seed
        r = range * rand;                     % Random number from 0 to range
        if prbs(i) == maxu                    % If level is high
            aprbs(i) = prbs(i) - r;           % decrement
            aprbs(i+1) = prbs(i+1) - r;
        else                                  % If level is low
            aprbs(i) = prbs(i) + r;           % increment
            aprbs(i+1) = prbs(i+1) + r;
        end
    else
        if seed > 2^31                        % Prevent seed overflow
            seed = randomSeed;        
        end
        seed = seed + 10;                     % When level is changed,
        rng(seed);                            % increment seed value
        r = range * rand;
        if prbs(i+1) == maxu                  % If level is high
            aprbs(i+1) = prbs(i+1) - r;       % decrement
        else                                  % If level is low
            aprbs(i+1) = prbs(i+1) + r;       % increment
        end
    end
end

figure(1)
stairs(aprbs)                                 % Plot signal
axis([0, N, minu - 0.1 * range, maxu + 0.1 * range])
xlabel('Muestras k')                              % X-label
ylabel('Amplitud')                      % Y-label
title('Señal APRBS')
u = aprbs;

%% generación de datos de salida
for i=3:N
    % se calcula de acuerdo a la dinámica del proceso
    y(i)=(0.9 - 0.4/sqrt(1 + y(i-2)*y(i-2)))*y(i-1) - (0.5 + 0.7/sqrt(1 + y(i-1)*y(i-1)))*y(i-2)...
             + u(i-1) + 0.3*u(i-2) + 0.2*u(i-1)*u(i-2) + normrnd(0, 0.01); % dinámica en estudio
end

figure(2)
plot(y)
xlabel('Muestras k')                              % X-label
ylabel('Amplitud')                      % Y-label
title('Respuesta del sistema a entrada APRBS')

Salida = y
Entrada = u
%% exportar datos
clearvars -except Salida Entrada

save dataP2
