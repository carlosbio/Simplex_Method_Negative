% -------------------------------------------------------------------------
%
%       Função que apresenta a solução óptima e o valor de Z óptimo
%
% -------------------------------------------------------------------------
%
%   Trabalho realizado no âmbito da disciplina de Investigação Operacional
%
%   ISEC - Curso de Engenharia Informática, ano lectivo 2014/2015
%
%   Autor: Carlos da Silva (21220319)
%
%   Turma: P6
%
%   Data de realização: 21/11/2014
%
%   NOTA: O presente trabalho trata-se de uma adaptação de uma
%   implementação do Método Simplex realizada numa das aulas práticas
%   laboratoriais, modificando-o de forma a contemplar o caso particular
%   de, num dado problema, existirem variáveis de decisão a poderem tomar
%   valores negativos
%
% -------------------------------------------------------------------------
%
%   Parâmetros de entrada:
%
%   n = nº de variáveis
%   m = nº de restrições
%   r = vector dos índices das variáveis que assumem valores negativos
%   l = vector dos limites inferiores das gamas de valores
%   nro = nro de variáveis que podem assumir valores negativos
%   c = coeficientes de todas as variaveis na FO
%   A = matriz A do problema na forma aumentada
%   colb = valores originais da coluna b
%   d = valor constante da coluna b
%   b = vector dos termos independentes das restrições após transformação
%
% -------------------------------------------------------------------------

function Apresenta_info(n,m,r,l,nro,c,A,colb,d,b)

rest=zeros(1,n); % vector inicializado com n zeros

for i=1:n % Cria um vector que guarda as restrições do problema
    for j=1:nro
       if i==r(j)
           rest(i)=l(j);
       end
    end
end

fprintf('----------------------');
fprintf('\n Problema a resolver:\n');
fprintf('----------------------');
fprintf('\n\n Max  z =');

for i=1:n % Ciclo que mostra no ecrã a Função Objectivo
    if c(i)<0
        aux=c(i)*(-1); % Caso seja um valor negativo
        fprintf(' - %d x%d',aux,i);
    else
        if i==1
            fprintf(' %d x%d',c(i),i); % Se for o 1ro valor positivo
        else
            fprintf(' + %d x%d',c(i),i); % Se for outro valor positivo
        end
    end 
end

fprintf('\n sujeito a\n\n');

for i=1:m % Ciclo que mostra no ecrã os coeficientes e variáveis da matriz
    fprintf(' \t\t');
    for j=1:n
        if A(i,j)==0    % Caso o valor seja zero
            if j==1     % Caso seja o primeiro valor
                fprintf('      ');
            else
                fprintf('       ');
            end
        else
            if A(i,j)<0 % Caso o valor seja negativo
                aux=A(i,j)*(-1);
                if j==1 % Caso seja o primeiro valor
                    fprintf('- %d x%d',aux,j);
                else
                    fprintf(' - %d x%d',aux,j);
                end
            else
                if j==1 % Caso seja o 1ro valor positivo
                    fprintf('  %d x%d',A(i,j),j);
                else
                    fprintf(' + %d x%d',A(i,j),j);
                end
            end
        end
    end
    
    fprintf(' <= %d\n',colb(i)); % Mostra os valores da coluna b
end

fprintf('\n \t\t');

for i=1:n % Mostra as restrições das variáveis
    if i==1
        fprintf('  x%d >= %d',i,rest(1,i));
    else
        fprintf(',  x%d >= %d',i,rest(1,i));
    end
end

if nro~=0 % Caso haja pelo menos uma variável que possa assumir valores negativos
    fprintf('\n\n');
    fprintf('----------------------------------');
    fprintf('\n Mudanças de variável a efectuar:\n');
    fprintf('----------------------------------');
    fprintf('\n\n');

    for i=1:n
        flagaux=0; % Estratégia com recurso a uma flag auxiliar que se repete ao longo da função

        for j=1:nro
            if i==r(j)
                flagaux=1; % O valor consta no vector com as variáveis a transformar
            end
        end

        if flagaux==1
            neg=rest(1,i)*(-1); % Variável auxiliar
            fprintf(' x´%d = x%d + %d >= 0  ou seja  x%d = x´%d - %d\n\n',i,i,neg,i,i,neg);
        end
    end
    
    fprintf('----------------------------------------------------------------');
    fprintf('\n Depois da substituição do modelo acima, este transforma-se em:\n');
    fprintf('----------------------------------------------------------------');
    fprintf('\n\n Max  Z =');

    for i=1:n % Ciclo que mostra no ecrã a função objectivo transformada
        if c(i)<0
            aux=c(i)*(-1); % Caso seja um valor negativo

            flagaux=0;

            for j=1:nro
                if i==r(j)
                    flagaux=1; % O valor consta do vector
                end
            end

            if flagaux==1
                neg=rest(1,i)*(-1);
                fprintf(' - %d (x´%d - %d)',aux,i,neg);
            else
                fprintf(' - %d x%d',aux,i);
            end
        else % Sendo um valor positivo
            if i==1 % Se for o primeiro da equação
                flagaux=0;

                for j=1:nro

                    if i==r(j)
                        flagaux=1;
                    end
                end

                if flagaux==1
                    neg=rest(1,i)*(-1);
                    fprintf(' %d (x´%d - %d)',c(i),i,neg);
                else
                    fprintf(' %d x%d',c(i),i);
                end
            else % Caso não seja o primeiro da equação
                flagaux=0;

                for j=1:nro

                    if i==r(j)
                        flagaux=1;
                    end
                end

                if flagaux==1
                    neg=rest(1,i)*(-1);
                    fprintf(' + %d (x´%d - %d)',c(i),i,neg);
                else
                    fprintf(' + %d x%d',c(i),i);
                end  
            end
        end 
    end

    fprintf(' =');

    for i=1:n % Ciclo que mostra no ecrã a função objectivo transformada e simplificada
        if c(i)<0
            aux=c(i)*(-1); % Caso seja um valor negativo

            flagaux=0;

            for j=1:nro
                if i==r(j)
                    flagaux=1;
                end
            end

            if flagaux==1
                fprintf(' - %d x´%d',aux,i);
            else
                fprintf(' - %d x%d',aux,i);
            end
        else % No caso de um valor positivo
            if i==1
                flagaux=0;

                for j=1:nro

                    if i==r(j)
                        flagaux=1;
                    end
                end

                if flagaux==1
                    fprintf(' %d x´%d',c(i),i);
                else
                    fprintf(' %d x%d',c(i),i);
                end
            else % Não sendo o primeiro da equação, aplica a seguinte formatação
                flagaux=0;

                for j=1:nro

                    if i==r(j)
                        flagaux=1;
                    end
                end

                if flagaux==1
                    fprintf(' + %d x´%d',c(i),i);
                else
                    fprintf(' + %d x%d',c(i),i);
                end  
            end
        end 
    end

    if d>0 % Valor constante que vai ser colocado no topo da coluna b
        fprintf(' - %d',d);
    else
        daux=d*(-1);
        fprintf(' + %d',daux);
    end

    fprintf('\n sujeito a\n\n');

    for i=1:m % Ciclo que mostra no ecrã os coeficientes e variáveis da matriz
        fprintf(' \t\t');
        for j=1:n
            if A(i,j)==0    % Caso o valor seja zero
                if j==1     % Caso seja o primeiro valor
                    flagaux=0;

                    for k=1:nro
                        if j==r(k)
                            flagaux=1; % Estratégia baseada numa flag auxiliar
                        end
                    end

                    if flagaux==1
                        fprintf('              ');
                    else
                        fprintf('      ');
                    end
                else % Caso não seja o primeiro valor, aplica as devidas formatações de texto
                    flagaux=0;

                    for k=1:nro
                        if j==r(k)
                            flagaux=1;
                        end
                    end

                    if flagaux==1
                        fprintf('              ');
                    else
                        fprintf('       ');
                    end
                end
            else
                if A(i,j)<0 % Caso o valor seja negativo
                    aux=A(i,j)*(-1);

                    if j==1 % Caso seja o primeiro valor
                        flagaux=0;

                        for k=1:nro
                            if j==r(k)
                                flagaux=1;
                            end
                        end

                        if flagaux==1
                            neg=rest(1,j)*(-1);
                            fprintf('- %d (x´%d - %d)',aux,j,neg);
                        else
                            fprintf('- %d x%d',aux,j);
                        end

                    else
                        flagaux=0;

                        for k=1:nro
                            if j==r(k)
                                flagaux=1;
                            end
                        end

                        if flagaux==1
                            neg=rest(1,j)*(-1);
                            fprintf(' - %d (x´%d - %d)',aux,j,neg);
                        else
                            fprintf(' - %d x%d',aux,j);
                        end
                    end  
                else
                    if j==1 % Caso seja o 1ro valor positivo
                        flagaux=0;

                        for k=1:nro
                            if j==r(k)
                                flagaux=1;
                            end
                        end

                        if flagaux==1
                            neg=rest(1,j)*(-1);
                            fprintf('  %d (x´%d - %d)',A(i,j),j,neg);
                        else
                            fprintf('  %d x%d',A(i,j),j);
                        end
                    else
                        flagaux=0;

                        for k=1:nro
                            if j==r(k)
                                flagaux=1;
                            end
                        end

                        if flagaux==1
                            neg=rest(1,j)*(-1);
                            fprintf(' + %d (x´%d - %d)',A(i,j),j,neg);
                        else
                            fprintf(' + %d x%d',A(i,j),j);
                        end
                    end
                end
            end
        end

        fprintf(' <= %d\n',colb(i)); % Mostra os valores da coluna b
    end

    fprintf('\n <=>\n');

    for i=1:m % Ciclo que mostra no ecrã os coeficientes e variáveis da matriz
        fprintf(' \t\t');
        for j=1:n
            if A(i,j)==0    % Caso o valor seja zero
                if j==1     % Caso seja o primeiro valor
                    flagaux=0;

                    for k=1:nro
                        if j==r(k)
                            flagaux=1;
                        end
                    end

                    if flagaux==1
                        fprintf('       ');
                    else
                        fprintf('      ');
                    end
                else
                    flagaux=0;

                    for k=1:nro
                        if j==r(k)
                            flagaux=1;
                        end
                    end

                    if flagaux==1
                        fprintf('        ');
                    else
                        fprintf('       ');
                    end
                end
            else
                if A(i,j)<0 % Caso o valor seja negativo
                    aux=A(i,j)*(-1);

                    if j==1 % Caso seja o primeiro valor
                        flagaux=0;

                        for k=1:nro
                            if j==r(k)
                                flagaux=1;
                            end
                        end

                        if flagaux==1
                            fprintf('- %d x´%d',aux,j);
                        else
                            fprintf('- %d x%d',aux,j);
                        end

                    else
                        flagaux=0;

                        for k=1:nro
                            if j==r(k)
                                flagaux=1;
                            end
                        end

                        if flagaux==1
                            fprintf(' - %d x´%d',aux,j);
                        else
                            fprintf(' - %d x%d',aux,j);
                        end
                    end  
                else
                    if j==1 % Caso seja o 1ro valor positivo
                        flagaux=0;

                        for k=1:nro
                            if j==r(k)
                                flagaux=1;
                            end
                        end

                        if flagaux==1
                            fprintf('  %d x´%d',A(i,j),j);
                        else
                            fprintf('  %d x%d',A(i,j),j);
                        end
                    else
                        flagaux=0;

                        for k=1:nro
                            if j==r(k)
                                flagaux=1;
                            end
                        end

                        if flagaux==1
                            fprintf(' + %d x´%d',A(i,j),j);
                        else
                            fprintf(' + %d x%d',A(i,j),j);
                        end
                    end
                end
            end
        end

        fprintf(' <= %d\n',b(i)); % Mostra os valores da coluna b
    end

    fprintf('\n \t\t');

    for i=1:n % Mostra as restrições das variáveis
        if i==1
            flagaux=0;

            for j=1:nro
                if i==r(j)
                    flagaux=1;
                end
            end

            if flagaux==1
                fprintf('  x´%d >= 0',i);
            else
                fprintf('  x%d >= 0',i)
            end
        else
            flagaux=0;

            for j=1:nro
                if i==r(j)
                    flagaux=1;
                end
            end

            if flagaux==1
                fprintf(',  x´%d >= 0',i);
            else
                fprintf('  x%d >= 0',i)
            end 
        end
    end
end

fprintf('\n\n');
fprintf('--------------------------------');
fprintf('\n Premir uma tecla para avançar\n');
fprintf('--------------------------------');
fprintf('\n\n');

pause % Espera que o utilizador carregue numa tecla

end
