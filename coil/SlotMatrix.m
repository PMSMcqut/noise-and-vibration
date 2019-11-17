%% calculating slot matrix
function [SlotMatrix]=SlotMatrix(Qs,m,Winding)
for r=1:m
    for c=1:Qs
        if abs(Winding.all(1,c))==r && abs(Winding.all(2,c))==r
            SlotMatrix(r,c)=1*sign(Winding.all(1,c));
        elseif abs(Winding.all(1,c))==r
            SlotMatrix(r,c)=0.5*sign(Winding.all(1,c));
        elseif abs(Winding.all(2,c))==r
            SlotMatrix(r,c)=0.5*sign(Winding.all(2,c));
        else
            SlotMatrix(r,c)=0*sign(Winding.all(1,c));
        end
    end
end
end