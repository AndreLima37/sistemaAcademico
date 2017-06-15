package com.PartilhoUX.persistence.interfaces;

import java.util.List;

import com.PartilhoUX.model.Avaliacao;
import com.PartilhoUX.model.Disciplina;

public interface IAvaliacaoDAO {
	
	/**
	 * 
	 * @param disciplina
	 * Os seguintes par�metros ser�o passados na Query
	 * - Nome da disciplina
	 * - Turno
	 * 
	 * @return
	 * Saida esperada:
	 * - Lista com uma coluna s�, contendo o tipo das avalia��es existentes para essa disciplina
	 * 
	 */
	public List<Avaliacao> listarAvaliacoesPorDisciplina(Disciplina disciplina);
}
