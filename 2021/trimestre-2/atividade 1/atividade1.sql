CREATE database AulaSQLJoins;
use AulaSQLJoins;

CREATE TABLE Cargo (
    codigo INT NOT NULL,
    profissao VARCHAR(40) NOT NULL,
    CONSTRAINT pk_Cargo PRIMARY KEY (codigo)
);

CREATE TABLE Departamento (
    codigo INT NOT NULL,
    nome VARCHAR(30) NOT NULL,
    CONSTRAINT pk_Departamento PRIMARY KEY (codigo)
);

CREATE TABLE Funcionario (
    codigo INT NOT NULL,
    nome VARCHAR(40) NOT NULL,
    codCargo INT NULL,
    codDepartamento INT NOT NULL,
    CONSTRAINT pk_Funcionario PRIMARY KEY (codigo),
    CONSTRAINT fk_FuncionarioCargo FOREIGN KEY (codCargo)
        REFERENCES Cargo (codigo)
        ON DELETE SET NULL,
    CONSTRAINT fk_FuncionarioDepartamento FOREIGN KEY (codDepartamento)
        REFERENCES Departamento (codigo)
        ON DELETE RESTRICT
);

insert into Cargo values (1, 'Gerente');
insert into Cargo values (2, 'Vendedor');
insert into Cargo values (3, 'Programador');
insert into Cargo values (4, 'Contador');

insert into Departamento values (10, 'Suporte de Informática');
insert into Departamento values (12, 'Coaching d vendas');
insert into Departamento values (13, 'Desenvolvimento de Sistemas');
insert into Departamento values (14, 'Salão de vendas');

insert into Funcionario values (101, 'José Maria', 4, 12);
insert into Funcionario values (102, 'Ana Júlia', 3, 13);
insert into Funcionario values (103, 'Maria José', null, 10);
insert into Funcionario values (104, 'Carlos Max', 3, 13);
insert into Funcionario values (105, 'Sandra Silva', 1, 14);

create view ContagemProfissao
as
select c.profissao, count(*) as numFuncinarios
from 	Cargo c, Funcionario f
where 	c.Codigo = f.codCargo
group by c.profissao; 

select cp.profissao, f.nome
from ContagemProfissao cp, Cargo c, Funcionario f
where cp.profissao = c.profissao and 
	  c.codigo = f.codCargo  and 
	  cp.numFuncinarios >= 2;

create view CargoFuncionario
as
select  f.codCargo, c.profissao, f.codigo as codFuncionario, f.codDepartamento
from 	Cargo c, Funcionario f
where 	c.Codigo = f.codCargo;

select * 
from   CargoFuncionario;