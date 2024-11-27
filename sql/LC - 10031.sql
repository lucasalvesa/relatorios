SELECT V.UNIDADE,
       B.BAIXA MOTIVO_BAIXA,
       COALESCE(NULLIF(M.TITULO_MATERIAL, ''), 'SEM T�TULO REGISTRADO') TITULO_MATERIAL,
       COALESCE (A.NOME, 'SEM AUTOR REGISTRADO') AUTOR,
       E.DATA_HORA_BAIXA,
       M.ID ID_MATERIAL,
       E.CODIGO_BARRA EXEMPLAR
FROM LCL.EXEMPLAR E
     LEFT JOIN LCL.V_SGCI_EXEMPLAR V ON
                V.ID = E.ID
     LEFT JOIN LCL.BAIXA_EXEMPLAR B ON
                B.ID = E.ID_BAIXA_EXEMPLAR
     LEFT JOIN LCL.V_MATERIAL M ON
                M.ID = E.ID_MATERIAL
     LEFT JOIN LCL.AUTOR A ON
                A.ID = M.ID_AUTOR
WHERE B.BAIXA IS NOT NULL AND
      V.UNIDADE LIKE '%' AND
      E.DATA_HORA_BAIXA BETWEEN '%' AND '%'
ORDER BY UNIDADE, A.NOME, M.TITULO_MATERIAL