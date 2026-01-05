function [Zcz, m, n, code] = zcz_code_L_M(L, M)
%[Zcz, m, n, code] = zcz_code_L_M(L, M)
%
% Returns Zcz and the matrix with the Zero Correlation Zone (ZCZ) codes,from L and M
% According to the article: Pingzhi Fan, N. Suehiro, N. Kuroyanagi and X. M. Deng,
% Class of binary sequences with zero correlation zone,
% IEEE Electronics Letters, Vol. 35, No. 10, pp. 777-779, 1999
% The resulting code is F(L, M, Zcz) =
% (2^(2n+m) * Lo, 2^(n+1), 2^(n+m) + 1)
% Where:
% Lo = 2
% L = 2^(2n+m) * Lo is the total length of the lines of the code matrix. It is the length of the codes.
% M = 2^(n+1) is the number of rows in the code matrix. % This is the number of codes in the family.
% m: This parameter defines the starter or initial vector. The larger m is, the larger Zcz and the smaller M.
% n: This parameter sets the number of iterations when generating the code matrices, starting from the starter or initial vector.
%code: Matrix. Each row is a different ZCZ code.
% Zcz = 2^(n+m) + 1 is the number of zeros around the center of any correlation performed. It is the length of the zero correlation zone.
% You need to use the function zcz_code(m,n)
%
%Esp.
% Retorna Zcz y la matriz con los codigos Zero Correlation Zone (ZCZ),
% a partir de L y M
%Segun el articulo: Pingzhi Fan, N. Suehiro, N. Kuroyanagi and X. M. Deng,
% Class of binary sequences with zero correlation zone,
% IEE Electronics Letters, Vol.35, No.10, pp.777-779, 1999
%El codigo resultante es F(L, M, Zcz) =
% (2^(2n+m) * Lo, 2^(n+1), 2^(n+m) + 1)
%Donde:
% Lo = 2
% L = 2^(2n+m) * Lo  es la longitud total de las lineas de la matriz code. Es la longitud de los codigos.
% M = 2^(n+1)  es el numero de filas de la matriz code. Es el numero de codigos de la familia.
% m: Es el parametro que define el starter o vector inicial. Cuanto mayor sea m, mayor es Zcz y menor es M
% n: Es el parametro que establece el numero de iteraciones al generar las matrices de codigos, a partir del starter o vector inicial.
%code: Matriz. Cada fila es un codigo ZCZ diferente.
% Zcz = 2^(n+m) + 1 es el numero de ceros entorno al centro de cualquier correlacion que se haga. Es la longitud de la zona de correlacion cero
%Necesita utilizar la funcion zcz_code(m,n)

% Copyright 2021, Pablo Torío (ORCID: 0000-0001-7934-3345)
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%    http://www.apache.org/licenses/LICENSE-2.0
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.

%Control
if (log2(L) ~= int8(log2(L)))
    disp('L must be a power of 2');
    disp('L debe ser una potencia de 2');
    Zcz = 0; code = 0;
    return;
end
if (log2(M) ~= int8(log2(M)))
    disp('M must be a power of 2');
    disp('M debe ser una potencia de 2');
    Zcz = 0; code = 0;
    return;
end

%Calculo de los parametros m y n, a partir de L y M
n = log2(M) - 1;
m = log2(L) - 2*n - 1;

%Control
if (m < 0)
    disp('m < 0. M cannot be so high');
    disp('m < 0. No es posible este valor tan alto de M');
    Zcz = 0; code = 0;
    return;
end
    
%Retornar resultados
% Zcz = 2^(n+m) + 1;
[code, Mrecalculado, Zcz] = zcz_code(m,n);

%Control
if (Mrecalculado ~= M)
    dist('Error when checking out M');
    dist('Error en el calculo de comprobacion de M');   
end

end

