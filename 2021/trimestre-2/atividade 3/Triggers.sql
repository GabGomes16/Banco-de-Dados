create database AulaTriggers;
use AulaTriggers;

create table Produto(
	codigo int(5) not null,
    nome varchar(50) not null,
    estoque int(10) not null,
    
    constraint pk_Produto primary key (codigo)
);

create table ItemVenda(
	codItem int(6) auto_increment not null,
    quantidade int(10) not null,
    preco float(8,2) not null,
    codProd int(5) null,
    
    constraint pk_ItemVenda primary key (codItem),
    constraint fk_Produto foreign key (codProd)
		references Produto(codigo) on delete set null

insert into Produto values(7, 'Kit arduino', 700);
insert into Produto values(12, 'Caixa de Leite', 152);
insert into Produto values(50, 'Penne Vilma', 134);
insert into Produto values(91, 'Bombons Anny', 18);

insert into ItemVenda (quantidade, preco, codProd) values(1, 2.00, 91);
insert into ItemVenda (quantidade, preco, codProd) values(5, 10.00, 91);
insert into ItemVenda (quantidade, preco, codProd) values(2, 22.50, 50);
insert into ItemVenda (quantidade, preco, codProd) values(3, 2.00, 91);

select * from Produto;
select * from ItemVenda;

delimiter ?
create procedure VerificarQuantProd( out quantidade int)
begin
	select count(*) into quantidade from Produto;
end ?
delimiter ;

call VerificarQuantProd(@total);
select @total;

delimiter %
create trigger AtualizaEstoqueVenda after insert
on ItemVenda for each row 
begin
	update Produto set estoque = estoque - new.quantidade
    where  codigo = new.codProd;
end  %
delimiter ;
