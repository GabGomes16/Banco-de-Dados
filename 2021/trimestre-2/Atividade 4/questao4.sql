create database q4;
use q4;

CREATE table Fornecedor(
 codForn int not null,
 nome varchar(40),
 
 constraint pk_codForn primary key(codForn)
);

CREATE table Produto(
 codProd int not null,
 estoque int,
 
constraint pk_codForn primary key(codProd)
);

CREATE table Faz_Pedido (
	id_codProd int not null,
	id_codForn int not null,
	quantidade int,
	preco float(5,2)
);

INSERT into Fornecedor (codForn , nome) values(1, 'João');
INSERT into Fornecedor (codForn , nome) values(2, 'Pedro');
INSERT into Fornecedor (codForn , nome) values(3, 'Cleber');
INSERT into Fornecedor (codForn , nome) values(4, 'Felipe');
INSERT into Fornecedor (codForn , nome) values(5, 'Yago');

INSERT into Produto (codProd, estoque) values(1, 3);
INSERT into Produto (codProd, estoque) values(2, 8);
INSERT into Produto (codProd, estoque) values(3, 11);
INSERT into Produto (codProd, estoque) values(4, 4);
INSERT into Produto (codProd, estoque) values(5, 1);
INSERT into Produto (codProd, estoque) values(6, 16);
INSERT into Produto (codProd, estoque) values(7, 7);
INSERT into Produto (codProd, estoque) values(8, 12);
INSERT into Produto (codProd, estoque) values(9, 16);
INSERT into Produto (codProd, estoque) values(10, 3);

INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(1, 2, 3, 15.00);
INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(1, 2, 8, 17.00);
INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(1, 2, 70, 14.00);
INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(1, 2, 1, 15.00);
INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(2, 1, 4, 16.00);
INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(3, 4, 2, 30.00);
INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(4, 3, 8, 80.00);
INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(5, 5, 1, 10.00);
INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(6, 5, 7, 49.00);
INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(7, 1, 6, 120.00);
INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(8, 2, 12, 230.00);
INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(9, 3, 9, 9.00);
INSERT into Faz_Pedido (id_codProd,id_codForn, quantidade, preco) values(10, 4, 60, 90.00);

Delimiter //
Create Function BuscaFornecedoresRentaveis ( valor float, cod int ) returns  int deterministic 
	Begin
		declare quantidade int;
		If (valor >= 0) Then
			Select  SUM(p.quantidade) into quantidade 
			From Faz_Pedido p
			join Fornecedor f on p.id_codForn = f.codForn 
			where p.id_codForn = cod and p.preco > valor;	
			Return quantidade;
		End If;
		return "0";
	End //
Delimiter ;

select BuscaFornecedoresRentaveis(14.0, 2);
