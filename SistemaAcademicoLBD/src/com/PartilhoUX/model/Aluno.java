package com.PartilhoUX.model;

import java.io.Serializable;

public class Aluno implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4774555612515027575L;
	
	private String nome;
	private String ra;
	
	
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getRa() {
		return ra;
	}
	public void setRa(String ra) {
		this.ra = ra;
	}
	@Override
	public String toString() {
		return this.nome;
	}
	
}
