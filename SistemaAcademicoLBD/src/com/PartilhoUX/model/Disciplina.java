package com.PartilhoUX.model;

public class Disciplina {
	private String codigo;
	private String nome;
	private String sigla;
	private String turno;
	private int numeroAulas;
	
	public Disciplina(String nome, String turno){
		this.nome = nome;
		this.turno = turno;
	}
	
	public Disciplina(){
		
	}
	
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getSigla() {
		return sigla;
	}
	public void setSigla(String sigla) {
		this.sigla = sigla;
	}
	public String getTurno() {
		return turno;
	}
	public void setTurno(String turno) {
		this.turno = turno;
	}
	public int getNumeroAulas() {
		return numeroAulas;
	}
	public void setNumeroAulas(int numeroAulas) {
		this.numeroAulas = numeroAulas;
	}
	@Override
	public String toString() {
		return this.nome;
	}
}
