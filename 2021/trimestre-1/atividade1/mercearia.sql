CREATE DATABASE Mercearia;
USE Mercearia;

CREATE TABLE IF NOT EXISTS Categoria (
    Codigo INT NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    CONSTRAINT pk_Categoria PRIMARY KEY (Codigo)
);

CREATE TABLE IF NOT EXISTS Produto (
    Codigo INT NOT NULL,
    Descricao VARCHAR(20) NOT NULL,
    PrecoVenda DOUBLE NOT NULL,
    PrecoCusto DOUBLE NOT NULL,
    CodigoCategoria INT NOT NULL,
    CONSTRAINT pk_Produto PRIMARY KEY (Codigo),
    CONSTRAINT fk_CategoriaProduto FOREIGN KEY (CodigoCategoria)
        REFERENCES Categoria (Codigo)
        ON DELETE RESTRICT
);

insert into Categoria values (1, 'Papelaria');
insert into Categoria values (2, 'Informática');
insert into Categoria values (3, 'Religioso');

insert into Produto values (1, 'Caderno', 5.45, 1.00, 1);
insert into Produto values (2, 'Caneta', 1.20, 0.50, 1);
insert into Produto values (3, 'CD', 1.00, 0.10, 2);
insert into Produto values (4, 'Mouse', 14.00, 5.00, 2);

UPDATE Produto 
SET PrecoVenda = 16
WHERE Codigo = 4;

insert into Produto values(5, 'Santinha', 55.0, 28.0, 3);

DELETE FROM Produto 
WHERE Codigo = 5;

SELECT p.Codigo, p.Descricao
FROM Produto p
WHERE p.PrecoVenda > 5.00;

SELECT p.Descricao, c.Nome
FROM Produto p, Categoria c
WHERE p.CodigoCategoria = c.Codigo AND p.PrecoVenda > 5.00;
        
SELECT c.Nome, AVG(p.PrecoVenda)
FROM Categoria c, Produto p
WHERE c.Codigo = p.CodigoCategoria
GROUP BY c.Nome
HAVING min(p.PrecoVenda) > 1.00
ORDER BY C.Nome;