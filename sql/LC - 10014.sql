SELECT U.SIGLA,
       COUNT(ID_UNIDADE) TOTAL_DE_EXEMPLARES,
       SUM(CASE WHEN E.ESTADO = 'BAIXADO' THEN 1 ELSE 0 END) EXEMPLARES_BAIXADOS,
       SUM(CASE WHEN E.ESTADO <> 'BAIXADO' THEN 1 ELSE 0 END) EXEMPLARES_ATIVOS
FROM LCL.EXEMPLAR E
     INNER JOIN LCL.UNIDADE U ON
                U.ID = E.ID_UNIDADE
GROUP BY U.SIGLA
ORDER BY U.SIGLA