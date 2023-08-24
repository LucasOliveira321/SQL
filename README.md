<h1>application.properties</h1>
<div>
    <a>spring.datasource.url=jdbc:mysql://localhost:3306/tabela</a>
    <a>spring.datasource.username=username</a>
    <a>spring.datasource.password=password</a>
    <a>spring.jpa.database-platform=org.hibernate.dialect.MySQLDialect</a>
    <a>spring.jpa.show-sql=false</a>
    <a>spring.jpa.hibernate.ddl-auto=create</a>
    <a>spring.mvc.hiddenmethod.filter.enabled=true</a>
</div>

<h1>Conjuntos de Comandos SQL</h1>
<ul>
    <li>
        <details>
            <summary>DDL</summary>
            <p>São os comandos que criam o bando de dados nos servidores, criam as tabelas, altera os índices, todo comando que altera a estrutura de um banco de dados. Alguns exemplos de comando DDL são:</p>
            <p>CREATE: Comando utilizado para criar uma base de dados ou tabela no banco de dados</p>
            <p>ALTER: Altera as propriedades das estruturas de um componente do banco de dados</p>
            <p>TRUNCATE: Apaga de forma definitiva os dados de uma tabela</p>
            <p>DROP: Apaga o componente da estrutura do banco de dados</p>
        </details>
    </li>
    <li>
        <details>
            <summary>DML</summary>
            <p>São os comandos utilizados para gerenciar os dados, alterando o conteúdo dos objetos contidos no banco de dados . Alguns exemplos de comando DML são:</p>
            <p>INSERT: Incluí dados dentro de uma tabela</p>
            <p>UPDATE: Altera os dados de dentro de uma tabela</p>
            <p>DELETE: Apaga os dados de dentro da uma tabela</p>
            <p>LOCK: Gerencia a concorrência de atualização de dados na mesma tabela</p>
        </details>
    </li>
    <li>
        <details>
            <summary>DCL</summary>
            <p>São os comandos que nos permite administrar o banco de dados, mas não a estrutura e sim o ambiente, como administração dos usuarios, como os dados serão armazenados no disco da máquina. Alguns exemplos de comando DCL são:</p>
            <p>COMMIT: Salva o estado do banco de dados de forma definitiva no disco da máquina</p>
            <p>ROLLBACK: Retorna um estado salvo préviamente no banco de dados</p>
            <p>SAVEPOINT: Salva o ponto prévio no banco de dados</p>
        </details>
    </li>
</ul>
