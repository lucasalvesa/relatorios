ALTER FUNCTION REL.F_041( @FILIAL VARCHAR(8),
                          @DATA_REFERENCIA DATE,
                          @ANO_REFERENCIA VARCHAR(4),
                          @NOME VARCHAR(256),
                          @CATEGORIA VARCHAR(256) )
RETURNS @RETORNO TABLE( ID_USUARIO BIGINT,
                        NOME VARCHAR(255),
                        MATRICULA VARCHAR(16),
                        CODIGO_BARRA BIGINT,
                        TITULO_MATERIAL VARCHAR(256),
                        DATA_DEVOLUCAO DATE,
                        FILIAL_EXEMPLAR VARCHAR(16),
                        FILIAL_USUARIO VARCHAR(8) ) AS
BEGIN

  INSERT INTO @RETORNO
  SELECT U.ID ID_USUARIO,
         U.NOME,
         U.MATRICULA,
         E.CODIGO_BARRA,
         M.TITULO_MATERIAL,
         I.DATA_DEVOLUCAO,
         E.UNIDADE FILIAL_EXEMPLAR,
         U.FILIAL FILIAL_USUARIO
  FROM LCL.V_EMPRESTIMO I
       INNER JOIN LCL.USUARIO U ON
                  U.ID = I.ID_USUARIO 
       INNER JOIN LCL.V_SGCI_EXEMPLAR E ON
                  E.ID = I.ID_EXEMPLAR
       INNER JOIN LCL.V_MATERIAL M ON
                  M.ID = E.ID_MATERIAL
  WHERE U.FILIAL LIKE @FILIAL AND
        I.DATA_DEVOLUCAO < @DATA_REFERENCIA AND
        DATEPART(YEAR, I.DATA_DEVOLUCAO) = @ANO_REFERENCIA AND
        I.DEVOLUCAO_DATA_HORA IS NULL AND
        U.NOME LIKE @NOME AND
        U.ID_CATEGORIA LIKE @CATEGORIA
  
  RETURN

END