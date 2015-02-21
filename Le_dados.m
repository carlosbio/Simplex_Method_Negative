% -------------------------------------------------------------------------
%
%                   Função que obtém os dados do problema
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
%   n = nro de variáveis
%   m = nro de restrições
%   c = vector dos coeficientes das variáveis na FO (1xn)
%   A = matriz dos coeficientes das variáveis nas restrições (mxn)
%   b = vector dos termos independentes das restrições (mx1)
%   r = vector dos índices das variáveis que assumem valores negativos
%   l = vector dos limites inferiores das gamas de valores
%   nro = nro de variáveis que podem assumir valores negativos
%
% -------------------------------------------------------------------------

function [n,m,c,A,b,r,l,nro]=Le_dados()

    fprintf('\n DADOS DO PROBLEMA\n')
    
    n=input('\n Nº de variáveis:\n [> ');  % Pede nro de variáveis
    
    while n<=0 % Validação de parâmetros
        n=input('\n Nº de variáveis:\n [> ');  % Pede nro de variáveis
    end
    
    m=input('\n Nº de restrições:\n [> '); % Pede nro de restrições
    
    while m<=0 % Validação de parâmetros
        m=input('\n Nº de restrições:\n [> ');  % Pede nro de variáveis
    end
    
    flg=0;
    
    while(~flg)
        c=input('\n Vector com os coeficientes das variáveis na Função Objectivo:\n [> ');
        if length(c)==n && isnumeric(c); % Validação de parâmetros
            flg=1;
        else
            disp('\n Dimensão do vector incorrecta!\n')
        end
    end
    
    while(flg)
        A=input('\n Matriz com os coeficientes das variáveis nas restrições:\n [> ');
        [lin,col]=size(A);
        if lin~=m || col~=n % Validação de parâmetros
            disp(' Dimensões da matriz incorrectas!')
        else
            flg=0;
        end
    end

    while(~flg)
        b=input('\n Vector com os termos independentes das restrições: \n [> ');
        if length(b)==m
            flg=1;
        else
            disp(' Dimensão do vector incorrecta!')
        end
    end
    
    b=b'; % Transpõe vector linha para coluna
    
    nro=input('\n Nº de variáveis que podem assumir valores negativos:\n [> ');
    
    r=zeros(1,nro);
    l=zeros(1,nro);
    
    for i=1:nro
        if nro==1
            r(1)=input('\n Índice da variável que pode assumir valores negativos:\n [> ');
            
            while r(1)<=0 % Validação de parâmetros
                r(1)=input('\n Índice da variável que pode assumir valores negativos:\n [> ');
            end
            
            fprintf('\n Limite inferior da gama de valores de x%d:\n [> ',r(1));
            l(1)=input('');
    
            while l(1)>=0 % Validação de parâmetros
                fprintf('\n Limite inferior da gama de valores de x%d:\n [> ',r(1));
                l(1)=input('');
            end
        else
            fprintf('\n Índice da %da variável que pode assumir valores negativos:\n [> ',i);
            r(i)=input('');
            
            while r(i)<=0 % Validação de parâmetros
                fprintf('\n Índice da %da variável que pode assumir valores negativos:\n [> ',i);
                r(i)=input('');
            end
            
            fprintf('\n Limite inferior da gama de valores da variável x%d:\n [> ',r(i));
            l(i)=input('');
    
            while l(i)>=0 % Validação de parâmetros
                fprintf('\n Limite inferior da gama de valores da variável x%d:\n [> ',r(i));
                l(i)=input('');
            end
        end
    end
end