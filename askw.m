function v = askw(A)

v = zeros(3,1);
v(1) = A(3, 2);
v(2) = A(1, 3);
v(3) = A(2, 1);

end