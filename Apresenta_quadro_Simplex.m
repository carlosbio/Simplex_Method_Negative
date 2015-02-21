% -------------------------------------------------------------------------
%
%        Função que constrói e apresenta um quadro Simplex no ecrã 
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
%   c = vector dos coeficientes das variáveis na FO
%   xB = vector com os indices das váriaveis básicas
%   cB = vector com os coeficientes das variáveis básicas na FO 
%   A = matriz dos coeficientes técnicos
%   b = vector dos termos independentes das restrições
%   Zjcj = vector que contém os valores da linha Zj-cj
%   Z = valor da FO
%   iteracao = nº da iteração
%   flag = indica se quadro é óptimo (0) ou não (1)
%   VN = variável que vai entrar para a base
%   VNB = variável que vai sair da base 
%   r = vector dos índices das variáveis que assumem valores negativos
%   d = valor constante no topo da coluna b
%   nro = nro de variáveis que podem assumir valores negativos
%
% -------------------------------------------------------------------------

function Apresenta_quadro_Simplex(n,m,c,xB,cB,A,b,Zjcj,Z,iteracao,flag,VB,VNB,r,d,nro)
    
    fprintf(' %dª Iteraçao:\n\n',iteracao);
    
    for i=1:16
        fprintf(' '); % Espaços antes do 1ro coeficiente
    end
    
    for j=1:n+m % Coeficientes das variáveis na FO
        fprintf(' %-10.1f',c(j))
    end
    
    fprintf(' %-10.1f\n',d) % Mostra o valor constante no topo da coluna b
    
    for i=1:16 % Espaços antes da 1ra variável
        fprintf(' ');
    end
    
    for j=1:n+m % Variáveis
        flagaux=0;
        
        for i=1:nro
            
           if j==r(i) % Caso seja igual ao índice da variável transformada
               flagaux=1;
           end
        end
        
        if flagaux==1 % Apresenta a formatação de acordo com o valor da flag
            fprintf(' x´%-9.0f',j);
        else
            fprintf(' x%-9.0f',j);
        end
        
    end
    
    fprintf(' b\n')
    
    for i=1:18
        fprintf('-'); % Traços do topo da tabela
    end
    
    for j=1:(n+m+1)*10
        fprintf('-') % Traços da tabela acordo com o nro de variáveis
    end
    
    fprintf('\n')
    
    for i=1:m
        flagaux=0;
        
        for k=1:nro
 
            if xB(i)==r(k) % Caso seja igual ao índice da variável transformada
                flagaux=1;
            end
        end
        
        if flagaux==1 % Apresenta a formatação de acordo com o valor da flag
            fprintf('x´%-3.0f%-11.1f',xB(i),cB(i));
        else
            fprintf(' x%-3.0f%-11.1f',xB(i),cB(i));
        end
       
        for j=1:n+m
            fprintf(' %-10.1f',A(i,j)) % Valores da tabela
        end
        
        fprintf(' %-10.1f\n',b(i)) % Valores da coluna b
    end
    
    for i=1:18 % Traços da base da tabela
        fprintf('-');
    end
    
    for j=1:(n+m+1)*10
        fprintf('-')  % Traços da tabela acordo com o nro de variáveis
    end
    
    fprintf('\n')
    fprintf(' Zj-cj')
    
    for i=1:10
        fprintf(' ');
    end
    
    for j=1:n+m
        fprintf(' %-10.1f',Zjcj(j)) % Valores da linha Zj-cj
    end
    
    fprintf(' %-10.1f\n\n',Z) % Valor de Z
    
    flagVB=0;  % Flag auxiliar para os VBs
    flagVNB=0; % Flag auxiliar para os VNBs
    
    if flag
        for i=1:nro
            if r(i)==VB
                flagVB=1; % Caso seja uma variável que assuma valores negativos e seja VB
            end
            
            if r(i)==VNB
                flagVNB=1;% Caso seja uma variável que assuma valores negativos e seja VNB
            end
        end
        
        if flagVB==1 % Aplica a devida formatação de acordo com o valor da flag
            fprintf(' Variável que vai tornar-se VB -> x´%d\n',VB)
        else
            fprintf(' Variável que vai tornar-se VB -> x%d\n',VB)
        end
        
        if flagVNB==1 % Aplica a devida formatação de acordo com o valor da flag
           fprintf(' Variável que vai tornar-se VNB -> x´%d\n\n',VNB)
        else
           fprintf(' Variável que vai tornar-se VNB -> x%d\n\n',VNB)
        end 
    end
end
