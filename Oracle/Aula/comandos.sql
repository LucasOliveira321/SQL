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
