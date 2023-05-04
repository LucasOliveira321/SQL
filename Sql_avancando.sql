
CREATE TABLE aluno(
	
	id SERIAL PRIMARY KEY,
	primeiro_nome VARCHAR(255) NOT NULL,
	ultimo_nome VARCHAR(255) NOT NULL,
	data_nascimento DATE NOT NULL
);

INSERT INTO aluno (primeiro_nome, ultimo_nome, data_nascimento) VALUES ('Lucas',    'Souza',     '1996/05/15'),
																	   ('João',     'Berto',     '1978/04/10'),
																	   ('Malaquias','Silva',     '1990/08/18'),
																	   ('Maria',    'Oliveira',  '1992/03/19'),
																	   ('Fernando', 'Morai',     '1988/11/30'),
																	   ('Jefferson','Aparecido', '1980/02/28');
SELECT * FROM aluno

CREATE TABLE curso(

	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	categoria INTEGER NOT NULL REFERENCES categoria(id)
);

INSERT INTO curso (nome, categoria) VALUES ('HTML',1);
INSERT INTO curso (nome, categoria) VALUES ('Java',2);
INSERT INTO curso (nome, categoria) VALUES ('JavaScript',2);
INSERT INTO curso (nome, categoria) VALUES ('JavaScript',1);
INSERT INTO curso (nome, categoria) VALUES ('Excel',3);
SELECT * FROM curso

CREATE TABLE categoria(

	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL
);

INSERT INTO categoria (nome) VALUES ('FRONT-END');
INSERT INTO categoria (nome) VALUES ('BACK-END');
INSERT INTO categoria (nome) VALUES ('ADMINISTRATIVO');
SELECT * FROM categoria

CREATE TABLE aluno_curso(
	
	aluno_id INTEGER NOT NULL REFERENCES aluno(id),
	curso_id INTEGER NOT NULL REFERENCES curso(id),
	PRIMARY KEY(aluno_id, curso_id)
);

INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (1,3);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (2,1);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (3,3);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (4,2);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (5,1);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (6,2);
SELECT * FROM aluno_curso

-- MANEIRAS DE GERAR RELATÓRIOS

SELECT aluno.primeiro_nome,
	   aluno.ultimo_nome,
	   COUNT(aluno_curso.curso_id) AS numero_cursos
	   FROM aluno
	   JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
GROUP BY aluno.primeiro_nome, aluno.ultimo_nome
ORDER BY numero_cursos DESC
LIMIT 3;

SELECT curso.nome,
	   categoria.nome,
	   COUNT(aluno_curso.aluno_id) AS "Alunos Matriculados"
	   FROM curso
	   JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	   JOIN categoria	ON categoria.id         = curso.categoria
GROUP BY curso.nome, categoria.nome
ORDER BY 3 DESC;

SELECT cat.nome,
	   COUNT (aluno_curso.aluno_id) AS "Alunos"
	   FROM categoria cat
	   JOIN curso       ON curso.categoria = cat.id
	   JOIN aluno_curso ON aluno_curso.curso_id = curso.id
GROUP BY 1;

SELECT * FROM curso WHERE categoria IN (1,2);
SELECT * FROM curso WHERE nome LIKE '%Ja%';
SELECT curso.nome FROM curso WHERE categoria IN (SELECT id FROM categoria WHERE nome LIKE '%END%');

SELECT nome
	FROM(
		SELECT cat.nome,
		   COUNT (aluno_curso.aluno_id)
		   FROM categoria cat
		   JOIN curso       ON curso.categoria = cat.id
		   JOIN aluno_curso ON aluno_curso.curso_id = curso.id
		GROUP BY 1
	    ) AS cat
	      WHERE cat.count > 1;
		  
-- FUNÇÕES

SELECT (primeiro_nome || ' ' || ultimo_nome) AS nome_completo FROM aluno;
SELECT CONCAT (primeiro_nome, ' ', ultimo_nome) AS nome_completo FROM aluno;
SELECT UPER(CONCAT (primeiro_nome, ' ', ultimo_nome)) AS nome_completo FROM aluno;

-- DATA

SELECT CONCAT (primeiro_nome, ' ', ultimo_nome) AS nome_completo, data_nascimento FROM aluno;
SELECT CONCAT (primeiro_nome, ' ', ultimo_nome) AS nome_completo, NOW(), data_nascimento FROM aluno;
SELECT CONCAT (primeiro_nome, ' ', ultimo_nome) AS nome_completo, NOW()::DATE, data_nascimento FROM aluno;
SELECT CONCAT (primeiro_nome, ' ', ultimo_nome) AS nome_completo, (NOW()::DATE-data_nascimento)/365 AS idade FROM aluno;
SELECT CONCAT (primeiro_nome, ' ', ultimo_nome) AS nome_completo, AGE(data_nascimento) AS idade FROM aluno;
SELECT CONCAT (primeiro_nome, ' ', ultimo_nome) AS nome_completo, EXTRACT(YEAR FROM AGE(data_nascimento)) AS idade FROM aluno;
SELECT TO_CHAR(data_nascimento, 'DD-MM-YYYY') AS data FROM aluno;
SELECT TO_CHAR(data_nascimento, 'DD-MM-YYYY HH12') AS data FROM aluno;
SELECT TO_CHAR(data_nascimento, 'DD-MM-YYYY HH24') AS data FROM aluno;
SELECT TO_CHAR(data_nascimento, 'DD-MM-YYYY HH24 MI') AS data FROM aluno;
SELECT TO_CHAR(data_nascimento, 'DD-MM-YYYY HH24 MI SS') AS data FROM aluno;

-- VIEW

CREATE VIEW vw_quantidade_de_alunos_curso AS
SELECT curso.nome AS curso,
	   categoria.nome,
	   COUNT(aluno_curso.aluno_id) AS "Alunos Matriculados"
	   FROM curso
	   JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	   JOIN categoria	ON categoria.id         = curso.categoria
GROUP BY curso.nome, categoria.nome
ORDER BY 3 DESC;


SELECT * FROM vw_quantidade_de_alunos_curso;
















