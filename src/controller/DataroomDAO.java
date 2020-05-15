package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DataroomDAO {
	

	//멤버변수 (클레스 전체 멤버메소드에서 접근가능)
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public DataroomDAO() {
		try {
			Context initCtx = new InitialContext();
			/*
			Context ctx = (Context)initCtx.lookup("java:comp/env");
			DataSource source = (DataSource)ctx.lookup("jdbc/myoracle");
			*/
			//위 2번의 lookup을 아래 1번으로 병합할 수 있다
			DataSource source = (DataSource)initCtx.lookup("java:comp/env/jdbc/myoracle");
			con = source.getConnection();		
			
			System.out.println("DBCP연결성공");
		} catch (Exception e) {
			System.out.println("DBCP연결실패");
			e.printStackTrace();
		}
	}
	
	//자원반납하기 : DB연결 자체를 끊는것이 아니라 커넥션풀에 커넥션객체를 반납하는것
		public void close() {
			try {
				if(rs!=null) rs.close();
				if(psmt!=null) psmt.close();
				if(con!=null) con.close();
			} catch (Exception e) {
				System.out.println("자원반납시 예외발생");
			}
		}
	
	//자료실 게시판의 레코드 갯수 카운트
	public int getTotalRecordCount(Map map) {
		int totalCount = 0;
		try {
			String sql = "select count(*) from dataroom";
			if(map.get("Word")!=null) {
				sql+="where" + map.get("Column") + " "+ " like '%"+map.get("Word")+ "%' ";
			}
			
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
			System.out.println("getTotalRecordCount성공");

		} catch (Exception e) {
			System.out.println("getTotalRecordCount실패");

		}
		return totalCount;
	}
	
	//게시물 리스트 출력하기 (페이지처리X)
	public List<DataroomDTO> selectList(Map map){
		List<DataroomDTO> bbs= new Vector<DataroomDTO>();
		
		String query = "select * from dataroom ";
		if(map.get("Word")!=null) {
			query += " where " +map.get("Column")+" "+ " like '%"+map.get("Word")+"%'"; 
		}
		query += "order by idx desc";
		
		try {
			psmt= con.prepareStatement(query);
			rs= psmt.executeQuery();
			while(rs.next()) {
				DataroomDTO dto= new DataroomDTO();
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setAttachedfile(rs.getString(6));
				dto.setDowncount(rs.getInt(7));
				dto.setPass(rs.getString(8));
				dto.setVisitcount(rs.getInt(9));
				
				bbs.add(dto);
			}
			System.out.println("select성공");
		} catch (Exception e) {
			System.out.println("Select시 예외발생");
			e.printStackTrace();
		}
		return bbs;
	}
			
}












