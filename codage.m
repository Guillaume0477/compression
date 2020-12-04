function [I_C,dictionnaire]=codage(I_PRED)
  
  s = size(I_PRED);
  
  %Get the histogram
  [hDec, vals_dec] = hist(reshape(I_PRED, [s(2)*s(1),1]), -31:31);
  
  %Extract symbols
  ind = find(hDec);
  symb = vals_dec(ind);
  prob = hDec(ind) / sum(sum(hDec));
  
  %Creation of the dictionnary
  dictionnaire = huffmandict(symb, prob);
  
  %Creation of the code of the image
  I_C = huffmanenco(reshape(I_PRED,[1,s(2)*s(1)]) , dictionnaire);
  
end  
