function yPrime = freeRigidBody(y, invInertia, alpha)

if nargin == 2
    alpha = 0;
end

m = y(1:3);
Q = y(4:3+9);
Q = reshape(Q, 3, 3);

mPrime = cross(m, invInertia * m) - alpha * m;
QPrime = Q * skw(invInertia * m);
QPrime = reshape(QPrime, 9, 1);

yPrime = zeros(size(y));
yPrime(1:3) = mPrime;
yPrime(4:end) = QPrime;

end