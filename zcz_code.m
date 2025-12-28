function [code, M, Zcz] = zcz_code(m, n)
%[code, M, Zcz]  = zcz_code(m, n)
%
% Returns the matrix with the Zero Correlation Zone (ZCZ) codes,
% according to the article: Pingzhi Fan, N. Suehiro, N. Kuroyanagi and X. M. Deng,
% Class of binary sequences with zero correlation zone,
% IEEE Electronics Letters, Vol. 35, No. 10, pp. 777-779, 1999
% The resulting code is F(L, M, Zcz) =
% (2^(2n+m) * Lo, 2^(n+1), 2^(n+m) + 1)
% Where:
% Lo = 2
% L = 2^(2n+m) * Lo is the total length of the lines of
% the code matrix. It is the length of the codes.
% M = 2^(n+1) is the number of rows in the code matrix. It is the number of codes in the family.
% m: This parameter defines the starter or initial vector. The larger m is, the larger Zcz is and the smaller M is.
% n: This parameter sets the number of iterations when generating the
% code matrices, starting from the starter or initial vector.
% If the parameter m is high relative to n, Zcz increases, although not many different codes are obtained.
% The number of different codes depends on the parameter n.
% Returns:
% code: Matrix. Each row is a different ZCZ code.
%
%Esp.
% Retorna la la matriz con los codigos Zero Correlation Zone (ZCZ),
% segun el articulo: Pingzhi Fan, N. Suehiro, N. Kuroyanagi and X. M. Deng,
% Class of binary sequences with zero correlation zone,
% IEE Electronics Letters, Vol.35, No.10, pp.777-779, 1999
%El codigo resultante es F(L, M, Zcz) =
% (2^(2n+m) * Lo, 2^(n+1), 2^(n+m) + 1)
%Donde:
% Lo = 2
% L = 2^(2n+m) * Lo  es la longitud total de las lineas de la matriz code. Es la longitud de los codigos.
% M = 2^(n+1)  es el numero de filas de la matriz code. Es el numero de codigos de la familia.
% m: Es el parametro que define el starter o vector inicial. Cuanto mayor sea m, mayor es Zcz y menor es M.
% n: Es el parametro que establece el numero de iteraciones al generar las matrices de codigos, a partir del starter o vector inicial.
%Si el parametro m es alto con relacion a n, Zcz aumenta, aunque no se consiguen demasiados códigos diferentes.
%El numero de codigos diferentes depende del parametro n
%Retorna:
%code: Matriz. Cada fila es un codigo ZCZ diferente.

% By Pablo Torio. 2016 a 2021

%Calculo del starter, a partir del parametro m
xy0 = [1, 1];
xy = xy0;
for ctr = 1 : m
    aux = zeros(2^ctr, 2);
    aux(:, 1) = [xy(:, 1); xy(:, 2)];
    aux(:, 2) = [-xy(:, 1); xy(:, 2)];
    xy = aux;
end
%starter
F0 = zeros(2, 2, 2^m);
F0(1, 1, :) = -xy(:, 1);
F0(1, 2, :) = xy(:, 2);
F0(2, 1, :) = -flipud(xy(:, 2));
F0(2, 2, :) = -flipud(xy(:, 1));
%Calculo de la matriz code, a partir del parametro n
F = F0;
%Numero de filas
rows = size(F, 1);
%Longitud de la tercera dimension
depth = size(F, 3);
for ctr = 1 : n
    %bloque arriba izquierda
    block11 = zeros(rows, rows, 2*depth);
    block11(:, :, 1:depth) = F;
    block11(:, :, depth+1:2*depth) = F;
    %bloque arriba derecha
    block12 = zeros(rows, rows, 2*depth);
    block12(:, :, 1:depth) = -F;
    block12(:, :, depth+1:2*depth) = F;
    %bloque abajo izquierda, igual a block12
    %bloque abajo derecha, igual a block11
    %Nueva matriz, de orden superior
    F = zeros(2*rows, 2*rows, 2*depth);
    %bloque arriba izquierda
    F(1:rows, 1:rows, :) = block11;
    %bloque arriba derecha
    F(1:rows, rows+1:2*rows, :) = block12;
    %bloque abajo izquierda
    F(rows+1:2*rows, 1:rows, :) = block12;
    %bloque abajo derecha
    F(rows+1:2*rows, rows+1:2*rows, :) = block11;
    %incrementar longitudes
    rows = rows * 2;
    depth = depth * 2;  
end
%sintetizar la matriz code, pasando F de tres a dos dimensiones
cols = rows;
code = zeros(rows, cols*depth);
for ctr = 1 : cols
    cursor = 1 + (ctr - 1) * depth;
    code(:, cursor:cursor+depth-1) = F(:, ctr, :);
end

M = 2 ^ (n + 1);
Zcz = 2 ^ (n + m) + 1;

end

