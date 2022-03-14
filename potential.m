function val = potential(q, L, m)

    g = 9.81;
    e3 = [0; 0; 1];
    
    val = L * g * m * e3' * q;

end