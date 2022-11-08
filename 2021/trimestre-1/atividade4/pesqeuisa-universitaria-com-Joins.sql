create database PesquisaUniversitaria;
use PesquisaUniversitaria;

create table Projeto (
	id int not null,
    titulo varchar(45) not null,
    dataProjeto date not null,
    url varchar(100) default 'https://www.ifmg.edu.br/ribeiraodasneves/pesquisa' not null,
    constraint pk_Projeto primary key (id)
);

create table Usuario (
	id int not null,
    nome varchar(45) not null,
    email varchar(45) not null,
    senha varchar(45) not null,
    constraint pk_Usuario primary key (id)
);

create table Comentario (
	id int not null,
    comentario text not null,
    dataComentario date not null,
    id_Projeto int not null,
    id_Usuario int null,
    constraint pk_Comentario primary key (id),
    constraint fk_Projeto_Comentario foreign key (id_Projeto) 
		references Projeto (id) on delete cascade,
	constraint fk_Usuario_Comentario foreign key (id_Usuario) 
		references Usuario (id) on delete set null
);

create table LikesPorProjeto (
	id_Projeto int not null,
    id_Usuario int not null,
    constraint pk_LikesPorProjeto primary key (id_Projeto, id_Usuario),
    constraint fk_Projeto_LikesPorProjeto foreign key (id_Projeto) 
		references Projeto (id) on delete cascade,
	constraint fk_Usuario_LikesPorProjeto foreign key (id_Usuario) 
		references Usuario (id) on delete cascade
);

create table LikesPorComentario (
    id_Comentario int not null,
    id_Usuario int not null,
    constraint pk_LikesPorComentario primary key (id_Comentario, id_Usuario),
	constraint fk_Comentario_LikesPorComentario foreign key (id_Comentario) 
		references Comentario (id) on delete cascade,
	constraint fk_Usuario_LikesPorComentario foreign key (id_Usuario) 
		references Usuario (id) on delete cascade
);

insert into Projeto(id, titulo, dataProjeto) values(1, 'Aplicação C#', str_to_date('2018-04-01', '%Y-%m-%d'));
insert into Projeto(id, titulo, dataProjeto) values(2, 'Aplicação Ionic', str_to_date('2018-05-07', '%Y-%m-%d'));
insert into Projeto(id, titulo, dataProjeto) values(3, 'Aplicação Python', str_to_date('2018-08-05', '%Y-%m-%d'));
insert into Projeto(id, titulo, dataProjeto) values(4, 'Aplicação Java', str_to_date('2018-09-03', '%Y-%m-%d'));
insert into Projeto(id, titulo, dataProjeto) values(5, 'Aplicação Mobile', str_to_date('2018-10-20', '%Y-%m-%d'));
insert into Projeto(id, titulo, dataProjeto) values(6, 'Aplicação WEB', str_to_date('2018-11-07', '%Y-%m-%d'));
insert into Projeto(id, titulo, dataProjeto) values(7, 'Aplicação java Script', str_to_date('2019-01-02', '%Y-%m-%d'));

insert into Usuario values(1, 'Bruna Luiza', 'bruninha@gmail.com', 'abc123.');
insert into Usuario values(2, 'Thiago Braga', 'thiagobraga_1@hotmail.com', 'pena093');
insert into Usuario values(3, 'Osvaldo Justino', 'osvaltino@yahoo.com.br', 'osvaldit1_s');
insert into Usuario values(4, 'Gabriel Fernando', 'gabriel_fnd@gmail.com', 'gabss34');
insert into Usuario values(5, 'Aroldo', 'aroldo@gmail.com', 'arol34');
insert into Usuario values(6, 'Paulo', 'paulo@gmail.com', 'paulo256');
insert into Usuario values(7, 'Geraldo', 'geraldo@gmail.com', 'corsa846');
insert into Usuario values(8, 'Erasmo', 'erasmo@gmail.com', 'asmo8000');

insert into Comentario values(1, 'A microsoft acertou com essa linguagem!', curdate(), 1, 1);
insert into Comentario values(2, 'Parabéns pelo projet! bem legal!', curdate(), 1, 3);
insert into Comentario values(3, 'Super interessante! Fácil e rapido!', curdate(), 2, 4);
insert into Comentario values(4, 'Cara, que simples fazer um app assim!', curdate(), 2, 1);
insert into Comentario values(5, 'Linguagem muito diferente.', curdate(), 3, 3);
insert into Comentario values(6, 'Adorei aprender Python! Parabéns!', curdate(), 3, 2);
insert into Comentario values(7, 'Muito dificil esse Java, cheio de peculiaridades!', curdate(), 4, 5);
insert into Comentario values(8, 'Passo muita raiva com Java!', curdate(), 4, 8);
insert into Comentario values(9, 'Muito massa as aplicações android!', curdate(), 5, 8);
insert into Comentario values(10, 'Muito bonito esse seu design do .css!', curdate(), 6, 1);
insert into Comentario values(11, 'A JetBrains mandou muito bem com esse Kotlin!', curdate(), 5, 5);

insert into LikesPorProjeto values(1, 1);
insert into LikesPorProjeto values(1, 3);
insert into LikesPorProjeto values(2, 1);
insert into LikesPorProjeto values(2, 2);
insert into LikesPorProjeto values(2, 3);
insert into LikesPorProjeto values(2, 4);
insert into LikesPorProjeto values(3, 2);
insert into LikesPorProjeto values(4, 2);
insert into LikesPorProjeto values(4, 5);
insert into LikesPorProjeto values(4, 6);
insert into LikesPorProjeto values(6, 7);
insert into LikesPorProjeto values(7, 7);
insert into LikesPorProjeto values(7, 8);
insert into LikesPorProjeto values(7, 6);

insert into LikesPorComentario values(7, 1);
insert into LikesPorComentario values(7, 2);
insert into LikesPorComentario values(7, 4);
insert into LikesPorComentario values(8, 4);
insert into LikesPorComentario values(8, 6);
insert into LikesPorComentario values(7, 6);
insert into LikesPorComentario values(9, 8);
insert into LikesPorComentario values(9, 5);
insert into LikesPorComentario values(11, 5);
insert into LikesPorComentario values(10, 7);

select p.titulo as Título_do_projeto, p.id as Código_do_projeto from Projeto p
where exists (select lp.id_Projeto from LikesPorProjeto lp, Usuario u
			  where lp.id_Usuario = u.id and lp.id_Projeto = p.id);/*caso alguem precise saber o titulo e o codigo dos projetos que tem ao menos 1 like*/
              
select c.id as Codigo_comentário, (select count(lc.id_Comentario)
			  from LikesPorComentario lc
			  where lc.id_Comentario = c.id) as Likes_do_comentário
from Comentario c 
group by c.id;/*Caso alguem precise listar os codigos dos comentarios e saber quantos likes tem neles*/

select p.id as Codigo_Projeto, p.titulo as Titulo_Projeto, p.dataProjeto as Data_Inicio_Projeto 
from Projeto p 
where p.id in (select c.id_Projeto 
			   from Comentario c, LikesPorComentario lc
               where c.id_Projeto = p.id and c.id = lc.id_Comentario);/*caso alguem precise saber quais projetos tem likes nos comentários*/
               
select c.Comentario, c.id as Codigo_comentário
from Comentario c
where exists (select lc.id_Comentario 
			  from LikesPorComentario lc, Usuario u
              where lc.id_Usuario = u.id and lc.id_Comentario = c.id);/*caso algume queira listar os comentários com ao menos 1 like*/
              
select Usuario.nome as Nome_do_usuário, Projeto.titulo as Título_do_projeto 
from LikesPorProjeto
inner join Usuario 
on Usuario.id = LikesPorProjeto.id_Usuario
inner join Projeto 
on Projeto.id = LikesPorProjeto.id_Projeto
order by Usuario.nome asc;/*caso alguem precise listar o nome dos usuarios e o nome dos projetos que eles deram like em ordem alfabética*/