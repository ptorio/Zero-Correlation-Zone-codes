function correlat = period_corr(z1, z2)
%correlat = period_corr(z1, z2)
%
% Returns the periodic correlation between z1 and z2
%The order of the operands z1 and z2 is that of the definition of
% correlation. It is not like the xcorr function in Matlab,
% which considers the order of the operands in reverse order
%z1 y z2 are row vectors
%There is no guarantee that the last piece is correct if z1 or z2 are
% truncated sequences of periodic series, ie., if they do not contain an
% integer number of complete periods.
%
%Esp.
% Retorna la correlacion periodica entre z1 y z2
%El orden de los operandos z1 y z2 es el propio de la definicion de
% correlacion. No es como la funcion xcorr de Matlab,
% que considera el orden de los operandos al reves
%z1 y z2 son vectores fila
%No hay garantia de que el ultimo trozo este correcto si z1 o z2 son
% secuencias truncadas de series periodicas, es decir, si no contienen un
% numero entero de periodos completos.

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


%Buscar cual es la secuencia mas corta y cual la mas larga
L = max(length(z1), length(z2));
P = min(length(z1), length(z2));
firstIsTheLongOne = 1;
if (L == length(z1))
    firstIsTheLongOne = 1;
    longSequence = z1;
    clear z1;
    shortSequence = z2;
    clear z2;
else
    firstIsTheLongOne = 0;
    longSequence = z2;
    clear z2;
    shortSequence = z1;
    clear z1;
end

%Para hacer la correlacion periodica sin aliasing
N = L + P - 1;
%Si las secuencias son iguales no hay que hacer zero padding
if (L == P); N = L; end
%Secuencia larga rellenada con ceros
longSequencePadded = zeros(1, N); 
longSequencePadded(1 : L) = longSequence; 
clear longSequence;
%Secuencia corta rellenada con ceros
shortSequencePadded = zeros(1, N); 
shortSequencePadded(1 : P) = shortSequence;
clear shortSequence;

%Para hacer la correlacion se utilizara la siguiente formula:
% correlat(s1, s2) = ifft(conj(fft(s1)) .* fft(s2))
fftLong = fft(longSequencePadded);
clear longSequencePadded;
fftShort = fft(shortSequencePadded);
clear shortSequencePadded;

if (firstIsTheLongOne)
    correlat = ifft(conj(fftLong) .* fftShort);
else
    correlat = ifft(conj(fftShort) .* fftLong);
end

end

