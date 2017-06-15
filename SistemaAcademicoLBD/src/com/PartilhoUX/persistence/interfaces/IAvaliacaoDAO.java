package com.PartilhoUX.persistence.interfaces;

import java.util.List;

import com.PartilhoUX.model.Avaliacao;
import com.PartilhoUX.model.Disciplina;

public interface IAvaliacaoDAO {
	
	/**
	 * 
	 * @param disciplina
	 * Os seguintes parâmetros serão passados na Query
	 * - Nome da disciplina
	 * - Turno
	 * 
	 * @return
	 * Saida esperada:
	 * - Lista com uma coluna só, contendo o tipo das avaliações existentes para essa disciplina
	 * 
	 */
	public List<Avaliacao> listarAvaliacoesPorDisciplina(Disciplina disciplina);
}
