function F = fManiToAlgebra(q, w, L, m, damp)

%     R = assembleR(q,L,m); %Creates the matrix R multiplying w'
%     
%     Func = assembleF(q,w,m,L); %Creates the right hand site Rw' = Func
    
%     V = R\Func; %Finds the right hand side of the equation w' = V

    z = [q; w];
    V = FuncW(z, L, m, damp);

    F = zeros(6, 1);
    F(1:3) = w; 
    F(4:6) = hat(q) * V;
    
end