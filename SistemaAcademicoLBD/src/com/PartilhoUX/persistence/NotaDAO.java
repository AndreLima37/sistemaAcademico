package com.PartilhoUX.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import com.PartilhoUX.model.Nota;
import com.PartilhoUX.persistence.interfaces.INotaDAO;

public class NotaDAO implements INotaDAO{
	
	private Connection con;

	public NotaDAO() {
		GenericDAO SqlDao = new GenericDAO();
		con = SqlDao.getConnection();
	}
	
	
	@Override
	public void inserirNota(Nota nota) throws SQLException {
		String sql = "{CALL p_inserirNota (?,?,?,?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, nota.getDisciplina().getNome());
		cs.setString(2, nota.getDisciplina().getTurno());
		cs.setString(3, nota.getAvaliacao().getTipo());	
		cs.setString(4, nota.getAluno().getNome());
		cs.setDouble(5, nota.getNota());
		cs.execute();
		cs.close();
	}
	
	

}
