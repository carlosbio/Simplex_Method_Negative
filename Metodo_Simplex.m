% -------------------------------------------------------------------------
%
%                  Implementaçao do Método Simplex
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
%   Variáveis principais:
%
%   n = nº de variáveis originais
%   m = nº de restrições funcionais
%   A = matriz dos coeficientes técnicos
%   b = vector dos termos independentes das restrições
%   c = vector dos coeficientes das variáveis na FO
%   x = vector com os índices de todas as variáveis
%   xB = vector com os índices das variáveis básicas
%   cB = vector com os coeficientes das variáveis básicas na FO 
%   Zjcj = vector com os valores da linha Zj-cj
%   Z = valor da FO
%   SBA = vector com os valores da SBA em cada iteração
%   r = vector dos índices das variáveis que assumem valores negativos
%   l = vector dos limites inferiores das gamas de valores
%   nro = nro de variáveis que podem assumir valores negativos
%
% -------------------------------------------------------------------------

clc % Limpa janela de comandos

disp('------------------------------------------------------------')
disp('        Resolução de um problema pelo Método Simplex        ')
disp('------------------------------------------------------------')
fprintf('\n');
disp(' Observações:                                               ')
fprintf('\n');
disp(' - A Função Objectivo está na forma de maximização          ')
disp(' - Todas as restrições são de "<="                          ')
disp(' - As variáveis de decisão podem tomar valores negativos    ')
fprintf('\n');
disp('------------------------------------------------------------')

[n,m,c,A,b,r,l,nro]=Le_dados; % Le dados do problema

clc % Limpa a janela de comandos

Baux=zeros(m,nro);  % vector auxiliar inicializado a zeros
B=zeros(m,1);       % vector B inicializado a zeros

for i=1:nro
    Baux(:,i)=A(:,r(i));   % Guarda em B os valores dos coeficientes das variáveis que podem assumir valores negativos
    Baux(:,i)=l(i)*Baux(:,i); % Multiplica os valores dos coeficientes das variáveis que podem assumir valores negativos pelo limite inferior da gama de valores
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
    aux=c(r(i));    % Guarda em aux o valor do coeficiente, na FO, da variável que pode assumir valores negativos
    aux=aux*l(i);   % Multiplica o valor do coeficiente, na FO, da variável que pode assumir valores negativos pelo limite inferior da gama de valores
    d=d+(aux*(-1)); % Multiplica o valor por -1 (fica com sinal contrário quando colocado no topo da coluna b) e soma ao valor de d
end

xo=1:n;         % Indices das variaveis originais
xs=n+1:n+m;     % Indices das variaveis slack
x=[xo xs];      % Indices de todas as variaveis

xB=xs';         % xB e um vector coluna com os indices das VBs
cB=cs';         % cB e um vector coluna com os coeficientes das VBs na FO

colb=b;         % Guarda numa variável auxiliar os valores originais da coluna b

b=b-B;          % Calcula os novos valores da coluna b

SBA=[zeros(n,1);b];     % Inicialização da 1ª SBA (vector coluna)

Zjcj=zeros(1,n+m);      % Inicialização do vector Zjcj a zeros

termina=0;              % Controla a execução do ciclo
iteracao=1;             % Contabiliza o nº de iterações

Apresenta_info(n,m,r,l,nro,c,A,colb,d,b); % Apresenta informação ao utilizador depois de serem pedidos os dados do problema

while ~termina
    
    for j=1:n+m
        Zjcj(j)=cB'*A(:,j)-c(j); % Calcula linha Zj-cj
    end
    
    Z=(cB'*b)-d; % Calcula o valor de Z e subtrai d (valor constante da coluna b)
    
    [valor_min,coluna_pivot]=min(Zjcj); % Testa se a solução é óptima
    
    if valor_min>=0 % Caso a solução seja óptima, mostra os resultados
        termina=1;
        Apresenta_quadro_Simplex(n,m,c,xB,cB,A,b,Zjcj,Z,iteracao,0,0,0,r,d,nro);
        Apresenta_resultados_finais(n,m,SBA,Z,r,l,nro);
        
    else % No caso da solução não ser óptima
        q=realmax*ones(m,1); % Inicializa o vector com valores + infinito
        
        for i=1:m
            if A(i,coluna_pivot)>0 % Admite apenas quocientes sobre valores maiores que 0
                q(i)=b(i)/A(i,coluna_pivot);
            end
        end
        
        [valor_min,linha_pivot]=min(q); % Determina a linha pivot
            
        % Variável que vai entrar na base: x(coluna_pivot)
        % Variável que vai sair da base: xB(linha_pivot)
        
        Apresenta_quadro_Simplex(n,m,c,xB,cB,A,b,Zjcj,Z,iteracao,1,x(coluna_pivot),xB(linha_pivot),r,d,nro);
        
        fprintf('--------------------------------------------------------');
        fprintf('\n Premir uma tecla para avançar para a próxima iteração\n');
        fprintf('--------------------------------------------------------');
        fprintf('\n\n');
        pause % Espera que o utilizador carregue numa tecla
        
        xB(linha_pivot)=x(coluna_pivot); % Actualiza base
        cB(linha_pivot)=c(coluna_pivot);
        
        K=1/A(linha_pivot,coluna_pivot); % Reduz elemento pivot à unidade
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
            linha=find(xB==j); % Verifica se algum dos elementos de xB é igual a j e devolve a linha onde se encontra, senão devolve uma matriz vazia
            
            if ~isempty(linha) % Se não for vazia
                SBA(j)=b(linha); % Vai buscar valor de xj à coluna b
            else
                SBA(j)=0; % Se não fizer parte da base, xj é zero
            end
        end
    end
    iteracao=iteracao+1;
end

