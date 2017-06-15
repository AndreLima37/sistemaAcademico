package com.PartilhoUX.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.PartilhoUX.model.Disciplina;
import com.PartilhoUX.model.Presenca;
import com.PartilhoUX.persistence.interfaces.IPresencaDAO;

public class PresencaDAO implements IPresencaDAO{
	
	private Connection con;

	public PresencaDAO() {
		GenericDAO SqlDao = new GenericDAO();
		con = SqlDao.getConnection();
	}
	
	@Override
	public void inserirPresenca(Presenca presenca) throws SQLException {
		String sql = "{CALL p_inserirPresenca (?,?,?,?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, presenca.getAluno().getRa());
		cs.setString(2, presenca.getData().toString());
		cs.setInt(3, presenca.getPresenca());
		cs.setString(4, presenca.getDisciplina().getTurno());
		cs.setString(5, presenca.getDisciplina().getNome());	
		cs.execute();
		cs.close();
	}

	@Override
	public List<List<String>> listarPresencas(Disciplina disciplina) {
		List<List<String>> listasDePresencas = new ArrayList<List<String>>();
		String sql = "SELECT * FROM f_listarPresencas (?,?)";
		try {
			PreparedStatement pmst = con.prepareStatement(sql);
			pmst.setString(1, disciplina.getNome());
			pmst.setString(2, disciplina.getTurno());
			ResultSet rs = pmst.executeQuery();
			while (rs.next()) {
				List<String> lista = new ArrayList<String>();
				lista.add(rs.getString("ra"));
				lista.add(rs.getString("aluno"));
				lista.add(rs.getString("dia1"));
				lista.add(rs.getString("dia2"));
				lista.add(rs.getString("dia3"));
				lista.add(rs.getString("dia4"));
				lista.add(rs.getString("dia5"));
				lista.add(rs.getString("dia6"));
				lista.add(rs.getString("dia7"));
				lista.add(rs.getString("dia8"));
				lista.add(rs.getString("dia9"));
				lista.add(rs.getString("dia10"));
				lista.add(rs.getString("dia11"));
				lista.add(rs.getString("dia12"));
				lista.add(rs.getString("dia13"));
				lista.add(rs.getString("dia14"));
				lista.add(rs.getString("dia15"));
				lista.add(rs.getString("dia16"));
				lista.add(rs.getString("dia17"));
				lista.add(rs.getString("dia18"));
				lista.add(rs.getString("dia19"));
				lista.add(rs.getString("dia20"));
				lista.add(rs.getString("presencas"));
				listasDePresencas.add(lista);
			}
			rs.close();
			pmst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listasDePresencas;
	}

	@Override
	public List<String> listarDatas(Disciplina disciplina) {
		List<String> listasDeDatas = new ArrayList<String>();
		String sql = "SELECT * FROM dbo.f_listarDatas(?, ?)";
		try {
			PreparedStatement pmst = con.prepareStatement(sql);
			pmst.setString(1, disciplina.getNome());
			pmst.setString(2, disciplina.getTurno());
			ResultSet rs = pmst.executeQuery();
			while (rs.next()) {
				listasDeDatas.add(rs.getString("data"));
			}
			rs.close();
			pmst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listasDeDatas;
	}
	
	
}
