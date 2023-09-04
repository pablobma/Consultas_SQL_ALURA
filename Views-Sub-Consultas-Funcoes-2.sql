SELECT * FROM curso;
SELECT * FROM categoria;

SELECT * FROM curso WHERE categoria_id = 1 OR categoria_id = 2;
SELECT * FROM curso WHERE categoria_id IN(1,2);
-- Os dois comandos representam a mesma tabela
-- A função "IN" otimiza o código

SELECT nome FROM categoria WHERE nome NOT LIKE '% %';
-- '% %' significa que não há espaços de separação


SELECT * FROM curso WHERE categoria_id IN(
    SELECT id FROM categoria WHERE nome NOT LIKE '% %'
);

SELECT curso.nome FROM curso WHERE categoria_id IN(
    SELECT id FROM categoria WHERE nome LIKE '% de %'
);
-- Dois exemplos de sub queries (queries aninhadas)


SELECT categoria.nome AS categoria, COUNT(curso.id) AS numero_cursos
FROM categoria
    JOIN curso ON curso.categoria_id = categoria.id
        GROUP BY categoria;

SELECT categoria.nome AS categoria, COUNT(curso.id) AS numero_cursos
FROM categoria
    JOIN curso ON curso.categoria_id = categoria.id
        GROUP BY categoria
        HAVING COUNT(curso.id) > 3;
-- Mais exemplos de "JOIN"
-- É possível usar sub-queries dentro do "FROM", mas o código torna-se mais complexo









