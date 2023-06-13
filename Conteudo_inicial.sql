-- MODELOS DE TABELA

CREATE TABLE aluno(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	cpf CHAR(11),
	observacao TEXT,
	idade INTEGER,
	dinheiro NUMERIC(10,2),
	altura REAL,
	ativo BOOLEAN,
	data_nascimento DATE,
	hora_aula TIME,
	matriculado_em TIMESTAMP
);
CREATE TABLE hora(

	id_hora SERIAL PRIMARY KEY,
	matricula VARCHAR(50) NOT NULL,
	data_hora_inicial TIMESTAMP NOT NULL,
	data_hora_final TIMESTAMP NOT NULL,
	justificativa VARCHAR(200),
	id_equipe INTEGER NOT NULL,
	tipo_hora VARCHAR(30) NOT NULL,
	id_cliente INTEGER,
	status VARCHAR(50),
	justificativa_status VARCHAR(200),

	FOREIGN KEY (matricula)
	REFERENCES usuario (matricula)
	ON DELETE CASCADE
	ON UPDATE CASCADE,

	FOREIGN KEY (id_equipe)
	REFERENCES equipe (id_equipe)
	ON DELETE CASCADE
	ON UPDATE CASCADE,

	FOREIGN KEY (id_cliente)
	REFERENCES cliente (id_cliente)
	ON DELETE CASCADE
	ON UPDATE CASCADE

);

-- INSERT's

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

INSERT INTO aluno (primeiro_nome, ultimo_nome, data_nascimento) VALUES ('Lucas',    'Souza',     '1996/05/15'),
																	   ('João',     'Berto',     '1978/04/10'),
																	   ('Malaquias','Silva',     '1990/08/18'),
																	   ('Maria',    'Oliveira',  '1992/03/19'),
																	   ('Fernando', 'Morai',     '1988/11/30'),
																	   ('Jefferson','Aparecido', '1980/02/28');

-- ALTERANDO VALORES DA TABELA

UPDATE aluno SET nome = 'Lucas Oliveira', matriculado_em = '2023-03-25 20:12:00' WHERE id = 1;

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

SELECT 
	aluno.nome AS "Aluno",
	curso.nome AS "Curso" 
FROM 
	aluno
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

-- ORDER BY / DESC & ASC / DISTINCT / GROUP BY

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