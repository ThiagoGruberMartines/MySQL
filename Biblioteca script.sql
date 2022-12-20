create database biblioteca;

use biblioteca;

create table livro(
	id_livro int not null auto_increment primary key,
    titulo_livro varchar(100) not null,
    data_pub year not null,
    preco_livro decimal(10,2) not null
);

create table autor(
	id_autor int not null primary key auto_increment,
    nome_autor varchar(50) not null,
    sobrenome_autor varchar(60) not null
);

select * from livro;
select * from autor;



-- Adicionando a nova coluna na tabela
alter table livro add id_autor int not null; 





-- Transformando a coluna criada anteriormente na chave estrangeira que realiza o relacionamento dos autores e dos livros
alter table livro 
add constraint fk_id_autor 
foreign key (id_autor) 
references autor (id_autor); 




-- Inserindo autores

insert into autor values (null,'José','de Alencar');
insert into autor values (null,'Machado','de Assis');
insert into autor values (null,'Euclides','da Cunha');



alter table livro add un_livro int not null;
alter table livro change column data_pub data_pub date not null;




-- Visualização de uma tabela em ordem descrescente ou ascendente
select * from livro
order by titulo_livro desc;

select * from livro
order by preco_livro asc;




-- Utilizando a clausula WHERE
select * from livro where titulo_livro = ('Dom Casmurro');

select titulo_livro, preco_livro from livro where id_autor = 2;


-- Utilizando duas condições AND, OR, AND NOT.
select * from livro where id_livro >2 and id_autor <3;


-- Pesquisa de dados com a cláusula IN.
select * from livro where id_livro IN (4,6);
select * from livro where titulo_livro IN ('Dom Casmurro','O alienista');




-- Utilizando um Alias (AS), apelidando as colunas da tabela:

select titulo_livro AS livro, 
preco_livro AS preço
from livro;


-- Funções de agregação:

-- MIN = Valor Mínimo
-- MAX = Valor Máximo
-- AVG = Média Aritmética
-- SUM = Total (SOMA)
-- COUNT = Contar quantidade de itens


select count(*) from livro;
select count(distinct id_autor) from livro;
select MIN(preco_livro) from livro;
select MAX(preco_livro) from livro;
select AVG(preco_livro) from livro;
select SUM(preco_livro) from livro;


-- RENOMEANDO UMA TABELA
RENAME TABLE autor TO escritor;

-- RENOMEANDO NOVAMENTE PARA O NOME ANTERIOR
RENAME TABLE escritor TO autor;

select * from autor;



-- ATUALIZANDO REGISTROS DA TABELA AUTOR
UPDATE autor
SET nome_autor = 'Carlos'
WHERE id_autor = 1;

select * from autor;

-- ATUALIZANDO NOVAMENTE O REGISTRO PARA O NOME CORRETO
UPDATE autor
SET nome_autor = 'José'
WHERE id_autor = 1;

-- ATUALIZANDO REGISTROS DA TABELA LIVRO
UPDATE livro
SET titulo_livro = 'Casmurro Dom'
WHERE id_livro = 3;

select * from livro;

-- ATUALIZANDO NOVAMENTE O REGISTRO PARA O NOME CORRETO
UPDATE livro
SET titulo_livro = 'Dom Casmurro'
WHERE id_livro = 3;




-- CLÁUSULA BETWEEN - seleção de intervalos
SELECT * FROM livro
WHERE preco_livro BETWEEN 20 AND 30; -- AO UTILIZAR ESSE COMANDO SQL, ESTAMOS SELECIONANDO A TABELA LIVRO E TRAZENDO APENAS OS REGISTROS QUE POSSUEM O VALOR DE 20 ATÉ 30 REAIS.

-- Agora iremos ver quais livros no banco de dados estão quase acabando (10 UNIDADES OU MENOS), porém só iremos mostrar o estoque e o nome desse livro
SELECT titulo_livro AS titulo, un_livro AS unidade FROM livro 
WHERE un_livro BETWEEN 0 AND 10;




-- LIKE e NOT LIKE
select * from livro
where titulo_livro LIKE 'O%'; -- Aparece apenas registros que se iniciam com O

SELECT id_livro AS código, titulo_livro AS titulo from livro
WHERE titulo_livro NOT LIKE 'C%'; -- Aparece apenas os registos que não se iniciam com C

SELECT * FROM livro
WHERE titulo_livro LIKE '_s sertões'; -- Completa apenas a letra que está faltando "_"




-- Usando o REGEXP

SELECT * FROM livro
WHERE titulo_livro REGEXP '^[OC]'; -- Vai buscar registros que começam com algum caracter informado dentro do []

SELECT * FROM livro
WHERE titulo_livro REGEXP '^[^OC]'; -- Vai buscar registros que não começam com algum caracter informado dentro do []

SELECT * FROM livro
WHERE titulo_livro REGEXP '[OA]$'; -- Vai buscar registros que terminam com algum caracter informado dentro do []

SELECT * FROM livro
WHERE titulo_livro REGEXP '^[DI]|OS'; -- Vai buscar registros que comecem com algum caracter informado dentro do [] ou também algum registros que possuam uma sequencia igual a que foi citada após o |, nesse caso o OS.




-- CRIANDO VIEWS

CREATE VIEW vw_autorlivro 
AS SELECT livro.titulo_livro AS Titulo, 
livro.preco_livro AS Preço, 
autor.nome_autor AS Autor
FROM livro
INNER JOIN autor
ON livro.id_autor = autor.id_autor;

-- ALTERANDO VIEWS

ALTER VIEW vw_autorlivro 
AS SELECT livro.titulo_livro AS Titulo, 
livro.preco_livro AS Preço, 
autor.nome_autor AS Autor, autor.sobrenome_autor AS Sobrenome
FROM livro
INNER JOIN autor
ON livro.id_autor = autor.id_autor;

-- VISUALIZANDO VIEWS

select * from vw_autorlivro;

-- VISUALIZANDO A VIEW COM ORDER BY
select * from vw_autorlivro
ORDER BY preço; -- IRÁ ORGANIZAR A LISTA DE ACORDO COM O PREÇO



