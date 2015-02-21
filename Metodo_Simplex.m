% -------------------------------------------------------------------------
%
%                  Implementa�ao do M�todo Simplex
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
%   Vari�veis principais:
%
%   n = n� de vari�veis originais
%   m = n� de restri��es funcionais
%   A = matriz dos coeficientes t�cnicos
%   b = vector dos termos independentes das restri��es
%   c = vector dos coeficientes das vari�veis na FO
%   x = vector com os �ndices de todas as vari�veis
%   xB = vector com os �ndices das vari�veis b�sicas
%   cB = vector com os coeficientes das vari�veis b�sicas na FO 
%   Zjcj = vector com os valores da linha Zj-cj
%   Z = valor da FO
%   SBA = vector com os valores da SBA em cada itera��o
%   r = vector dos �ndices das vari�veis que assumem valores negativos
%   l = vector dos limites inferiores das gamas de valores
%   nro = nro de vari�veis que podem assumir valores negativos
%
% -------------------------------------------------------------------------

clc % Limpa janela de comandos

disp('------------------------------------------------------------')
disp('        Resolu��o de um problema pelo M�todo Simplex        ')
disp('------------------------------------------------------------')
fprintf('\n');
disp(' Observa��es:                                               ')
fprintf('\n');
disp(' - A Fun��o Objectivo est� na forma de maximiza��o          ')
disp(' - Todas as restri��es s�o de "<="                          ')
disp(' - As vari�veis de decis�o podem tomar valores negativos    ')
fprintf('\n');
disp('------------------------------------------------------------')

[n,m,c,A,b,r,l,nro]=Le_dados; % Le dados do problema

clc % Limpa a janela de comandos

Baux=zeros(m,nro);  % vector auxiliar inicializado a zeros
B=zeros(m,1);       % vector B inicializado a zeros

for i=1:nro
    Baux(:,i)=A(:,r(i));   % Guarda em B os valores dos coeficientes das vari�veis que podem assumir valores negativos
    Baux(:,i)=l(i)*Baux(:,i); % Multiplica os valores dos coeficientes das vari�veis que podem assumir valores negativos pelo limite inferior da gama de valores
end

for i=1:m % Ciclo que soma em B os valores dos coeficientes transformados em cada linha da matriz Baux
    for j=1:nro
        B(i,:)=B(i,:)+Baux(i,j);
    end
end

I=eye(m);       % Matriz identidade (mxm)
A=[A I];        % Matriz A do problema na forma aumentada
cs=zeros(1,m);  % Coeficientes das variaveis slack na FO
c=[c cs];       % Coeficientes de todas as variaveis na FO

d=0;

for i=1:nro
    aux=c(r(i));    % Guarda em aux o valor do coeficiente, na FO, da vari�vel que pode assumir valores negativos
    aux=aux*l(i);   % Multiplica o valor do coeficiente, na FO, da vari�vel que pode assumir valores negativos pelo limite inferior da gama de valores
    d=d+(aux*(-1)); % Multiplica o valor por -1 (fica com sinal contr�rio quando colocado no topo da coluna b) e soma ao valor de d
end

xo=1:n;         % Indices das variaveis originais
xs=n+1:n+m;     % Indices das variaveis slack
x=[xo xs];      % Indices de todas as variaveis

xB=xs';         % xB e um vector coluna com os indices das VBs
cB=cs';         % cB e um vector coluna com os coeficientes das VBs na FO

colb=b;         % Guarda numa vari�vel auxiliar os valores originais da coluna b

b=b-B;          % Calcula os novos valores da coluna b

SBA=[zeros(n,1);b];     % Inicializa��o da 1� SBA (vector coluna)

Zjcj=zeros(1,n+m);      % Inicializa��o do vector Zjcj a zeros

termina=0;              % Controla a execu��o do ciclo
iteracao=1;             % Contabiliza o n� de itera��es

Apresenta_info(n,m,r,l,nro,c,A,colb,d,b); % Apresenta informa��o ao utilizador depois de serem pedidos os dados do problema

while ~termina
    
    for j=1:n+m
        Zjcj(j)=cB'*A(:,j)-c(j); % Calcula linha Zj-cj
    end
    
    Z=(cB'*b)-d; % Calcula o valor de Z e subtrai d (valor constante da coluna b)
    
    [valor_min,coluna_pivot]=min(Zjcj); % Testa se a solu��o � �ptima
    
    if valor_min>=0 % Caso a solu��o seja �ptima, mostra os resultados
        termina=1;
        Apresenta_quadro_Simplex(n,m,c,xB,cB,A,b,Zjcj,Z,iteracao,0,0,0,r,d,nro);
        Apresenta_resultados_finais(n,m,SBA,Z,r,l,nro);
        
    else % No caso da solu��o n�o ser �ptima
        q=realmax*ones(m,1); % Inicializa o vector com valores + infinito
        
        for i=1:m
            if A(i,coluna_pivot)>0 % Admite apenas quocientes sobre valores maiores que 0
                q(i)=b(i)/A(i,coluna_pivot);
            end
        end
        
        [valor_min,linha_pivot]=min(q); % Determina a linha pivot
            
        % Vari�vel que vai entrar na base: x(coluna_pivot)
        % Vari�vel que vai sair da base: xB(linha_pivot)
        
        Apresenta_quadro_Simplex(n,m,c,xB,cB,A,b,Zjcj,Z,iteracao,1,x(coluna_pivot),xB(linha_pivot),r,d,nro);
        
        fprintf('--------------------------------------------------------');
        fprintf('\n Premir uma tecla para avan�ar para a pr�xima itera��o\n');
        fprintf('--------------------------------------------------------');
        fprintf('\n\n');
        pause % Espera que o utilizador carregue numa tecla
        
        xB(linha_pivot)=x(coluna_pivot); % Actualiza base
        cB(linha_pivot)=c(coluna_pivot);
        
        K=1/A(linha_pivot,coluna_pivot); % Reduz elemento pivot � unidade
        A(linha_pivot,:)=K*A(linha_pivot,:);
        b(linha_pivot)=K*b(linha_pivot);
        
        for i=1:n % Elimina restantes elementos da coluna pivot
            if i~=linha_pivot % Exclui a linha pivot
                K=A(i,coluna_pivot);
                A(i,:)=A(i,:)-K*A(linha_pivot,:);
                b(i)=b(i)-K*b(linha_pivot);
            end
        end
        
        for j=1:n+m % Actualiza SBA
            linha=find(xB==j); % Verifica se algum dos elementos de xB � igual a j e devolve a linha onde se encontra, sen�o devolve uma matriz vazia
            
            if ~isempty(linha) % Se n�o for vazia
                SBA(j)=b(linha); % Vai buscar valor de xj � coluna b
            else
                SBA(j)=0; % Se n�o fizer parte da base, xj � zero
            end
        end
    end
    iteracao=iteracao+1;
end

