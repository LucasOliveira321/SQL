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
-- SUBSTR
-- UTILIZANDO PARA FORMATAR CNPJ
SELECT SUBSTR(CNPJ,1,2) || '.' || SUBSTR(CNPJ,3,3) || '.' || SUBSTR(CNPJ,6,3) || '/' || SUBSTR(CNPJ,9,4) || '-' || SUBSTR(CNPJ,13,2) AS CNPJ_FORMATADO FROM CLIENTE;


--FUNÇÕES PARA DATA

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

-- CRIANDO FUNÇÕES

create or replace FUNCTION categoria_cliente
(p_FATURAMENTO IN CLIENTE.FATURAMENTO_PREVISTO%type)
RETURN CLIENTE.CATEGORIA%type
IS
   v_CATEGORIA CLIENTE.CATEGORIA%type;
BEGIN
   IF p_FATURAMENTO <= 10000 THEN
     v_CATEGORIA := 'PEQUENO';
  ELSIF p_FATURAMENTO <= 50000 THEN
     v_CATEGORIA := 'MÉDIO';
  ELSIF p_FATURAMENTO <= 100000 THEN
     v_CATEGORIA := 'MÉDIO GRANDE';
  ELSE
     v_CATEGORIA := 'GRANDE';
  END IF;
  RETURN v_CATEGORIA;
END;

create or replace FUNCTION obter_descricao_segmercado
(p_ID IN SEGMERCADO.ID%type)
RETURN SEGMERCADO.DESCRICAO%type
IS
   v_DESCRICAO SEGMERCADO.DESCRICAO%type;
BEGIN
    SELECT DESCRICAO INTO v_DESCRICAO FROM SEGMERCADO WHERE ID = p_ID;
    RETURN v_DESCRICAO;
END;

create or replace FUNCTION RETORNA_CATEGORIA
(p_COD IN produto_exercicio.cod%type)
RETURN produto_exercicio.categoria%type
IS
   v_CATEGORIA produto_exercicio.categoria%type;
BEGIN
    SELECT CATEGORIA INTO v_CATEGORIA FROM PRODUTO_EXERCICIO WHERE COD = p_COD;
    RETURN v_CATEGORIA;
END;

create or replace FUNCTION RETORNA_IMPOSTO 
(p_COD_PRODUTO produto_venda_exercicio.cod_produto%type)
RETURN produto_venda_exercicio.percentual_imposto%type
IS
   v_CATEGORIA produto_exercicio.categoria%type;
   v_IMPOSTO produto_venda_exercicio.percentual_imposto%type;
BEGIN
    v_CATEGORIA := retorna_categoria(p_COD_PRODUTO);
    IF TRIM(v_CATEGORIA) = 'Sucos de Frutas' THEN
        v_IMPOSTO := 10;
    ELSIF  TRIM(v_CATEGORIA) = 'Águas' THEN
        v_IMPOSTO := 20;
    ELSIF  TRIM(v_CATEGORIA) = 'Mate' THEN
        v_IMPOSTO := 15;
    END IF;
    RETURN v_IMPOSTO;
END;

-- CRIANDO PROCEDURE

create or replace PROCEDURE ALTERANDO_CATEGORIA_PRODUTO 
(p_COD produto_exercicio.cod%type
, p_CATEGORIA produto_exercicio.categoria%type)
IS
BEGIN
   UPDATE PRODUTO_EXERCICIO SET CATEGORIA = p_CATEGORIA WHERE COD = P_COD;
   COMMIT;
END;

create or replace PROCEDURE EXCLUINDO_PRODUTO  
(p_COD produto_exercicio.cod%type)
IS
BEGIN
   DELETE FROM PRODUTO_EXERCICIO WHERE COD = P_COD;
   COMMIT;
END;

create or replace PROCEDURE INCLUINDO_DADOS_VENDA 
(
p_ID produto_venda_exercicio.id%type,
p_COD_PRODUTO produto_venda_exercicio.cod_produto%type,
p_DATA produto_venda_exercicio.data%type,
p_QUANTIDADE produto_venda_exercicio.quantidade%type,
p_PRECO produto_venda_exercicio.preco%type
)
IS
   v_VALOR produto_venda_exercicio.valor_total%type;
   v_PERCENTUAL produto_venda_exercicio.percentual_imposto%type;
BEGIN
   v_PERCENTUAL := retorna_imposto(p_COD_PRODUTO);
   v_VALOR := p_QUANTIDADE * p_PRECO;
   INSERT INTO PRODUTO_VENDA_EXERCICIO 
   (id, cod_produto, data, quantidade, preco, valor_total, percentual_imposto) 
   VALUES 
   (p_ID, p_COD_PRODUTO, p_DATA, p_QUANTIDADE, p_PRECO, v_VALOR, v_PERCENTUAL);
    COMMIT;
END; 

create or replace PROCEDURE INCLUINDO_PRODUTO 
(p_COD produto_exercicio.cod%type
, p_DESCRICAO produto_exercicio.descricao%type
, p_CATEGORIA produto_exercicio.categoria%type)
IS
BEGIN
   INSERT INTO PRODUTO_EXERCICIO (COD, DESCRICAO, CATEGORIA) VALUES (p_COD, REPLACE(p_DESCRICAO,'-','>')
   , p_CATEGORIA);
   COMMIT;
END;

create or replace PROCEDURE incluir_cliente
(
p_ID CLIENTE.ID%type,
p_RAZAO CLIENTE.RAZAO_SOCIAL%type,
p_CNPJ CLIENTE.CNPJ%type,
p_SEGMERCADO CLIENTE.SEGMERCADO_ID%type,
p_FATURAMENTO CLIENTE.FATURAMENTO_PREVISTO%type
)
IS
  v_CATEGORIA CLIENTE.CATEGORIA%type;
BEGIN

   v_CATEGORIA := categoria_cliente(p_FATURAMENTO);

   INSERT INTO CLIENTE
   VALUES 
   (p_ID, p_RAZAO, p_CNPJ, p_SEGMERCADO, SYSDATE, p_FATURAMENTO, v_CATEGORIA);
   COMMIT;
END;

create or replace PROCEDURE incluir_segmercado
(p_ID IN SEGMERCADO.ID%type, p_DESCRICAO IN SEGMERCADO.DESCRICAO%type)
IS
BEGIN
   INSERT INTO SEGMERCADO (ID, DESCRICAO) VALUES (p_ID, UPPER(p_DESCRICAO));
   COMMIT;
END;