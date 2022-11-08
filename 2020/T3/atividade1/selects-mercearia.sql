use Mercearia;

SELECT 
    p.Codigo, p.Descricao
FROM
    Produto p
WHERE
    p.PrecoVenda > 5.00;

SELECT 
    p.Descricao, c.Nome
FROM
    Produto p,
    Categoria c
WHERE
    p.CodigoCategoria = c.Codigo
        AND p.PrecoVenda > 5.00;
        
SELECT c.Nome, AVG(p.PrecoVenda)
FROM Categoria c, Produto p
WHERE c.Codigo = p.CodigoCategoria
GROUP BY c.Nome
HAVING min(p.PrecoVenda) > 1.00
ORDER BY C.Nome;