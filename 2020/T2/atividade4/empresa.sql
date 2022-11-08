create database if not exists Empresa;
use Empresa;

CREATE TABLE IF NOT EXISTS Empregado (
    CPF VARCHAR(14) NOT NULL,
    DataNascimento VARCHAR(11) NOT NULL,
    Nome VARCHAR(40) NOT NULL,
    Sexo ENUM('M', 'F'),
    Endereco VARCHAR(50) NOT NULL,
    Salario INT NOT NULL,
    CPFSupervisor VARCHAR(14) NOT NULL,
    CONSTRAINT pk_Empregado PRIMARY KEY (CPF),
    CONSTRAINT fk_Empregado FOREIGN KEY (CPFSupervisor)
        REFERENCES Empregado (CPF)
        ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Dependente (
    Nome VARCHAR(40) NOT NULL,
    Sexo ENUM('M', 'F'),
    Parentesco VARCHAR(8) NOT NULL,
    DataNascimento VARCHAR(11) NOT NULL,
    CPFEmpregado VARCHAR(14) NOT NULL,
    CONSTRAINT fk_DependenteEmpregado FOREIGN KEY (CPFEmpregado)
        REFERENCES Empregado (CPF)
        ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS Departamento (
    Codigo VARCHAR(20) NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    CPFSupervisor VARCHAR(14) NOT NULL,
    CONSTRAINT pk_Departamento PRIMARY KEY (Codigo),
    CONSTRAINT fk_EmpregadoDEP FOREIGN KEY (CPFSupervisor)
        REFERENCES Empregado (CPF)
        ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Localizacoes (
    CodigoDEP VARCHAR(20) NOT NULL,
    infoLOC VARCHAR(30) NOT NULL,
    CONSTRAINT pk_Departamento_Loc PRIMARY KEY (CodigoDEP),
    CONSTRAINT fk_Departamento_Loc FOREIGN KEY (COdigoDEP)
        REFERENCES Departamento (Codigo)
        ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Projeto (
    Titulo VARCHAR(20) NOT NULL,
    Codigo VARCHAR(20) NOT NULL,
    Localizacao VARCHAR(20) NOT NULL,
    CodigoDepartamento VARCHAR(20) NOT NULL,
    CONSTRAINT pk_Projeto PRIMARY KEY (Codigo),
    CONSTRAINT fk_DepartamentoProjeto FOREIGN KEY (CodigoDepartamento)
        REFERENCES Departamento (Codigo)
        ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS Empregado_Departamento (
    CPFEmpregado VARCHAR(14) NOT NULL,
    CodigoDepartamento VARCHAR(20) NOT NULL,
    CONSTRAINT fk_CPFEmpregado FOREIGN KEY (CPFEmpregado)
        REFERENCES Empregado (CPF)
        ON DELETE CASCADE,
    CONSTRAINT fk_CodigoDepartamento FOREIGN KEY (CodigoDepartamento)
        REFERENCES Departamento (Codigo)
        ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS Empregado_Projeto (
    CPFEmpregado VARCHAR(14) NOT NULL,
    TituloProjeto VARCHAR(20) NOT NULL,
    CodigoProjeto VARCHAR(20) NOT NULL,
    CONSTRAINT fk_CPFEmpregado FOREIGN KEY (CPFEmpregado)
        REFERENCES Empregado (CPF)
        ON DELETE CASCADE,
    CONSTRAINT fk_TituloProjeto FOREIGN KEY (TituloProjeto)
        REFERENCES Projeto (Titulo)
        ON DELETE RESTRICT,
    CONSTRAINT fk_CodigoProjeto FOREIGN KEY (CodigoProjeto)
        REFERENCES Projeto (Codigo)
        ON DELETE RESTRICT
);