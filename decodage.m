function [I_PRED] = decodage(I_C, dictionnaire, lignes, colonnes)


  Im = huffmandeco(I_C, dictionnaire);
  
  I_PRED = reshape(Im, [lignes, colonnes]);
    
end
