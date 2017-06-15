package com.PartilhoUX.persistence.interfaces;

import java.sql.SQLException;
import java.util.List;

import com.PartilhoUX.model.Disciplina;
import com.PartilhoUX.model.Presenca;

public interface IPresencaDAO {
	/**
	 * 
	 * @param presenca
	 * Entradas:
	 * - Data
	 * - Turno
	 * - Disciplina
	 * - RA
	 * - Total de presencas (ou faltas) (Varia de 0 a 4)
	 * 
	 */
	public void inserirPresenca(Presenca presenca) throws SQLException;
	
	/**
	 * 
	 * @param disciplina
	 * Entradas:
	 * - Nome da Disciplina
	 * - Turno
	 * 
	 * @return
	 * Saida esperada:
	 * - Uma tabela com as seguintes:
	 * 		- RA
	 * 		- Nome
	 * 		- Quantidade de faltas deste aluno na data 1 (EX: FFFF, PPPP, FFPP, PPFF...)
	 * 		- Quantidade de faltas deste aluno na data 2
	 * 		- Quantidade de faltas deste aluno na data 3
	 * 		- Quantidade de faltas deste aluno na data 4
	 * 		- Quantidade de faltas deste aluno na data 5
	 * 		- Quantidade de faltas deste aluno na data 6
	 * 		- Quantidade de faltas deste aluno na data 7
	 * 		- Quantidade de faltas deste aluno na data 8
	 * 		- Quantidade de faltas deste aluno na data 9
	 * 		- Quantidade de faltas deste aluno na data 10
	 * 		- Quantidade de faltas deste aluno na data 11
	 * 		- Quantidade de faltas deste aluno na data 12
	 * 		- Quantidade de faltas deste aluno na data 13
	 * 		- Quantidade de faltas deste aluno na data 14
	 * 		- Quantidade de faltas deste aluno na data 15
	 * 		- Quantidade de faltas deste aluno na data 16
	 * 		- Quantidade de faltas deste aluno na data 17
	 * 		- Quantidade de faltas deste aluno na data 18
	 * 		- Quantidade de faltas deste aluno na data 19
	 * 		- Quantidade de faltas deste aluno na data 20
	 * 		- Total de Faltas A soma de todas as faltas 
	 * 
	 */
	public List<List<String>> listarPresencas(Disciplina disciplina);
	
	/**
	 * 
	 * @param disciplina
	 * Entradas:
	 * - Nome da Disciplina
	 * - Turno
	 * 
	 * @return
	 * Tabela com apenas uma coluna, contendo todas as datas das aulas
	 * 
	 */
	public List<String> listarDatas(Disciplina disciplina);
}
