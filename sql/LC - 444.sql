SELECT COALESCE(U.FILIAL, '') FILIAL,
       I.DATA_HORA_EMPRESTIMO,
       E.CODIGO_BARRA,
       M.TITULO_MATERIAL,
       U.ID_CATEGORIA,
       U.ID ID_USUARIO,
       U.NOME USUARIO,
       U.MATRICULA,
       I.DATA_PREVISTA_DEVOLUCAO,
       COALESCE(I.DATA_HORA_DEVOLUCAO, '-') DATA_HORA_DEVOLUCAO
FROM LCL.V_SGCI_EMPRESTIMO I
     INNER JOIN LCL.USUARIO U ON
                U.ID = I.ID_USUARIO
     INNER JOIN LCL.EXEMPLAR E ON
                E.ID = I.ID_EXEMPLAR
     INNER JOIN LCL.V_MATERIAL M ON
                M.ID = E.ID_MATERIAL
WHERE I.DATA_HORA_EMPRESTIMO BETWEEN '2024-01-01' AND '2024-11-27' AND
      COALESCE(U.FILIAL, '') LIKE '%'
ORDER BY FILIAL, DATA_HORA_EMPRESTIMO, USUARIO