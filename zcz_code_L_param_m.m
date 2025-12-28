function [M, Zcz, n, code] = zcz_code_L_param_m(L, m)
%[M, Zcz, n, code] = zcz_code_L_param_m(L, m)
%
% Returns Zcz and the matrix with the Zero Correlation Zone (ZCZ) codes, from L and the parameter m
% According to the article: Pingzhi Fan, N. Suehiro, N. Kuroyanagi and X. M. Deng,
% Class of binary sequences with zero correlation zone,
% IEEE Electronics Letters, Vol. 35, No. 10, pp. 777-779, 1999
% The resulting code is F(L, M, Zcz) =
% (2^(2n+m) * Lo, 2^(n+1), 2^(n+m) + 1)
% Where:
% Lo = 2
% L = 2^(2n+m) * Lo is the total length of the lines of the code matrix. It is the length of the codes.
% m: Is the parameter that defines the starter or initial vector. The larger m is, the larger Zcz is and the smaller M is.
% n: This parameter sets the number of iterations when generating the code matrices, starting from the starter or initial vector.
% M = 2^(n+1) is the number of rows in the code matrix. This is the number of codes in the family.
%code: Matrix. Each row is a different ZCZ code.
% Zcz = 2^(n+m) + 1 is the number of zeros around the center of any correlation. It is the length of the zero correlation zone.
% You need to use the function zcz_code(m,n)
%
%Esp.
% Retorna Zcz y la matriz con los codigos Zero Correlation Zone (ZCZ),
% a partir de L y el parametro m
%Segun el articulo: Pingzhi Fan, N. Suehiro, N. Kuroyanagi and X. M. Deng,
% Class of binary sequences with zero correlation zone,
% IEE Electronics Letters, Vol.35, No.10, pp.777-779, 1999
%El codigo resultante es F(L, M, Zcz) =
% (2^(2n+m) * Lo, 2^(n+1), 2^(n+m) + 1)
%Donde:
% Lo = 2
% L = 2^(2n+m) * Lo  es la longitud total de las lineas de la matriz code. Es la longitud de los codigos.
% m: Es el parametro que define el starter o vector inicial. Cuanto mayor sea m, mayor es Zcz y menor es M
% n: Es el parametro que establece el numero de iteraciones al generar las matrices de codigos, a partir del starter o vector inicial.
% M = 2^(n+1) es el numero de filas de la matriz code. Es el numero de codigos de la familia.
%code: Matriz. Cada fila es un codigo ZCZ diferente.
% Zcz = 2^(n+m) + 1 es el numero de ceros entorno al centro de cualquier correlacion que se haga. Es la longitud de la zona de correlacion cero
%Necesita utilizar la funcion zcz_code(m,n)

% By Pablo Torio. 2021

%Control
if (log2(L) ~= int8(log2(L)))
    disp('L must be a power of 2');
    disp('L debe ser una potencia de 2');
    M = 0; Zcz = 0; code = 0;
    return;
end

%Calculo del parametro n, a partir de L y m
n = 0.5 * (log2(L) - m - 1);

%Control
if (n ~= int8(n))
    disp('log2(L) - m must be an odd number');
    disp('log2(L) - m debe ser un numero impar');
    M = 0; Zcz = 0; code = 0;
    return;
end

%Retornar resultados
% M = 2^(n+1);
% Zcz = 2^(n+m) + 1;
[code, M, Zcz] = zcz_code(m,n);

end

