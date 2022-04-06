function rslt = bcFun(ya, yb, q1, q2)
% boundary condition function
% used by the MATLAB function bvp4c or bvp5c

rslt = zeros(8,1);
rslt(1:4) = ya(1:4) - q1;
rslt(5:8) = yb(1:4) - q2;

end