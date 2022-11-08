create database Imobiliaria;
use Imobiliaria;

CREATE TABLE Corretor (
    CPF VARCHAR(14) NOT NULL,
    Comissao DOUBLE NOT NULL,
    nome VARCHAR(30) NOT NULL,
    CPFGerente VARCHAR(14) NOT NULL,
    CONSTRAINT pk_Corretor PRIMARY KEY (CPF),
    CONSTRAINT fk_Corretor FOREIGN KEY (CPFGerente)
        REFERENCES Corretor (CPF)
        ON DELETE RESTRICT
);

CREATE TABLE Municipio (
    Nome VARCHAR(20) NOT NULL,
    UF CHAR(2) NOT NULL,
    CONSTRAINT pk_Municipio PRIMARY KEY (Nome , UF)
);

CREATE TABLE Regiao (
    ID INT NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    NomeMunicipio VARCHAR(20) NOT NULL,
    UFMunicipio CHAR(2) NOT NULL,
    CONSTRAINT pk_Regiao PRIMARY KEY (ID),
    CONSTRAINT fk_MunicipioRegiao FOREIGN KEY (NomeMunicipio , UFMunicipio)
        REFERENCES Municipio (Nome , UF)
        ON DELETE CASCADE
);

CREATE TABLE Telefones (
    CPFCorretor VARCHAR(14) NOT NULL,
    DDD VARCHAR(3) NOT NULL,
    Numero VARCHAR(9) NOT NULL,
    CONSTRAINT pk_Telefones PRIMARY KEY (CPFCorretor),
    CONSTRAINT fk_CorretorTelefones FOREIGN KEY (CPFCorretor)
        REFERENCES Corretor (CPF)
        ON DELETE CASCADE
);

CREATE TABLE CorretorAtendeRegiao (
    CPFCorretor VARCHAR(14) NOT NULL,
    IDRegiao INT NOT NULL,
    CONSTRAINT pk_CorretorAtendeRegiao PRIMARY KEY (CPFCorretor , IDRegiao),
    CONSTRAINT fk_CorretorAtendeRegiao FOREIGN KEY (CPFCorretor)
        REFERENCES Corretor (CPF)
        ON DELETE CASCADE,
    CONSTRAINT fk_RegiaoAtende FOREIGN KEY (IDRegiao)
        REFERENCES Regiao (ID)
        ON DELETE RESTRICT
);

insert into Corretor values('121.212-31', 2000, 'Amelie Brandão Tannus', '121.212-31');
insert into Corretor values('131.212-31', 2100.00, 'ZUcker Bergo', '131.212-31');
insert into Corretor values('141.212-31', 2300.00, 'Cebolinha Silva', '141.212-31');
insert into Corretor values('151.212-31', 2400.00, 'Paulo', '151.212-31');

insert into Regiao values (2121, 'Nacional');
insert into Regiao values (2122, 'Melão');
insert into Regiao values (2123, 'Goiaba docinha');
insert into Regiao values (2124, 'Uva azeda');

insert into Municipio values ('Paulo', '21', 2121);
insert into Municipio values ('Saulo', '22', 2123);
insert into Municipio values ('DinoSaulo','23', 2121);
insert into Municipio values ('SilvaSauro','24', 2122);
insert into Municipio values ('Goku','25', 2123);
insert into Municipio values ('Gohan','26', 2121);

insert into Telefones values('121.212-31', '999', '999999999');

insert into CorretorAtendeRegiao values('121.212-31', '2121');
insert into CorretorAtendeRegiao values('131.212-31', '2122');
insert into CorretorAtendeRegiao values('121.212-31', '2123');
insert into CorretorAtendeRegiao values('151.212-31', '2124');