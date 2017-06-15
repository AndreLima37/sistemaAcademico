package com.PartilhoUX.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.PartilhoUX.model.Avaliacao;
import com.PartilhoUX.model.Disciplina;
import com.PartilhoUX.persistence.interfaces.IAvaliacaoDAO;

public class AvaliacaoDAO implements IAvaliacaoDAO{
	
	private Connection con;

	public AvaliacaoDAO() {
		GenericDAO SqlDao = new GenericDAO();
		con = SqlDao.getConnection();
	}
	
	@Override
	public List<Avaliacao> listarAvaliacoesPorDisciplina(Disciplina disciplina) {
		List<Avaliacao> listaAvaliacoes = new ArrayList<Avaliacao>();
		String sql = "{CALL p_listarAvaliacoesPorDisciplinaETurno(?,?)}";
		try {
			PreparedStatement pmst = con.prepareStatement(sql);
			pmst.setString(1, disciplina.getNome());
			pmst.setString(2, disciplina.getTurno());
			ResultSet rs = pmst.executeQuery();
			while (rs.next()) {
				Avaliacao avaliacao = new Avaliacao();
				avaliacao.setTipo(rs.getString("tipo"));
				listaAvaliacoes.add(avaliacao);
			}
			rs.close();
			pmst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listaAvaliacoes;
	}

}
