function I_Q=Quantif(I_DCT)
    pasQ = ([3,5,7,9,11,13,15,17;
            5,7,9,11,13,15,17,19;
            7,9,11,13,15,17,19,21;
            9,11,13,15,17,19,21,23;
            11,13,15,17,19,21,23,25;
            13,15,17,19,21,23,25,27;
            15,17,19,21,23,25,27,29;
            17,19,21,23,25,27,29,31]);%-1)./2  ;
%     pasQ = ones(8,8)*20;
%     pasQ = ones(8,8);
    s = size(I_DCT);
    I_Q = zeros(s);
    
    for i = 1:s(1)/8
      for j = 1:s(2)/8
        I_Q(8*(i-1)+1:8*i, 8*(j-1)+1:8*j) = round((I_DCT(8*(i-1)+1:8*i, 8*(j-1)+1:8*j))./pasQ).*pasQ;     
      end
    end
    
    
end
