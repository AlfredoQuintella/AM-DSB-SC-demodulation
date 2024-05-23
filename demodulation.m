% Carregar o arquivo de áudio
filename = '22401_9900.mp3';
[x, fs] = audioread(filename);

% Tempo do sinal de áudio
t = (0:length(x)-1) / fs;

% Plot do sinal modulado 
figure;
subplot(3,2,1);
plot(t, x);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal no Domínio do Tempo');
grid on;

subplot(3,2,2);
EspectroLog(fs, x);
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Espectro de Frequência');
grid on;

%-------------------------------------------------------------------------%
%-             Demodulando                                         -      %
%-------------------------------------------------------------------------%

% Parametros
fc = 9900; % Frequência da portadora
BW = 1500; % Largura de banda do sinal modulante

% Tempo e sinal já carregados
t = (0:length(x)-1) / fs;
carrier = cos(2 * pi * fc * t);

% Demodulação coerente
demodulated_signal = x .* carrier';

% Plotar o sinal demodulado antes do filtro passa-baixa
% Domínio do tempo
subplot(3,2,3);
plot(t, demodulated_signal);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Demodulado Antes do Filtro Passa-Baixa');
grid on;

% Espectro de frequência do sinal demodulado antes do filtro passa-baixa
subplot(3,2,4);
EspectroLog(fc, demodulated_signal);
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Espectro de Frequência do Sinal Demodulado Antes do Filtro Passa-Baixa');
grid on;

%-------------------------------------------------------------------------%
%-                Filtro passa-baixa                                      %
% ------------------------------------------------------------------------%

% Filtro passa-baixa para remover a portadora
load('coef_filtr.mat');  % Carregar os coeficientes do filtro
demodulated_signal_filtered = filter(B, A, demodulated_signal);

% Plotando os gráficos
% Domínio do tempo
subplot(3,2,5);
plot(t, demodulated_signal_filtered);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Demodulado no Domínio do Tempo Depois do Filtro Passa-Baixa');
grid on;

% Espectro de frequência do sinal demodulado depois do filtro passa-baixa
subplot(3,2,6);
EspectroLog(fc, demodulated_signal_filtered);
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Espectro de Frequência do Sinal Demodulado Depois do Filtro Passa-Baixa');
grid on;

% Reproduzir o áudio demodulado filtrado
sound(demodulated_signal_filtered, 41100);

% Escrevendo novo arquivo
audiowrite("22401_9900_demod.wav", demodulated_signal_filtered, 44100);

% Bitter Sweet Symphony - The Verve
