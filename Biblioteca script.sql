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

-- Inserindo valores na tabela livro
INSERT INTO livro VALUES (null, 'Dom casmurro', '1899-01-01', 19, 2, 15);
INSERT INTO livro VALUES (null, 'O alienista', '1882-01-01', 22, 2, 17);
INSERT INTO livro VALUES (null, 'Iracema', '1865-01-01', 15, 1, 22);
INSERT INTO livro VALUES (null, 'O guarani', '1857-01-01', 17, 1, 32);
INSERT INTO livro VALUES (null, 'Os sertões', '1902-01-01', 27, 3, 37);
INSERT INTO livro VALUES (null, 'Constrastes e confrontos', '1907-01-01', 26, 3, 6);

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

CREATE VIEW vw_livrosate20
AS SELECT livro.titulo_livro AS Livro,
livro.preco_livro AS Preço,
autor.nome_autor AS Autor
FROM livro
INNER JOIN autor
ON livro.id_autor = autor.id_autor
WHERE livro.preco_livro BETWEEN 10 AND 20;

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
SELECT * FROM vw_livrosate20;
-- VISUALIZANDO A VIEW COM ORDER BY
select * from vw_autorlivro
ORDER BY preço; -- IRÁ ORGANIZAR A LISTA DE ACORDO COM O PREÇO



-- UTILIZANDO INNER JOIN

SELECT livro.titulo_livro AS Livro, 
autor.nome_autor AS Autor, 
autor.sobrenome_autor AS Sobrenome
FROM livro
INNER JOIN autor
ON livro.id_autor = autor.id_autor;

-- UTILIZANDO O INNER JOIN JUNTO DA CLÁUSULA WHERE E BETWEEN PARA ENCONTRAR LIVROS DE 20 ATÉ 30 REAIS E SEUS RESPECTIVOS AUTORES

SELECT livro.titulo_livro AS Livro, 
livro.preco_livro AS preço,
autor.nome_autor AS Autor, 
autor.sobrenome_autor AS Sobrenome
FROM livro
INNER JOIN autor
ON livro.id_autor = autor.id_autor
WHERE livro.preco_livro BETWEEN 20 AND 30;




-- UTILIZANDO O CONCAT PARA CONCATENAR (JUNTAR AS STRINGS)
SELECT CONCAT('Thiago', ' Gruber Martines') AS 'Meu nome';

SELECT CONCAT(nome_autor, ' ', sobrenome_autor)
AS 'Nome Completo' FROM autor;

SELECT CONCAT('Eu gosto do livro ', titulo_livro)
FROM livro where id_autor = 2;



-- CRIAREMOS AGORA UMA NOVA TABELA APENAS PARA TESTES
create table teste_nulo (
	id_teste int not null primary key auto_increment,
	nome_teste varchar(50) not null,
    item varchar(30)
);

select * from teste_nulo;

INSERT INTO teste_nulo VALUES (null, 'Thiago', 'Computador');
INSERT INTO teste_nulo VALUES (null, 'Pedro', 'Mouse');
INSERT INTO teste_nulo VALUES (null, 'José', null);




-- AGORA VOLTAREMOS A UTILIZAR O CONCAT, PORÉM EM UMA TABELA QUE POSSUI VALORES NULOS
SELECT CONCAT('O ', nome_teste, ' comprou um ', item)
FROM teste_nulo
WHERE nome_teste = 'José'; -- Caso informemos os outros nomes, que não estão com o valor 'item' NULL, eles aparecem concatenados, porém quem está com valor NULL, aparece bugado
-- Para corrigir esse problema, fazemos da seguinte forma:

-- FUNÇÕES IFNULL e COALESCE

-- IFNULL (valor, substituição)

SELECT CONCAT('O ', nome_teste, ' comprou um ', 
IFNULL(item, 'Video Game'))
FROM teste_nulo
WHERE nome_teste = 'José'; -- DESSA FORMA, SUBSTITUIMOS O VALOR NULL DURANTE O SELECT CONCAT

-- COALESCE (valor1, valor2, ......, valorN)
-- Essa função retornará o primeiro valor não-nulo encontrado em seus argumentos

SELECT CONCAT('O ', nome_teste, ' comprou um ', 
COALESCE(NULL, item, NULL, 'PS5')) -- IRÁ RETORNAR O PRIMEIRO VALOR QUE NÃO FOR NULO, NESSE CASO, O PS5
FROM teste_nulo
WHERE nome_teste = 'José';


-- DELETANDO UMA TABELA

DROP TABLE teste_nulo;


-- OPERAÇÕES ARITMÉTICAS
	-- SOMA +
    -- SUBTRAÇÃO -
    -- DIVISÃO /
    -- MULTIPLICAÇÃO *
    -- RESTO, OQUE SOBROU DA OPERAÇÃO % ou MOD 
    -- DIVISÃO INTEIRA	DIV
    



-- FUNÇÕES


CREATE FUNCTION fn_teste (a DECIMAL(10,2), b INT)
RETURNS INT
RETURN a * b;

-- INVOCANDO A FUNÇÃO
SELECT fn_teste(2.5, 4) AS Resultado;

SELECT titulo_livro, fn_teste(preco_livro, un_livro) AS 'Valor total dos livros após vender todas unidades'
FROM livro;


-- PARA DELETAR A FUNÇÃO, UTILIZAMOS O DROP

--  DROP FUNCTION fn_teste;



-- STORED PROCEDURE

CREATE PROCEDURE verPreco (varLivro varchar(50))
SELECT CONCAT('O livro ', titulo_livro, ' custa ', preco_livro)
AS Preço
FROM livro
WHERE titulo_livro = varLivro;



-- INVOCANDO UM STORED PROCEDURE

CALL verPreco('O alienista');
CALL verPreco('O guarani');
CALL verPreco('Contrastes e Confrontos');



-- PARA DELETAR UM PROCEDURE UTILIZAMOS O DROP

-- DROP PROCEDURE verPreco;






-- BLOCOS BEGIN, END COM FUNCTIONS

DELIMITER $$
CREATE FUNCTION aumenta_preco(preco DECIMAL(10,2), taxa DECIMAL(10,2))
	RETURNS DECIMAL(10,2)
	BEGIN
		RETURN preco + preco * taxa/100;
	END$$
DELIMITER ;


SELECT * from livro;

SELECT titulo_livro AS Livro, 
aumenta_preco(preco_livro, 10) AS 'Sugestão de Preço'
FROM livro;


-- BLOCOS BEGIN, END COM STORED PROCEDURE

DELIMITER //
CREATE PROCEDURE verAutor(varLivro varchar(50))
	BEGIN
		SELECT CONCAT('O autor do livro ', livro.titulo_livro, ' é ', autor.nome_autor, ' ', autor.sobrenome_autor)
        AS 'Autor do livro:'
        FROM livro
        INNER JOIN autor
        ON livro.id_autor = autor.id_autor
        WHERE titulo_livro = varLivro;
        SELECT 'Procedimento realizado com sucesso'; -- AQUI PASSAMOS UM SEGUNDO PROCEDIMENTO DENTRO DO BEGIN END, ASSIM, IRÁ ABRIR DUAS INTERFACES DE EXECUÇÃO, SENDO A DO PRIMEIRO E A DO SEGUNDO PROCEDIMENTO
    END//
DELIMITER ;

DROP PROCEDURE verAutor;

CALL verAutor('Iracema');
CALL verAutor('Contrastes e confrontos');
CALL verAutor('Dom Casmurro');




-- PARÂMETROS EM STORED PROCEDURE: 
-- IN (padrão)
-- OUT
-- INOUT



-- EXEMPLO DE OUT
DELIMITER $$
CREATE PROCEDURE teste_out(IN codigo INT, OUT l VARCHAR(50))
BEGIN
	SELECT titulo_livro
    INTO l
    FROM livro
    WHERE id_livro = codigo;
END$$
DELIMITER ;

SELECT @l; -- O VALOR NESSE MOMENTO AINDA ESTAVA NULO.
CALL teste_out(3, @l);
SELECT @l; -- O VALOR NESSE MOMENTO PASSOU A SER O LIVRO DOM CASMURRO, LIVRO DO ID CITADO A CIMA (3).
CALL teste_out(5, @l);
SELECT @l; -- AGORA O VALOR DESSA VARIÁVEL PASSOU A SER O LIVRO OS SERTÕES, LIVRO DO ID CITADO A CIMA(5).


-- EXEMPLO DE INOUT
DELIMITER $$
CREATE PROCEDURE aumento(INOUT valor DECIMAL(10,2), taxa DECIMAL(10,2))
BEGIN
	SET valor = valor + valor * taxa / 100;
END$$
DELIMITER ;
-- Testando: Criamos a variável valorinicial, e a usamos para passar o parâmetro valor. Vamos aumentar o valor em 15%.

SET @valorinicial = 20;
SELECT @valorinicial;

CALL aumento(@valorinicial, 15);
-- Verificamos agora se a variável externa @valorinicial foi alterada.
SELECT @valorinicial;




-- ESCOPO DE VARIÁVEIS (LOCAL ONDE A VARIÁVEL EXISTE/ONDE PODE SER ACESSADA)
-- NIVEIS DE ESCOPO:
	-- GLOBAL (ACESSIVEIS DE QUALQUER LUGAR)
    -- SESSÃO (VARIÁVEIS @ E DE SISTEMA)
    -- PARÂMETROS (CRIADA QUANDO A ROTINA É CHAMADA, E DESTRUÍDAS QUANDO A ROTINA TERMINA)
    -- LOCAL (LIMITADAS AO BLOCO "BEGIN" ONDE FORAM DECLARADAS)
    
-- UTILIZANDO DECLARE (DECLARANDO VARIÁVEIS LOCAIS)

DELIMITER $$
CREATE FUNCTION calcula_desconto(l INT, desconto DECIMAL(10,2))
RETURNS DECIMAL(10,2)
BEGIN
	DECLARE preco DECIMAL(10,2);
    SELECT preco_livro FROM livro
    WHERE id_livro = l INTO preco;
    RETURN preco - desconto;
END$$
DELIMITER ;


SELECT * FROM livro WHERE id_livro = 4; -- VALOR REAL;
SELECT calcula_desconto(4, 10); -- APENAS CALCULA, NÃO REALIZA ALTERAÇÃO NO VALOR FINAL;

SELECT * FROM livro WHERE id_livro = 4; -- AQUI NOVAMENTE TEMOS O VALOR REAL.




-- BLOCOS CONDICIONAIS (IF-ELSE e CASE)

-- IF
DELIMITER $$
CREATE FUNCTION calcula_imposto(salario DECIMAL(10,2))
RETURNS DECIMAL(10,2)
BEGIN
	DECLARE valor_imposto DECIMAL(10,2);
    IF salario < 1000 THEN
		SET valor_imposto = 0;
	ELSEIF salario < 2000 THEN
		SET valor_imposto = salario * 0.15;
	ELSEIF salario < 3000 THEN
		SET valor_imposto = salario * 0.22;
	ELSE
		SET valor_imposto = salario * 0.27;
    END IF;
    RETURN valor_imposto;
END$$
DELIMITER ;

SELECT calcula_imposto(800);
SELECT calcula_imposto(1000);
SELECT calcula_imposto(5000);


-- CASE (ideal quando se há mais possibilidades, como por exemplo na função anterior, o ideal seria ter feito essa função com o CASE e não com IF-ELSE)
DELIMITER $$
CREATE FUNCTION calcula_imposto_case(salario DECIMAL(10,2))
RETURNS DECIMAL(10,2)
BEGIN
	DECLARE valor_imposto DECIMAL(10,2);
    CASE 
    WHEN salario < 1000 THEN
		SET valor_imposto = 0;
	WHEN salario < 2000 THEN
		SET valor_imposto = salario * 0.15;
	WHEN salario < 3000 THEN
		SET valor_imposto = salario * 0.22;
	ELSE
		SET valor_imposto = salario * 0.27;
	END CASE;
    RETURN valor_imposto;
END$$
DELIMITER ;

SELECT calcula_imposto_case(900);
SELECT calcula_imposto_case(1300);
SELECT calcula_imposto_case(3100);




-- ESTRUTURAS DE REPETIÇÃO (LOOP)
