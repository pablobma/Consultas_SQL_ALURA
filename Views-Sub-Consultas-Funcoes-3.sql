SELECT * FROM aluno;

SELECT (primeiro_nome || ' ' || ultimo_nome) AS nome_completo
    FROM aluno;
-- "||" concatena (junta) informações de diferentes colunas


SELECT (primeiro_nome || ' ' || ultimo_nome) AS nome_completo, 
        (NOW()::DATE - data_nascimento) / 365 AS idade,
        data_nascimento
    FROM aluno;

SELECT (primeiro_nome || ' ' || ultimo_nome) AS nome_completo, 
        EXTRACT(YEAR FROM AGE(data_nascimento)) AS idade,
        data_nascimento
    FROM aluno;


CREATE VIEW vw_cursos_programacao AS
    SELECT nome FROM curso WHERE categoria_id = 2;

SELECT * FROM vw_cursos_programacao;
-- "VIEW" são listas virtuais que deixam o código mais seguro case este seja enviado à terceiros
