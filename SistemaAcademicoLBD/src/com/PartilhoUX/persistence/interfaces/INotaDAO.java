package com.PartilhoUX.persistence.interfaces;

import java.sql.SQLException;

import com.PartilhoUX.model.Nota;

public interface INotaDAO {
	/**
	 * 
	 * @param nota
	 * Entradas:
	 * - Valor da nota
	 * - Nome da Disciplina
	 * - Tipo da avaliacao
	 * - Nome do aluno
	 * 
	 */
	public void inserirNota(Nota nota) throws SQLException;
}
