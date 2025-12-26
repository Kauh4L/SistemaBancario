drop database SISTEMA_BANCARIO;
create database SISTEMA_BANCARIO;
use SISTEMA_BANCARIO;


create table Cliente(
IdCliente int primary key not null auto_increment,
email varchar(30) not null unique,
nacionalidade varchar(10) not null,
primeiroNome varchar(12) not null,
sobreNome varchar(30) not null,
logradouro varchar(20) not null,
bairro varchar(15) not null,
numCasa int not null,
complementoEnd varchar(20),
cidade varchar(10) not null,
Uf char(2) not null,
check (char_length(uf) = 2)

);

-- /// Criando a tabela Pessoa Física  ////

create table PessoaFis(
IdPessoaFis int primary key auto_increment,
Cliente int not null,
cpf char(11) unique not null,
data_nasc date not null, 
foreign key (Cliente) references Cliente (idCliente)
on delete cascade
on update cascade,
check (char_length(cpf) = 11)
);


-- /// Criando a tabela Pessoa Jurídica  ////

create table pessoaJur (
Cliente int not null,
cnpj char(14) unique not null,
razao_social varchar(50),
foreign key (Cliente) references Cliente(IdCliente)
on delete cascade
on update cascade,
check (char_length(cnpj) = 14)
);


-- /// Criando a tabela Telefone ////

create table Telefone (
IdTelefone int primary key auto_increment,
numero char(11) not null,
IdCliente int,
foreign key (IdCliente) references Cliente(IdCliente)
on delete cascade
on update cascade,
check (char_length(numero) = 11)
);


-- /// Criando a tabela Conta ////

create table Conta(
IdConta int primary key not null auto_increment,
IdCliente int not null,
numeroConta varchar(20) unique not null,
agencia varchar(7) not null,
tipoConta enum('Corrente', 'Poupanca', 'Salario')not null,
saldo decimal(13, 2) not null default 0.00,
StatusConta enum('ativa', 'inativa', 'bloqueada') default 'ativa',
dataAbertura timestamp default current_timestamp, 

foreign key(IdCliente) references Cliente(IdCliente)
	on delete restrict
	on update cascade,

check (saldo >= 0)
);


-- /// Criando a tabela Chave Pix ////

CREATE TABLE Chave_pix(
    IdChavePix INT PRIMARY KEY AUTO_INCREMENT,
    tipoDeChave ENUM('CPF', 'CNPJ', 'Email', 'Telefone', 'Aleatoria'),
    chave VARCHAR(100) NOT NULL UNIQUE,
    IdConta INT NOT NULL,
    dataRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativa TINYINT(1) DEFAULT 1,
    FOREIGN KEY (IdConta) REFERENCES Conta(IdConta)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



-- /// Criando a tabela Tipo de Transação ////

create table TipoTransacao(
IdTipoTransacao int primary key auto_increment,
nomeTipo varchar(30) unique not null,
descricao text
);


-- /// Criando a tabela Transação////

create table transacao(
IdTransacao int primary key not null auto_increment,
TipoTransacao int not null,
Valor decimal(10, 2),
DataTrans timestamp, 
conta_origem int not null,
conta_Final int,

foreign key(conta_origem) references Conta(IdConta)
	on delete restrict
	on update cascade,
foreign key(conta_Final) references Conta(IdConta)
	on delete restrict
    on update cascade,
foreign key(TipoTransacao) references TipoTransacao(IdTipoTransacao)
	on delete restrict
    on update cascade,
 
 check (valor > 0)
);



-- /// Criando a tabela Histórico ////

create table Historico(
IdHistorico int primary key auto_increment,
IdTransacao int not null,
descricao text not null,
dataHora date,
usuarioResponsavel varchar(50),

foreign key(IdTransacao) references transacao(IdTransacao)
	on delete cascade
	on update cascade
);

-- /// Criando tabela (resultado do relacionamento Transação - Histórico) ////

create table transacao_historico(
IdTransacao int,
IdHistorico int,
DataHora timestamp
);



-- /// Criando a tabela Tipo de Empréstimo ////

create table TipoEmprestimo(
idTipoEmprestimo int primary key auto_increment,
nomeTipo varchar(30) unique,
descricao TEXT
);



-- /// Criando a tabela Emprestimo////

create table Emprestimo(
IdEmprestimo int primary key not null auto_increment,
IdConta int not null ,
IdTipoEmprestimo int not null,
DataContratacao date,
statusEmp enum ('solicitado', 'aprovado', 'ativo', 'quitado', 'inadimplente') default 'solicitado',
ValorEmpr decimal(6, 2),
PrazoMeses date,
taxaJuros varchar(5) default 20,
quantParcelas int,
valorParcela DECIMAL(15,2),
valorFinalPago numeric,

foreign key(IdConta) references Conta(IdConta)
	on delete restrict
    on update cascade, 
foreign key(IdTipoEmprestimo) references TipoEmprestimo(idTipoEmprestimo)
	on delete restrict
    on update cascade, 

check(valorEmpr > 0),
check(prazoMeses > 0),
check (quantParcelas > 0)
);


-- /// Criando a tabela Comprovante de Pix ////

create table comprovantePix(
NumeroComp int primary key not null auto_increment,
IdTransacao int not null unique,
valorTransf decimal(10, 2) not null,
contaDestino varchar(100),
bancoDeDestino varchar(100),
dataPix date,
	
foreign key(IdTransacao) references transacao(IdTransacao)
	on delete cascade
    on update cascade 
);

