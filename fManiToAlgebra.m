function F = fManiToAlgebra(q, w, L, m, damp)

%     R = assembleR(q,L,m); %Creates the matrix R multiplying w'
%     
%     Func = assembleF(q,w,m,L); %Creates the right hand site Rw' = Func
    
%     V = R\Func; %Finds the right hand side of the equation w' = V

    z = [q; w];
%     V = FuncW(z, L, m, damp);
    V = assembleF(q, w, m, L);
%     g = 9.81;
%     e3 = [0; 0; 1];
%     V = -m * g * L * cross(e3,q) - damp*w;
    F = zeros(6, 1);
%     F(1:3) = w; 
%     F(4:6) = hat(q) * V;
    F(1:3) = cross(w, q); 
    F(4:6) = cross(V, q) - damp*w;

end