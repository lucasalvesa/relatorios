ALTER FUNCTION REL.F_044( @FILIAL VARCHAR(16),
                          @CDD VARCHAR(32),
                          @AUTOR VARCHAR(256) )
RETURNS @RETORNO TABLE( TITULO_MATERIAL VARCHAR(256),
                        AUTOR VARCHAR(256),
                        CDD VARCHAR(32),
                        CDU VARCHAR(32),
                        CODIGO_BARRA BIGINT,
                        UNIDADE VARCHAR(16) ) AS
BEGIN

  INSERT INTO @RETORNO
  SELECT M.TITULO_MATERIAL, M.AUTOR, C.CDD, C.CDU, E.CODIGO_BARRA, U.SIGLA UNIDADE
  FROM LCL.EXEMPLAR E
       INNER JOIN LCL.V_MATERIAL M ON
                  M.ID = E.ID_MATERIAL
       INNER JOIN LCL.MATERIAL_GERAL C ON
                  C.ID = E.ID_MATERIAL
       INNER JOIN LCL.UNIDADE U ON
                  U.ID = E.ID_UNIDADE
  WHERE U.SIGLA LIKE '%' + @FILIAL + '%' AND
        C.CDD LIKE '%' + @CDD + '%' AND
        M.AUTOR LIKE '%' + @AUTOR + '%' AND
        E.DATA_HORA_BAIXA IS NULL
  
  RETURN

END