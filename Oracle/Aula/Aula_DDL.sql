create table cliente(
    cli_cod integer CONSTRAINT pk_cliente_cli_cod Primary Key,
    cli_nome varchar(30),
    cli_ativo number(2) default 1,
    cli_data_nasc date);
    
select 
    constraint_name,
    constraint_type,
    status,
    search_condition 
from 
    user_constraints
where
    table_name = 'CLIENTE';
    
    select * from cliente;
    
insert into cliente (cli_cod, cli_nome, cli_ativo, cli_data_nasc) values (1,'Joao',1,'15/05/1996');