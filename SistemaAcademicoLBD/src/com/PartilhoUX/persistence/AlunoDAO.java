package com.PartilhoUX.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.PartilhoUX.model.Aluno;
import com.PartilhoUX.model.Avaliacao;
import com.PartilhoUX.model.Disciplina;
import com.PartilhoUX.persistence.interfaces.IAlunoDAO;

public class AlunoDAO implements IAlunoDAO{
	
	private Connection con;

	public AlunoDAO() {
		GenericDAO SqlDao = new GenericDAO();
		con = SqlDao.getConnection();
	}
	
	@Override
	public List<Aluno> listarAlunosPorDisciplinaETurno(Disciplina disciplina) {
		List<Aluno> listaAlunos = new ArrayList<Aluno>();
		String sql = "{CALL p_listarAlunosPorDisciplinaETurno(?,?)}";
		try {
			CallableStatement pmst = con.prepareCall(sql);
			pmst.setString(1, disciplina.getNome());
			pmst.setString(2, disciplina.getTurno());
			ResultSet rs = pmst.executeQuery();
			while (rs.next()) {
				Aluno aluno = new Aluno();
				aluno.setRa(rs.getString("ra"));
				aluno.setNome(rs.getString("nome"));
				listaAlunos.add(aluno);
			}
			rs.close();
			pmst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listaAlunos;
	}

}
