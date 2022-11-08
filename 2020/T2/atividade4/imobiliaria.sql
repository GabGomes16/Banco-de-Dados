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