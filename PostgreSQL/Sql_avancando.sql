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

SELECT NOW()
SELECT NOW(), NOW() - interval '3 hours 15 minutes' AS past
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
SELECT EXTRACT(YEAR FROM data_time) AS ano FROM aluno;
SELECT EXTRACT(MONTH FROM data_time) AS mes FROM aluno;
SELECT EXTRACT(HOUR FROM data_time) AS hora FROM aluno;
SELECT EXTRACT(DAY FROM data_time) AS dia FROM aluno;
SELECT EXTRACT(MINUTE FROM data_time) AS minuto FROM aluno;

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
	
-- CASE WHEN, THEN, ELSE, END

SELECT
	usuario.matricula,
	usuario.nome,
	CASE 
		WHEN hora.tipo_hora = 'Sobreaviso' THEN '3016'
		WHEN hora.tipo_hora = 'Extra' AND EXTRACT(HOUR FROM hora.data_hora_inicial) >= 6 AND EXTRACT(HOUR FROM hora.data_hora_inicial) <= 22 AND EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600 <= 2 THEN '1601'
		WHEN hora.tipo_hora = 'Extra' AND EXTRACT(HOUR FROM hora.data_hora_inicial) >= 6 AND EXTRACT(HOUR FROM hora.data_hora_inicial) <= 22 AND EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600 > 2 THEN CONCAT('2h 1601 E ',EXTRACT(EPOCH FROM (AGE(hora.data_hora_final,hora.data_hora_inicial))/3600)-2,'h 1602')                           
		WHEN hora.tipo_hora = 'Extra' AND EXTRACT(HOUR FROM hora.data_hora_inicial) > 22 OR EXTRACT(HOUR FROM hora.data_hora_inicial) < 6 AND EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600 <= 1 THEN CONCAT(EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600,'h 3000')
		WHEN hora.tipo_hora = 'Extra' AND EXTRACT(HOUR FROM hora.data_hora_inicial) > 22 OR EXTRACT(HOUR FROM hora.data_hora_inicial) < 6 AND EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600 > 1 THEN CONCAT('1h 3000 e ',EXTRACT(EPOCH FROM (AGE(hora.data_hora_final,hora.data_hora_inicial))/3600)-1,'h 1809')
		ELSE 'NULL' END AS verba,
	CASE 
		WHEN hora.tipo_hora = 'Sobreaviso' THEN EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600
		WHEN hora.tipo_hora = 'Extra' AND EXTRACT(HOUR FROM hora.data_hora_inicial) >= 6 AND EXTRACT(HOUR FROM hora.data_hora_inicial) <= 22 AND EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600 <= 2 THEN EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600* 1.75
		WHEN hora.tipo_hora = 'Extra' AND EXTRACT(HOUR FROM hora.data_hora_inicial) >= 6 AND EXTRACT(HOUR FROM hora.data_hora_inicial) <= 22 AND EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600 > 2 THEN  3.5 + ((EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600)-2)*2
		WHEN hora.tipo_hora = 'Extra' AND EXTRACT(HOUR FROM hora.data_hora_inicial) > 22 OR EXTRACT(HOUR FROM hora.data_hora_inicial) < 6 AND EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600 <= 1 THEN (EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600* 1.1429)*1.75
		WHEN hora.tipo_hora = 'Extra' AND EXTRACT(HOUR FROM hora.data_hora_inicial) > 22 OR EXTRACT(HOUR FROM hora.data_hora_inicial) < 6 AND EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600 > 1 THEN 1.75 + (((EXTRACT(EPOCH FROM AGE(hora.data_hora_final,hora.data_hora_inicial))/3600)-1)*1.429)*2
		ELSE 0.0 END AS horas_proporcionais,	
	hora.data_hora_inicial,
	hora.data_hora_final,
	hora.tipo_hora,
	cliente.empresa,
	cliente.responsavel,
	cliente.projeto,
	equipe.nome_equipe,
	hora.justificativa,
	hora.justificativa_status
FROM
	hora
LEFT JOIN usuario ON usuario.matricula = hora.matricula
LEFT JOIN cliente ON cliente.id_cliente = hora.id_cliente
LEFT JOIN equipe ON equipe.id_equipe = hora.id_equipe
WHERE usuario.matricula = '12345'
ORDER BY hora.data_hora_inicial
	
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
















