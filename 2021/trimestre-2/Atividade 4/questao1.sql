# RESOLUÇÃO DA PRIMEIRA QUESTÃO A PARTIR DA LINHA 54

create database q1;
use q1;

create table produto (
	codigo int(5) not null,
    nome varchar(30) not null,
    estoque int(10) not null,
    
    constraint pk_produto primary key (codigo)
);

create table ItemVenda (
	codItem int(6) auto_increment not null,
    quantidade int(10) not null,
    preco float(8,2) not null,
    codProd int(5) null,
    
    constraint pk_ItemVenda primary key (codItem),
    constraint fk_produto foreign key (codProd) references produto (codigo) on delete set null
);

# Adicionar (Inserir) X produtos no BD
insert into produto (codigo, nome, estoque) values (1, 'Kit Arduino', 700);
insert into produto (codigo, nome, estoque) values (2, 'Iphone 3000', 50);
insert into produto (codigo, nome, estoque) values (3, 'Gol Quadrado', 10);
insert into produto (codigo, nome, estoque) values (4, 'Jogo', 200);

select * from produto;
select * from ItemVenda;

# Trigger para toda vez que adicionar (Insert) um Produto no mercado de vendas (ItemVendas) Diminuir o Estoque
delimiter //
create trigger AtualizaEstoqueVenda after insert
on ItemVenda for each row
begin
	update produto set estoque = estoque - new.quantidade
    where codigo = new.codProd;
end//
delimiter ;

insert into ItemVenda (quantidade, preco, codProd) values (1, 300.00, 1);
insert into ItemVenda (quantidade, preco, codProd) values (5, 20000.00, 2);
insert into ItemVenda (quantidade, preco, codProd) values (3, 5000.00, 3);
insert into ItemVenda (quantidade, preco, codProd) values (2, 100.00, 4);

select * from produto;
select * from ItemVenda;

# Trigger para toda hora que acontecer um delete na tabela ItemVenda, repor automaticamente o estoque em Produto
delimiter //
create trigger AtualizaVendaConcluida after delete
on ItemVenda for each row
begin
	update produto set estoque = estoque + old.quantidade
    where codigo = old.codProd;
end//
delimiter ;

delete from ItemVenda where codItem = 1;

select * from produto;
select * from ItemVenda;

# LETRA B:
# Isso não séria possivel, pois no momento que se usa uma Trigger para vigiar um UPDATE e essa mesma Trigger se usa um UPDATE
# cria-se assim uma redundância no código, onde a Trigger chama ela mesma em um loop infinito.
