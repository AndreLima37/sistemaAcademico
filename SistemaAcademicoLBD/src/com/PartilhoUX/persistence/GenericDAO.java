package com.PartilhoUX.persistence;

import java.sql.Connection;
import java.sql.DriverManager;

public class GenericDAO {

	private static Connection con;

	public Connection getConnection() {
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String hostName = "sistemalbd";
	        String dbName = "sistemaAcademico";
	        String user = "adminGeral";
	        String password = "abc123/*-";
	        String url = String.format("jdbc:sqlserver://%s.database.windows.net:1433;database=%s;user=%s;password=%s;encrypt=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;", hostName, dbName, user, password);
	        //Connection con = null;
	        
	        con = DriverManager.getConnection(url);
			
			System.out.println("Conexao ok");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}

	public void fechaConexao() {
		try {
			if (con != null)
				con.close();
			con = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
