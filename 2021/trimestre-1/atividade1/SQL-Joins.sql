create database AulaSQLJoins;
use AulaSQLJoins;

create table Cargo (
	Codigo int not null,
    Profissao varchar(20) not null,
    constraint pk_Cargo primary key (Codigo)
);

create table Funcionario (
	Codigo int not null,
    Nome varchar (40) not null,
    CodCargo int not null,
    constraint pk_Funcionario primary key (Codigo),
    constraint fk_FuncionarioCargo foreign key (CodCargo)
		references Cargo (Codigo)
        on delete set null
);

insert into Cargo values (1, 'Gerente');
insert into Cargo values (2,'Vendedor');
insert into Cargo values (3,'Programador');
insert into Cargo values (4,'Contador');

insert into Funcionario values ( 101, 'José Maria', 4);
insert into Funcionario values ( 102, 'Ana Júlia', 3);
insert into Funcionario values ( 103, 'Maria José', null);
insert into Funcionario values ( 104, 'Carlos Max', 3);
insert into Funcionario values ( 105, 'Sandra Silva', 1);

select *
from Cargo a
inner join Funcionario b
on a.Codigo = b.codCargo;

select *
from Cargo a
left join Funcionario b
on a.Codigo = b.codCargo
where b.CodCargo is null;

select *
from Cargo a
right join Funcionario b
on a.Codigo = b.codCargo
where a.Codigo is null;

select *
from Cargo a
left join Funcionario b
on a.Codigo = b.codCargo
union
select *
from Cargo a
right join Funcionario b
on a.Codigo = b.codCargo;

select *
from Cargo a
left join Funcionario b
on a.Codigo = b.codCargo
where b.CodCargo is null
union
select *
from Cargo a
right join Funcionario b
on a.Codigo = b.codCargo
where a.Codigo is null;