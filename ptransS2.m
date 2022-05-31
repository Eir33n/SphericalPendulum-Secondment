function v1 = ptransS2(q0,q1,v0)
    
Q0=zeros(3,3);
Q0(:,3) = q0;
a = transpose(q0)*q1;
vq0 = q1-a*q0;
Q0(:,1) = vq0/norm(vq0,2);
Q0(:,2) = cross(Q0(:,3),Q0(:,1));

Q1=zeros(3,3);
Q1(:,3) = q1;
vq1 = a*q1-q0;
Q1(:,1) = vq1/norm(vq1,2);
Q1(:,2) = cross(Q1(:,3),Q1(:,1));

v1 = Q1*Q0'*v0;
return
