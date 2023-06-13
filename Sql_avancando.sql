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

-- OVER PARTITION BY (ACUMULADO)

SELECT 
	DISTINCT produto.descricao,
	SUM(material_apontado.quilograma) AS kg,
	CONCAT('R$ ',ROUND(AVG(tabela_preco.valor_prod) OVER(PARTITION BY tabela_preco.cod_prod),2)) AS vlr,
	CONCAT('R$ ',ROUND(SUM(material_apontado.quilograma) * AVG(tabela_preco.valor_prod) OVER(PARTITION BY tabela_preco.cod_prod),2)) AS fat
FROM
	material_apontado
LEFT JOIN produto ON produto.cod_prod = material_apontado.cod_prod
LEFT JOIN tabela_preco ON tabela_preco.cod_prod = produto.cod_prod
LEFT JOIN mes ON mes.mes = tabela_preco.mes 
LEFT JOIN ano ON ano.ano = tabela_preco.ano
WHERE material_apontado.id_equipamento = 1 AND mes.mes_valor >= 1 AND mes.mes_valor <= 5 AND ano.ano_valor = 2023 
GROUP BY
	produto.descricao,
	tabela_preco.valor_prod,
	tabela_preco.cod_prod

-- FROM SELECT

SELECT CONCAT('R$ ',SUM(apont.fat)) AS total FROM
	(SELECT DISTINCT produto.descricao,
		SUM(material_apontado.quilograma) AS kg,
		ROUND(AVG(tabela_preco.valor_prod) OVER(PARTITION BY tabela_preco.cod_prod),2) AS vlr,
		ROUND(SUM(material_apontado.quilograma) * AVG(tabela_preco.valor_prod) OVER(PARTITION BY tabela_preco.cod_prod),2) AS fat
	FROM material_apontado
	LEFT JOIN produto ON produto.cod_prod = material_apontado.cod_prod
	LEFT JOIN tabela_preco ON tabela_preco.cod_prod = produto.cod_prod
	LEFT JOIN mes ON mes.mes = tabela_preco.mes 
	LEFT JOIN ano ON ano.ano = tabela_preco.ano
	WHERE material_apontado.id_equipamento = 1 AND mes.mes_valor >= 1 AND mes.mes_valor <= 5 AND ano.ano_valor = 2023 
	GROUP BY produto.descricao,tabela_preco.valor_prod,tabela_preco.cod_prod) AS apont;
	
-- WITH AS (CTE)

WITH apont AS
(SELECT DISTINCT produto.descricao,
		SUM(material_apontado.quilograma) AS kg,
		ROUND(AVG(tabela_preco.valor_prod) OVER(PARTITION BY tabela_preco.cod_prod),2) AS vlr,
		ROUND(SUM(material_apontado.quilograma) * AVG(tabela_preco.valor_prod) OVER(PARTITION BY tabela_preco.cod_prod),2) AS fat
	FROM material_apontado
	LEFT JOIN produto ON produto.cod_prod = material_apontado.cod_prod
	LEFT JOIN tabela_preco ON tabela_preco.cod_prod = produto.cod_prod
	LEFT JOIN mes ON mes.mes = tabela_preco.mes 
	LEFT JOIN ano ON ano.ano = tabela_preco.ano
	WHERE material_apontado.id_equipamento = 4 AND mes.mes_valor >= 1 AND mes.mes_valor <= 5 AND ano.ano_valor = 2023 
	GROUP BY produto.descricao,tabela_preco.valor_prod,tabela_preco.cod_prod)
SELECT SUM(apont.fat) FROM apont

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
















