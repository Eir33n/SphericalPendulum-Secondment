function f = vecFieldRigidBody(q, w, invinertia)

V = -cross(q, cross(q, invinertia*q));

f = zeros(6, 1);
f(1:3) = w;
f(4:6) = skw(q) * V;

end