function sequenceArray = findAllUZCZ(L, UZCZ)
%sequenceArray = findAllUZCZ(L, UZCZ)
%
% Returns an array with all available one-sided zero-correlation zone (UZCZ) codes
% of length L and one-sided zero-correlation zone of length UZCZ.
% Each row has a developed UZCZ code
% Stems from the article: Pingzhi Fan, N. Suehiro, N. Kuroyanagi and X. M. Deng,
% Class of binary sequences with zero correlation zone,
% IEEE Electronics Letters, Vol. 35, No. 10, pp. 777-779, 1999
% L: Length of the UZCZ code
% UZCZ: Length of the one-sided zero-correlation zone on the right
%Return:
% sequenceArray: Array with the UZCZ codes
%
%Requires using the function period_corr(z1, z2)
%
%Locates all codes using brute force, i.e., checking them
% one by one. That's why it's inefficient.
%
%Esp.
% Retorna una matriz con todos los codigos de zona unilateral
%  de correlacion cero (UZCZ) disponibles de longitud L y zona unilateral
%  de correlacion cero de longitud UZCZ.
% En cada fila tiene un codigo UZCZ desarrollado
%Basado en el articulo: Pingzhi Fan, N. Suehiro, N. Kuroyanagi and X. M. Deng,
% Class of binary sequences with zero correlation zone,
% IEE Electronics Letters, Vol.35, No.10, pp.777-779, 1999
% L: longitud del codigo UZCZ
% UZCZ: Longitud de la zona unilateral de correlacion cero a la derecha
%Return:
% sequenceArray: Matriz con los codigos UZCZ
%
%Necesita utilizar la funcion period_corr(z1, z2)
%
%Localiza todos los codigos usando fuerza bruta, es decir, comprobandolos
% todos uno por uno. Por eso es poco eficiente.

% Pablo Torio. 2021

%Mask
%Mascara
vectorVacio = zeros(1, L);
mascaraAutocorr = zeros(1, L);
mascaraAutocorr(2:UZCZ+1) = ones(1, UZCZ);
mascaraCrosscorr = zeros(1, L);
mascaraCrosscorr(1:UZCZ+1) = ones(1, UZCZ+1);
numCombinaciones = 2^L - 1;
sequenceArray = zeros(L/4, L, 4*L);
encontradosPrincipal = 0;
for ctr1 = 1 : numCombinaciones
    %Convert ctr1 to binary
    %Convertir ctr1 a binario
    code = de2bi(ctr1);
    code1 = vectorVacio;
    code1(1:length(code)) = code;
    % Convert sequences so as zeros are -1
    % Convertir las secuencias, de manera que los ceros sean -1
    code1 = 2 * code1 - 1;
    autocorr = period_corr(code1, code1);
    comprobarUZCZ = mascaraAutocorr .* autocorr;
    if (not(any(comprobarUZCZ)))
        %This code can be
        %Este codigo puede ser
        encontradosPrincipal = encontradosPrincipal + 1;
        sequenceArray(1, :, encontradosPrincipal) = code1;
        disp(ctr1);%%%%%%%%%%%%%
        encontradosAmigos = 1;
        for ctr2 = ctr1+1 : numCombinaciones
            %Convert ctr2 to binary
            %Convertir ctr2 a binario
            code = de2bi(ctr2);
            code2 = vectorVacio;
            code2(1:length(code)) = code; 
            % Convert sequences so as zeros are -1
            % Convertir las secuencias, de manera que los ceros sean -1
            code2 = 2 * code2 - 1;
            
            autocorr = period_corr(code2, code2);
            comprobarUZCZ = mascaraAutocorr .* autocorr;   
            if (any(comprobarUZCZ))
                continue;
            end
            ctrAmigos = 0;
            for ctr3 = 1 : encontradosAmigos
                xcorr = period_corr(sequenceArray(ctr3, :, ...
                        encontradosPrincipal), code2);
                comprobarUZCZ = mascaraCrosscorr .* xcorr;
                if (any(comprobarUZCZ))
                    break;
                end
                ctrAmigos = ctrAmigos + 1;
            end
            if (ctrAmigos >= encontradosAmigos)
                encontradosAmigos = encontradosAmigos + 1;
                sequenceArray(encontradosAmigos, :, ...
                    encontradosPrincipal) = code2;           
            end
        end
    end
end
                
end


