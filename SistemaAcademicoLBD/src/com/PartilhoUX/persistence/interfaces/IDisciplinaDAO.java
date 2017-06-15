package com.PartilhoUX.persistence.interfaces;

import java.util.List;

import com.PartilhoUX.model.Disciplina;
public interface IDisciplinaDAO {
	
	/**
	 * 
	 * @return
	 * Saida esperada:
	 * - Lista com os turnos existentes (Manha, Tarde e Noite)
	 * 
	 */
	public List<String> listarTurnos();
	
	/**
	 * 
	 * @param turno
	 * Entradas:
	 * - Turno (Manha, tarde ou noite)
	 * 
	 * @return
	 * Saida esperada:
	 * - Uma tabela com duas colunas:
	 * 		- Nome
	 * 		- Numero de aulas (80 ou 40) 
	 * 
	 */
	public List<Disciplina> listarDisciplinasPorTurno(String turno);
	
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
	 * 		- Nota da Avaliacao 1 (P1 ou M. Resumida)
	 * 		- Nota da Avaliacao 2 (P2 ou M. Completa)
	 * 		- Nota da Avaliacao 3 (P3 ou T.) Se não houver, poder ser NULL
	 * 		- Nota de Pre Exame (Se não houver, poder ser NULL)
	 * 		- Nota de Exame (Se não houver, poder ser NULL)
	 * 		- Media calculada de acordo com os pesos das respectivas avaliações
	 * 		- Situação (Aprovado, Reprovado, ou Exame) 
	 * 
	 */
	public List<List<String>> listarAlunosENotas(Disciplina disciplina);
}
