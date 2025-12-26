use SISTEMA_BANCARIO;
-- 4. INSERÇÃO DE DADOS EM TODAS AS TABELAS 

-- /// Inserção de Dados ////

-- // Inserção na tabela Cliente
INSERT INTO Cliente (email, nacionalidade, primeiroNome, sobreNome, logradouro, bairro, numCasa, complementoEnd, cidade, Uf) VALUES
('joao.silva@email.com', 'Brasileira', 'João', 'Silva Santos', 'Rua das Flores', 'Centro', 123, 'Apto 201', 'Teresina', 'PI'),
('maria.lima@email.com', 'Brasileira', 'Maria', 'Lima Oliveira', 'Av. Principal', 'Jockey', 456, NULL, 'Teresina', 'PI'),
('carlos.souza@email.com', 'Brasileira', 'Carlos', 'Souza Costa', 'Rua do Comércio', 'Fátima', 789, 'Casa', 'Teresina', 'PI'),
('ana.santos@email.com', 'Brasileira', 'Ana', 'Santos Pereira', 'Rua 13 de Maio', 'Redenção', 234, 'Apto 102', 'Teresina', 'PI'),
('pedro.costa@email.com', 'Brasileira', 'Pedro', 'Costa Alves', 'Av. Frei Serafim', 'Centro', 567, NULL, 'Teresina', 'PI'),
('luciana.ramos@email.com', 'Brasileira', 'Luciana', 'Ramos Ferreira', 'Rua Paissandu', 'Centro', 890, 'Sala 3', 'Teresina', 'PI');

-- // Inserção na tabela PessoaFis
INSERT INTO PessoaFis (Cliente, cpf, data_nasc) VALUES
(1, '12345678901', '1985-03-15'),
(2, '98765432109', '1990-07-22'),
(3, '45678912345', '1978-11-30'),
(4, '78945612378', '1995-05-10');

-- // Inserção na tabela pessoaJur
INSERT INTO pessoaJur (Cliente, cnpj, razao_social) VALUES
(5, '12345678000195', 'Costa Alves Comércio LTDA'),
(6, '87654321000123', 'Ramos Ferreira Serviços ME');

-- // Inserção na tabela Telefone
INSERT INTO Telefone (numero, IdCliente) VALUES
('86981234567', 1),
('86987654321', 1),
('86988111222', 2),
('86989333444', 3),
('86985555666', 4),
('86984777888', 5),
('86983999000', 6);

-- // Inserção na tabela Conta
INSERT INTO Conta (IdConta, IdCliente, numeroConta, agencia, tipoConta, saldo, StatusConta, dataAbertura) VALUES
(1001, 1, '00001-5', '0001-9', 'Corrente', 5000.00, 'ativa', '2023-01-15 10:30:00'),
(1002, 2, '00002-3', '0001-9', 'Poupanca', 12500.50, 'ativa', '2023-02-20 14:15:00'),
(1003, 3, '00003-1', '0002-7', 'Corrente', 8700.75, 'ativa', '2023-03-10 09:00:00'),
(1004, 4, '00004-9', '0002-7', 'Salario', 3200.00, 'ativa', '2023-04-05 16:45:00'),
(1005, 5, '00005-7', '0001-9', 'Corrente', 25000.00, 'ativa', '2023-05-12 11:20:00'),
(1006, 6, '00006-5', '0003-5', 'Corrente', 18500.25, 'ativa', '2023-06-18 13:30:00');

-- // Inserção na tabela Chave_pix
INSERT INTO Chave_pix (tipoDeChave, chave, IdConta, dataRegistro, ativa) VALUES
('CPF', '12345678901', 1001, '2023-01-15 11:00:00', TRUE),
('Email', 'joao.silva@email.com', 1001, '2023-01-16 14:30:00', TRUE),
('CPF', '98765432109', 1002, '2023-02-20 15:00:00', TRUE),
('Telefone', '86989333444', 1003, '2023-03-10 10:00:00', TRUE),
('CPF', '45678912345', 1003, '2023-03-11 09:30:00', TRUE),
('CNPJ', '12345678000195', 1005, '2023-05-12 12:00:00', TRUE);

-- // Inserção na tabela TipoTransacao
INSERT INTO TipoTransacao (nomeTipo, descricao) VALUES
('PIX', 'Transferência instantânea via PIX'),
('TED', 'Transferência Eletrônica Disponível'),
('DOC', 'Documento de Ordem de Crédito'),
('Depósito', 'Depósito em conta'),
('Saque', 'Retirada de dinheiro'),
('Pagamento', 'Pagamento de contas e boletos');

-- // Inserção na tabela TipoEmprestimo
INSERT INTO TipoEmprestimo (nomeTipo, descricao) VALUES
('Empréstimo Pessoal', 'Crédito pessoal'),
('Empréstimo Consignado', 'Desconto direto em folha de pagamento'),
('Financiamento Imobiliário', 'Financiamento para compra de imóveis'),
('Financiamento Veicular', 'Financiamento para compra de veículos'),
('Crédito Empresarial', 'Linha de crédito para empresas'),
('Antecipação FGTS', 'Antecipação do saque do FGTS');

-- // Inserção na tabela Emprestimo
INSERT INTO Emprestimo (IdConta, IdTipoEmprestimo, DataContratacao, statusEmp, ValorEmpr, PrazoMeses, taxaJuros, quantParcelas, valorParcela, valorFinalPago) VALUES
(1001, 1, '2024-01-10', 'ativo', 5000.00, '2026-01-10', '2.5', 24, 229.17, 0),
(1002, 3, '2024-02-15', 'ativo', 9000.00, '2029-02-15', '1.8', 60, 166.67, 0),
(1003, 1, '2024-03-20', 'quitado', 3000.00, '2024-09-20', '3.0', 6, 545.00, 3270.00),
(1004, 2, '2024-04-25', 'ativo', 7500.00, '2027-04-25', '2.2', 36, 229.17, 0),
(1005, 5, '2024-05-30', 'ativo', 8500.00, '2034-05-30', '1.5', 120, 79.17, 0),
(1006, 1, '2024-06-10', 'quitado', 2000.00, '2024-10-10', '3.5', 4, 535.00, 2140.00);

-- // Inserção na tabela Transacao
INSERT INTO transacao (TipoTransacao, Valor, DataTrans, conta_origem, conta_Final) VALUES
(1, 500.00, '2024-10-01 10:30:00', 1001, 1002),
(4, 1000.00, '2024-10-05 14:15:00', 1002, 1001),
(5, 250.00, '2024-10-10 09:20:00', 1003, NULL),
(6, 3000.00, '2024-10-15 16:45:00', 1004, NULL),
(1, 750.00, '2024-10-20 11:30:00', 1005, 1003),
(2, 1500.00, '2024-10-25 13:00:00', 1006, 1004);

-- // Inserção na tabela Historico
INSERT INTO Historico (IdTransacao, descricao, dataHora, usuarioResponsavel) VALUES
(1, 'Transferência PIX realizada com sucesso', '2024-10-01', 'João Silva Santos'),
(2, 'Depósito em conta corrente', '2024-10-05', 'Maria Lima Oliveira'),
(3, 'Saque em terminal eletrônico', '2024-10-10', 'Carlos Souza Costa'),
(4, 'Pagamento de conta de energia', '2024-10-15', 'Ana Santos Pereira'),
(5, 'Transferência PIX entre contas', '2024-10-20', 'Pedro Costa Alves'),
(6, 'Transferência TED entre bancos', '2024-10-25', 'Luciana Ramos Ferreira');

-- // Inserção na tabela comprovantePix
INSERT INTO comprovantePix (IdTransacao, valorTransf, contaDestino, bancoDeDestino, dataPix) VALUES
(1, 500.00, '00002-3', 'Banco do Brasil', '2024-10-01'),
(2, 1000.00, '00001-5', 'Banco do Brasil', '2024-10-05'),
(3, 250.00, NULL, 'Caixa Econômica', '2024-10-10'),
(4, 3000.00, NULL, 'Santander', '2024-10-15'),
(5, 750.00, '00003-1', 'Itaú Unibanco', '2024-10-20'),
(6, 1500.00, '00004-9', 'Bradesco', '2024-10-25');

-- // Inserção na tabela transacao_historico
INSERT INTO transacao_historico (IdTransacao, IdHistorico, DataHora) VALUES
(1, 1, '2024-10-01 10:30:00'),
(2, 2, '2024-10-05 14:15:00'),
(3, 3, '2024-10-10 09:20:00'),
(4, 4, '2024-10-15 16:45:00'),
(5, 5, '2024-10-20 11:30:00'),
(6, 6, '2024-10-25 13:00:00');


-- Verificar Clientes inseridos
SELECT * FROM Cliente;

-- Verificar Pessoas Físicas
SELECT * FROM PessoaFis;

-- Verificar Pessoas Jurídicas
SELECT * FROM pessoaJur;

-- Verificar Telefones
SELECT * FROM Telefone;

-- Verificar Contas
SELECT * FROM Conta;

-- Verificar Chaves PIX
SELECT * FROM Chave_pix;

-- Verificar Tipos de Transação
SELECT * FROM TipoTransacao;

-- Verificar Tipos de Empréstimo
SELECT * FROM TipoEmprestimo;

-- Verificar Empréstimos
SELECT * FROM Emprestimo;

-- Verificar Transações
SELECT * FROM transacao;

-- Verificar Histórico
SELECT * FROM Historico;

-- Verificar Comprovantes PIX
SELECT * FROM comprovantePix;

-- Verificar Transacao_Historico
SELECT * FROM transacao_historico;

