package com.PartilhoUX.model;

import java.util.Date;

public class Presenca {
	private Aluno aluno;
	private Date data;
	private int presenca;
	private Disciplina disciplina;
	
	public Aluno getAluno() {
		return aluno;
	}
	public void setAluno(Aluno aluno) {
		this.aluno = aluno;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	public int getPresenca() {
		return presenca;
	}
	public void setPresenca(int presenca) {
		this.presenca = presenca;
	}
	public Disciplina getDisciplina() {
		return disciplina;
	}
	public void setDisciplina(Disciplina disciplina) {
		this.disciplina = disciplina;
	}
}
