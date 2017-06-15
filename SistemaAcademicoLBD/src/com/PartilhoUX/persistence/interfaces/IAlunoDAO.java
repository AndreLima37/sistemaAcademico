package com.PartilhoUX.persistence.interfaces;

import java.util.List;

import com.PartilhoUX.model.Aluno;
import com.PartilhoUX.model.Disciplina;

public interface IAlunoDAO {
	/**
	 * 
	 * @param disciplina
	 * Os seguintes parâmetros serão passados na Query
	 * - Nome da disciplina
	 * - Turno
	 * 
	 * @return
	 * Saida esperada:
	 * - Tabela com as seguintes colunas:
	 * 		- RA
	 * 		- Nome
	 * 		- Total de Aulas		
	 * 
	 */
	public List<Aluno> listarAlunosPorDisciplinaETurno(Disciplina disciplina);
}
