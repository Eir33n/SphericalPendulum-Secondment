function res = actionSE3(B, input)
% This is the action on the SE3 group
% B is a 3x4 matrix
% input is a concatenate couple of vectors of dimension 3 [size(input) => 6]
% The result is a column vector 6x1

res = [B(1:3,1:3)*input(1:3); B(1:3,1:3)*input(4:6) + cross(B(:,end), (B(1:3,1:3)*input(1:3)))];

end