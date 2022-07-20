clearvars

[s, p] = readAll();

crr_s = cell(11, 1);
crr_p = cell(11, 1);

for i = 1:10
    crr_s{1} = s{1};
    crr_p{1} = p{1};

    crr_s(2:2+9) = s(2+10*(i-1):1+10*i);
    crr_p(2:2+9) = p(2+10*(i-1):1+10*i);

    err = evalErr(crr_s, crr_p);
    plotErr(err)
end