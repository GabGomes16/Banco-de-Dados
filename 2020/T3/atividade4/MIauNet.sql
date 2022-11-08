create database MiauNet;
use MiauNet;

CREATE TABLE Genero (
    Codigo INT AUTO_INCREMENT,
    Nome VARCHAR(20) NOT NULL,
    CONSTRAINT pk_Codigo PRIMARY KEY (Codigo)
);

CREATE TABLE Filme (
    Titulo VARCHAR(50) NOT NULL,
    codigoGenero INT NOT NULL,
    Duracao VARCHAR(20) NOT NULL,
    Tipo ENUM('Filme', 'Série'),
    CONSTRAINT pk_Titulo PRIMARY KEY (Titulo),
    CONSTRAINT fk_codigoGenero FOREIGN KEY (codigoGenero)
        REFERENCES Genero (Codigo)
);

insert into Genero(Nome) values ('Ação');
insert into Genero(Nome) values ('Animação');
insert into Genero(Nome) values ('Aventura');
insert into Genero(Nome) values ('Comédia');
insert into Genero(Nome) values ('Crime');
insert into Genero(Nome) values ('Documentário');
insert into Genero(Nome) values ('Drama');
insert into Genero(Nome) values ('Família');
insert into Genero(Nome) values ('Ficção Cientifica');
insert into Genero(Nome) values ('Guerra');
insert into Genero(Nome) values ('Mistério');
insert into Genero(Nome) values ('Música');
insert into Genero(Nome) values ('Romance');
insert into Genero(Nome) values ('Suspense');
insert into Genero(Nome) values ('Terror');

insert into Filme values ("Jojo's Bizarre Adventure", 11, '180 episódios', 'Série'); 
insert into Filme values ('Hunter x Hunter', 3, '150 episódios', 'Série');
insert into Filme values ('Shingeki no Kyojin', 10, '70 episódios', 'Série');
insert into Filme values ('Kimetsu no Yaba: Movie', 1, '2h', 'Filme');
insert into Filme values ('One Piece', 3, '967 episódios', 'Série');
insert into Filme values ('Vingadores: Ultimato', 1, '3h', 'Filme');
insert into Filme values ('Harry Petter e a Pedra filosofal', 3, '2h', 'Filme');
insert into Filme values ('Kimetsu no Yaba', 1, '24 episódios', 'Série');
insert into Filme values ('Pokemon', 3, '1200 episódios', 'Série');
insert into Filme values ('Jujutsu Kaisen', 4, '24 episódios', 'Série');