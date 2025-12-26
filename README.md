# Sistema Bancário – Banco de Dados

Este projeto consiste na implementação de um **Sistema Bancário** utilizando **SQL (MySQL/MariaDB)**, desenvolvido e testado no **DBeaver**.  
O objetivo é simular o funcionamento básico de um banco digital, aplicando conceitos de **modelagem de dados, relacionamentos e regras de negócio** diretamente no banco de dados.

---

## Objetivo

- Praticar **Banco de Dados Relacional**
- Aplicar **chaves primárias, estrangeiras e constraints**
- Modelar um sistema bancário próximo do mundo real
- Consolidar conhecimentos acadêmicos em SQL

---

## Tecnologias Utilizadas

- MySQL / MariaDB  
- DBeaver  
- SQL

---

## Estrutura do Banco de Dados

### Cliente
Armazena os dados principais dos clientes do banco.

**Campos principais:**
- IdCliente
- Email
- Nacionalidade
- Nome e sobrenome
- Endereço completo (logradouro, bairro, número, cidade, UF)

---

### Pessoa Física
Tabela especializada para clientes pessoa física.

- CPF
- Data de nascimento
- Relacionamento 1:1 com Cliente

---

### Pessoa Jurídica
Tabela especializada para clientes pessoa jurídica.

- CNPJ
- Razão social
- Relacionamento com Cliente

---

### Telefone
Armazena telefones dos clientes.

- Número de telefone
- Relacionamento N:1 com Cliente

---

### Conta
Representa as contas bancárias.

- Número da conta
- Agência
- Tipo da conta (Corrente, Poupança, Salário)
- Saldo
- Status da conta
- Data de abertura
- Relacionamento com Cliente

---

### Chave Pix
Gerencia as chaves PIX associadas às contas.

- Tipo de chave (CPF, CNPJ, Email, Telefone, Aleatória)
- Chave
- Conta associada
- Status da chave

---

### Transação
Registra movimentações financeiras.

- Tipo de transação
- Valor
- Data da transação
- Conta de origem
- Conta de destino (quando houver)

---

### Histórico
Armazena descrições e registros das transações.

- Descrição
- Data e hora
- Usuário responsável

---

### Empréstimo
Gerencia empréstimos bancários.

- Tipo de empréstimo
- Valor
- Prazo
- Taxa de juros
- Quantidade de parcelas
- Valor final pago
- Status do empréstimo

---

### Comprovante Pix
Registra comprovantes de transferências via PIX.

- Valor transferido
- Conta e banco de destino
- Data do PIX

---

## Como Executar

1. Abrir o **DBeaver**
2. Criar uma conexão com MySQL ou MariaDB
3. Executar o script SQL completo utilizando:
   - **Ctrl + Alt + X** (Executar Script)
4. O banco `SISTEMA_BANCARIO` será criado automaticamente

---

## Contexto Acadêmico

Projeto desenvolvido para fins educacionais, com foco em:
- Banco de Dados
- Modelagem relacional
- SQL aplicado a sistemas reais

---

## Autores

**Kauhã Almeida**  
**Ingrid Bezerra**  
**Milena Picaço**  
Estudante de Ciência da Computação  
Interesse em Banco de Dados, Dados e Sistemas

---

 *Projeto com finalidade acadêmica.*
