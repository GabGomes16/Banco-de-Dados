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

insert into Usuario values(1, 'Bruna Luiza', 'bruninha@gmail.com', 'abc123.');
insert into Usuario values(2, 'Thiago Braga', 'thiagobraga_1@hotmail.com', 'pena093');
insert into Usuario values(3, 'Osvaldo Justino', 'osvaltino@yahoo.com.br', 'osvaldit1_s');
insert into Usuario values(4, 'Gabriel Fernando', 'gabriel_fnd@gmail.com', 'gabss34');

insert into Comentario values(1, 'A microsoft acertou com essa linguagem!', curdate(), 1, 1);
insert into Comentario values(2, 'Parabéns pelo projet! bem legal!', curdate(), 1, 3);
insert into Comentario values(3, 'Super interessante! Fácil e rapido!', curdate(), 2, 4);
insert into Comentario values(4, 'Cara, que simples fazer um app assim!', curdate(), 2, 1);
insert into Comentario values(5, 'Linguagem muito diferente.', curdate(), 3, 3);
insert into Comentario values(6, 'Adorei aprender Python! Parabéns!', curdate(), 3, 2);
insert into Comentario values(7, 'Muito maneiro esse framework!', curdate(), 2, 2);

insert into LikesPorProjeto values(1, 1);
insert into LikesPorProjeto values(1, 3);
insert into LikesPorProjeto values(2, 1);
insert into LikesPorProjeto values(2, 2);
insert into LikesPorProjeto values(2, 3);
insert into LikesPorProjeto values(2, 4);
insert into LikesPorProjeto values(3, 2);

insert into LikesPorComentario values(7, 1);
insert into LikesPorComentario values(7, 2);
insert into LikesPorComentario values(7, 4);

select p.titulo, count(c3.id_Projeto)
from Projeto p, (select c.id_Projeto
				from Comentario c
                where c.id_Usuario = 3) c3
where p.id = c3.id_Projeto
group by p.titulo;

select p.titulo, count((select c.id_Projeto from Comentario c where c.id_Usuario = 3 and c.id_Projeto = p.id))
from Projeto p
group by p.titulo;

select p.titulo as Titulo_Projeto,
		(select count(c.id)
        from Comentario c
        where c.id_Projeto = p.id) as Qunatidade_Comentarios,
        (select count(lp.id_Projeto)
        from LikesPorProjeto lp
        where lp.id_Projeto = p.id) as Qunatidades_Likes
from Projeto p;

select p.id as Codigo_Projeto, p.titulo as Titulo_Projeto, p.dataProjeto as Data_Inicio_Projeto
from Projeto p
where p.id in (select c.id_Projeto
			   from Comentario c, LikesPorComentario lc
               where c.id_Projeto = p.id and
					 c.id = lc.id_Comentario);
                     
select p.id as Codigo_Projeto, p.titulo as Titulo_Projeto, p.dataProjeto as Data_Inicio_Projeto
from Projeto p
where exists (select c.id_Projeto
			   from Comentario c, LikesPorComentario lc
               where c.id_Projeto = p.id and
					 c.id = lc.id_Comentario);