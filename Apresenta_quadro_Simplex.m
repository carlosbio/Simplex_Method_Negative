% -------------------------------------------------------------------------
%
%        Fun��o que constr�i e apresenta um quadro Simplex no ecr� 
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
%   c = vector dos coeficientes das vari�veis na FO
%   xB = vector com os indices das v�riaveis b�sicas
%   cB = vector com os coeficientes das vari�veis b�sicas na FO 
%   A = matriz dos coeficientes t�cnicos
%   b = vector dos termos independentes das restri��es
%   Zjcj = vector que cont�m os valores da linha Zj-cj
%   Z = valor da FO
%   iteracao = n� da itera��o
%   flag = indica se quadro � �ptimo (0) ou n�o (1)
%   VN = vari�vel que vai entrar para a base
%   VNB = vari�vel que vai sair da base 
%   r = vector dos �ndices das vari�veis que assumem valores negativos
%   d = valor constante no topo da coluna b
%   nro = nro de vari�veis que podem assumir valores negativos
%
% -------------------------------------------------------------------------

function Apresenta_quadro_Simplex(n,m,c,xB,cB,A,b,Zjcj,Z,iteracao,flag,VB,VNB,r,d,nro)
    
    fprintf(' %d� Itera�ao:\n\n',iteracao);
    
    for i=1:16
        fprintf(' '); % Espa�os antes do 1ro coeficiente
    end
    
    for j=1:n+m % Coeficientes das vari�veis na FO
        fprintf(' %-10.1f',c(j))
    end
    
    fprintf(' %-10.1f\n',d) % Mostra o valor constante no topo da coluna b
    
    for i=1:16 % Espa�os antes da 1ra vari�vel
        fprintf(' ');
    end
    
    for j=1:n+m % Vari�veis
        flagaux=0;
        
        for i=1:nro
            
           if j==r(i) % Caso seja igual ao �ndice da vari�vel transformada
               flagaux=1;
           end
        end
        
        if flagaux==1 % Apresenta a formata��o de acordo com o valor da flag
            fprintf(' x�%-9.0f',j);
        else
            fprintf(' x%-9.0f',j);
        end
        
    end
    
    fprintf(' b\n')
    
    for i=1:18
        fprintf('-'); % Tra�os do topo da tabela
    end
    
    for j=1:(n+m+1)*10
        fprintf('-') % Tra�os da tabela acordo com o nro de vari�veis
    end
    
    fprintf('\n')
    
    for i=1:m
        flagaux=0;
        
        for k=1:nro
 
            if xB(i)==r(k) % Caso seja igual ao �ndice da vari�vel transformada
                flagaux=1;
            end
        end
        
        if flagaux==1 % Apresenta a formata��o de acordo com o valor da flag
            fprintf('x�%-3.0f%-11.1f',xB(i),cB(i));
        else
            fprintf(' x%-3.0f%-11.1f',xB(i),cB(i));
        end
       
        for j=1:n+m
            fprintf(' %-10.1f',A(i,j)) % Valores da tabela
        end
        
        fprintf(' %-10.1f\n',b(i)) % Valores da coluna b
    end
    
    for i=1:18 % Tra�os da base da tabela
        fprintf('-');
    end
    
    for j=1:(n+m+1)*10
        fprintf('-')  % Tra�os da tabela acordo com o nro de vari�veis
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
                flagVB=1; % Caso seja uma vari�vel que assuma valores negativos e seja VB
            end
            
            if r(i)==VNB
                flagVNB=1;% Caso seja uma vari�vel que assuma valores negativos e seja VNB
            end
        end
        
        if flagVB==1 % Aplica a devida formata��o de acordo com o valor da flag
            fprintf(' Vari�vel que vai tornar-se VB -> x�%d\n',VB)
        else
            fprintf(' Vari�vel que vai tornar-se VB -> x%d\n',VB)
        end
        
        if flagVNB==1 % Aplica a devida formata��o de acordo com o valor da flag
           fprintf(' Vari�vel que vai tornar-se VNB -> x�%d\n\n',VNB)
        else
           fprintf(' Vari�vel que vai tornar-se VNB -> x%d\n\n',VNB)
        end 
    end
end
