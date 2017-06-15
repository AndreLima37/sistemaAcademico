package com.PartilhoUX.controller;

import java.util.ArrayList;
import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import com.PartilhoUX.model.Aluno;
import com.PartilhoUX.model.Avaliacao;
import com.PartilhoUX.model.Disciplina;
import com.PartilhoUX.persistence.AvaliacaoDAO;
import com.PartilhoUX.persistence.DisciplinaDAO;
import com.PartilhoUX.tool.ColumnModel;

@ManagedBean
@ViewScoped
public class ListarNotasMB {
	
	//Models atuais
	private Disciplina disciplina;
	
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
	
	//Lista de presenças com os alunos
	//Lista de alunos notas
	private List<List<String>> listasDeAlunos;
	//
	public void listarAlunosENotas(){
		//Listar os alunos
		DisciplinaDAO ddao = new DisciplinaDAO();
		listasDeAlunos = ddao.listarAlunosENotas(disciplina);
	}
	
	//Lista de avaliaceos discilina que contem o peso
	private List<Avaliacao> avaliacoes;
	//Listar avaliações da disciplina
	public void listarAvaliacaoDisciplina(){
		AvaliacaoDAO avdao = new AvaliacaoDAO();
		avaliacoes = avdao.listarAvaliacoesPorDisciplina(disciplina);
	}
	
	//Total de colunas da tabela
	private List<ColumnModel> colunas;
	//
	public void construirColunaNotas(){
		if(disciplina.getNome().equals("Arquitetura e Organização de Computadores")){
			this.p1 = true;
			this.p2 = true;
			this.trabalho = true;
			this.exame = true;
			
			this.p3 = false;
			this.preExame = false;
			
		}else if(disciplina.getNome().equals("Laboratório de Hardware")){
			this.p1 = true;
			this.p2 = true;
			this.trabalho = true;
			this.exame = true;
			
			this.p3 = false;
			this.preExame = false;
			
		}else if(disciplina.getNome().equals("Sistemas Operacionais I")){
			this.p1 = true;
			this.p2 = true;
			this.trabalho = true;
			this.preExame = true;
			this.exame = true;
			
			this.p3 = false;
			
		}else if(disciplina.getNome().equals("Banco de Dados")){
			this.p1 = true;
			this.p2 = true;
			this.trabalho = true;
			this.exame = true;
			
			this.p3 = false;
			this.preExame = false;
			
		}else if(disciplina.getNome().equals("Laboratório de Banco de Dados")){
			this.p1 = true;
			this.p2 = true;
			this.p3 = true;
			this.exame = true;
			
			this.trabalho = false;
			this.preExame = false;
			
		}else if(disciplina.getNome().equals("Métodos para Produção do Conhecimento")){
			this.p1 = true;
			this.p2 = true;
			this.exame = true;
			
			this.p3 = false;
			this.trabalho = false;
			this.preExame = false;
		}
	}
	
	//CONSTRUTOR PRINCIPAL!!
	public ListarNotasMB(){
		//Inicializacao!
		disciplina = new Disciplina();		
		listasDeAlunos = new ArrayList<List<String>>();
		//
		inicio();
	}
	
	//Variaveis para controle das colunas
	private boolean p1;
	private boolean p2;
	private boolean p3;
	private boolean trabalho;
	private boolean preExame;
	private boolean exame;
	
	//Inicio
	public void inicio(){
		//Esconder todas as colunas
		this.p1 = false;
		this.p2 = false;
		this.p3 = false;
		this.trabalho = false;
		this.preExame = false;
		this.exame = false;
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
		//Esconder todas as colunas
		this.p1 = false;
		this.p2 = false;
		this.p3 = false;
		this.trabalho = false;
		this.preExame = false;
		this.exame = false;
		//Se existir uma lista de alunos e suas notas
		if(listasDeAlunos != null && listasDeAlunos.size() > 0){
			//Apagar a lista de alunos
			listasDeAlunos = null;
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
				//Monta a tabela dos alunos com suas respectivas notas
				listarAlunosENotas();
				//Listar disciplinas
				listarAvaliacaoDisciplina();
				//Montar a tabela de notas de acordo com o total de avaliacoes
				construirColunaNotas();
			}
		}catch(Exception e){
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL, "Fatal!",
					"Nao foi possivel carregar os dados do banco de dados!"));
		}
	}
	
	//Combobox disciplina selecionado
	public void disciplinaSelecionada(){
		//***
		//Esconder todas as colunas
		p1 = false;
		p2 = false;
		p3 = false;
		trabalho = false;
		preExame = false;
		exame = false;
		//Se existir uma lista de alunos e suas notas
		if(listasDeAlunos != null && listasDeAlunos.size() > 0){
			//Apagar a lista de alunos
			listasDeAlunos = null;
			//Apagar a lista de notas
			colunas = null;
		}	
		//***
		try{
			System.out.println("Aqui:");
			//Listar alunos
			//Monta a tabela dos alunos com suas respectivas notas
			listarAlunosENotas();
			//Listar disciplinas
			listarAvaliacaoDisciplina();
			//Montar a tabela de notas de acordo com o total de avaliacoes
			construirColunaNotas();
		}catch(Exception e){
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL, "Fatal!",
					"Nao foi possivel carregar os dados do banco de dados!"));
		}
	}
	
	
	public Disciplina getDisciplina() {
		return disciplina;
	}

	public void setDisciplina(Disciplina disciplina) {
		this.disciplina = disciplina;
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

	public List<List<String>> getListasDeAlunos() {
		return listasDeAlunos;
	}

	public void setListasDeAlunos(List<List<String>> listasDeAlunos) {
		this.listasDeAlunos = listasDeAlunos;
	}

	public List<Avaliacao> getAvaliacoes() {
		return avaliacoes;
	}

	public void setAvaliacoes(List<Avaliacao> avaliacoes) {
		this.avaliacoes = avaliacoes;
	}

	public List<ColumnModel> getColunas() {
		return colunas;
	}

	public void setColunas(List<ColumnModel> colunas) {
		this.colunas = colunas;
	}

	public boolean isP1() {
		return p1;
	}

	public void setP1(boolean p1) {
		this.p1 = p1;
	}

	public boolean isP2() {
		return p2;
	}

	public void setP2(boolean p2) {
		this.p2 = p2;
	}

	public boolean isP3() {
		return p3;
	}

	public void setP3(boolean p3) {
		this.p3 = p3;
	}

	public boolean isTrabalho() {
		return trabalho;
	}

	public void setTrabalho(boolean trabalho) {
		this.trabalho = trabalho;
	}

	public boolean isPreExame() {
		return preExame;
	}

	public void setPreExame(boolean preExame) {
		this.preExame = preExame;
	}

	public boolean isExame() {
		return exame;
	}

	public void setExame(boolean exame) {
		this.exame = exame;
	}
	
}
