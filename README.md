<h1>Transação de BD (ACID)</h1>
<ul>
    <li>
        <details>
            <summary>A - Atomicidade</summary>
            <p>Seria a garantia de que a transação será feita totalmente ou não será feita. Nesse caso, a transação não é feita “pela metade”. Se por ventura uma operação da transação falhar, consequentemente, toda a transação falhará.</p>
        </details>
    </li>
    <li>
        <details>
            <summary>C - Consistência</summary>
            <p>Seria a proteção da integridade dos dados. Ou seja, se um banco de dados fizer uma operação que não seja válida, o processo será impedido e retornará para o estado inicial do processo.</p>
        </details>
    </li>
    <li>
        <details>
            <summary>I - Isolamento</summary>
            <p>A capacidade de isolamento seria o fato de uma transação não “atrapalhar” a outra e ocorrer de forma isolada, garantindo que sejam feitas de forma individual.</p>
        </details>
    </li>
    <li>
        <details>
            <summary>D - Durabilidade</summary>
            <p>Seria a preservação dos dados após as operações terem sido realizadas. Ou seja, uma vez que uma transação for efetuada, ela permanecerá dessa forma, mesmo que ocorram problemas graves no sistema, sem precisar de retrabalho.</p>
        </details>
    </li>
</ul>
<h2>Conjuntos de Comandos SQL</h2>
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
