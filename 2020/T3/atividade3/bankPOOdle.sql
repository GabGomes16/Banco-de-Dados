create database bankPOOdle;
use bankPOOdle;

CREATE TABLE Cliente (
    Codigo INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(40) NOT NULL,
    Endereco VARCHAR(40) NOT NULL,
    DataNasc VARCHAR(10) NOT NULL,
    CONSTRAINT pk_Codigo PRIMARY KEY (Codigo)
);

CREATE TABLE pessoaFisica (
    CodigoCliente INT NOT NULL,
    CPF VARCHAR(14) NOT NULL,
    CONSTRAINT pk_CodigoCliente PRIMARY KEY (CodigoCliente),
    CONSTRAINT fk_CodigoClienteFis FOREIGN KEY (CodigoCliente)
        REFERENCES Cliente (Codigo)
        ON DELETE CASCADE
);

CREATE TABLE pessoaJuridica (
    CodigoCliente INT NOT NULL,
    CNPJ VARCHAR(18) NOT NULL,
    CONSTRAINT pk_CodigoCliente PRIMARY KEY (CodigoCliente),
    CONSTRAINT fk_CodigoClienteJur FOREIGN KEY (CodigoCliente)
        REFERENCES Cliente (Codigo)
        ON DELETE CASCADE
);

CREATE TABLE Carteira (
    Codigo INT NOT NULL AUTO_INCREMENT,
    CodigoCliente INT NOT NULL,
    Investimento VARCHAR(20) NOT NULL,
    CONSTRAINT pk_Codigo PRIMARY KEY (Codigo),
    CONSTRAINT fk_CodigoClienteCar FOREIGN KEY (CodigoCliente)
        REFERENCES Cliente (Codigo)
        ON DELETE RESTRICT
);

CREATE TABLE Conta (
    Numero INT NOT NULL AUTO_INCREMENT,
    CodigoCarteira INT NOT NULL,
    Titular VARCHAR(40) NOT NULL,
    Saldo DOUBLE NOT NULL,
    CONSTRAINT pk_Numero PRIMARY KEY (Numero),
    CONSTRAINT fk_CodigoCarteira FOREIGN KEY (CodigoCarteira)
        REFERENCES Carteira (Codigo)
);

CREATE TABLE contaCorrente (
    NumeroConta INT NOT NULL,
    Limite DOUBLE NOT NULL,
    CONSTRAINT pk_NumeroConta PRIMARY KEY (NumeroConta),
    CONSTRAINT fk_NumeroContaCor FOREIGN KEY (NumeroConta)
        REFERENCES Conta (Numero)
        ON DELETE CASCADE
);

CREATE TABLE contaPoupanca (
    NumeroConta INT NOT NULL,
    Rendimento DOUBLE NOT NULL,
    CONSTRAINT pk_NumeroConta PRIMARY KEY (NumeroConta),
    CONSTRAINT fk_NumeroContaPou FOREIGN KEY (NumeroConta)
        REFERENCES Conta (Numero)
        ON DELETE CASCADE
);

insert into Cliente(Nome, Endereco, DataNasc) values('Jotaro Kujo', 'Morioh', '16/01/1978');
insert into Carteira(CodigoCliente, Investimento) values(1, 'Golfinho Novo');
insert into Conta(CodigoCarteira, Titular, Saldo) values(1, 'Jotaro Kujo', 5000.0);
insert into Carteira(CodigoCliente, Investimento) values(1, 'Reparar o Navio');
insert into Conta(CodigoCarteira, Titular, Saldo) values(2, 'Jotaro Kujo', 100000.0);
insert into Conta(CodigoCarteira, Titular, Saldo) values(2, 'Jotaro Kujo', 25000.0);

insert into Cliente(Nome, Endereco, DataNasc) values('Higashikata Josuke', 'Morioh', '27/05/1984');
insert into Carteira(CodigoCliente, Investimento) values(2, 'Tenis novo');
insert into Conta(CodigoCarteira, Titular, Saldo) values(3, 'Higashikata Josuke', 200.0);

insert into Cliente(Nome, Endereco, DataNasc) values('Hirose Koichi', 'Morioh', '15/08/1984');
insert into Carteira(CodigoCliente, Investimento) values(3, 'Roupas');
insert into Carteira(CodigoCliente, Investimento) values(3, 'Escola');
insert into Conta(CodigoCarteira, Titular, Saldo) values(5, 'Hirose Koichi', 800.0);
insert into Carteira(CodigoCliente, Investimento) values(3, 'Trasporte');
insert into Conta(CodigoCarteira, Titular, Saldo) values(6, 'Hirose Koichi', 50.0);
insert into Conta(CodigoCarteira, Titular, Saldo) values(6, 'Hirose Koichi', 15.0);
insert into Conta(CodigoCarteira, Titular, Saldo) values(6, 'Hirose Koichi', 20.0);

insert into Cliente(Nome, Endereco, DataNasc) values('Jolyne Cujoh', 'Califórnia', '15/04/1998');
insert into Carteira(CodigoCliente, Investimento) values(4, 'Joias');
insert into Conta(CodigoCarteira, Titular, Saldo) values(7, 'Jolyne Cujoh', 1000.0);
insert into Carteira(CodigoCliente, Investimento) values(4, 'Carro');
insert into Conta(CodigoCarteira, Titular, Saldo) values(8, 'Jolyne Cujoh', 50000.0);

insert into Cliente(Nome, Endereco, DataNasc) values('Joseph Joestar', 'Nova Iorque', '17/09/1923');
insert into Carteira(CodigoCliente, Investimento) values(5, 'Medicamentos');
insert into Conta(CodigoCarteira, Titular, Saldo) values(9, 'Joseph Joestar', 300.0);
insert into Conta(CodigoCarteira, Titular, Saldo) values(9, 'Joseph Joestar', 700.0);