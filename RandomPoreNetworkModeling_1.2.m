clear all
clc
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                 %
%                                                 %
%  Software de conectividad para una muestra      %
%          de roca porosa                         %
%         Version de prueba alpha 0.9.5           %
%                                                 %     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% comando para registral el tiempo de simulacion
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% cargamos datos %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

grid=input("Indique el Grid de la nube de nodos (valores enteros desde 1 a 30):   ")

disp("Simulando nube de nodos")
Vnodo=SimulationNodes(grid);

N=7668; %no de conexiones de la muestra de prueba
M=length(Vnodo) % numero de poros, se asume que todos estan conectados

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NV=length(Vnodo);
%%%%%%%%%% Parametros de la muestra real %%%%%%%%%%%%%%
lamda=3.55-1; % lambda es 3.55 pero se resta 1 por el sesgo de no admitir valores de conexi�n iguales a cero.
mdis=-9.26044; %datos de probabilidad de la muestra original que se distribuye como lognormal
stdis=0.52523;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dim=M; count=1; count2=1;
NOconex=poissrnd(lamda,M,1);
MatrixConex=zeros(M,M);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Estos son contadores de ciclos %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rr1=1; rr2=1;
disp("Simulando conexiones")

for ii=1:M
  Nc=NOconex(ii);   
%%%%%% esto garantiza que todo los nodos esten conectados, 
%%%%%% si se encuentra un cero, se pone por default 1, por eso en lambda coloca -1  
if  Nc==0
  Nc=1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  for kk=1:Nc
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%% primer filtro
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

 if sum(MatrixConex(ii,:))<Nc

    Drul=(lognrnd(mdis,stdis));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%%%%%%%%%%%%%%%%%%%%%% Guardando los datos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
   [jj,dis]=mysearchforjjC(ii,Drul,Vnodo);
   
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Calcula el numero de nodos conectados sobre el indice ii y el transpuesto 
 
 NN1=sum(MatrixConex(ii,:));  NN2=sum(MatrixConex(:,ii));

% el primer if es para revisar que se cumpla todo los criterios se�alados

      if or(ii~=jj && MatrixConex(ii,jj)==1,NN1>=Nc && NN2>=Nc) 

         continue 
         %% Para que un nodo ii se conecte con un nodo jj debe ocurrir cualquiera de la siguiente condicion
         %%% que jj y ii sean diferentes
      elseif or(jj==ii,dis==0) 
             
             %%% este ciclo garantiza que encuentre nodos para conectar que no sea el mismo (jj e ii) y que jj no sea 0
                while or(jj ==0,  jj==ii)
                %% la ruleta gira y se busca otro nodo que cumpla la distancia
                %% que indica la ruleta. Esto ocurre en caso de que se cumpla el if 
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                Drul=(lognrnd(mdis,stdis));
                [jj,dis]=mysearchforjjC(ii,Drul,Vnodo); 
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
               
               
               %%% repeticion del codigo 
                 NN1=sum(MatrixConex(ii,:));
                 NN2=sum(MatrixConex(:,ii));
              %% se repite la condicion 
                  if  or(ii~=jj && MatrixConex(ii,jj)==1,NN1>=Nc && NN2>=Nc) 
                  
                   continue
               %%% para que el nodo sea aceptado debe ser un nodo que nosea el mismo ii y jj, que no sea 0 y que exista que no exceda el umbral determinado que es la condicion de valor 1 establecido 
                 elseif jj~=ii && MatrixConex(ii,jj)==0 && NN1<Nc && NN2<Nc
                   MatrixConex(ii,jj)=1;
                   MatrixConex(jj,ii)=1; 
                  
                 end 
                end  
                             %%% para que el nodo sea aceptado debe ser un nodo que no sea el mismo ii y jj, que no sea 0 y que exista que no exceda el umbral determinado que es la condicion de valor 1 establecido 
    
    elseif jj~=ii && MatrixConex(ii,jj)==0  && NN1<Nc && NN2<Nc
    % se debe conectar de igual manera el reciproco 
      MatrixConex(ii,jj)=1;
      MatrixConex(jj,ii)=1;
    end

  %% guardo el valor de distancia de  Drul y la distancia del nodo para observar que no haya distancias 0's
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
       DISS(rr2)=dis;
       DRUL(rr2)=Drul;   
           rr2++;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  end   
  rr1++;
 end
end

disp('tiempo de la simulacion')
processtimess=toc/60

ns=find(sum(MatrixConex)==0);
disp('No de ceros')
nl=length(ns)

if ns>=1
disp('hay ceros')
ns
else 
disp('No hay ceros')
end 

%%%% Comando para plotear los datos
%%%% correr subrutina_GraficadoAnalisis
