CREATE TABLE aluno (
    id SERIAL PRIMARY KEY,
	primeiro_nome VARCHAR(255) NOT NULL,
	ultimo_nome VARCHAR(255) NOT NULL,
	data_nascimento DATE NOT NULL
);
DROP TABLE aluno;

CREATE TABLE categoria (
    id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL UNIQUE
);
DROP TABLE categoria;

CREATE TABLE curso (
    id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	categoria_id INTEGER NOT NULL REFERENCES categoria(id)
);
DROP TABLE curso;

CREATE TABLE aluno_curso (
	aluno_id INTEGER NOT NULL REFERENCES aluno(id),
	curso_id INTEGER NOT NULL REFERENCES curso(id),
	PRIMARY KEY (aluno_id, curso_id)
);
DROP TABLE aluno_curso;

-- Outra forma de criar uma chave estrangeira sem usar o "FOREIGN KEY"
/* Fazer a referência ("REFERENCES") com identificadores únicos, como 
"PRIMARY KEY" ou "UNIQUE" */

/* Tipos de relacionamentos entre informações:
1)Um para um (mais raro).
2)Um para muitos; muitos para um.
3)Muitos para muitos (tabela aluno_curso). */

INSERT INTO aluno (primeiro_nome, ultimo_nome, data_nascimento) VALUES (
	'Vinicius', 'Dias', '1997-10-15'
), (
	'Patricia', 'Freitas', '1986-10-25'
), (
	'Diogo', 'Oliveira', '1984-08-27'
), (
	'Maria', 'Rosa', '1985-01-01'
);

INSERT INTO categoria (nome) VALUES ('Front-end'), ('Programação'), ('Bancos de dados'), ('Data Science');
-- Maneira mais prática da sintaxe para a função "INSERT INTO"
/* UPDATE categoria SET nome = 'Ciência de Dados' WHERE id = 4;
Forma para mudar o nome de algo no banco; quando há chave estrangeira, deve-se usar também o "CASCADE" */

INSERT INTO curso (nome, categoria_id) VALUES
	('HTML', 1),
	('CSS', 1),
	('JS', 1),
	('PHP', 2),
	('Java', 2),
	('C++', 2),
	('PostgreSQL', 3),
	('MySQL', 3),
	('Oracle', 3),
	('SQL Server', 3),
	('SQLite', 3),
	('Pandas', 4),
	('Machine Learning', 4),
	('Power BI', 4);
	
INSERT INTO aluno_curso VALUES (1, 4), (1, 11), (2, 1), (2, 2), (3, 4), (3, 3), (4, 4), (4, 6), (4, 5);


SELECT aluno.primeiro_nome, aluno.ultimo_nome, COUNT(curso.id) 
AS numero_de_cursos
    FROM aluno 
        JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
        JOIN curso ON curso.id = aluno_curso.curso_id
GROUP BY aluno.primeiro_nome, aluno.ultimo_nome;

--Mesmo resultado, com uma sintaxe mais fácil:
SELECT aluno.primeiro_nome, aluno.ultimo_nome, COUNT(aluno_curso.curso_id)
AS numero_de_cursos
    FROM aluno
        JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
GROUP BY 1, 2   -- Queries antes do "COUNT"
ORDER BY numero_de_cursos DESC;
-- Esses dois modelos se referem à criação de relatório

-- Usando a função "LIMIT", podemos descobrir qual aluno está em mais cursos:
SELECT aluno.primeiro_nome, aluno.ultimo_nome, COUNT(aluno_curso.curso_id)
AS numero_de_cursos
    FROM aluno
        JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
GROUP BY 1, 2   -- Queries antes do "COUNT"
ORDER BY numero_de_cursos DESC
    LIMIT 1;


SELECT curso.nome, COUNT(aluno_curso.aluno_id)
AS numero_de_alunos
    FROM curso
        JOIN aluno_curso ON aluno_curso.curso_id = curso.id
GROUP BY 1   
ORDER BY numero_de_alunos DESC
    LIMIT 1;
-- Curso mais requisitado
