ALTER FUNCTION REL.F_030( @PERIODO_LETIVO VARCHAR(10), @POSICAO INT )
RETURNS @RETORNO TABLE( FILIAL VARCHAR(10),
                        POSICAO INT,
                        CODIGO INT,
                        NOME_ALUNO VARCHAR(100),
                        QUANTIDADE_LIVROS INT ) AS
BEGIN

  INSERT INTO @RETORNO
  SELECT U.FILIAL,
         ROW_NUMBER() OVER (PARTITION BY U.FILIAL ORDER BY U.FILIAL, COUNT(*) DESC) POSICAO,
         U.ID ID_DO_USUARIO, 
         U.NOME,  
         COUNT(*) TOTAL_LIVROS_EMPRESTADOS
  FROM LCL.V_EMPRESTIMO I
       INNER JOIN ACD.PERIODO P ON
                  I.DATA_HORA BETWEEN P.DATA_INICIO AND P.DATA_TERMINO
       INNER JOIN LCL.USUARIO U ON
                  U.ID = I.ID_USUARIO
  WHERE P. SIGLA = @PERIODO_LETIVO AND
        U.ID_CATEGORIA = 1
  GROUP BY U.ID, U.NOME, U.FILIAL
  ORDER BY U.FILIAL, POSICAO
  
  DELETE FROM @RETORNO
  WHERE POSICAO > @POSICAO

  RETURN

END