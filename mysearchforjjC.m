function [JJ, DIS]=mysearchforjjC(ii,Drul,Vnodo)

%%% Vnodo es la matriz de la nube de datos que representa la muestra simulada
% datos modificados para la muestra original
dy= [4.7897e-05 1.1346e-04 1.7902e-04 2.4457e-04 3.1013e-04 3.7569e-04 4.4125e-04 5.0681e-04 5.7237e-04 6.3793e-04];

if Drul>dy(10) 
%%%%%%%%%%%% nuevo j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 jj=round(rand*4310)+1;
 veci=Vnodo(ii,:);
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
  
    while dis>=dy(10) 
    %%%%%%%%%%%% nuevo j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      jj=round(rand*4310)+1;
      vecj=Vnodo(jj,:);
      dis=distancia(veci,vecj);
   end 
 
 elseif Drul>dy(9) && Drul<=dy(10)

%%%%%%%%%%%% nuevo j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 jj=round(rand*4310)+1;
 veci=Vnodo(ii,:);
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
  
    while dis>=dy(9) && dis>dy(10) 
      jj=round(rand*4310)+1;
      vecj=Vnodo(jj,:);
      dis=distancia(veci,vecj);
    end  
  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 elseif Drul>dy(8) && Drul<=dy(9)  
%%%%%%%%%%%% nuevo j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 jj=round(rand*4310)+1;
 veci=Vnodo(ii,:);
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);

 while dis>=dy(8) && dis>dy(9) 
 jj=round(rand*4310)+1;
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
 end 
 
  elseif Drul>dy(7) && Drul<=dy(8)  
%%%%%%%%%%%% nuevo j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 jj=round(rand*4310)+1;
 veci=Vnodo(ii,:);
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);

 while dis>=dy(7) && dis>dy(8) 
 jj=round(rand*4310)+1;
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
 end 

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

elseif Drul>dy(6) && Drul<=dy(7)   
%%%%%%%%%%%% nuevo j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 jj=round(rand*4310)+1;
 veci=Vnodo(ii,:);
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
 
while dis>=dy(6) && dis>dy(7) && dis>0 && jj~=ii
 jj=round(rand*4310)+1;
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
end 

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

elseif Drul>dy(5) && Drul<=dy(6)   
%%%%%%%%%%%% nuevo j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 jj=round(rand*4310)+1;
 veci=Vnodo(ii,:);
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
 
while dis>=dy(5) && dis>dy(6) && dis>0 && jj~=ii
 jj=round(rand*4310)+1;
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
elseif Drul>dy(4) && Drul<=dy(5)  
%%%%%%%%%%%% nuevo j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 jj=round(rand*4310)+1;
 veci=Vnodo(ii,:); 
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
 
while dis>=dy(4) && dis>dy(5) && dis>0 && jj~=ii

 jj=round(rand*4310)+1;
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
end  
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
elseif Drul>dy(3) && Drul<=dy(4)  
%%%%%%%%%%%% nuevo j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 jj=round(rand*4310)+1;
 veci=Vnodo(ii,:); 
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
 
while dis>=dy(3) && dis>dy(4) && dis>0 && jj~=ii
 jj=round(rand*4310)+1;
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
end 
 
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
elseif Drul>dy(2) && Drul<=dy(3)  
%%%%%%%%%%%% nuevo j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 jj=round(rand*4310)+1;
 veci=Vnodo(ii,:); 
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
 
while dis>=dy(2) && dis>dy(3) && dis>0 && jj~=ii

 jj=round(rand*4310)+1;
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
end 
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 elseif  Drul>dy(1) && Drul<=dy(2)  

 jj=round(rand*4310)+1;
 veci=Vnodo(ii,:);
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
 
  while  dis>=dy(1) && dis>dy(2) && dis>0 && jj~=ii
    jj=round(rand*4310)+1;
    vecj=Vnodo(jj,:);
    dis=distancia(veci,vecj);
  end 
 

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

  elseif Drul<=dy(1)  
 
 jj=round(rand*4310)+1;
 veci=Vnodo(ii,:);
 vecj=Vnodo(jj,:);
 dis=distancia(veci,vecj);
 
  while  dis>dy(1) && dis>0
    jj=round(rand*4310)+1;
    vecj=Vnodo(jj,:);
    dis=distancia(veci,vecj);
  end 
end
 DIS=dis;
 JJ=jj;
end
