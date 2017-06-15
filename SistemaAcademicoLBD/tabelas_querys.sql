CREATE DATABASE sistemaAcademicos
USE sistemaAcademicos

CREATE TABLE aluno(
	ra CHAR(8) NOT NULL PRIMARY KEY,
	nome VARCHAR(250) NOT NULL
)

CREATE TABLE disciplina(
	codigo CHAR(8) NOT NULL PRIMARY KEY,
	nome VARCHAR(250) NOT NULL,
	sigla VARCHAR(10) NOT NULL,
	turno CHAR(5) NOT NULL,
	numeroAulas INT NOT NULL
)

CREATE TABLE avaliacao(
	codigo INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	tipo VARCHAR(100) NOT NULL
)

CREATE TABLE presenca(
	ra_aluno CHAR(8) NOT NULL, 
	codigo_disciplina CHAR(8) NOT NULL,
	data DATETIME NOT NULL,
	presenca INT NOT NULL
	PRIMARY KEY(ra_aluno,codigo_disciplina,data)
	FOREIGN KEY (ra_aluno) REFERENCES aluno(ra),
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo)
)

CREATE TABLE nota(
	ra_aluno CHAR(8) NOT NULL, 
	codigo_disciplina CHAR(8) NOT NULL,
	codigo_avaliacao INT NOT NULL,
	valor DECIMAL(3,1)
	PRIMARY KEY(ra_aluno,codigo_disciplina,codigo_avaliacao)
	FOREIGN KEY (ra_aluno) REFERENCES aluno(ra),
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo),
	FOREIGN KEY (codigo_avaliacao) REFERENCES avaliacao(codigo)
)

CREATE TABLE avaliacaoDisciplina(
	codigo_disciplina CHAR(8) NOT NULL,
	codigo_avaliacao INT NOT NULL,
	valor REAL NULL
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo),
	FOREIGN KEY (codigo_avaliacao) REFERENCES avaliacao(codigo)
)


DROP TABLE avaliacaoDisciplina
DROP TABLE nota
DROP TABLE aluno
DROP TABLE presenca
DROP TABLE disciplina
-----------------------------------------------------
----											 ----
----				INSERTS						 ----
----											 ----
-----------------------------------------------------

INSERT INTO disciplina
(codigo,
nome,
sigla,
turno,
numeroAulas)
VALUES
('4203-010','Arquitetura e Organização de Computadores','AOC','Tarde',80),
('4203-020','Arquitetura e Organização de Computadores','AOC','Noite',80),
('4208-010','Laboratório de Hardware','LBH','Tarde',40),
('4213-003','Sistemas Operacionais I','SOI','Tarde',80),
('4213-013','Sistemas Operacionais I','SOI','Noite',80),
('4226-004','Banco de Dados','BD','Tarde',80),
('4233-005','Laboratório de Banco de Dados','LBD','Tarde',80),
('5005-220','Métodos para Produção do Conhecimento','MPC','Manhã',40)


INSERT INTO aluno
(nome,ra)
VALUES
('Joao Coquinho','151000-2'),
('Mario Bros','151010-2'),
('Gilberto Kossack','151030-2'),
('Ivo Nante','151008-2'),
('Joel Maluco','151800-2'),
('Chico Tainha','154000-2'),
('James Neyman','151220-2'),
('Oliver Man','151450-3'),
('Jabuticabal','151006-4'),
('Pekkto Nielsen','151070-5'),
('Sapakla','151000-6'),
('Jabirola','151000-7'),
('Sapa Veia','151000-8'),
('Roberto o Grande','151000-9'),
('Sabirola','151090-1'),
('Chico Tuita','151080-1'),
('Nilva Nella','151066-2'),
('Julia Kay','151000-3')



INSERT INTO presenca
(ra_aluno,
codigo_disciplina,
data,
presenca)
VALUES
('151000-2','4203-010','2017-06-06',4),
('151010-2','4203-010','2017-06-06',4),
('151030-2','4203-020','2017-06-06',4),
('151008-2','4203-020','2017-06-06',4),
('151800-2','4208-010','2017-06-07',2),
('154000-2','4208-010','2017-06-07',2),
('151220-2','4213-003','2017-06-07',4),
('151450-3','4213-003','2017-06-07',4),
('151006-4','4213-013','2017-06-08',4),
('151070-5','4213-013','2017-06-08',4),
('151000-6','4226-004','2017-06-08',4),
('151000-7','4226-004','2017-06-08',4),
('151000-8','4233-005','2017-06-09',4),
('151000-9','4233-005','2017-06-09',4),
('151090-1','4233-005','2017-06-09',4),
('151080-1','5005-220','2017-06-10',2),
('151066-2','5005-220','2017-06-10',2),
('151000-3','5005-220','2017-06-10',2)


INSERT INTO avaliacao
(tipo)
VALUES
('T'),
('P1'),
('P2'),
('P3'),
('Pre-Exame'),
('Exame'),
('Monografia-Completa'),
('Monografia-Resumida')

SELECT * FROM avaliacao
SELECT * FROM disciplina

INSERT INTO avaliacaodisciplina
(codigo_disciplina,
codigo_avaliacao,
valor)
VALUES
('4203-010','2','0.3'),
('4203-010','3','0.5'),
('4203-010','1','0.2'),
('4203-010','6',NULL),
('4203-020','2','0.3'),
('4203-020','3','0.5'),
('4203-020','1','0.2'),
('4203-020','6',NULL),

--aoc t
('4208-010','2','0.3'),
('4208-010','3','0.5'),
('4208-010','1','0.2'),
('4208-010','6',NULL),

--bd
('4226-004','2','0.3'),
('4226-004','3','0.5'),
('4226-004','1','0.2'),
('4226-004','6',NULL),

--soi t/n
('4213-003','2','0.35'),
('4213-003','3','0.35'),
('4213-003','1','0.3'),
('4213-003','5','0.2'),
('4213-003','6',NULL),

('4213-013','2','0.35'),
('4213-013','3','0.35'),
('4213-013','1','0.3'),
('4213-013','5','0.2'),
('4213-013','6',NULL),

--lbd
('4233-005','2','0.333'),
('4233-005','3','0.333'),
('4233-005','4','0.333'),
('4233-005','6',NULL),

---mpc
('5005-220','8','0.2'),
('5005-220','7','0.8'),
('5005-220','6',NULL)

-----------------------------------------------------
----											 ----
----				CODIGO						 ----
----											 ----
-----------------------------------------------------

-- LISTAR AVALIAÇÃO POR DISCIPLINA E TURNO

CREATE PROCEDURE p_listarAvaliacoesPorDisciplinaETurno(@Disciplina VARCHAR(100), @Turno VARCHAR(10))
AS
BEGIN
	SELECT a.tipo FROM avaliacao a
		INNER JOIN avaliacaodisciplina ad ON a.codigo = ad.codigo_avaliacao
        INNER JOIN disciplina d ON d.codigo = ad.codigo_disciplina
        WHERE d.nome LIKE @Disciplina AND d.turno LIKE @Turno;
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LISTA ALUNO POR DISCIPLINA E TURNO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LISTA ALUNO POR DISCIPLINA

CREATE PROCEDURE p_listarAlunosPorDisciplinaETurno(@Disciplina VARCHAR(100), @Turno VARCHAR(10))
AS
BEGIN
	SELECT DISTINCT a.nome,a.ra FROM aluno a
		INNER JOIN presenca p ON a.ra = p.ra_aluno
        INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
        WHERE d.nome LIKE @Disciplina AND d.turno LIKE @Turno;
END 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LISTA TURNO


CREATE VIEW v_listarturnos
AS
SELECT DISTINCT turno FROM disciplina

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LISTA ALUNOS E NOTAS


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LISTA DISCIPLINA POR TURNO

CREATE PROCEDURE p_listarDisciplinasPorTurno(@Turno VARCHAR(10))
AS
BEGIN
	SELECT nome, turno, numeroAulas 
	FROM disciplina 
	WHERE turno LIKE @Turno
END 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- INSERIR NOTA

CREATE PROCEDURE p_inserirNota
(@Disciplina VARCHAR(100),
 @Turno VARCHAR(10), 
 @TipoAvaliacao VARCHAR(30), 
 @NomeAluno VARCHAR(250),
 @Valor DECIMAL(3,1))
AS
BEGIN
    
    /*OBTER CODIGO DA DISCIPLINA*/
    DECLARE @codigoDisciplina AS VARCHAR(MAX)
	SET @codigoDisciplina = (SELECT codigo FROM disciplina WHERE nome LIKE @Disciplina AND @turno LIKE @Turno)
    
    /*OBTER RA DO ALUNO*/
    DECLARE @RAAluno AS CHAR(8)
	SET @RAAluno = (SELECT ra FROM aluno WHERE nome LIKE @NomeAluno)
    
    /*OBTER O CODIGO DE AVALIACAO DE ACORDO COM O TIPO*/
	DECLARE @codigoAvaliacao AS INT
    SET @codigoAvaliacao = (SELECT codigo FROM avaliacao WHERE tipo LIKE @TipoAvaliacao)
    
    /*Verificar se ja nao existe uma nota para a mesma avaliacao da mesma disciplina no mesmo turno*/
	DECLARE @totalNotasMesmaAvaliacao AS INT
	SET @totalNotasMesmaAvaliacao = (SELECT COUNT(n.valor) FROM nota n 
										INNER JOIN aluno a ON n.ra_aluno = a.ra
										INNER JOIN disciplina d ON n.codigo_disciplina = d.codigo
										INNER JOIN avaliacao av ON n.codigo_avaliacao = av.codigo
										WHERE d.codigo LIKE @codigoDisciplina
										AND a.ra LIKE @RAAluno
										AND av.tipo LIKE @TipoAvaliacao)
	

    IF (@totalNotasMesmaAvaliacao = 0)
	BEGIN 
		/*INSERIR NOTAS...*/
        INSERT INTO nota(ra_aluno,codigo_disciplina,codigo_avaliacao,valor) VALUES(@RAAluno,@codigoDisciplina,@codigoAvaliacao,@Valor)
    END
	ELSE
	BEGIN
		/*ERRO!*/
       RAISERROR('Ja foi inserida uma nota de P1 para este aluno',16,1)
	END
END 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- INSERIR PRESENÇA

CREATE PROCEDURE p_inserirPresenca(@Disciplina VARCHAR(100), @Turno VARCHAR(10), @Data VARCHAR(30), @RAAluno VARCHAR(250), @Presencas INT)
AS
BEGIN
    /*OBTER CODIGO DA DISCIPLINA*/
	DECLARE @codigoDisciplina AS VARCHAR(MAX)
    SET @codigoDisciplina = (SELECT codigo FROM disciplina WHERE nome LIKE @Disciplina AND turno LIKE @Turno)
    
    /*Verificar se ja nao existe uma nota para a mesma avaliacao da mesma disciplina no mesmo turno*/
	DECLARE @totalPresencasMesmaData AS INT
	SET @totalPresencasMesmaData = (SELECT COUNT(p.data) FROM presenca p 
																	INNER JOIN aluno a ON p.ra_aluno = a.ra
																	INNER JOIN disciplina d ON p.codigo_disciplina = d.codigo
																	WHERE d.nome LIKE @Disciplina
																	AND p.data LIKE @Data
																	AND d.turno LIKE @Turno
																	AND a.ra LIKE @RAAluno)
	/*VERIFICAR SE NAO EXISTEM MAIS DE 23 PRESENCAS!!*/
    IF (@totalPresencasMesmaData = 0)
	BEGIN	
		/*INSERIR PRESENCAS*/
        INSERT INTO presenca(ra_aluno,codigo_disciplina,data,presenca) VALUES(@RAAluno,@codigoDisciplina,@Data,@Presencas)
    END
	ELSE
	BEGIN
		/*ERRO!*/
       RAISERROR('Ja foram inseridas presencas de P1 para estes alunos!',16,1) 
	END
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LISTA PRESENÇAS


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LISTA DATAS 



SELECT * FROM v_listarturnos

EXEC p_listarDisciplinasPorTurno 'Tarde'

EXEC p_listarAlunosPorDisciplinaETurno 'Banco de Dados','Tarde'

EXEC p_listarAvaliacoesPorDisciplinaETurno 'Métodos para Produção do Conhecimento','Manhã'

EXEC p_inserirNota 'Banco de Dados','Tarde','T','Sapakla','9.3'

EXEC p_inserirPresenca 'Banco de Dados','Tarde','10/06/2017','151000-2',4

SELECT * FROM nota