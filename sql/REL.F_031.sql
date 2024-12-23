ALTER FUNCTION REL.F_031()
RETURNS @RETORNO TABLE( CODIGO_BARRA BIGINT,
                        TITULO_MATERIAL VARCHAR(256),
                        AUTOR VARCHAR(256),
                        APELIDO VARCHAR(128),
                        UNIDADE_ORIGEM VARCHAR(16),
                        DATA_HORA_ORIGEM DATETIME2(7),
                        UNIDADE_DESTINO VARCHAR(16) ) AS
BEGIN

  INSERT INTO @RETORNO
  SELECT E.CODIGO_BARRA,
         M.TITULO_MATERIAL,
         COALESCE(M.AUTOR, 'SEM AUTOR REGISTRADO') AUTOR,
         O.APELIDO,
         UORIGEM.SIGLA UNIDADE_ORIGEM,
         T.DATA_HORA_ORIGEM,
         UDESTINO.SIGLA UNIDADE_DESTINO
  FROM LCL.TRANSITO T WITH(NOLOCK)
       INNER JOIN LCL.EXEMPLAR E WITH(NOLOCK) ON
                  E.ID = T.ID_EXEMPLAR
       INNER JOIN LCL.V_MATERIAL M ON
                  M.ID = E.ID_MATERIAL
       INNER JOIN ACS.V_OPERADOR O ON
                  O.ID = T.ID_ACESSO_ORIGEM
       INNER JOIN LCL.UNIDADE UORIGEM WITH(NOLOCK) ON
                  UORIGEM.ID = T.ID_UNIDADE_ORIGEM
       INNER JOIN LCL.UNIDADE UDESTINO WITH(NOLOCK) ON
                  UDESTINO.ID = T.ID_UNIDADE_DESTINO
  WHERE T.DATA_HORA_RECEBIMENTO IS NULL

  RETURN

END