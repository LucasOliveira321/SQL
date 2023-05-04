-- Database: alura

-- DROP DATABASE IF EXISTS alura;

-- CRIANDO A BASE DE DADOS

CREATE DATABASE alura
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- CRIANDO TABELA

CREATE TABLE aluno(
	id SERIAL,
	nome VARCHAR(255),
	cpf char (11),
	observacao TEXT,
	idade INTEGER,
	dinheiro NUMERIC(10,2),
	altura REAL,
	ativo BOOLEAN,
	data_nascimento DATE,
	hora_aula TIME,
	matriculado_em TIMESTAMP
);

CREATE TABLE curso (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL
);

CREATE TABLE aluno (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL
);

-- INSERINDO INFORMAÇÃO NA TABELA

INSERT INTO curso (nome) VALUES ('JavaScript')

INSERT INTO aluno (
	nome,
	cpf,
	observacao,
	idade,
	dinheiro,
	altura,
	ativo,
	data_nascimento,
	hora_aula,
	matriculado_em
) 
VALUES (
	'Joao',
	'12345678901',
	'teste texto testando',
	22,
	100.30,
	1.70,
	TRUE,
	'1996-05-16',
	'19:05:00',
	'2022-08-01'
)

-- ALTERANDO VALORES DA TABELA

UPDATE aluno SET
	nome = 'Lucas Oliveira',
	matriculado_em = '2023-03-25 20:12:00'
WHERE id = 1;

-- DELETANDO TABELA OU LINHAS

DROP TABLE aluno;
DELETE FROM curso WHERE nome = 'Luan';

-- REALIZANDO FILTROS

SELECT 
	nome AS "NOME DO ALUNO",
	idade,
	data_nascimento AS "DATA DE NASCIMENTO"
	FROM aluno;

SELECT nome, idade, data_nascimento FROM aluno;
SELECT * FROM curso;
SELECT * FROM aluno WHERE nome LIKE 'F_lipe'
SELECT * FROM aluno WHERE nome LIKE 'L%'
SELECT * FROM aluno WHERE nome LIKE '%a'
SELECT * FROM aluno WHERE nome LIKE '%c%a%'
SELECT * FROM aluno WHERE nome NOT LIKE 'F_lipe'
SELECT * FROM aluno WHERE CPF IS NULL
SELECT * FROM aluno WHERE CPF IS NOT NULL
SELECT * FROM aluno WHERE idade BETWEEN 22 AND 27
SELECT * FROM aluno WHERE ativo = TRUE
SELECT * FROM aluno WHERE nome LIKE 'L%' AND cpf IS NOT null
SELECT * FROM aluno WHERE nome LIKE 'Lucas%' OR nome LIKE 'Joao' OR nome LIKE 'não existe'

-- TESTANDO RELACAO ENTRE TABELAS DE ALUNO E CURSO

CREATE TABLE aluno_curso (
	aluno_id INTEGER,
	curso_id INTEGER,
	PRIMARY KEY(aluno_id,curso_id),
	
	FOREIGN KEY (aluno_id)
	 REFERENCES aluno (id),
	
	FOREIGN KEY (curso_id)
	 REFERENCES curso (id)
);

SELECT * FROM curso

INSERT INTO curso (nome) VALUES ('HTML');

SELECT aluno.nome AS "Aluno",
	   curso.nome AS "Curso" 
	   FROM aluno
	   JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	   JOIN curso       ON curso.id             = aluno_curso.curso_id


SELECT * FROM aluno
	     LEFT JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
		 LEFT JOIN curso       ON curso.id 			  = aluno_curso.curso_id

SELECT * FROM aluno
	     RIGHT JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
		 RIGHT JOIN curso       ON curso.id 			  = aluno_curso.curso_id

SELECT * FROM aluno
	     FULL JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
		 FULL JOIN curso       ON curso.id 			  = aluno_curso.curso_id

SELECT * FROM aluno
		 CROSS JOIN curso

-- CONFIGURANDO A TABELA REALIZAR A EXCLUSAO DE UM ALUNO JUNTO COM O RELACIONAMENTO

CREATE TABLE aluno_curso (
	aluno_id INTEGER,
	curso_id INTEGER,
	PRIMARY KEY(aluno_id,curso_id),
	
	FOREIGN KEY (aluno_id)
	REFERENCES aluno (id) 
	ON DELETE CASCADE,
	
	FOREIGN KEY (curso_id)
	REFERENCES curso (id)
);

-- CONFIGURANDO A TABELA REALIZAR A EXCLUSAO E O UPDATE DE UM ALUNO JUNTO COM O RELACIONAMENTO

CREATE TABLE aluno_curso (
	aluno_id INTEGER,
	curso_id INTEGER,
	PRIMARY KEY(aluno_id,curso_id),
	
	FOREIGN KEY (aluno_id)
	REFERENCES aluno (id) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	
	FOREIGN KEY (curso_id)
	REFERENCES curso (id)
);

UPDATE aluno SET id = 10 WHERE id = 2;
	
-- ORDENANDO OS DADOS

CREATE TABLE funcionarios (
	
	id SERIAL PRIMARY KEY,
	matricula VARCHAR(10),
	nome      VARCHAR(255),
	sobrenome VARCHAR(255)
	
)

INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('001','LUCAS', 'OLIVEIRA');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('002','FELIPE', 'OLIVEIRA');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('003','MARIA', 'AUGUSTA');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('004','JOAO', 'SOUZA');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('005','FRANCISCO', 'CHICO');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('006','BERNADETE', 'AUGUSTA');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('007','LUCAS', 'AUGUSTO');

SELECT * FROM funcionarios

SELECT * FROM funcionarios ORDER BY nome
SELECT * FROM funcionarios ORDER BY nome DESC
SELECT * FROM funcionarios ORDER BY nome, matricula
SELECT * FROM funcionarios ORDER BY nome, matricula DESC
SELECT * FROM funcionarios ORDER BY nome DESC, matricula
SELECT DISTINCT nome FROM funcionarios ORDER BY nome 
SELECT DISTINCT nome, sobrenome FROM funcionarios ORDER BY nome 
SELECT nome, sobrenome FROM funcionarios GROUP BY nome, sobrenome ORDER BY nome
  
-- CASO TENHA TABELAS COM TITULOS IGUAIS, SERÁ NECESSÁRIO DECLARAR A TABELA
SELECT * FROM funcionarios ORDER BY funcionarios.nome

-- LIMITANDO CONSULTAS

SELECT * FROM funcionarios LIMIT 3
SELECT * FROM funcionarios LIMIT 3 OFFSET 2

-- FUNCAO DE AGREGACAO

SELECT COUNT (id) FROM  funcionarios
SELECT SUM (id) FROM  funcionarios
SELECT MAX (id) FROM  funcionarios
SELECT MIN (id) FROM  funcionarios
SELECT AVG (id) FROM  funcionarios
SELECT ROUND(AVG (id),2) FROM  funcionarios

SELECT  COUNT (id),
		SUM (id),
		MAX (id),
		MIN (id),
		AVG (id),
		ROUND(AVG (id),2)
		FROM  funcionarios

SELECT nome, sobrenome, COUNT(id) FROM funcionarios GROUP BY nome, sobrenome ORDER BY nome

SELECT nome FROM funcionarios 
		    GROUP BY nome
			HAVING COUNT(nome) > 1;
	   
SELECT nome, COUNT(nome) 
			 FROM funcionarios 
		     GROUP BY nome
			 HAVING COUNT(nome) > 1;




