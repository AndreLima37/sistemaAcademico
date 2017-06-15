package com.PartilhoUX.controller;

import java.util.ArrayList;
import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import com.PartilhoUX.model.Disciplina;
import com.PartilhoUX.persistence.DisciplinaDAO;
import com.PartilhoUX.persistence.PresencaDAO;

@ManagedBean
@ViewScoped
public class ListarPresencasMB {
	
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
	
	//Lista de presencas por aluno
	private List<List<String>> listasDePresencas;
	//
	public void listarPresencas(){
		//Listar as disciplinas de acordo com um torno
		PresencaDAO pdao = new PresencaDAO();
		listasDePresencas = pdao.listarPresencas(disciplina);
	}
	
	//Lista de datas 
	private List<String> listasDeDatas;
	//
	public void listarDatas(){
		//Listar as disciplinas de acordo com um torno
		PresencaDAO pdao = new PresencaDAO();
		listasDeDatas = pdao.listarDatas(disciplina);
		//
		boolean preenche = true;
		while(preenche) {
			if(listasDeDatas.size() < 20){
				listasDeDatas.add("--/--");
			}else{
				preenche = false;
			}
		}
		//
	}
	
	public ListarPresencasMB() {
		turnos = new ArrayList<String>();
		disciplina = new Disciplina();
		listasDePresencas = new ArrayList<List<String>>();
		listasDeDatas = new ArrayList<String>();
		for (int i = 0; i < 20; i++) {
			listasDeDatas.add("");
		}
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
		//Se existir uma lista de alunos e suas notas
		if(listasDePresencas != null && listasDePresencas.size() > 0){
			//Apagar a lista de faltas
			listasDePresencas = null;
			//Apagar a lista de datas
			listasDeDatas = null;
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
				//Listar datas
				listarDatas();
				//Monta a tabela dos alunos com suas respectivas faltas e presencas
				listarPresencas();
			}
		}catch(Exception e){
			e.printStackTrace();
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL, "Fatal!",
					"Nao foi possivel carregar os dados do banco de dados!"));
		}
	}
	
	//Combobox disciplina selecionado
	public void disciplinaSelecionada(){
		//***
		//Se existir uma lista de alunos e suas notas
		if(listasDePresencas != null && listasDePresencas.size() > 0){
			//Apagar a lista de alunos
			listasDePresencas = null;
			//Apagar a lista de notas
			listasDeDatas = null;
		}	
		//***
		try{
			//Listar alunos
			//Listar datas
			listarDatas();
			//Monta a tabela dos alunos com suas respectivas faltas e presencas
			listarPresencas();
		}catch(Exception e){
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL, "Fatal!",
					"Nao foi possivel carregar os dados do banco de dados!"));
		}
	}
	
	public List<List<String>> getListasDePresencas() {
		return listasDePresencas;
	}
	public void setListasDePresencas(List<List<String>> listasDePresencas) {
		this.listasDePresencas = listasDePresencas;
	}
	public List<String> getListasDeDatas() {
		return listasDeDatas;
	}
	public void setListasDeDatas(List<String> listasDeDatas) {
		this.listasDeDatas = listasDeDatas;
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
}
