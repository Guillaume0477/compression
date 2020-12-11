function I_PRED=pred(I, a1, a2, a3)
  s = size(I);
  I_PRED = zeros(s);
  I_PRED(1,:) = I(1,:);
  I_PRED(:,1) = I(:,1);
  
  for i = 2:s(1)
    for j = 2:s(2)
      I_PRED(i,j) = I(i,j) - (a1*I(i, j-1) + a2*I(i-1, j-1) + a3*I(i-1, j));  
    end
  end
  
  
  
end
