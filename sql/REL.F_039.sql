ALTER FUNCTION REL.F_039( @DATA_INICIAL DATETIME2,
                          @DATA_FINAL DATETIME2,
                          @FILIAL VARCHAR(8) )
RETURNS @RETORNO TABLE( FILIAL VARCHAR(8),
                        DATA_HORA_EMPRESTIMO datetime2,
                        CODIGO_BARRA BIGINT,
                        TITULO_MATERIAL VARCHAR(256),
                        ID_CATEGORIA BIGINT,
                        ID_USUARIO BIGINT,
                        USUARIO VARCHAR(256),
                        MATRICULA VARCHAR(16),
                        DATA_PREVISTA_DEVOLUCAO DATE,
                        DATA_HORA_DEVOLUCAO DATETIME2 ) AS
BEGIN

  INSERT INTO @RETORNO
  SELECT COALESCE(U.FILIAL, '') FILIAL,
         I.DATA_HORA_EMPRESTIMO,
         E.CODIGO_BARRA,
         M.TITULO_MATERIAL,
         U.ID_CATEGORIA,
         U.ID ID_USUARIO,
         U.NOME USUARIO,
         U.MATRICULA,
         I.DATA_PREVISTA_DEVOLUCAO,
         I.DATA_HORA_DEVOLUCAO
  FROM LCL.V_SGCI_EMPRESTIMO I
       INNER JOIN LCL.USUARIO U WITH(NOLOCK) ON
                  U.ID = I.ID_USUARIO
       INNER JOIN LCL.EXEMPLAR E WITH(NOLOCK) ON
                  E.ID = I.ID_EXEMPLAR
       INNER JOIN LCL.V_MATERIAL M ON
                  M.ID = E.ID_MATERIAL
  WHERE I.DATA_HORA_EMPRESTIMO BETWEEN @DATA_INICIAL AND @DATA_FINAL AND
        COALESCE(U.FILIAL, '') LIKE '%' + @FILIAL + '%'

  RETURN

END