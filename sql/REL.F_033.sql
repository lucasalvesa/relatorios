ALTER FUNCTION REL.F_033()
RETURNS @RETORNO TABLE( TITULO_MATERIAL VARCHAR(256),
                        ID_MATERIAL BIGINT ) AS
BEGIN

  INSERT INTO @RETORNO
  SELECT COALESCE(NULLIF(M.TITULO_MATERIAL, ''), 'MATERIAL SEM TITULO REGISTRADO') TITULO_MATERIAL,
         M.ID ID_MATERIAL
  FROM LCL.V_MATERIAL M
  WHERE NOT EXISTS (SELECT 1
                    FROM LCL.EXEMPLAR E
                    WHERE E.ID_MATERIAL = M.ID)

  RETURN

END