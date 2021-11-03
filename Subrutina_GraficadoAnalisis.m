MCNX=sum(MatrixConex);

disp("Promedio de conexiones generadas")
%disp(suma/M)
meancx=mean(MCNX)
disp("No de 0s")
sum(MCNX==0)

[Px dx]=hist(DISS);
sumx=sum(Px);
Dx=dx;

[Pz dz]=hist(DRUL);
sumz=sum(Pz);
Dz=dz;

%subplot(2,1,1)
bar(Dx,Px/sumx)
xlabel("distancia media")
ylabel("Histograma de la simulacion %")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Nueva Matriz de Conexiones  %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


vv=find(diag(MatrixConex)==1);
if length(vv)>0
 for ii=1:length(vv);  MatrixConex(vv(ii),vv(ii))=0; end
end

cont=0;
ll=max(sum(MatrixConex));
for ii=1:4311

  aa=find(MatrixConex(ii,:)==1);
  La=length(aa);
  
  for kk=1:La  
    NodeConect(cont+1,1:2)=[ii aa(kk)];
    VconexDATA(cont+1,1:6)=[Vnodo(ii,:) Vnodo(aa(kk),:)];
  cont++;
  end 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Nueva Matriz de Conexiones  II    %%%%%%%%%%%%% %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


MatConexL=tril(MatrixConex);

cont=0;
ll=max(sum(MatConexL));
for ii=1:4311
  aa=find(MatConexL(ii,:)==1);
  La=length(aa);
  
  for kk=1:La  
    jj=aa(kk);
    
    NodeConectB(cont+1,1:3)=[ii jj  distancia(Vnodo(ii,:),Vnodo(jj,:))];
    VconexDATAB(cont+1,1:7)=[Vnodo(ii,:) Vnodo(aa(kk),:) distancia(Vnodo(ii,:),Vnodo(jj,:))];
  cont++;
  end 
end 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Graficado y save datas   %%%%%%%%%%%%% %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Lmd=num2str(meancx);
GRID=num2str(grid);


mysname=strcat("SimulConnect","Lambda")
mystrname=strcat(mysname,Lmd)

mkdir(mystrname)
cd(mystrname) 


extname=strcat(mystrname,".csv")

newname0=strcat("NubeG",GRID)
%newname1=strcat(newname0,".csv")
name1=strcat(newname0,extname)
save(name1,"Vnodo")

name2=strcat("ZerosOnesMatrix",extname)
save(name2,"MatrixConex")

name3=strcat("NoNodos",extname)
save(name3,"NodeConect")

name3=strcat("NoNodosSinRepeticion",extname)
save(name3,"NodeConectB")

name4=strcat("VectorNodos",extname)
save(name4,"VconexDATA")

name4=strcat("VectorNodosSinRepeticion",extname)
save(name4,"VconexDATAB")

name5=strcat("DISS",extname)
save(name5,"DISS")

name6=strcat("DRUL",extname)
save(name6,"DRUL")

 sname="Simulation Conect ,";
 stitle=strcat(sname,Lmd)

figure
bar(Dx,Px/sumx)
xlabel("Distance")
ylabel("Histogramm Wtq%") 
title(stitle)

namepng=strcat(mystrname,".png")
print ("png", namepng) 
