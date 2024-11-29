SELECT E.UNIDADE, M.CDD, V.TITULO_MATERIAL, V.AUTOR, E.ID EXEMPLAR
FROM LCL.V_SGCI_EXEMPLAR E
     INNER JOIN LCL.V_MATERIAL_GERAL M ON
                M.ID = E.ID_MATERIAL
     INNER JOIN LCL.V_MATERIAL V ON
                V.ID = M.ID
     INNER JOIN LCL.AUTOR A ON
                A.ID = V.ID_AUTOR
WHERE E.UNIDADE LIKE '%' AND
      M.CDD BETWEEN 'A1' AND 'B2' AND
      E.DATA_HORA_BAIXA IS NULL
ORDER BY E.UNIDADE, M.CDD, M.TITULO