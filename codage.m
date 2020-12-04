function [I_C,dictionnaire]=codage(I_PRED)
  
  s = size(I_PRED);
  
  %Get the histogram
  [hDec, vals_dec] = hist(reshape(I_PRED, [s(2)*s(1),1]), min(min(I_PRED)):max(max(I_PRED)));
  
  %Extract symbols
  ind = find(hDec);
  symb = vals_dec(ind);
  prob = hDec(ind) / sum(sum(hDec));
  
  %Creation of the dictionnary
  [dictionnaire , l_moy] = huffmandict(symb, prob);
  
  l_moy
  %Creation of the code of the image
  I_C = huffmanenco(reshape(I_PRED,[1,s(2)*s(1)]) , dictionnaire);
  
end  
