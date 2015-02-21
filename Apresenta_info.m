% -------------------------------------------------------------------------
%
%       Fun��o que apresenta a solu��o �ptima e o valor de Z �ptimo
%
% -------------------------------------------------------------------------
%
%   Trabalho realizado no �mbito da disciplina de Investiga��o Operacional
%
%   ISEC - Curso de Engenharia Inform�tica, ano lectivo 2014/2015
%
%   Autor: Carlos da Silva (21220319)
%
%   Turma: P6
%
%   Data de realiza��o: 21/11/2014
%
%   NOTA: O presente trabalho trata-se de uma adapta��o de uma
%   implementa��o do M�todo Simplex realizada numa das aulas pr�ticas
%   laboratoriais, modificando-o de forma a contemplar o caso particular
%   de, num dado problema, existirem vari�veis de decis�o a poderem tomar
%   valores negativos
%
% -------------------------------------------------------------------------
%
%   Par�metros de entrada:
%
%   n = n� de vari�veis
%   m = n� de restri��es
%   r = vector dos �ndices das vari�veis que assumem valores negativos
%   l = vector dos limites inferiores das gamas de valores
%   nro = nro de vari�veis que podem assumir valores negativos
%   c = coeficientes de todas as variaveis na FO
%   A = matriz A do problema na forma aumentada
%   colb = valores originais da coluna b
%   d = valor constante da coluna b
%   b = vector dos termos independentes das restri��es ap�s transforma��o
%
% -------------------------------------------------------------------------

function Apresenta_info(n,m,r,l,nro,c,A,colb,d,b)

rest=zeros(1,n); % vector inicializado com n zeros

for i=1:n % Cria um vector que guarda as restri��es do problema
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

for i=1:n % Ciclo que mostra no ecr� a Fun��o Objectivo
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

for i=1:m % Ciclo que mostra no ecr� os coeficientes e vari�veis da matriz
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

for i=1:n % Mostra as restri��es das vari�veis
    if i==1
        fprintf('  x%d >= %d',i,rest(1,i));
    else
        fprintf(',  x%d >= %d',i,rest(1,i));
    end
end

if nro~=0 % Caso haja pelo menos uma vari�vel que possa assumir valores negativos
    fprintf('\n\n');
    fprintf('----------------------------------');
    fprintf('\n Mudan�as de vari�vel a efectuar:\n');
    fprintf('----------------------------------');
    fprintf('\n\n');

    for i=1:n
        flagaux=0; % Estrat�gia com recurso a uma flag auxiliar que se repete ao longo da fun��o

        for j=1:nro
            if i==r(j)
                flagaux=1; % O valor consta no vector com as vari�veis a transformar
            end
        end

        if flagaux==1
            neg=rest(1,i)*(-1); % Vari�vel auxiliar
            fprintf(' x�%d = x%d + %d >= 0  ou seja  x%d = x�%d - %d\n\n',i,i,neg,i,i,neg);
        end
    end
    
    fprintf('----------------------------------------------------------------');
    fprintf('\n Depois da substitui��o do modelo acima, este transforma-se em:\n');
    fprintf('----------------------------------------------------------------');
    fprintf('\n\n Max  Z =');

    for i=1:n % Ciclo que mostra no ecr� a fun��o objectivo transformada
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
                fprintf(' - %d (x�%d - %d)',aux,i,neg);
            else
                fprintf(' - %d x%d',aux,i);
            end
        else % Sendo um valor positivo
            if i==1 % Se for o primeiro da equa��o
                flagaux=0;

                for j=1:nro

                    if i==r(j)
                        flagaux=1;
                    end
                end

                if flagaux==1
                    neg=rest(1,i)*(-1);
                    fprintf(' %d (x�%d - %d)',c(i),i,neg);
                else
                    fprintf(' %d x%d',c(i),i);
                end
            else % Caso n�o seja o primeiro da equa��o
                flagaux=0;

                for j=1:nro

                    if i==r(j)
                        flagaux=1;
                    end
                end

                if flagaux==1
                    neg=rest(1,i)*(-1);
                    fprintf(' + %d (x�%d - %d)',c(i),i,neg);
                else
                    fprintf(' + %d x%d',c(i),i);
                end  
            end
        end 
    end

    fprintf(' =');

    for i=1:n % Ciclo que mostra no ecr� a fun��o objectivo transformada e simplificada
        if c(i)<0
            aux=c(i)*(-1); % Caso seja um valor negativo

            flagaux=0;

            for j=1:nro
                if i==r(j)
                    flagaux=1;
                end
            end

            if flagaux==1
                fprintf(' - %d x�%d',aux,i);
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
                    fprintf(' %d x�%d',c(i),i);
                else
                    fprintf(' %d x%d',c(i),i);
                end
            else % N�o sendo o primeiro da equa��o, aplica a seguinte formata��o
                flagaux=0;

                for j=1:nro

                    if i==r(j)
                        flagaux=1;
                    end
                end

                if flagaux==1
                    fprintf(' + %d x�%d',c(i),i);
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

    for i=1:m % Ciclo que mostra no ecr� os coeficientes e vari�veis da matriz
        fprintf(' \t\t');
        for j=1:n
            if A(i,j)==0    % Caso o valor seja zero
                if j==1     % Caso seja o primeiro valor
                    flagaux=0;

                    for k=1:nro
                        if j==r(k)
                            flagaux=1; % Estrat�gia baseada numa flag auxiliar
                        end
                    end

                    if flagaux==1
                        fprintf('              ');
                    else
                        fprintf('      ');
                    end
                else % Caso n�o seja o primeiro valor, aplica as devidas formata��es de texto
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
                            fprintf('- %d (x�%d - %d)',aux,j,neg);
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
                            fprintf(' - %d (x�%d - %d)',aux,j,neg);
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
                            fprintf('  %d (x�%d - %d)',A(i,j),j,neg);
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
                            fprintf(' + %d (x�%d - %d)',A(i,j),j,neg);
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

    for i=1:m % Ciclo que mostra no ecr� os coeficientes e vari�veis da matriz
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
                            fprintf('- %d x�%d',aux,j);
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
                            fprintf(' - %d x�%d',aux,j);
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
                            fprintf('  %d x�%d',A(i,j),j);
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
                            fprintf(' + %d x�%d',A(i,j),j);
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

    for i=1:n % Mostra as restri��es das vari�veis
        if i==1
            flagaux=0;

            for j=1:nro
                if i==r(j)
                    flagaux=1;
                end
            end

            if flagaux==1
                fprintf('  x�%d >= 0',i);
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
                fprintf(',  x�%d >= 0',i);
            else
                fprintf('  x%d >= 0',i)
            end 
        end
    end
end

fprintf('\n\n');
fprintf('--------------------------------');
fprintf('\n Premir uma tecla para avan�ar\n');
fprintf('--------------------------------');
fprintf('\n\n');

pause % Espera que o utilizador carregue numa tecla

end
