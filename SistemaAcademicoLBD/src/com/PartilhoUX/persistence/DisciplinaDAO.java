package com.PartilhoUX.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.PartilhoUX.model.Disciplina;
import com.PartilhoUX.persistence.interfaces.IDisciplinaDAO;


public class DisciplinaDAO implements IDisciplinaDAO {
	
	private Connection con;

	public DisciplinaDAO() {
		GenericDAO SqlDao = new GenericDAO();
		con = SqlDao.getConnection();
	}
	
	@Override
	public List<String> listarTurnos() {
		List<String> listaTurnos = new ArrayList<String>();
		String sql = "SELECT * FROM v_listarturnos";
		try {
			PreparedStatement pmst = con.prepareStatement(sql);
			ResultSet rs = pmst.executeQuery();
			while (rs.next()) {
				listaTurnos.add(rs.getString("turno"));
			}
			rs.close();
			pmst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listaTurnos;
	}

	@Override
	public List<Disciplina> listarDisciplinasPorTurno(String turno) {
		List<Disciplina> listaDisciplinas = new ArrayList<Disciplina>();
		String sql = "{CALL p_listarDisciplinasPorTurno (?)}";
		try {
			CallableStatement pmst = con.prepareCall(sql);
			pmst.setString(1, turno);
			ResultSet rs = pmst.executeQuery();
			while (rs.next()) {
				Disciplina disciplina = new Disciplina();
				disciplina.setNome(rs.getString("nome"));
				disciplina.setTurno(rs.getString("turno"));
				disciplina.setNumeroAulas(Integer.parseInt(rs.getString("numeroAulas")));
				listaDisciplinas.add(disciplina);
			}
			rs.close();
			pmst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listaDisciplinas;
	}

	@Override
	public List<List<String>> listarAlunosENotas(Disciplina disciplina) {
		List<List<String>> notas = new ArrayList<List<String>>();
		String sql = "SELECT * FROM f_listarNotas(?, ?)";
		try {
			PreparedStatement pmst = con.prepareStatement(sql);
			System.out.println(disciplina.getNome());
			System.out.println(disciplina.getTurno());
			pmst.setString(1, disciplina.getNome());
			pmst.setString(2, disciplina.getTurno());
			ResultSet rs = pmst.executeQuery();
			while (rs.next()) {
				List<String> lista = new ArrayList<String>();
				lista.add(rs.getString("ra"));
				lista.add(rs.getString("aluno"));
				lista.add(rs.getString("p1"));
				lista.add(rs.getString("p2"));
				lista.add(rs.getString("p3"));
				lista.add(rs.getString("t"));
				lista.add(rs.getString("preExame"));
				lista.add(rs.getString("exame"));
				lista.add(rs.getString("media"));
				lista.add(rs.getString("situacao"));
				notas.add(lista);
			}
			rs.close();
			pmst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return notas;
	}

}
