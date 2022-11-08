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
); 
/*A delimitação((6)) indica que quando nn completarmos tantos digitos o banco* vai
completar com espaços em branco(não recomendado a ultilização por isso o aviso)*/

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
delimiter ; /*Parametro apenas de saida - out*/

call VerificarQuantProd(@total);
select @total;

/*estrutura procedure = clica no create stored procedure(7° item da esqueda para direita) 
lembrar do delimiter*/
/*estrutura function = clica no create finction(8° item da esqueda para direita) LDD*/

/*estrutura trigger

delimiter "codigo_qualquer_diferente_de_;"
create [definer = {'nome_do_usuario' ou CURRENT_USER}] trigger "nome_da_trigger" "Momento" "evento_DML"
on "nome_da_tabela" for each row 
begin
	[declaração de variaveis]
    'código_da_trigger';
end "codigo_definido_diferente_de_;"
delimiter ;
*/

/*enquanto nos rodamos|chamamos procedures e functions, triggers rodam automaticamente sem a necessidade de 
rodarmos ela de acordo com um evento DML, um exemplo é um insert, td vez que um insert for feito o tigger e ativado*/

delimiter %
create trigger AtualizaEstoqueVenda after insert
on ItemVenda for each row 
begin
	update Produto set estoque = estoque - new.quantidade
    where  codigo = new.codProd;
end  %
delimiter ;

/*update Produto set estoque = estoque - 6
where  codigo = 91;
update Produto set estoque = estoque - 2
where  codigo = 50;*/

/*       MOMENTOS
before = antes do evento acontecer 
after =depois do evento acontecer
		Eventos DML
apenas comandos de DML(insert, update e delete), um exemplo seria o select que é um comando DQL, logo a trigger nn funcionaria.
(pode se usar DML e DQL dentro do bloco de codigo)

new.'nome_coluna_tabela' = insert ou update 
old.'nome_coluna_tabela' = delete ou update 

se a trigger esta monitorando algo vc não pode fazer o mesmo dentro da trigger, pois se cria um loop infinito, recurcividade
ex: se o evento DML da trigger é update a trigger nn pode fazer updade */