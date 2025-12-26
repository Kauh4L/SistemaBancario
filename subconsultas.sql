use SISTEMA_BANCARIO;
-- SUBCONSULTAS:

/* SUBCONSULTA 1
objetivo : consultar qual cliente tem o maior saldo no banco */

SELECT
    c.primeiroNome,
    c.sobreNome,
    co.numeroConta,
    co.saldo
FROM Cliente c 
INNER JOIN Conta co 
ON c.IdCliente = co.IdCliente 
WHERE co.saldo = ( 
    SELECT MAX(saldo)  /*subconsulta que vai pegar o maior valor na coluna saldo*/
    FROM Conta
);

/* SUBCONSULTA 2
objetivo : consultar quais empréstimos possuem o status ativo */
SELECT 
	IdEmprestimo, 
    ValorEmpr, 
    DataContratacao 
FROM Emprestimo 
WHERE statusEmp IN ( 
	SELECT 'ativo'  /*subconsulta que vai pegar na coluna statusEmp todos que estão 'Ativo'*/
);

/* SUBCONSULTA 3
objetivo : consultar qual é o empréstimo contratado com o menor valor */

SELECT 
    e.IdEmprestimo,
    e.ValorEmpr,
    e.DataContratacao,
    e.statusEmp,
    te.nomeTipo
FROM Emprestimo e
INNER JOIN TipoEmprestimo te 
ON e.IdTipoEmprestimo = te.idTipoEmprestimo
WHERE e.ValorEmpr = (
    SELECT MIN(ValorEmpr)  /*subconsulta que vai pegar o menor valor na coluna ValorEmpr*/
    FROM Emprestimo
);


/* SUBCONSULTA 4
objetivo : consultar quais contas possuem mais de uma chave pix cadastrada */

SELECT 
    IdConta,
    numeroConta,
    saldo
FROM Conta
WHERE IdConta IN (
    SELECT IdConta     /* subconsulta que traz somente contas com mais de 1 chave */
    FROM Chave_pix
    GROUP BY IdConta
    HAVING COUNT(*) > 1
); 


INSERT INTO transacao (TipoTransacao, Valor, DataTrans, conta_origem, conta_Final) VALUES
(1, 100.00, '2024-10-01 17:00:00', 1001, 1003);

/* SUBCONSULTA 5
objetivo : consultar qual cliente realizou mais transações */

SELECT 
    c.IdCliente,
    c.primeiroNome,
    c.sobreNome
FROM Cliente c
JOIN Conta ct ON ct.IdCliente = c.IdCliente
JOIN (
    SELECT conta_origem    /* subconsulta que encontra a conta com maior número de transações*/
    FROM transacao
    GROUP BY conta_origem
    ORDER BY COUNT(*) DESC
    LIMIT 1
) AS top_conta
ON top_conta.conta_origem = ct.IdConta;

