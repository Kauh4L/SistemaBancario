USE DATABASE SISTEMA_BANCARIO;
USE SISTEMA_BANCARIO;
-- 5. REALIZAÇÃO DAS CONSULTAS E SUBCONSULTAS

/* CONSULTA 1
objetivo : consultar todos os dados dos clientes pessoas físicas, incluindo informações pessoais, suas contas e respectivos saldos*/
SELECT 
    c.IdCliente,
    c.primeiroNome,
    c.sobreNome,
    c.email,
    pf.cpf,
    pf.data_nasc,
    co.IdConta,
    co.numeroConta,
    co.agencia,
    co.tipoConta,
    co.saldo,
    co.StatusConta
FROM Cliente c
INNER JOIN PessoaFis pf 
ON c.IdCliente = pf.Cliente 
INNER JOIN Conta co ON c.IdCliente = co.IdCliente
ORDER BY co.saldo DESC;


/* CONSULTA 2
objetivo : listar todas as chaves PIX com os dados do dono da conta*/
SELECT 
    cp.IdChavePix,
    cp.tipoDeChave,
    cp.chave,
    cp.ativa,
    c.primeiroNome,
    c.sobreNome,
    c.email,
    co.numeroConta,
    co.agencia,
    co.saldo
FROM Chave_pix cp
INNER JOIN Conta co ON cp.IdConta = co.IdConta
INNER JOIN Cliente c ON co.IdCliente = c.IdCliente
WHERE cp.ativa = TRUE
ORDER BY cp.tipoDeChave;


/* CONSULTA 3
objetivo : consultar todos os empréstimos com o status 'ativo', mostrando os dados da conta, o valor do empréstimo, a taxa de juros e o nome do cliente associado*/
SELECT
    e.IdEmprestimo,
    CONCAT(c.primeiroNome, ' ', c.sobreNome) AS Nome_Cliente,
    co.numeroConta,
    co.agencia,
    te.nomeTipo AS Tipo_Emprestimo,
    e.ValorEmpr,
    e.taxaJuros,
    e.quantParcelas,
    e.valorParcela,
    e.DataContratacao
FROM Emprestimo e
INNER JOIN Conta co ON e.IdConta = co.IdConta
INNER JOIN Cliente c ON co.IdCliente = c.IdCliente
INNER JOIN TipoEmprestimo te ON e.IdTipoEmprestimo = te.idTipoEmprestimo
WHERE e.statusEmp = 'ativo'
ORDER BY e.DataContratacao;


/* CONSULTA 4
objetivo : listar todos os clientes Pessoa Jurídica (PJ), mostrando a razão social, CNPJ e todos os seus números de telefone registrados*/
SELECT
    pj.razao_social,
    pj.cnpj,
    c.email,
    t.numero AS Telefone
FROM pessoaJur pj
INNER JOIN Cliente c ON pj.Cliente = c.IdCliente
LEFT JOIN Telefone t ON c.IdCliente = t.IdCliente -- LEFT JOIN para incluir PJs que não têm telefone cadastrado
ORDER BY pj.razao_social ASC;

