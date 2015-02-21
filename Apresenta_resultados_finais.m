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
%   Z = valor óptimo da Função Objectivo (Z*)
%   SBA = vector que contém os valores das variáveis na solução óptima (x*)
%   r = vector dos índices das variáveis que assumem valores negativos
%   l = vector dos limites inferiores das gamas de valores
%   nro = nro de variáveis que podem assumir valores negativos
%
% -------------------------------------------------------------------------

function Apresenta_resultados_finais(n,m,SBA,Z,r,l,nro)

    fprintf('\n Quadro óptimo!')
    fprintf(' Não existem valores negativos na linha Zj-cj.\n\n')
    
    fprintf('-----------------');
    fprintf('\n Solução óptima:\n')
    fprintf('-----------------');
    fprintf('\n\n');
    
    for j=1:n+m % Valores da SO que estão armazenados em SBA
        if j<=nro&&j==r(j)
            fprintf('\t x´%d* = %.2f\n',j,SBA(j));
        else
            fprintf('\t x%d* = %.2f\n',j,SBA(j))
        end
    end
    
    fprintf('\n');
    
    if nro~=0
        fprintf('-------------------------------------------');
        fprintf('\n Valores repostos das variáveis originais:\n');
        fprintf('-------------------------------------------');
        fprintf('\n');
    end
    
    for i=1:nro % Mostra os valores repostos
        fprintf('\n\t x´%d* = %.2f\n',r(i),SBA(r(i))+l(i));
    end
    
    fprintf('\n');
    fprintf('--------------------');
    fprintf('\n Valor óptimo de Z:\n');
    fprintf('--------------------');
    fprintf('\n\n\t Z* = %.2f\n\n',Z); % Valor de Z*
    
    fprintf('------------------');
    fprintf('\n FIM DO PROGRAMA\n');
    fprintf('------------------');
    fprintf('\n\n');
end
