%% Winding Arrange
function [Winding,Slot]=WindingArrange(Qs,p,yq,m,n3ph,Beta,alphaS);
%% begin to caculate the star of slots
g=gcd(Qs,2*m*p); % caculate the gratest common division of slots and 2*m*p
N=Qs/g;D=2*m*p/g;
J=[1:Qs,-Qs:-1];% the number of 3-phase slots
%% ------caculate the position of each slot
R=D*(abs(J)-1)+1+m*N*((1-sign(J))/2)-2*m*N;
for i=1:1:2*Qs
    while R(i)>2*m*N
        R(i)=R(i)-2*m*N;
    end
    while R(i)<=0
        R(i)=R(i)+2*m*N;
    end
end
j=0;
theta0=2*pi/(2*m*N);%槽号相位图中每个小格的电角度
BetaNum=Beta/theta0;%一个相带所占的格数
DeltaS=alphaS/theta0;%不同星型之间偏移小格数

%% distribution the slots to A B C phase
for ii=1:n3ph
    for i=1:1:2*Qs
        for iii=1:m/n3ph
            if R(i)>(0+(iii-1)*2*pi/3/theta0+DeltaS*(ii-1))&&R(i)<=(BetaNum+(iii-1)*2*pi/3/theta0+DeltaS*(ii-1))
                j=j+1;
                Winding_temp1(iii+(m/n3ph)*(ii-1),i)=J(i);
            end
        end
    end
end
for i=1:m
    temp=Winding_temp1(i,:);
    temp(temp==0)=[];
    Winding_temp(i,:)=sort(temp,'ComparisonMethod','abs');
end
Winding_temp2=reshape(Winding_temp,[],1)';
Winding.Top=sort(Winding_temp2,'ComparisonMethod','abs');
for i=1:m
    [lia,locb]=ismember(Winding_temp(i,:),Winding.Top);%ABC三相绕组上层边所处的位置
    Winding.Top(locb)=i*sign(Winding.Top(locb));%用1，2，3代表A，B，C三相绕组,4,5,6代表D,E,F绕组
end
for j=1:Qs
    if j+yq<=Qs
        Winding.Bottom(j+yq)=-Winding.Top(j);
    else
        Winding.Bottom(abs(j+yq-Qs))=-Winding.Top(j);
    end
end
Slot=Winding_temp;
Winding.all=[Winding.Top;Winding.Bottom];