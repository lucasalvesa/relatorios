SELECT COALESCE(NULLIF(TITULO_MATERIAL, ''), 'MATERIAL SEM T�TULO REGISTRADO') TITULO_MATERIAL,
       ID ID_MATERIAL
FROM LCL.V_MATERIAL M
WHERE NOT EXISTS (SELECT 1
                  FROM LCL.EXEMPLAR E
                  WHERE E.ID_MATERIAL = M.ID)
ORDER BY TITULO_MATERIAL