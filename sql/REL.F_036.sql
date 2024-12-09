ALTER FUNCTION REL.F_036( @FILIAL VARCHAR(16),
                          @T1 BIT,
                          @T2 BIT,
                          @T3 BIT,
                          @T4 BIT,
                          @T5 BIT,
                          @T6 BIT,
                          @T7 BIT,
                          @T8 BIT,
                          @T9 BIT,
                          @T10 BIT,
                          @T11 BIT,
                          @T12 BIT,
                          @T13 BIT,
                          @T14 BIT )
RETURNS @RETORNO TABLE( TIPO_MATERIAL VARCHAR(128),
                        UNIDADE VARCHAR(16),
                        TITULO_MATERIAL VARCHAR(256),
                        CODIGO_BARRA BIGINT,
                        CODIGO_MATERIAL BIGINT ) AS
BEGIN

  INSERT INTO @RETORNO
  SELECT T.TIPO TIPO_MATERIAL, U.SIGLA UNIDADE, V.TITULO_MATERIAL, E.CODIGO_BARRA, M.ID CODIGO_MATERIAL
  FROM LCL.EXEMPLAR E
       INNER JOIN LCL.MATERIAL M ON
                  M.ID = E.ID_MATERIAL
       INNER JOIN LCL.TIPO_MATERIAL T ON
                  T.ID = M.ID_TIPO_MATERIAL
       INNER JOIN LCL.UNIDADE U ON
                  U.ID = E.ID_UNIDADE
       INNER JOIN LCL.V_MATERIAL V ON
                  V.ID = M.ID
  WHERE U.SIGLA LIKE '%' + @FILIAL + '%' AND
        E.ESTADO <> 'BAIXADO' AND
        M.ID_TIPO_MATERIAL IN ( CASE WHEN @T1 = 1 THEN 1 ELSE 0 END,
                                CASE WHEN @T2 = 1 THEN 2 ELSE 0 END,
                                CASE WHEN @T3 = 1 THEN 3 ELSE 0 END,
                                CASE WHEN @T4 = 1 THEN 4 ELSE 0 END,
                                CASE WHEN @T5 = 1 THEN 5 ELSE 0 END,
                                CASE WHEN @T6 = 1 THEN 6 ELSE 0 END,
                                CASE WHEN @T7 = 1 THEN 7 ELSE 0 END,
                                CASE WHEN @T8 = 1 THEN 8 ELSE 0 END,
                                CASE WHEN @T9 = 1 THEN 9 ELSE 0 END,
                                CASE WHEN @T10 = 1 THEN 10 ELSE 0 END,
                                CASE WHEN @T11 = 1 THEN 11 ELSE 0 END,
                                CASE WHEN @T12 = 1 THEN 12 ELSE 0 END,
                                CASE WHEN @T13 = 1 THEN 13 ELSE 0 END,
                                CASE WHEN @T14 = 1 THEN 14 ELSE 0 END )
  
  RETURN

END