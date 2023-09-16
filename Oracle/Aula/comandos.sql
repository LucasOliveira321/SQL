--TABELA CLIENTE
select * from TABELA_DE_CLIENTES;
select * from TABELA_DE_CLIENTES where data_de_nascimento >= to_date('14/11/1995','DD/MM/YYYY');
select * from TABELA_DE_CLIENTES where IDADE BETWEEN 18 AND 22;
select * from TABELA_DE_CLIENTES where NOME LIKE '%Silva%';
select cidade, round(avg(idade),2) from TABELA_DE_CLIENTES GROUP BY cidade;

-- HAVING FAZ FILTROS CONDICIONAIS DO RESULTADO QUE É FEITO DO SELEC, PORTANTO ELE FICA NO FINAL
select estado, sum(limite_de_credito) from TABELA_DE_CLIENTES group by estado having sum(limite_de_credito) >= 900000;
select distinct tc.bairro from tabela_de_clientes tc union select distinct tv.bairro from tabela_de_vendedores tv;
select distinct tc.bairro from tabela_de_clientes tc union all select distinct tv.bairro from tabela_de_vendedores tv;
select * from tabela_de_clientes where bairro in (select distinct bairro from tabela_de_vendedores);


--TABELA PRODUTO
select * from TABELA_DE_PRODUTOS;
select * from TABELA_DE_PRODUTOS where sabor in ('Manga', 'Laranja', 'Melancia') and tamanho = '1 Litro';
select * from TABELA_DE_PRODUTOS where sabor in ('Manga', 'Laranja', 'Melancia') and (preco_de_lista between 8 and 15);
select distinct embalagem from TABELA_DE_PRODUTOS;
select rownum, p.* from TABELA_DE_PRODUTOS p where rownum <= 4;
select nome_do_produto, preco_de_lista, 
    (case when preco_de_lista >= 12 then 'PRODUTO CARO' 
          when preco_de_lista >= 7 and preco_de_lista < 12 then 'PRODUTO EM CONTA' 
          ELSE 'PRODUTO BARATO' END) AS CLASSIFICACAO 
from TABELA_DE_PRODUTOS;

select
    nf.matricula, 
    tv.nome, 
    count(*) as "numeros de notas"
from 
    notas_fiscais nf
inner join tabela_de_vendedores tv on tv.matricula = nf.matricula
group by nf.matricula, tv.nome;


--VIEW
create view vw_soma_embalagens as 
select embalagem, sum(preco_de_lista) as soma_preco
from tabela_de_produtos group by embalagem;

select * from vw_soma_embalagens;

--FUNÇOÕES PARA TEXTO
select nome, lower(nome) from tabela_de_clientes; 
select nome, upper(nome) from tabela_de_clientes;
select nome, initcap(nome) from tabela_de_clientes;
select endereco_1 , bairro, concat(concat(endereco_1, ', '), bairro) from tabela_de_clientes;
select endereco_1 || ' ' || bairro || ' ' || cidade || ' ' || estado || ' - ' || cep from tabela_de_clientes;
select nome_do_produto, lpad(nome_do_produto, 70,'*') from tabela_de_produtos;
select nome_do_produto, rpad(nome_do_produto, 70,'*') from tabela_de_produtos;
select nome_do_produto, substr(nome_do_produto,3,5) from tabela_de_produtos;
select nome_do_produto, instr(nome_do_produto,'Campo') from tabela_de_produtos;
-- dual é um tabela que não existe no banco de dados
-- LTRIM tira espaço da esquerda, RTRIM da direita e TRIM dos dois lados
select '       lucas    ', ltrim('       lucas    ') from dual; 
select '       lucas    ', rtrim('       lucas    ') from dual; 
select '       lucas    ', trim('       lucas    ') from dual; 
select nome_do_produto, replace(nome_do_produto, 'Litro', 'L') from tabela_de_produtos;


--FUNÇOÕES PARA DATA

-- SIMBOLOS

-- D - DIA DA SEMANA
-- DD - DIA DO MÊS
-- DDD - NÚMERO DO DIA NO ANO
-- DAY - DIA POR EXTENSO
-- MM - MÊS DO ANO
-- MON - MÊS ABREVIADO
-- MONTH - MÊS POR EXTENSO
-- YYYY - ANO COM 4 DÍGITOS
-- YY - ANO COM 2 DÍGITOS
-- ( / * - ) - SÃO SIMBOLOS QUE PODEM SER UTILIZADOS PARA SEPARAR DATA 
-- HH - HORA COM DOIS DÍGITOS
-- HH12 - HORA DE 0 A 12
-- HH24 - HORA DE 0 A 24
-- MI - MINUTO
-- SS - SEGUNDO
select sysdate from dual;
select sysdate+127 from dual;
select to_char(sysdate, 'DD/MM/YYYY') from dual;
select to_char(sysdate, 'YYYY/MM/DD') from dual;
select to_char(sysdate, 'DD/MM/YYYY HH:MM:SS') from dual;
select nome, idade, round(months_between(sysdate, tc.data_de_nascimento)/12,1) as idade_atual from TABELA_DE_CLIENTES tc;
select add_months(sysdate,10) from dual;
select sysdate, next_day(sysdate, 'sexta') from dual;
select sysdate, last_day(sysdate) from dual;
select sysdate, trunc(sysdate, 'month') from dual;
select extract(month from to_date('05/09/2023','dd/mm/yyyy')) from dual;

--FUNÇOÕES MATEMÁTICAS
select ceil(3.6) from dual;
select floor(3.6) from dual;
select power(10,4) from dual;
select exp(2) from dual;
select sqrt(64) from dual;
select abs(-10) from dual;
select mod(10,6) from dual;
select to_char(1234.655, '9999.99') from dual;
select NVL(NULL, 0) from dual;

-- TRIGGER

-- AO INSERIR ITENS NA TABELA ITENS_NOTAS, SERÁ 
-- DELETADO A TABELA TAB_FATURAMENTO, E CRIADO 
-- NOVAMENTE A MESMA TABLEA COM OS DADOS ATUALIZADOS
-- CASO QUEIRA DELETAR A TRIGGER É "DROP TRIGGER TG_TAB_FATURAMENTO"
CREATE TRIGGER TG_TAB_FATURAMENTO
AFTER INSERT ON ITENS_NOTAS
BEGIN
DELETE FROM TAB_FATURAMENTO;
INSERT INTO TAB_FATURAMENTO
SELECT
N.DATA_VENDA, SUM(ITN.QUANTIDADE * ITN.PRECO), AS FATURAMENTO
FROM
NOTAS N
INNER JOIN
ITENS_NOTAS ITN
ON N.NUMERO = ITN.NUMERO
GROUP BY N.DATA_VENDA;
END;

-- AGORA A TRIGGER SERÁ EXECUTADA SEMPRE QUE EU TIVER
-- AS OPERAÇÕES DE ALTERAÇÃO NA TRIGGER "REPLACE" E
-- SEMPRE QUANDO TIVER INSERT, UPDATE OU DELETE NA TABELA ITENS_NOTAS
CREATE OR REPLACE TRIGGER TG_TAB_FATURAMENTO
AFTER INSERT OR UPDATE OR DELETE ON ITENS_NOTAS
BEGIN
DELETE FROM TAB_FATURAMENTO;
INSERT INTO TAB_FATURAMENTO
SELECT
N.DATA_VENDA, SUM(ITN.QUANTIDADE * ITN.PRECO), AS FATURAMENTO
FROM
NOTAS N
INNER JOIN
ITENS_NOTAS ITN
ON N.NUMERO = ITN.NUMERO
GROUP BY N.DATA_VENDA;
END;

--CRIANDO UM USUARIO
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER lucas IDENTIFIED BY lucas DEFAULT TABLESPACE USERS;
-- DANDO ACESSO TOTAL AO USUARIO CRIADO
GRANT CONNECT, RESOURCE TO LUCAS;
-- ADICIONANDO UMA COTA ILIMITADA DE TAMANHO DA TABLESPACE (AREA DE TRABALHO)
ALTER USER lucas QUOTA UNLIMITED ON USERS;
