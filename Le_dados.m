% -------------------------------------------------------------------------
%
%                   Fun��o que obt�m os dados do problema
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
%   n = nro de vari�veis
%   m = nro de restri��es
%   c = vector dos coeficientes das vari�veis na FO (1xn)
%   A = matriz dos coeficientes das vari�veis nas restri��es (mxn)
%   b = vector dos termos independentes das restri��es (mx1)
%   r = vector dos �ndices das vari�veis que assumem valores negativos
%   l = vector dos limites inferiores das gamas de valores
%   nro = nro de vari�veis que podem assumir valores negativos
%
% -------------------------------------------------------------------------

function [n,m,c,A,b,r,l,nro]=Le_dados()

    fprintf('\n DADOS DO PROBLEMA\n')
    
    n=input('\n N� de vari�veis:\n [> ');  % Pede nro de vari�veis
    
    while n<=0 % Valida��o de par�metros
        n=input('\n N� de vari�veis:\n [> ');  % Pede nro de vari�veis
    end
    
    m=input('\n N� de restri��es:\n [> '); % Pede nro de restri��es
    
    while m<=0 % Valida��o de par�metros
        m=input('\n N� de restri��es:\n [> ');  % Pede nro de vari�veis
    end
    
    flg=0;
    
    while(~flg)
        c=input('\n Vector com os coeficientes das vari�veis na Fun��o Objectivo:\n [> ');
        if length(c)==n && isnumeric(c); % Valida��o de par�metros
            flg=1;
        else
            disp('\n Dimens�o do vector incorrecta!\n')
        end
    end
    
    while(flg)
        A=input('\n Matriz com os coeficientes das vari�veis nas restri��es:\n [> ');
        [lin,col]=size(A);
        if lin~=m || col~=n % Valida��o de par�metros
            disp(' Dimens�es da matriz incorrectas!')
        else
            flg=0;
        end
    end

    while(~flg)
        b=input('\n Vector com os termos independentes das restri��es: \n [> ');
        if length(b)==m
            flg=1;
        else
            disp(' Dimens�o do vector incorrecta!')
        end
    end
    
    b=b'; % Transp�e vector linha para coluna
    
    nro=input('\n N� de vari�veis que podem assumir valores negativos:\n [> ');
    
    r=zeros(1,nro);
    l=zeros(1,nro);
    
    for i=1:nro
        if nro==1
            r(1)=input('\n �ndice da vari�vel que pode assumir valores negativos:\n [> ');
            
            while r(1)<=0 % Valida��o de par�metros
                r(1)=input('\n �ndice da vari�vel que pode assumir valores negativos:\n [> ');
            end
            
            fprintf('\n Limite inferior da gama de valores de x%d:\n [> ',r(1));
            l(1)=input('');
    
            while l(1)>=0 % Valida��o de par�metros
                fprintf('\n Limite inferior da gama de valores de x%d:\n [> ',r(1));
                l(1)=input('');
            end
        else
            fprintf('\n �ndice da %da vari�vel que pode assumir valores negativos:\n [> ',i);
            r(i)=input('');
            
            while r(i)<=0 % Valida��o de par�metros
                fprintf('\n �ndice da %da vari�vel que pode assumir valores negativos:\n [> ',i);
                r(i)=input('');
            end
            
            fprintf('\n Limite inferior da gama de valores da vari�vel x%d:\n [> ',r(i));
            l(i)=input('');
    
            while l(i)>=0 % Valida��o de par�metros
                fprintf('\n Limite inferior da gama de valores da vari�vel x%d:\n [> ',r(i));
                l(i)=input('');
            end
        end
    end
end