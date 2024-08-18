%--------------------------------------------------------------------------
% Datos de Entrada

% Definir t como símbolo simbólico
syms t;

% Parámetros dados
g = 32.17; % pies/s^2
m = 0.25; % lb
k = 0.1; % lb-s/pies
s0 = 300; % pies

% Tolerancia
tol = 1e-3;

% Aproximación inicial
t0 = 1.0; % Valor inicial para t

% Número máximo de iteraciones
max_iter = 100;


% Definir la función simbólica para la altura s(t)
s_sym = s0 - (m * g / k) * t + (m^2 * g / k^2) * (1 - exp(-k * t / m));

% Calcular la derivada de s con respecto a t
ds_sym = diff(s_sym, t);

% Convertir las expresiones simbólicas a funciones manejables numéricamente
s = matlabFunction(s_sym);
ds = matlabFunction(ds_sym);

%--------------------------------------------------------------------------
% Método de Newton-Raphson
for iter = 1:max_iter
    s0 = s(t0);
    ds0 = ds(t0);
    t1 = t0 - s0 / ds0; % Actualizar t0 usando la fórmula de Newton-Raphson
    error = abs(t1 - t0);
    t0 = t1; % Preparar para la siguiente iteración
    if error < tol
        break; % Parar si se alcanza la tolerancia deseada
    end
end

% Mostrar los resultados
fprintf('El tiempo que tarda el objeto en caer al suelo es: %.10f segundos\n', t1);
fprintf('El número de iteraciones fue: %d\n', iter);
fprintf('El error estimado es: %.10f\n', error);

% Mostrar la derivada resultante
disp('La derivada de s(t) es:');
disp(ds_sym);