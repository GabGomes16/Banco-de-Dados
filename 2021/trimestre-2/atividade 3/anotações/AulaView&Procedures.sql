create database AulaSQLJoins;
use AulaSQLJoins;

create table Cargo (
	codigo int not null,
    profissao varchar(50) not null,
    
    constraint pk_Cargo primary key (codigo)
);

create table Departamento (
	codigo int not null,
    nome varchar(30) not null,
    
    constraint pk_Departamento primary key(codigo)
);

create table Funcionario(
	codigo int not null,
    nome varchar(40) not null,
    codCargo int null,
    codDepartamento int not null,
    
    constraint pk_Funcionario primary key (codigo),
    constraint fk_FuncionarioCargo foreign key (CodCargo) 
		references Cargo(codigo) on delete set null,
	constraint fk_FuncionarioDepartamento foreign key (codDepartamento)
		references Departamento(codigo) on delete restrict
);

insert into Cargo values(1, 'Gerente');
insert into Cargo values(2, 'Vendedor');
insert into Cargo values(3, 'Programador');
insert into Cargo values(4, 'Contador');

insert into Departamento values(10, 'Suporte de Informatica');
insert into Departamento values(11, 'Coaching de Vendas');
insert into Departamento values(12, 'Desenvolvimento de Sistemas');
insert into Departamento values(13, 'Salão de Vendas');

insert into Funcionario values(101, 'José Maria', 4, 12);
insert into Funcionario values(102, 'Ana Júlia', 3, 13);
insert into Funcionario values(103, 'Maria José ', null, 10);
insert into Funcionario values(104, 'Carlos Max', 3, 13);
insert into Funcionario values(105, 'Sandra Silva', 1, 11);
insert into Funcionario values(106, 'José das Couve', 4, 12);
insert into Funcionario values(107, 'João Silva', 4, 13);
insert into Funcionario values(108, 'Moisés Pereira', 1, 10);

select c.profissao as "Profissão", count(*) as "Número de Funcionario"
from Cargo c, Funcionario f
where c.codigo = f.codCargo
group by c.profissao; /*Ao usar uma função de agregação(count) e 
nescessario agrupar esse atributo, já que o mesmo não está dentro
da função de agregação*/

/*Views ou "tabela virtual": usado cara criar consultas/tabelas fixas no banco de dados 
fazendo com que não tenhamos que rodar elas sempre que precisarmos dessa informação
NESSE EXEMPLO*/

create view ContagemProfissao
as select c.profissao, count(*) as num_Funcionarios
   from   Cargo c, Funcionario f
   where  c.codigo = f.codCargo
   group by c.profissao;
   
select cp.profissao, f.nome
from   ContagemProfissao cp, Cargo c, Funcionario f
where  cp.profissao = c.profissao and
	   c.codigo = f.codCargo and
       cp.num_Funcionarios >= 2;

/*Exemplo de erro por falta de nomeação*/

create view CargoFuncionario
as select f.codCargo, c.profissao, f.codigo as codFunc, f.codDepartamento
   from   Cargo c, Funcionario f
   where  c.codigo = f.codCargo;
   
select *
from   Cargofuncionario;

/*Vantagens da criação de views 
Quando há consulas complexas ou que se repetem muito é vantagoso criar views, 
uma estrutura fixa no banco de dados que vai facilitar as consultas e também 
pode ser usado para disponibilizar certos dados de uma tabela que esta restrita
para certo usuario do banco de dados */

/*Estrutura de modulo, funções ou procedimento uma estrutura com parametro para
automatizar filtros,filtrar consultas de maneira dinâmica 

Procedimentos armazenados(Stored Procedures) - Um bloco com um parametro*/

delimiter °
create procedure ContaProfissoes (inout LimiteContador int)
begin
	declare contador int;
    
	select count(*) into contador
	from   ContagemProfissao cp, Cargo c, Funcionario f
	where  cp.profissao = c.profissao and
		   c.codigo = f.codCargo and
		   cp.num_Funcionarios >= LimiteContador;
	set LimiteContador = contador;
end °
delimiter ;

/*set @limite = 2;
call ContaProfissoes(@limite);
select @limite;*/

/*in = entrada 
inout = entrar com un valor e atualizar dentro de um procedimento
out = saida de um valor de dentro do procedimento para fora */

/*Funcitions - recebe parametro de entrada e sempre retorna dados*/

delimiter °
create function RetornaMensagem(limite int) returns varchar(100) deterministic
begin
    call ContaProfissoes(limite);
    if limite < 3 then
		return "Poucas profissões =/";
	end if;
    return "Muitas profissões =)";
end °
delimiter ;

select RetornaMensagem(2);