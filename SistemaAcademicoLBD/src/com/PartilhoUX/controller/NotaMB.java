package com.PartilhoUX.controller;

import java.io.Serializable;
import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import com.PartilhoUX.model.Aluno;
import com.PartilhoUX.model.Avaliacao;
import com.PartilhoUX.model.Disciplina;
import com.PartilhoUX.model.Nota;
import com.PartilhoUX.persistence.AlunoDAO;
import com.PartilhoUX.persistence.AvaliacaoDAO;
import com.PartilhoUX.persistence.DisciplinaDAO;
import com.PartilhoUX.persistence.NotaDAO;


@ManagedBean
@ViewScoped
public class NotaMB implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7410547166993508252L;
	
	//Models atuais
	private Nota nota;
	private Aluno aluno;
	private Disciplina disciplina;
	private Avaliacao avaliacao;
	
	//Lista de Turnos
	private List<String> turnos;
	//
	public void listarTurnos(){
		//Listar os turnos existentes
		DisciplinaDAO ddao = new DisciplinaDAO();
		turnos = ddao.listarTurnos();
	}

	//Lista de Disciplinas
	private List<Disciplina> disciplinas;
	//
	public void listarDisciplinas(){
		//Listar as disciplinas de acordo com um torno
		DisciplinaDAO ddao = new DisciplinaDAO();
		disciplinas = ddao.listarDisciplinasPorTurno(disciplina.getTurno());
	}
	
	//Lista de alunos
	private List<Aluno> alunos;
	//
	public void listarAlunos(){
		//Listar os alunos
		AlunoDAO aldao = new AlunoDAO();
		alunos = aldao.listarAlunosPorDisciplinaETurno(disciplina);
	}
	
	//Lista de avaliacoes
	private List<Avaliacao> avaliacoes;
	//
	public void listarAvaliacoes(){
		//Listar os alunos
		AvaliacaoDAO avdao = new AvaliacaoDAO();
		avaliacoes = avdao.listarAvaliacoesPorDisciplina(disciplina);
	}
	
	public NotaMB() {
		//Inicializacao das models atuais!
		nota = new Nota();
		aluno = new Aluno();
		disciplina = new Disciplina();
		avaliacao = new Avaliacao();
		nota.setAluno(aluno);
		nota.setDisciplina(disciplina);
		nota.setAvaliacao(avaliacao);
		//
		inicio();
	}
	
	//Inicio
	public void inicio(){
		//Preencher o combo box turno
		try{
			listarTurnos();
		}catch(Exception e){
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL, "Fatal!",
					"Nao foi possivel carregar os dados do banco de dados!"));
		}
	}
	
	//Evento Combobox turno selecionado
	public void turnoSelecionado(){
		//***
		//Se existir uma lista de alunos
		if(alunos != null && alunos.size() > 0){
			//Apagar a lista de alunos
			alunos = null;
			//Apagar a lista de avaliacoes
			avaliacoes = null;
		}	
		//Se existir uma lista de disciplinas
		if(disciplinas != null && disciplinas.size() > 0){
			//Apagar a lista de disciplinas
			disciplinas = null;
		}
		//***
		try{
			//listar todas as disciplinas naquele turno
			listarDisciplinas();
			//***
			//Se total da lista de disciplinas == 1
			if(disciplinas.size() == 1){
				//Atribui a primeira disciplina da lista
				disciplina.setNome(disciplinas.get(0).getNome());
				//Listar alunos
				//Monta a tabela dos alunos
				listarAlunos();
				//Listar avaliacoes
				listarAvaliacoes();
			}
		}catch(Exception e){
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL, "Fatal!",
					"Nao foi possivel carregar os dados do banco de dados!"));
		}
	}
	
	//Combobox disciplina selecionado
	public void disciplinaSelecionada(){
		//***
		if(alunos != null && alunos.size() > 0){
			//Apagar a lista de alunos
			alunos = null;
			//Apagar a lista de presencas
			avaliacoes = null;
		}	
		//***
		try{
			//Listar alunos
			//Monta a tabela dos alunos
			listarAlunos();
			//Monta a tabela dos alunos
			listarAlunos();
			//Listar avaliacoes
			listarAvaliacoes();
			//
		}catch(Exception e){
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL, "Fatal!",
					"Nao foi possivel carregar os dados do banco de dados!"));
		}
	}
	
	public void salvar(){
		//
		try{
			NotaDAO ndao = new NotaDAO();
			ndao.inserirNota(nota);
		}catch(Exception e){
			e.printStackTrace();
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Erro!",
					"Nao foi possivel salvar a nota!"));
		}
	}
	
	
	
	
	public List<String> getTurnos() {
		return turnos;
	}

	public void setTurnos(List<String> turnos) {
		this.turnos = turnos;
	}

	public List<Disciplina> getDisciplinas() {
		return disciplinas;
	}

	public void setDisciplinas(List<Disciplina> disciplinas) {
		this.disciplinas = disciplinas;
	}

	public List<Avaliacao> getAvaliacoes() {
		return avaliacoes;
	}

	public void setAvaliacoes(List<Avaliacao> avaliacoes) {
		this.avaliacoes = avaliacoes;
	}

	public List<Aluno> getAlunos() {
		return alunos;
	}

	public void setAlunos(List<Aluno> alunos) {
		this.alunos = alunos;
	}

	public Nota getNota() {
		return nota;
	}

	public void setNota(Nota nota) {
		this.nota = nota;
	}

	public Aluno getAluno() {
		return aluno;
	}

	public void setAluno(Aluno aluno) {
		this.aluno = aluno;
	}

	public Disciplina getDisciplina() {
		return disciplina;
	}

	public void setDisciplina(Disciplina disciplina) {
		this.disciplina = disciplina;
	}

	public Avaliacao getAvaliacao() {
		return avaliacao;
	}

	public void setAvaliacao(Avaliacao avaliacao) {
		this.avaliacao = avaliacao;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
