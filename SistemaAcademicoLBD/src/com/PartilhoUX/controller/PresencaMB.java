package com.PartilhoUX.controller;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import com.PartilhoUX.model.Aluno;
import com.PartilhoUX.model.Disciplina;
import com.PartilhoUX.model.Presenca;
import com.PartilhoUX.persistence.AlunoDAO;
import com.PartilhoUX.persistence.DisciplinaDAO;
import com.PartilhoUX.persistence.PresencaDAO;
import com.PartilhoUX.tool.ColumnModel;

@ManagedBean
@ViewScoped
public class PresencaMB implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2957000987655722516L;
	
	//Models atuais
	private Presenca presenca;
	private Aluno aluno;
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
	
	//Lista de alunos
	private List<Aluno> alunos;
	//
	public void listarAlunos(){
		//Listar os alunos
		AlunoDAO aldao = new AlunoDAO();
		alunos = aldao.listarAlunosPorDisciplinaETurno(disciplina);
	}
	
	//Lista de colunas de presenca
	private List<ColumnModel> presencaColuna;
	//
	public void construirColunaPresencas(){
		presencaColuna = new ArrayList<ColumnModel>();
		//Construir coluna de presencas
		//
		//obter disciplina selecionada atraves da iteracao na lista
		//
		for (Disciplina d : disciplinas) {
			if(d.getNome().equals(disciplina.getNome())){
				disciplina.setNumeroAulas(d.getNumeroAulas());
			}
		}
		//
		if(disciplina.getNumeroAulas() == 80){
			presencaColuna.add(new ColumnModel("aula1", "Aula 1"));
			presencaColuna.add(new ColumnModel("aula2", "Aula 2"));
			presencaColuna.add(new ColumnModel("aula3", "Aula 3"));
			presencaColuna.add(new ColumnModel("aula4", "Aula 4"));
		}else if(disciplina.getNumeroAulas() == 40){
			presencaColuna.add(new ColumnModel("aula1", "Aula 1"));
			presencaColuna.add(new ColumnModel("aula2", "Aula 2"));
		}
	}
	
	
	//CONSTRUTOR PRINCIPAL!!
	public PresencaMB(){
		//Inicializacao!
		presenca = new Presenca();
		aluno = new Aluno();
		disciplina = new Disciplina();
		
		alunos = new ArrayList<Aluno>(); 
		turnos = new ArrayList<String>();
		disciplinas = new ArrayList<Disciplina>();
		alunos = new ArrayList<Aluno>();
		presencaColuna = new ArrayList<ColumnModel>();
		//Preencher a data com a mais atual
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy"); 
		Date date = new Date(); 
		String dataAtual = dateFormat.format(date);
		System.out.println(dataAtual);
		presenca.setData(date);
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
		//Setar presenca padrao Verdadeiro
		checkBoxEstado = true;
		//Se existir uma lista de alunos
		if(alunos != null && alunos.size() > 0){
			//Apagar a lista de alunos
			alunos = null;
			//Apagar a lista de presencas
			presencaColuna = null;
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
				//Monta a tabela das presencas
				construirColunaPresencas();
				//Montar lista de presença
				criarListaDePresencas();
			}
		}catch(Exception e){
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL, "Fatal!",
					"Nao foi possivel carregar os dados do banco de dados!"));
		}
	}
	
	//Combobox disciplina selecionado
	public void disciplinaSelecionada(){
		//***
		//Setar presenca padrao Verdadeiro
		checkBoxEstado = true;
		//
		if(alunos != null && alunos.size() > 0){
			//Apagar a lista de alunos
			alunos = null;
			//Apagar a lista de presencas
			presencaColuna = null;
		}	
		//***
		try{
			//Listar alunos
			//Monta a tabela dos alunos
			listarAlunos();
			//Monta a tabela das presencas
			construirColunaPresencas();
			//Montar lista de presença
			criarListaDePresencas();
		}catch(Exception e){
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL, "Fatal!",
					"Nao foi possivel carregar os dados do banco de dados!"));
		}
	}
	
	//
	private boolean checkBoxEstado = true;
	
	//Atributos necessarios para o controle da presenca
	public List<Presenca> presencas;
	//Cada vez que ticado uma presenca
	public void alterarPresenca(){
		//Obter parametros da linha da tabela
		FacesContext fc = FacesContext.getCurrentInstance();
	    Map<String,String> params = fc.getExternalContext().getRequestParameterMap();
	    //Obter Ra e Nome do Aluno
	    String nomeRa = params.get("nomeRA");
	    String nomeAluno = params.get("nomeAluno");
	    
	    String alunoNome = "";
	    String raAluno = "";
		//***
	    //Busca pelo aluno cujo presenca foi alterada
	    for (Presenca presenca : presencas) {
	    	//SOLUCAO RUIM
	    	alunoNome = presenca.getAluno().getNome();
	    	raAluno = presenca.getAluno().getRa();
	    	
			if(nomeAluno.equals(alunoNome) && nomeRa.equals(raAluno)){
				
				//Se o check box estiver preenchido
				if(checkBoxEstado){
					//Aumenta uma aula de presenca
					presenca.setPresenca(presenca.getPresenca() + 1);
				}
				//Se o check box nao estiver preenchido
				else if(!checkBoxEstado){
					//Aumenta uma aula de presenca
					presenca.setPresenca(presenca.getPresenca() - 1);
				}
			}
		}
	}
		
	public void criarListaDePresencas(){
		//Instancia uma nova lista de presenca
		presencas = new ArrayList<Presenca>();
		//Para cada aluno desta disciplina
		for (Aluno aluno : alunos) {
			Presenca p = new Presenca();
			//Verifica numero de aulas
			if(disciplina.getNumeroAulas() == 80){
				//Configura 4 presencas aulas como padrão
				p.setPresenca(4);
			}else if(disciplina.getNumeroAulas() == 40){
				//Configura 2 presencas aulas como padrão
				p.setPresenca(2);
			}
			p.setAluno(aluno);
			p.setData(presenca.getData());
			p.setDisciplina(disciplina);
			presencas.add(p);
		}
	}
	
	//Salvar
	public void salvar(){
		//Instancia em instancia de presenca
		try{
			PresencaDAO pdao = new PresencaDAO();
			for (Presenca presenca : presencas) {
				pdao.inserirPresenca(presenca);
			}
			disciplinaSelecionada();
		}catch(Exception e){
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Erro!",
					"Nao foi salvar a presença!"));
		}
	}
	
	//Atualizar a data toda vez que esta e alterada
	public void atualizarData(){
		System.out.println("Go to hell!");
		if(presencas != null){
			for (Presenca p : presencas) {
				p.setData(presenca.getData());
			}
		}
	}


	public Presenca getPresenca() {
		return presenca;
	}


	public void setPresenca(Presenca presenca) {
		this.presenca = presenca;
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


	public List<Aluno> getAlunos() {
		return alunos;
	}


	public void setAlunos(List<Aluno> alunos) {
		this.alunos = alunos;
	}


	public List<ColumnModel> getPresencaColuna() {
		return presencaColuna;
	}


	public void setPresencaColuna(List<ColumnModel> presencaColuna) {
		this.presencaColuna = presencaColuna;
	}


	public boolean isCheckBoxEstado() {
		return checkBoxEstado;
	}


	public void setCheckBoxEstado(boolean checkBoxEstado) {
		this.checkBoxEstado = checkBoxEstado;
	}


	public List<Presenca> getPresencas() {
		return presencas;
	}


	public void setPresencas(List<Presenca> presencas) {
		this.presencas = presencas;
	}
}
