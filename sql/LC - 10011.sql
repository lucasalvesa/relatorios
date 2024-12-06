SELECT M.TITULO_MATERIAL, M.AUTOR, C.CDD, C.CDU, E.CODIGO_BARRA, U.SIGLA UNIDADE
FROM LCL.EXEMPLAR E
     INNER JOIN LCL.V_MATERIAL M ON
                M.ID = E.ID_MATERIAL
     INNER JOIN LCL.MATERIAL_GERAL C ON
                C.ID = E.ID_MATERIAL
     INNER JOIN LCL.UNIDADE U ON
                U.ID = E.ID_UNIDADE
WHERE U.SIGLA LIKE '%' AND
      C.CDD LIKE '%' AND
      M.AUTOR LIKE '%' AND
      E.DATA_HORA_BAIXA IS NULL
ORDER BY UNIDADE, C.CDD, M.TITULO_MATERIAL