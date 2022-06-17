function yPrime = freeRigidBody(y, invInertia)

yPrime = - cross(y, cross(y, invInertia * y));

end