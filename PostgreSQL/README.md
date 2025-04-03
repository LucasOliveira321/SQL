#  PostgreSQL
<h2>application.properties</h2>
<div>
    <p>spring.datasource.url=jdbc:postgresql://localhost:5432/database</p>
    <p>spring.datasource.username=postgres</p>
    <p>spring.datasource.password=password</p>
    <p>spring.mvc.hiddenmethod.filter.enabled=true</p>
    <p>spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect</p>
    <p>spring.jpa.show-sql=true</p>
    <p>spring.jpa.hibernate.ddl-auto=create</p>
</div>
<h2>Comando DUMP</h2>
<p>Comando para gerar arquivo dump do banco</p>
<li>
    export PGPASSWORD="sua_senha" && /opt/homebrew/opt/libpq/bin/pg_dump(local_do_arquivo .exe do dump) -U usuario -h host_da_aplicacao -p 5432 -F c -v -f /diretorio/para/salvar/o/arquivo_$(date +%Y-%m-%d).backup nome_do_seu_banco
</li>
<br/>

<p>Comando para subir o arquivo dump do banco</p>
<li>
    export PGPASSWORD='sua_senha' && /opt/homebrew/opt/libpq/bin/pg_restore(local_do_arquivo .exe do pg_restore) -U usuario -h host_da_aplicacao -p 5432 -d nome_do_seu_banco -v /diretorio/do/seu/arquivo/dump/arquivo_2025-01-01.backup
</li>


<h4> Os dois arquivos possuem exemplos de comandos realizados no PostgreSQL que me ajudam nas consultas de novas Query's </h4>
<h2> Conteudo_inicial.slq </h2>
- CRIAR TABELAS<br/>
- FOREIGN KEY REFERENCES, CASCADE ON DELETE, CASCADE ON UPDATE<br/>
- INSERT's<br/>
- UPDATE<br/>
- DROP, DELET<br/>
- SELECT FROM<br/>
- WHERE<br/>
- AND, IS, OR<br/>
- LIKE<br/>
- BETWEEN<br/>
- ORDER BY<br/>
- DESC, ASC
- GROUP BY<br/>
- JOIN, LEFT JOIN, RIGTH JOIN, FULL JOIN<br/>
- LIMIT<br/>
- HAVING<br/>
- ROUND<br/>
- COUNT, SUM, MAX, MIN, AVG<br/>
<h2> Sql_avancado.sql </h2>
- QUERY's MAIS ELABORADAS<br/>
- ALIAS (AS)<br/>
- CONCAT<br/>
- UPER<br/>
- FORMATAÇÃO DE DATA<br/>
- OVER PARTITION BY<br/>
- WITH CTE<br/>
- CASE WHEN, THEN, ELSE, END<br/>
- VIEW<br/>
