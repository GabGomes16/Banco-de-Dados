create database if not exists Empresa;
use Empresa;

CREATE TABLE IF NOT EXISTS Departamento (
    Codigo VARCHAR(20) NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    CONSTRAINT pk_Departamento PRIMARY KEY (Codigo)
);
CREATE TABLE IF NOT EXISTS Empregado (
    CPF VARCHAR(14) NOT NULL,
    DataNascimento VARCHAR(11) NOT NULL,
    Nome VARCHAR(40) NOT NULL,
    Sexo ENUM('M', 'F'),
    Endereco VARCHAR(50) NOT NULL,
    Salario INT NOT NULL,
    CPFSupervisor VARCHAR(14) NOT NULL,
    CodDep VARCHAR(20) NULL,
    CONSTRAINT pk_Empregado PRIMARY KEY (CPF),
    CONSTRAINT fk_Empregado FOREIGN KEY (CPFSupervisor)
        REFERENCES Empregado (CPF)
        ON DELETE CASCADE,
	constraint fk_Departamento Foreign key (CodDep)
		references Departamento (Codigo)
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
    CodigoProjeto VARCHAR(20) NOT NULL,
    CONSTRAINT fk_CPF_Empregado FOREIGN KEY (CPFEmpregado)
        REFERENCES Empregado (CPF)
        ON DELETE CASCADE,
    CONSTRAINT fk_CodigoProjeto FOREIGN KEY (CodigoProjeto)
        REFERENCES Projeto (Codigo)
        ON DELETE RESTRICT
);

insert into Departamento values(1, 'Maker lab');
insert into Departamento values(2, 'Química');
insert into Departamento values(3, 'Física');
insert into Departamento values(4, 'Marketing');
insert into Departamento values(5, 'Economia');

insert into Empregado values('647.645.876-98','04/10/2000','Ermes Costello', 'F', 'Rua teste, 45', 2415.00, '647.645.876-98', 2);
insert into Empregado values('652.398.223-76','27/10/2001','Kujo Jotaro', 'M','Rua teste, 90', 2415.00, '652.398.223-76', 1);
insert into Empregado values('132.255.767-09','17/12/2002','Jolyne Cujoh', 'F', 'Rua teste, 245', 2415.00, '647.645.876-98', null);
insert into Empregado values('847.098.837-65','09/02/1994', 'Anasui Cujoh','M', 'Rua teste, 87', 2415.00, '652.398.223-76', null);
insert into Empregado values('098.738.980-09','20/04/2001','Higashikata Josuke', 'M','Rua teste, 10', 2415.00,'132.255.767-09', null);

insert into Localizacoes values('1', 'Edificio Ficticio, sala 25');
insert into Localizacoes values('2', 'Edificio Ficticio, sala 26');
insert into Localizacoes values('3', 'Edificio Ficticio, sala 27');
insert into Localizacoes values('4', 'Edificio Ficticio, sala 28');
insert into Localizacoes values('5', 'Edificio Ficticio, sala 29');

insert into Projeto values('F23', '123', 'Lab Física', 3);
insert into Projeto values('R54', '456', 'Lab Química', 2);
insert into Projeto values('G65', '897', 'Maker lab', 1);
insert into Projeto values('V43', '655', 'Marketing', 4);
insert into Projeto values('J65','254', 'Economia', 5);

insert into Dependente values('Sofia', 'F', 'Mãe', '15/12/1981', '647.645.876-98');
insert into Dependente values('Maria ', 'F', 'Avó', '29/11/1967',  '647.645.876-98');
insert into Dependente values('Alice', 'F', 'Filha', '23/03/2010','847.098.837-65');
insert into Dependente values('Victor', 'M', 'Pai', '12/04/1984', '652.398.223-76');
insert into Dependente values('José', 'M', 'Avô', '02/05/1965', '098.738.980-09');

insert into Empregado_Projeto values('132.255.767-09', 123);
insert into Empregado_Projeto values('647.645.876-98', 655);
insert into Empregado_Projeto values('647.645.876-98', 254);
insert into Empregado_Projeto values('647.645.876-98', 897);
insert into Empregado_Projeto values('098.738.980-09', 456);

insert into Empregado_Departamento values('132.255.767-09', 3);
insert into Empregado_Departamento values('647.645.876-98', 1);
insert into Empregado_Departamento values('847.098.837-65', 5);
insert into Empregado_Departamento values('652.398.223-76', 4);
insert into Empregado_Departamento values('098.738.980-09', 2);

select d.Nome, d.Codigo
from Departamento d, Empregado_Projeto ep, Empregado e
where d.Codigo = e.CodDep and e.Sexo = 'F' and e.CPF = ep.CPFEmpregado
group by d.Codigo, d.Nome
having count(ep.CPFEmpregado) >= 3;

select e.Nome, d.Nome
from Empregado e, Departamento d, Empregado_Departamento ed, Projeto p, Empregado_Projeto ep
where ed.CPFEmpregado = e.CPF 
	and ed.CodigoDepartamento = d.Codigo 
	and p.CodigoDepartamento = d.Codigo 
	and ep.CodigoProjeto = p.Codigo 
	and ep.CPFEmpregado = e.CPF;

select e.Nome, count(ep.CodigoProjeto)
from Empregado e, Empregado_Projeto ep, Projeto p, (select e.Nome
													from Dependente s, Empregado e
                                                    where s.CPFEmpregado = e.CPF
                                                    group by e.Nome
                                                    having count(s.CPFEmpregado) > 1) d
where e.CPF = ep.CPFEmpregado and p.Codigo = ep.CodigoProjeto and d.Nome = e.Nome
group by e.Nome;

select e.Nome, count(ep.CodigoProjeto)
from Empregado e, Empregado_Projeto ep, Projeto p
where e.CPF = ep.CPFEmpregado and p.Codigo = ep.CodigoProjeto
group by e.Nome; /*O contexto do select acima é que o patrão ou supervisor pode, em algum momento, 
querer saber quais e em quantos projetos os empregados estão envolvidos*/

select e.Nome, d.Nome, d.Codigo, count(s.CPFEmpregado)
from Empregado e, Departamento d, Empregado_Departamento ed, Dependente s
where ed.CPFEmpregado = e.CPF and ed.CodigoDepartamento = d.Codigo and s.CPFEmpregado = e.CPF
group by e.Nome, d.Nome, d.Codigo;/*O contexto do select acima é que o patrão ou supervisor pode, em algum momento, 
querer saber o nome dos empregados e a quantidade de dependentes financeiros que eles tem, e o nome e código do departamento em que eles trabalham*/

select *
from Empregado e
inner join Empregado_Projeto ep
on e.CPF = ep.CPFEmpregado;/*O contexto é que em algum momento o patrão ou supervisor pode ,em algum momento, 
querer saber os dados dos empregados e o código do projeto no qual eles trabalham*/