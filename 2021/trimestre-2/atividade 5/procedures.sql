create database if not exists Lojjj;
use Lojjj;

CREATE TABLE IF NOT EXISTS Fornecedor (
    Nome VARCHAR(40) NOT NULL,
    Codigo VARCHAR(12) NOT NULL,
    CONSTRAINT pk_CodForn PRIMARY KEY (Codigo)
);

CREATE TABLE IF NOT EXISTS Produto (
    Codigo VARCHAR(12) NOT NULL,
    CONSTRAINT pk_CodProd PRIMARY KEY (Codigo)
);

CREATE TABLE if not exists Faz_Pedido (
    Preco VARCHAR(15) NOT NULL,
    Quantidade VARCHAR(15) NOT NULL,
    CodigoForn VARCHAR(12) NOT NULL,
    CodigoProd VARCHAR(12) NOT NULL,
    CONSTRAINT pk_CodFornProd PRIMARY KEY (CodigoForn , CodigoProd),
    CONSTRAINT fk_CodForn FOREIGN KEY (CodigoForn)
        REFERENCES Fornecedor (Codigo)
        ON DELETE RESTRICT,
    CONSTRAINT fk_CodProd FOREIGN KEY (CodigoProd)
        REFERENCES Produto (Codigo)
        ON DELETE CASCADE
);
    
insert into Fornecedor values ('Luffy', 1);
insert into Fornecedor values ('Zoro', 2);
insert into Fornecedor values ('Robin', 3);
insert into Fornecedor values ('Chopper', 4);
    
insert into Produto values (15);

insert into Faz_Pedido values (10, 8 , 1, 15); 
insert into Faz_Pedido values (20, 2 , 4, 15); 
insert into Faz_Pedido values (30, 15, 3, 15); 
insert into Faz_Pedido values (40, 55, 2, 15);

delimiter $
create procedure LOJAFODA(in cod int)
begin
    
	select count(*) as TotaldeRequisitos
	from   Faz_Pedido f
	where  f.CodigoProd = cod; 
    
    select sum(f.quantidade) as TotalPedidos
	from   Faz_Pedido f
	where  f.CodigoProd = cod;
    
    select sum(f.Preco*f.quantidade) as ValorArrecadado
	from   Faz_Pedido f
	where  f.CodigoProd = cod;
    
end $
delimiter ;

set @codproduto = 15;
call LOJAFODA(@codproduto);