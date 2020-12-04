function I_R=	INVpred(I_PRED,A,B,C)
    s = size(I_PRED);
    I_R = zeros(s);
    I_R(1,:) = I_PRED(1,:);
    I_R(:,1) = I_PRED(:,1);
    
    for i = 2:s(1)
      for j = 2:s(2)
        
        I_R(i,j) = I_PRED(i,j) + (A*I_R(i, j-1) + B*I_R(i-1, j-1) + C * I_R(i-1, j));
        
      end
    end
end
