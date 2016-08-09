function dF_dt = HillON(t,F)
k_b = 6/100;
f_o = 1;
dF_dt = k_b*f_o - k_b*F;
end



