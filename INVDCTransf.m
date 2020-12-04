function I_DCT=	INVDCTransf(I_PRED)
  s = size(I_PRED);
  I_DCT = zeros(s);

  for i = 1:s(1)/8
    for j = 1:s(2)/8
      I_DCT(8*(i-1)+1:8*i, 8*(j-1)+1:8*j) = idct2(I_PRED(8*(i-1)+1:8*i, 8*(j-1)+1:8*j));     
    end
  end
end
