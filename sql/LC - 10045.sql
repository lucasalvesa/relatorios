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
WHERE U.SIGLA LIKE '%' AND
      E.ESTADO <> 'BAIXADO' AND
      M.ID_TIPO_MATERIAL IN ( CASE WHEN T01 = 1 THEN 1 ELSE 0 END,
                              CASE WHEN T02 = 1 THEN 2 ELSE 0 END,
                              CASE WHEN T03 = 1 THEN 3 ELSE 0 END,
                              CASE WHEN T04 = 1 THEN 4 ELSE 0 END,
                              CASE WHEN T05 = 1 THEN 5 ELSE 0 END,
                              CASE WHEN T06 = 1 THEN 6 ELSE 0 END,
                              CASE WHEN T07 = 1 THEN 7 ELSE 0 END,
                              CASE WHEN T08 = 1 THEN 8 ELSE 0 END,
                              CASE WHEN T09 = 1 THEN 9 ELSE 0 END,
                              CASE WHEN T10 = 1 THEN 10 ELSE 0 END,
                              CASE WHEN T11 = 1 THEN 11 ELSE 0 END,
                              CASE WHEN T12 = 1 THEN 12 ELSE 0 END,
                              CASE WHEN T13 = 1 THEN 13 ELSE 0 END,
                              CASE WHEN T14 = 1 THEN 14 ELSE 0 END )
ORDER BY TIPO_MATERIAL, UNIDADE, TITULO_MATERIAL