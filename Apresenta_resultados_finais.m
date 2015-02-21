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
%   Z = valor �ptimo da Fun��o Objectivo (Z*)
%   SBA = vector que cont�m os valores das vari�veis na solu��o �ptima (x*)
%   r = vector dos �ndices das vari�veis que assumem valores negativos
%   l = vector dos limites inferiores das gamas de valores
%   nro = nro de vari�veis que podem assumir valores negativos
%
% -------------------------------------------------------------------------

function Apresenta_resultados_finais(n,m,SBA,Z,r,l,nro)

    fprintf('\n Quadro �ptimo!')
    fprintf(' N�o existem valores negativos na linha Zj-cj.\n\n')
    
    fprintf('-----------------');
    fprintf('\n Solu��o �ptima:\n')
    fprintf('-----------------');
    fprintf('\n\n');
    
    for j=1:n+m % Valores da SO que est�o armazenados em SBA
        if j<=nro&&j==r(j)
            fprintf('\t x�%d* = %.2f\n',j,SBA(j));
        else
            fprintf('\t x%d* = %.2f\n',j,SBA(j))
        end
    end
    
    fprintf('\n');
    
    if nro~=0
        fprintf('-------------------------------------------');
        fprintf('\n Valores repostos das vari�veis originais:\n');
        fprintf('-------------------------------------------');
        fprintf('\n');
    end
    
    for i=1:nro % Mostra os valores repostos
        fprintf('\n\t x�%d* = %.2f\n',r(i),SBA(r(i))+l(i));
    end
    
    fprintf('\n');
    fprintf('--------------------');
    fprintf('\n Valor �ptimo de Z:\n');
    fprintf('--------------------');
    fprintf('\n\n\t Z* = %.2f\n\n',Z); % Valor de Z*
    
    fprintf('------------------');
    fprintf('\n FIM DO PROGRAMA\n');
    fprintf('------------------');
    fprintf('\n\n');
end
