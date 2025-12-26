USE SISTEMA_BANCARIO;
-- 1. Apagar procedure antiga, se existir
DROP PROCEDURE IF EXISTS CriarConta;
-- 2. Criar procedure para criar conta
CREATE PROCEDURE CriarConta(
   IN p_cliente_id INT,
   IN p_num_conta VARCHAR(50),
   IN p_agencia VARCHAR(7),
   IN p_tipo_conta VARCHAR(20)
)
BEGIN
   -- Verifica se o cliente existe
   IF NOT EXISTS (SELECT 1 FROM Cliente WHERE IdCliente = p_cliente_id) THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente não encontrado';
   END IF;
   -- Valida tipo de conta
   IF p_tipo_conta NOT IN ('Corrente', 'Poupanca', 'Salario') THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de Conta Inválido';
   END IF;
   -- Verifica se o número da conta já existe
   IF EXISTS (SELECT 1 FROM Conta WHERE numeroConta = p_num_conta) THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Número já cadastrado';
   END IF;
   -- Insere a nova conta
   INSERT INTO Conta (IdCliente, numeroConta, agencia, tipoConta, saldo, StatusConta)
   VALUES (p_cliente_id, p_num_conta, p_agencia, p_tipo_conta, 0.00, 'ativa');
END;

-- 3. Inserir um cliente novo
INSERT INTO Cliente (email, nacionalidade, primeiroNome, sobreNome, logradouro, bairro, numCasa, complementoEnd, cidade, Uf)
VALUES ('teste1@gmail.com', 'Brasileira', 'Teste', 'Cliente', 'Rua A', 'Centro', 101, NULL, 'Teresina', 'PI');

-- 4. Capturar o ID do cliente recém-criado
SET @novo_cliente_id = LAST_INSERT_ID();

-- 5. Criar conta para o cliente recém-criado
CALL CriarConta(@novo_cliente_id, '00007-1', '0001-9', 'Corrente');

-- 6. Verificar se a conta foi criada
SELECT * FROM Conta WHERE IdCliente = @novo_cliente_id;
DROP PROCEDURE IF EXISTS AtualizarSaldo;

CREATE PROCEDURE AtualizarSaldo(
   IN p_idConta INT,
   IN p_valor DECIMAL(13,2),
   IN p_tipoOperacao varchar(10)
)
BEGIN
   DECLARE saldo_atual DECIMAL(13,2);
   -- Verifica se a conta existe
   IF NOT EXISTS (SELECT 1 FROM Conta WHERE IdConta = p_idConta) THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Conta não encontrada';
   END IF;
   -- Pega o saldo atual
   SELECT saldo INTO saldo_atual FROM Conta WHERE IdConta = p_idConta;
   -- Atualiza saldo
   IF p_tipoOperacao = 'credito' THEN
       UPDATE Conta
       SET saldo = saldo + p_valor
       WHERE IdConta = p_idConta;
   ELSEIF p_tipoOperacao = 'debito' THEN
       IF saldo_atual < p_valor THEN
           SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
       ELSE
           UPDATE Conta
           SET saldo = saldo - p_valor
           WHERE IdConta = p_idConta;
       END IF;
   ELSE
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de operação inválido';
   END IF;
END;


-- Atualizar saldo da conta (exemplo crédito)
CALL AtualizarSaldo((SELECT IdConta FROM Conta WHERE IdCliente = @novo_cliente_id), 500.00, 'credito');
-- Verificar saldo atualizado
SELECT * FROM Conta WHERE IdCliente = @novo_cliente_id;
-- Atualizar saldo da conta (exemplo débito)
CALL AtualizarSaldo((SELECT IdConta FROM Conta WHERE IdCliente = @novo_cliente_id), 200.00, 'debito');
-- Verificar saldo atualizado
SELECT * FROM Conta WHERE IdCliente = @novo_cliente_id;


