function MatrixSimul=SimulationNodes(grid)

load DatosdeNodos.csv;
nodox=DatosdeNodos(:,2);
nodoy=DatosdeNodos(:,3);
nodoz=DatosdeNodos(:,4);
index=DatosdeNodos(:,1)+1; %para que no comienze en cero

NoNod=length(index);
Dxmax=max(nodox);
Dxmin=min(nodox);
Dymax=max(nodoy);
Dymin=min(nodoy);
Dzmax=max(nodoz);
Dzmin=min(nodoz);


% crea una matriz de ceros donde se guardara¡ las coordenadas
noceldas=(grid-1)**3;
NNxyz=zeros(NoNod,3,noceldas);
%%% Para investigar los restantes
NNaa=zeros(NoNod,noceldas);


% linspace es una funcion de matlab para generar un vector desde dmin hasta dmax grid veces.
distx=linspace(Dxmin,Dxmax,grid);
disty=linspace(Dymin,Dymax,grid);
distz=linspace(Dzmin,Dzmax,grid);
%Volumen=(distz(2)-distz(1))**3;

ux=1:3;
count=1;
count3=1;

gridmax=grid-1;
for kk=1:gridmax
 for jj=1:gridmax
  for ii=1:gridmax 
    % FOR X, Y AND Z  (se colocaron los if del menos probable hasta el mas probable)
  if(ii==gridmax) &&  (jj==gridmax) &&  (kk==gridmax)
    aa=distz(kk)<=nodoz & disty(jj)<=nodoy & distx(ii)<=nodox ;

    elseif (jj==gridmax) && (kk==gridmax)
 aa=distz(kk)<=nodoz  & disty(jj)<=nodoy  & distx(ii)<=nodox & nodox<distx(ii+1);
 %% FOR X AND Z
  elseif(ii==gridmax) &&  (kk==gridmax)
 aa=distz(kk)<=nodoz & disty(jj)<=nodoy & nodoy<disty(jj+1) & distx(ii)<=nodox;
 %% FOR X AND Y
  elseif (ii==gridmax) &&  (jj==gridmax)
   aa=distz(kk)<=nodoz & nodoz<distz(kk+1) & disty(jj)<=nodoy  & distx(ii)<=nodox ;
% % FOR Z
  elseif  kk==gridmax
 aa=distz(kk)<=nodoz  & disty(jj)<=nodoy & nodoy<disty(jj+1) & distx(ii)<=nodox & nodox<distx(ii+1);
 %% FOR Y
 elseif jj==gridmax
   aa=distz(kk)<=nodoz & nodoz<distz(kk+1) & disty(jj)<=nodoy  & distx(ii)<=nodox & nodox<distx(ii+1);
  %FOR X
 elseif ii==gridmax
 aa=distz(kk)<=nodoz & nodoz<distz(kk+1) & disty(jj)<=nodoy & nodoy<disty(jj+1) & distx(ii)<=nodox;
 else
 %encuentra los poros analizando las fronteras de los vertices.
 aa=distz(kk)<=nodoz & nodoz<distz(kk+1) & disty(jj)<=nodoy & nodoy<disty(jj+1) & distx(ii)<=nodox & nodox<distx(ii+1);
 % Encuentra el numero total de poros en el th-celda "count"
% Guarda la posicion de cada poro
  end 
  % suma los poros por coordenadas
  NoPoros(count)=sum(aa);
  
  NNaa(:,count)=aa;
  %% guardo el origen del vertice por celda (count)
  Vertices(count,:)=[distx(ii) disty(jj) distz(kk)];
  lamda(count)=NoPoros(count)/noceldas;
  bb=NoPoros(count);
  % Con este if desprecio los datos donde las celdas sean 0, de esa manera evito guardar 0 porque esto recae en la memoria 
   if bb>0
   % El vector v guarda hasta bb poros 
       v=1:bb;
       % La matriz ModelPoro genera bb poros aleatorios escrito en coordenadas x y z
      ModelPoro(v,ux(1)) = (distx(ii+1)-distx(ii))*rand(bb,1)+distx(ii);
      ModelPoro(v,ux(2)) = (disty(jj+1)-disty(jj))*rand(bb,1)+disty(jj);
      ModelPoro(v,ux(3)) = (distz(kk+1)-distz(kk))*rand(bb,1)+distz(kk);
     ux=ux+3;
     else 
     count3++;
     end
  count++;
  end
 end
end
%encuentra cuando lambda es 0
cc=find(lamda==0);
AError=sum(sum(sum(NoPoros)))-length(index) 
  
  
  ux=1:3;
BB=0;
MatrixSimul=zeros(length(index),3);
 for ii=1:noceldas
   bb=round(lamda(ii)*noceldas);
   aa=find(NNaa(:,ii)==1);
  if bb>0
  hmin=BB+1;
  hmax=bb+BB;
  % Vectores con maximo tamaño de bb son extraidos del modelo y guardados en MatrixSimul
  % observe que la dimension de v1 y v son iguales. Sin embargo, uno correo de 1 a bb y el otro 
  % va en aumento.
  v1=(1:bb)';
  v=(hmin:hmax)';
  MatrixSimul(v,:)=ModelPoro(v1,ux);
   ux=ux+3;
   BB=max(v);
  else
  nada=0;
  endif
end

newMatrixSimul=MatrixSimul;

end

  
