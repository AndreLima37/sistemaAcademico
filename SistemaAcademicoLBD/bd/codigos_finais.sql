CREATE DATABASE sistemaAcademicos
USE sistemaAcademicos

--TABELAS--
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
	data VARCHAR(10) NOT NULL,
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
----------

-----------------------------------------------------
----											 ----
----				INSERTS						 ----
----											 ----
-----------------------------------------------------

--DADOS FICTICIOS--
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
('Angelo da Silva','151987-2'),
('Leandro Colevati','151510-2'),
('Andrea Zotovici','151039-2'),
('Antonio Rodrigues','151008-2'),
('Maria Marta','151800-2'),
('Wellington Pinto','154000-2'),
('Andre Lima','151220-2'),
('Ricardo Satoshi','151450-3'),
('Jessica Carneiro','151006-4'),
('Francisco Carlos','151070-5'),
('Luciano Francisco','151000-6'),
('Angelo Lotierso','151000-7'),
('Edson Saraiva','151000-8'),
('Maria Galvão','151000-9'),
('Edimilson Rodrigues','151090-1'),
('Jaimes Lannister','151080-1'),
('Robert Baratheon','151066-2'),
('Nilton Leitão','151000-3'),
('Marcos Lima','151022-2'),
('Jakob Nielsen','151024-2'),
('Ivo Branquinho','151256-2'),
('Paulo Cristiano','151451-2'),
('Edward Stark','151431-2'),
('Roose Bolton','154512-2'),
('Mario Bros','151542-2'),
('Luigi Bros','151556-3'),
('Anthony Salvati','151678-4'),
('Carlos Mil','151982-5'),
('João Tadeu','151444-6'),
('Gleba Souza','151211-7'),
('Naruto Uzumaki','151233-8'),
('Wario Bros','151432-9'),
('Min Yoongi','151433-1'),
('Baekhyun','151665-1'),
('Jackson Wang','151776-2'),
('Gilberto Kossack','151443-3')
SELECT * FROM aluno

INSERT INTO presenca
(ra_aluno,
codigo_disciplina,
data,
presenca)
VALUES
('151000-3','4203-010','2017-06-06',4),
('151000-6','4203-010','2017-06-06',4),
('151000-7','4203-020','2017-06-06',4),
('151000-8','4203-020','2017-06-06',4),
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

INSERT INTO nota
(ra_aluno,codigo_disciplina,codigo_avaliacao,valor)
VALUES
('151000-3','4203-010','1',4.0),
('151000-6','4203-010','1',4.0),
('151000-7','4203-020','1',4.0),
('151000-8','4203-020','1',4.0),
('151000-9','4208-010','1',5.0),
('151006-4','4208-010','1',3.0),
('151220-2','4213-003','1',2.0),
('151450-3','4213-003','1',4.0),
('151006-4','4213-013','1',4.0),
('151070-5','4213-013','1',4.0),
('151000-6','4226-004','1',4.0),
('151000-7','4226-004','1',4.0),
('151000-8','4233-005','1',2.0),
('151000-9','4233-005','1',4.0),
('151090-1','4233-005','1',4.0),
('151008-2','5005-220','1',2.0),
('151066-2','5005-220','1',2.0),
('151000-3','5005-220','1',4.0)

-----------------------------------------------------
----											 ----
----			    PROGRAMAÇÃO					 ----
----											 ----
-----------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LISTA ALUNOS E NOTAS
CREATE FUNCTION f_listarNotas(@disciplina VARCHAR(MAX), @turno VARCHAR(MAX))
RETURNS @notasListadas TABLE (
	aluno VARCHAR(MAX),
    ra VARCHAR(MAX),
    p1 DECIMAL(4,1),
    p2 DECIMAL(4,1),
    p3 DECIMAL(4,1),
    t DECIMAL(4,1),
    preExame DECIMAL(4,1),
    exame DECIMAL(4,1),
    media DECIMAL(4,1),
    situacao VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @nomeAluno VARCHAR(MAX)
	DECLARE @ra VARCHAR(MAX)
    
	DECLARE c_notasPorAluno CURSOR
	FOR SELECT DISTINCT ra,nome FROM aluno

 	OPEN c_notasPorAluno
	FETCH NEXT FROM c_notasPorAluno INTO @ra, @nomeAluno

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Se o ra estiver dentro dos ras disponiveis
		IF (@ra IN (SELECT DISTINCT a.ra FROM aluno a INNER JOIN nota n ON n.ra_aluno = a.ra
														  INNER JOIN disciplina d ON n.codigo_disciplina = d.codigo
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno))
		BEGIN
			-- Obter Notas de todas as avaliacoes possiveis
			DECLARE @notaP1 DECIMAL(4,2)
			SET @notaP1 = (SELECT n.valor FROM nota n INNER JOIN aluno a ON a.ra = n.ra_aluno
														INNER JOIN disciplina d ON d.codigo = n.codigo_disciplina
														INNER JOIN avaliacao av ON n.codigo_avaliacao = av.codigo
														WHERE a.ra = @ra
														AND d.nome LIKE @disciplina
														AND d.turno LIKE @turno
														AND av.tipo LIKE 'P1')

			DECLARE @notaP2 DECIMAL(4,2)
			SET @notaP2 = (SELECT n.valor FROM nota n INNER JOIN aluno a ON a.ra = n.ra_aluno
														INNER JOIN disciplina d ON d.codigo = n.codigo_disciplina
														INNER JOIN avaliacao av ON n.codigo_avaliacao = av.codigo
														WHERE a.ra = @ra
														AND d.nome LIKE @disciplina
														AND d.turno LIKE @turno
														AND av.tipo LIKE 'P2')
		
			DECLARE @notaP3 DECIMAL(4,2)
			SET @notaP3 = (SELECT n.valor FROM nota n INNER JOIN aluno a ON a.ra = n.ra_aluno
														INNER JOIN disciplina d ON d.codigo = n.codigo_disciplina
														INNER JOIN avaliacao av ON n.codigo_avaliacao = av.codigo
														WHERE a.ra = @ra
														AND d.nome LIKE @disciplina
														AND d.turno LIKE @turno
														AND av.tipo LIKE 'P3')
		
			DECLARE @trabalho DECIMAL(4,2)
			SET @trabalho = (SELECT n.valor FROM nota n INNER JOIN aluno a ON a.ra = n.ra_aluno
														INNER JOIN disciplina d ON d.codigo = n.codigo_disciplina
														INNER JOIN avaliacao av ON n.codigo_avaliacao = av.codigo
														WHERE a.ra = @ra
														AND d.nome LIKE @disciplina
														AND d.turno LIKE @turno
														AND av.tipo LIKE 'T')
		
			DECLARE @preExame DECIMAL(4,2)
			SET @preExame = (SELECT n.valor FROM nota n INNER JOIN aluno a ON a.ra = n.ra_aluno
														INNER JOIN disciplina d ON d.codigo = n.codigo_disciplina
														INNER JOIN avaliacao av ON n.codigo_avaliacao = av.codigo
														WHERE a.ra = @ra
														AND d.nome LIKE @disciplina
														AND d.turno LIKE @turno
														AND av.tipo LIKE 'Pre-Exame')
		
			DECLARE @exame DECIMAL(4,2)
			SET @exame = (SELECT n.valor FROM nota n INNER JOIN aluno a ON a.ra = n.ra_aluno
														INNER JOIN disciplina d ON d.codigo = n.codigo_disciplina
														INNER JOIN avaliacao av ON n.codigo_avaliacao = av.codigo
														WHERE a.ra = @ra
														AND d.nome LIKE @disciplina
														AND d.turno LIKE @turno
														AND av.tipo LIKE 'Exame')
		
			DECLARE @monografiaResumida DECIMAL(4,2)
			SET @monografiaResumida = (SELECT n.valor FROM nota n INNER JOIN aluno a ON a.ra = n.ra_aluno
														INNER JOIN disciplina d ON d.codigo = n.codigo_disciplina
														INNER JOIN avaliacao av ON n.codigo_avaliacao = av.codigo
														WHERE a.ra = @ra
														AND d.nome LIKE @disciplina
														AND d.turno LIKE @turno
														AND av.tipo LIKE 'Monografia-Resumida')
		
			DECLARE @monografiaCompleta DECIMAL(4,2)
			SET @monografiaCompleta = (SELECT n.valor FROM nota n INNER JOIN aluno a ON a.ra = n.ra_aluno
														INNER JOIN disciplina d ON d.codigo = n.codigo_disciplina
														INNER JOIN avaliacao av ON n.codigo_avaliacao = av.codigo
														WHERE a.ra = @ra
														AND d.nome LIKE @disciplina
														AND d.turno LIKE @turno
														AND av.tipo LIKE 'Monografia-Completa')
		
			-- CODIGO DO CALCULO DA MEDIA E DAS AVALIACOES...
			DECLARE @media DECIMAL(4,2)
			DECLARE @mediaFinal DECIMAL(4,2)
			DECLARE @situacao VARCHAR(MAX)

			/*ZERAR TODOS OS VALORES CASO SEJAM NULL*/
			IF(@notaP1 IS NULL)
			BEGIN
				SET @notaP1 = 0
			END
			IF(@notaP2 IS NULL)
			BEGIN
				SET @notaP2 = 0
			END
			IF(@notaP3 IS NULL)
			BEGIN
				SET @notaP3 = 0
			END
			IF(@trabalho IS NULL)
			BEGIN
				SET @trabalho = 0
			END
			IF(@preExame IS NULL)
			BEGIN
				SET @preExame = 0
			END
			IF(@exame IS NULL)
			BEGIN
				SET @exame = 0
			END
			IF(@mediaFinal IS NULL)
			BEGIN
				SET @mediaFinal = 0
			END


			/*Se a disciplina igual a SOI*/
			IF (@disciplina LIKE 'Sistemas Operacionais I')
			BEGIN
				SET @media = (SELECT ((@notaP1 * 0.35) + (@notaP2 * 0.35) + (@trabalho * 0.3)))
				SET @mediaFinal = @media
			
				IF (@media >= 3 AND @media < 6)
				BEGIN
					SET @mediaFinal = @media + (@preExame * 0.2)
				END 
			END
			ELSE
			BEGIN
				SET @preExame = 0
			END
    
			/*Se a disciplina igual a LBD*/
			IF (@disciplina LIKE 'Laboratório de Banco de Dados')
			BEGIN
				SET @media = (SELECT ((@notaP1 * 0.333) + (@notaP2 * 0.333) + (@notaP3 * 0.333)))
				SET @mediaFinal = @media
			END
			ELSE
			BEGIN
				SET @notaP3 = 0
			END
    
			/*Se a disciplina igual a MPC*/
			IF (@disciplina LIKE 'Métodos para Produção do Conhecimento')
			BEGIN
				SET @media = (SELECT ((@monografiaResumida * 0.2) + (@monografiaCompleta * 0.8)))
				SET @mediaFinal = @media
			END
			ELSE
			BEGIN
				SET @monografiaResumida = 0
				SET @monografiaCompleta = 0
			END
    
			/*Se a disciplina igual a AOC, BD, LBH, - Tarde e Noite e qualquer outra materia...*/
			IF (@disciplina <> 'Métodos para Produção do Conhecimento' AND
				@disciplina <> 'Laboratório de Banco de Dados' AND
				@disciplina <> 'Sistemas Operacionais I')
			BEGIN
				SET @media = (SELECT ((@notaP1 * 0.3) + (@notaP2 * 0.5) + (@trabalho * 0.2)))
				SET @mediaFinal = @media
			END
    
			/*Calculo generico do exame*/
			IF (@exame <> 0)
			BEGIN
				SET @mediaFinal = (@media + @exame) / 2
			END
    
			/*VERIFICAR ESTADO DO ALUNO*/
			IF (@mediaFinal < 3)
			BEGIN
				SET @situacao = 'Reprovado'
			END
			ELSE IF (@mediaFinal >= 3 AND @mediaFinal < 6)
			BEGIN
				SET @situacao = 'Exame'
			END
			ELSE IF (@mediaFinal >= 6)
			BEGIN
				SET @situacao = 'Aprovado'
			END
			
			
			/*INSERCAO NA TABELA TEMPORARIA DE NOTAS*/
			INSERT INTO @notasListadas(aluno,ra,p1,p2,p3,t,preExame,exame,media,situacao)
			VALUES (@nomeAluno,@ra,@notaP1,
									@notaP2,
									@notaP3,
									@trabalho,
									@preExame,
									@exame,
									@mediaFinal,
									@situacao)
			-- -----------------------------------------
		END 
		FETCH NEXT FROM c_notasPorAluno INTO @ra, @nomeAluno
	END
	CLOSE c_notasPorAluno
	DEALLOCATE c_notasPorAluno
    
    RETURN
END

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
										WHERE d.codigo = @codigoDisciplina
										AND a.ra = @RAAluno
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
	/*CONVERTER DATA!*/
	DECLARE @DataConvertida DATETIME
	SET @DataConvertida = (SELECT CONVERT(VARCHAR(10),@Data,126))
	SET @Data = (SELECT CONVERT(VARCHAR(10),@DataConvertida,126))

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
																	AND a.ra = @RAAluno)
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
CREATE FUNCTION f_listarPresencas(@disciplina VARCHAR(MAX), @turno VARCHAR(MAX))
RETURNS @presencasListadas TABLE (
		aluno VARCHAR(MAX),
        ra VARCHAR(MAX),
        dia1 VARCHAR(MAX),
        dia2 VARCHAR(MAX),
        dia3 VARCHAR(MAX),
        dia4 VARCHAR(MAX),
        dia5 VARCHAR(MAX),
        dia6 VARCHAR(MAX),
        dia7 VARCHAR(MAX),
		dia8 VARCHAR(MAX),
		dia9 VARCHAR(MAX),
		dia10 VARCHAR(MAX),
		dia11 VARCHAR(MAX),
		dia12 VARCHAR(MAX),
		dia13 VARCHAR(MAX),
		dia14 VARCHAR(MAX),
		dia15 VARCHAR(MAX),
		dia16 VARCHAR(MAX),
		dia17 VARCHAR(MAX),
		dia18 VARCHAR(MAX),
		dia19 VARCHAR(MAX),
		dia20 VARCHAR(MAX),
        presencas INT
	)
AS
BEGIN
	DECLARE @nomeAluno VARCHAR(MAX)
	DECLARE @ra VARCHAR(MAX)
    
	DECLARE c_notasPorAluno CURSOR
	FOR SELECT DISTINCT ra,nome FROM aluno

 	OPEN c_notasPorAluno
	FETCH NEXT FROM c_notasPorAluno INTO @ra, @nomeAluno

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Se o ra estiver dentro dos ras disponiveis
		IF (@ra IN (SELECT a.ra FROM aluno a INNER JOIN presenca p ON p.ra_aluno = a.ra
										 INNER JOIN disciplina d ON p.codigo_disciplina = d.codigo
																WHERE d.nome LIKE @disciplina AND
				 													  d.turno LIKE @turno))
		BEGIN
			-- OBTER CARGA HORARIA DA DISCIPLINA E AS AULAS!
			DECLARE @cargaHoraria INT
			SET @cargaHoraria = (SELECT (numeroAulas / 20) FROM disciplina WHERE nome = @disciplina AND turno = @turno)

			-- OBTER AS 20 DATAS
			DECLARE @dia1 VARCHAR(MAX)
			SET @dia1 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,1))

			DECLARE @dia2 VARCHAR(MAX)
			SET @dia2 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,2))

			DECLARE @dia3 VARCHAR(MAX)
			SET @dia3 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,3))

			DECLARE @dia4 VARCHAR(MAX)
			SET @dia4 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,4))

			DECLARE @dia5 VARCHAR(MAX)
			SET @dia5 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,5))

			DECLARE @dia6 VARCHAR(MAX)
			SET @dia6 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,6))

			DECLARE @dia7 VARCHAR(MAX)
			SET @dia7 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,7))

			DECLARE @dia8 VARCHAR(MAX)
			SET @dia8 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,8))

			DECLARE @dia9 VARCHAR(MAX)
			SET @dia9 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,9))

			DECLARE @dia10 VARCHAR(MAX)
			SET @dia10 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,10))

			DECLARE @dia11 VARCHAR(MAX)
			SET @dia11 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,11))

			DECLARE @dia12 VARCHAR(MAX)
			SET @dia12 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,12))

			DECLARE @dia13 VARCHAR(MAX)
			SET @dia13 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,13))

			DECLARE @dia14 VARCHAR(MAX)
			SET @dia14 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,14))

			DECLARE @dia15 VARCHAR(MAX)
			SET @dia15 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,15))

			DECLARE @dia16 VARCHAR(MAX)
			SET @dia16 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,16))

			DECLARE @dia17 VARCHAR(MAX)
			SET @dia17 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,17))

			DECLARE @dia18 VARCHAR(MAX)
			SET @dia18 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,18))

			DECLARE @dia19 VARCHAR(MAX)
			SET @dia19 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,19))
			
			DECLARE @dia20 VARCHAR(MAX)
			SET @dia20 = (SELECT dbo.f_obterDataDePresenca(@disciplina,@turno,20))

			-- OBTER TOTAL DE PRESENCAS POR DATA
			DECLARE @presencasDia1 INT
			SET @presencasDia1 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia1 AND
																	  a.ra = @ra)

			DECLARE @presencasDia2 INT
			SET @presencasDia2 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia2 AND
																	  a.ra = @ra)

			DECLARE @presencasDia3 INT
			SET @presencasDia3 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia3 AND
																	  a.ra = @ra)

			DECLARE @presencasDia4 INT
			SET @presencasDia4 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia4 AND
																	  a.ra = @ra)

			DECLARE @presencasDia5 INT
			SET @presencasDia5 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia5 AND
																	  a.ra = @ra)

			DECLARE @presencasDia6 INT
			SET @presencasDia6 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia6 AND
																	  a.ra = @ra)

			DECLARE @presencasDia7 INT
			SET @presencasDia7 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia7 AND
																	  a.ra = @ra)

			DECLARE @presencasDia8 INT
			SET @presencasDia8 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia8 AND
																	  a.ra = @ra)

			DECLARE @presencasDia9 INT
			SET @presencasDia9 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia9 AND
																	  a.ra = @ra)

			DECLARE @presencasDia10 INT
			SET @presencasDia10 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia10 AND
																	  a.ra = @ra)

			DECLARE @presencasDia11 INT
			SET @presencasDia11 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data >= @dia11 AND
																	  a.ra = @ra)

			DECLARE @presencasDia12 INT
			SET @presencasDia12 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia12 AND
																	  a.ra = @ra)

			DECLARE @presencasDia13 INT
			SET @presencasDia13 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia13 AND
																	  a.ra = @ra)

			DECLARE @presencasDia14 INT
			SET @presencasDia14 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia14 AND
																	  a.ra = @ra)
			
			DECLARE @presencasDia15 INT
			SET @presencasDia15 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia15 AND
																	  a.ra = @ra)

			DECLARE @presencasDia16 INT
			SET @presencasDia16 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia16 AND
																	  a.ra = @ra)
			
			DECLARE @presencasDia17 INT
			SET @presencasDia17 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia17 AND
																	  a.ra = @ra)

			DECLARE @presencasDia18 INT
			SET @presencasDia18 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia18 AND
																	  a.ra = @ra)
			

			DECLARE @presencasDia19 INT
			SET @presencasDia19 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia19 AND
																	  a.ra = @ra)

			DECLARE @presencasDia20 INT
			SET @presencasDia20 = (SELECT p.presenca FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
													   	   INNER JOIN aluno a ON a.ra = p.ra_aluno
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno AND
																	  p.data LIKE @dia20 AND
																	  a.ra = @ra)
			
			
			-- CONVERTER AS PRESENCAS PARA FFFF OU PPPP...
			DECLARE @presencasEscritasDia1 VARCHAR(MAX)
			SET @presencasEscritasDia1 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia1,@cargaHoraria))

			DECLARE @presencasEscritasDia2 VARCHAR(MAX)
			SET @presencasEscritasDia2 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia2,@cargaHoraria))

			DECLARE @presencasEscritasDia3 VARCHAR(MAX)
			SET @presencasEscritasDia3 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia3,@cargaHoraria))

			DECLARE @presencasEscritasDia4 VARCHAR(MAX)
			SET @presencasEscritasDia4 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia4,@cargaHoraria))

			DECLARE @presencasEscritasDia5 VARCHAR(MAX)
			SET @presencasEscritasDia5 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia5,@cargaHoraria))

			DECLARE @presencasEscritasDia6 VARCHAR(MAX)
			SET @presencasEscritasDia6 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia6,@cargaHoraria))

			DECLARE @presencasEscritasDia7 VARCHAR(MAX)
			SET @presencasEscritasDia7 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia7,@cargaHoraria))

			DECLARE @presencasEscritasDia8 VARCHAR(MAX)
			SET @presencasEscritasDia8 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia8,@cargaHoraria))

			DECLARE @presencasEscritasDia9 VARCHAR(MAX)
			SET @presencasEscritasDia9 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia9,@cargaHoraria))

			DECLARE @presencasEscritasDia10 VARCHAR(MAX)
			SET @presencasEscritasDia10 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia10,@cargaHoraria))

			DECLARE @presencasEscritasDia11 VARCHAR(MAX)
			SET @presencasEscritasDia11 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia11,@cargaHoraria))

			DECLARE @presencasEscritasDia12 VARCHAR(MAX)
			SET @presencasEscritasDia12 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia12,@cargaHoraria))

			DECLARE @presencasEscritasDia13 VARCHAR(MAX)
			SET @presencasEscritasDia13 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia13,@cargaHoraria))

			DECLARE @presencasEscritasDia14 VARCHAR(MAX)
			SET @presencasEscritasDia14 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia14,@cargaHoraria))

			DECLARE @presencasEscritasDia15 VARCHAR(MAX)
			SET @presencasEscritasDia15 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia15,@cargaHoraria))

			DECLARE @presencasEscritasDia16 VARCHAR(MAX)
			SET @presencasEscritasDia16 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia16,@cargaHoraria))

			DECLARE @presencasEscritasDia17 VARCHAR(MAX)
			SET @presencasEscritasDia17 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia17,@cargaHoraria))

			DECLARE @presencasEscritasDia18 VARCHAR(MAX)
			SET @presencasEscritasDia18 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia18,@cargaHoraria))

			DECLARE @presencasEscritasDia19 VARCHAR(MAX)
			SET @presencasEscritasDia19 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia19,@cargaHoraria))

			DECLARE @presencasEscritasDia20 VARCHAR(MAX)
			SET @presencasEscritasDia20 = (SELECT dbo.f_obterPresencasEscritas(@presencasDia20,@cargaHoraria))
			
			IF (@presencasDia1 IS NULL) BEGIN SET @presencasDia1 = 0 END
			IF (@presencasDia2 IS NULL) BEGIN SET @presencasDia2 = 0 END
			IF (@presencasDia3 IS NULL) BEGIN SET @presencasDia3 = 0 END
			IF (@presencasDia4 IS NULL) BEGIN SET @presencasDia4 = 0 END
			IF (@presencasDia5 IS NULL) BEGIN SET @presencasDia5 = 0 END
			IF (@presencasDia6 IS NULL) BEGIN SET @presencasDia6 = 0 END
			IF (@presencasDia7 IS NULL) BEGIN SET @presencasDia7 = 0 END
			IF (@presencasDia8 IS NULL) BEGIN SET @presencasDia8 = 0 END
			IF (@presencasDia9 IS NULL) BEGIN SET @presencasDia9 = 0 END
			IF (@presencasDia10 IS NULL) BEGIN SET @presencasDia10 = 0 END
			IF (@presencasDia11 IS NULL) BEGIN SET @presencasDia11 = 0 END
			IF (@presencasDia12 IS NULL) BEGIN SET @presencasDia12 = 0 END
			IF (@presencasDia13 IS NULL) BEGIN SET @presencasDia13 = 0 END
			IF (@presencasDia14 IS NULL) BEGIN SET @presencasDia14 = 0 END
			IF (@presencasDia15 IS NULL) BEGIN SET @presencasDia15 = 0 END
			IF (@presencasDia16 IS NULL) BEGIN SET @presencasDia16 = 0 END
			IF (@presencasDia17 IS NULL) BEGIN SET @presencasDia17 = 0 END
			IF (@presencasDia18 IS NULL) BEGIN SET @presencasDia18 = 0 END
			IF (@presencasDia19 IS NULL) BEGIN SET @presencasDia19 = 0 END
			IF (@presencasDia20 IS NULL) BEGIN SET @presencasDia20 = 0 END

			-- AJUSTAR TOTAL DE FALTAS
			DECLARE @totalFaltas INT 
			SET @totalFaltas = 0
			SET @totalFaltas = (SELECT (@presencasDia1 +
										@presencasDia2 + 
										@presencasDia3 +
										@presencasDia4 +
										@presencasDia5 +
										@presencasDia6 +
										@presencasDia7 +
										@presencasDia8 +
										@presencasDia9 +
										@presencasDia10 +
										@presencasDia11 +
										@presencasDia12 + 
										@presencasDia13 +
										@presencasDia14 +
										@presencasDia15 +
										@presencasDia16 +
										@presencasDia17 +
										@presencasDia18 +
										@presencasDia19 +
										@presencasDia20))

			/*INSERCAO NA TABELA TEMPORARIA DE PRESENCAS*/
			INSERT INTO @presencasListadas(aluno,ra,dia1,dia2,dia3,dia4,dia5,dia6,dia7,dia8,dia9,dia10,dia11,dia12,dia13,dia14,dia15,dia16,dia17,dia18,dia19,dia20,presencas)
			VALUES (@nomeAluno,@ra,@presencasEscritasDia1,
									@presencasEscritasDia2,
									@presencasEscritasDia3,
									@presencasEscritasDia4,
									@presencasEscritasDia5,
									@presencasEscritasDia6,
									@presencasEscritasDia7,
									@presencasEscritasDia8,
									@presencasEscritasDia9,
									@presencasEscritasDia10,
									@presencasEscritasDia11,
									@presencasEscritasDia12,
									@presencasEscritasDia13,
									@presencasEscritasDia14,
									@presencasEscritasDia15,
									@presencasEscritasDia16,
									@presencasEscritasDia17,
									@presencasEscritasDia18,
									@presencasEscritasDia19,
									@presencasEscritasDia20,
									@totalFaltas)
			-- -----------------------------------------
		END 
		FETCH NEXT FROM c_notasPorAluno INTO @ra, @nomeAluno
	END
	CLOSE c_notasPorAluno
	DEALLOCATE c_notasPorAluno
    
    RETURN
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OBTER DATA (PRIVATE)
CREATE FUNCTION f_obterDataDePresenca(@disciplina VARCHAR(MAX), @turno VARCHAR(MAX), @posicao INT)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @data VARCHAR(MAX)
	DECLARE @contador INT
	DECLARE @stopLoop BIT
	SET @contador = 1
	SET @stopLoop = 0
	
	DECLARE c_dataPorPosicao CURSOR
	FOR SELECT p.data FROM presenca p INNER JOIN disciplina d ON p.codigo_disciplina = d.codigo ORDER BY d.nome, p.data

 	OPEN c_dataPorPosicao
	FETCH NEXT FROM c_dataPorPosicao INTO @data 

	WHILE @@FETCH_STATUS = 0 AND @stopLoop = 0
	BEGIN
		--Se a data estiver dentro das datas daquela disciplina e daquele turno
		IF (@data IN (SELECT p.data FROM presenca p INNER JOIN disciplina d ON d.codigo = p.codigo_disciplina
																WHERE d.nome LIKE @disciplina AND
																	  d.turno LIKE @turno))
		BEGIN
			
			DECLARE @dataEquivalente VARCHAR(MAX)

			--Se posicao ja foi alcancada
			IF(@posicao = @contador)
			BEGIN 
				SET @dataEquivalente = @data
				SET @stopLoop = 1
			END
			ELSE
			BEGIN
				SET @contador = @contador + 1
			END
			FETCH NEXT FROM c_dataPorPosicao INTO @data
			
		END
		FETCH NEXT FROM c_dataPorPosicao INTO @data
	END
	CLOSE c_dataPorPosicao
	DEALLOCATE c_dataPorPosicao

	RETURN @dataEquivalente
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OBTER PRESENCAS ESCRITAS (PRIVATE)
CREATE FUNCTION f_obterPresencasEscritas(@totais INT, @aulas INT)
RETURNS VARCHAR(4)
AS
BEGIN
	DECLARE @contador INT
	SET @contador = 0

	DECLARE @presencas VARCHAR(4)
	SET @presencas = ''

	WHILE (@contador < @totais)
	BEGIN
		SET @presencas = (SELECT CONCAT(@presencas,'P'))
		SET @contador = @contador + 1
	END

	IF (@totais < @aulas)
	BEGIN
		SET @totais = @aulas - @totais
		SET @contador = 0

		WHILE (@contador < @totais)
		BEGIN
			SET @presencas = (SELECT CONCAT(@presencas,'F'))
			SET @contador = @contador + 1
		END
	END

	RETURN @presencas
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LISTA DATAS 
CREATE FUNCTION f_listarDatas(@disciplina VARCHAR(MAX), @turno VARCHAR(MAX))
RETURNS @tabela TABLE(
	data VARCHAR(MAX)
)
AS
BEGIN 
	INSERT INTO @tabela(data)
	SELECT DISTINCT CONVERT(VARCHAR(5),CONVERT(DATETIME,data,101),3) AS data FROM presenca
	RETURN
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




SELECT * FROM v_listarturnos

EXEC p_listarDisciplinasPorTurno 'Tarde'

EXEC p_listarAlunosPorDisciplinaETurno 'A','Tarde'

EXEC p_listarAvaliacoesPorDisciplinaETurno 'Métodos para Produção do Conhecimento','Manhã'

EXEC p_inserirNota 'Banco de Dados','Tarde','P2','Leandro Colevati','5.2'

EXEC p_inserirPresenca 'Arquitetura e Organização de Computadores','Tarde','27/06/2017','151000-6',4
EXEC p_inserirPresenca 'Banco de Dados','Tarde','03/06/2017','151000-7',2

EXEC p_listarNotas 'Banco de Dados','Tarde'

EXEC p_listarPresencas 'Arquitetura e Organização de Computadores','Tarde'

SELECT * FROM nota
SELECT * FROM disciplina
SELECT * FROM presenca
TRUNCATE TABLE presenca





