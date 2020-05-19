package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.sql.DataSource;

public class DataroomDAO {

	//멤버변수 (클래스 전체 멤버메소드에서 접근가능)
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;


	public DataroomDAO() {
		try {
			Context initctx = new InitialContext();

			/*
         Context ctx = (Context)initctx.lookup("java:comp/env"); 
         DataSource source = (DataSource)ctx.lookup("jdbc/myoracle");
			 */
			//위 2번의 lookup을 아래 1번의 lookup으로 병합할 수 있다.
			DataSource source = 
					(DataSource)initctx.lookup("java:comp/env/jdbc/myoracle");

			con = source.getConnection();
		}
		catch (Exception e) {
			System.out.println("DBCP 연결실패");
			e.printStackTrace();
		}
	}

	//DB자원해제 : DB연결 자체를 끊는것이 아니라 커넥션풀에 커넥션객체를 반납하는 것
	public void close() {
		try {
			if(rs != null) rs.close();
			if(psmt != null) psmt.close();
			if(con != null) con.close();
		} 
		catch (Exception e) {
			System.out.println("자원반납시 예외발생");
			e.printStackTrace();
		}
	}

	//자료실 게시판의 전체레코드 갯수 카운트
	public int getTotalRecordCount(Map map) {

		int totalCount = 0;

		try {
			String sql = "SELECT COUNT(*) FROM dataroom ";
			if(map.get("Word") != null) {
				sql += "   WHERE " + map.get("Column") + " "
						+ "   LIKE '%" + map.get("Word") + "%' ";
			}

			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		} 
		catch (Exception e) {}
		return totalCount;
	}

	//게시물 리스트 출력하기(페이지처리 x)
	public List<DataroomDTO> selectList(Map map) {

		List<DataroomDTO> bbs = new Vector<DataroomDTO>();

		String sql = "SELECT * FROM dataroom ";
		if(map.get("Word") != null) {
			sql += "   WHERE " + map.get("Column") + " "
					+ "      LIKE '%" + map.get("Word") + "%' ";
		}
		sql += "   ORDER BY idx DESC";

		try {

			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				DataroomDTO dto = new DataroomDTO();

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
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		return bbs;

	}

	//자료실 글쓰기 처리
	public int insert(DataroomDTO dto) {
		
		int affected = 0;
		try {
			String sql = "insert into dataroom ("
					+" idx, title, name, content, attachedfile, pass, downcount) "
					+" values ( "
					+" dataroom_seq.nextval, ?, ?, ?, ?, ?, 0) ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getAttachedfile());
			psmt.setString(5, dto.getPass());
		
			//insert성공시 1반환, 실패시 0반환
			affected = psmt.executeUpdate();
		}catch (Exception e) {
		
			e.printStackTrace();
		}
		
		return affected;
	}

	//조회수 증가
	public void updateVisitCount(String idx) {
		
		String sql = "update dataroom set "
				+" visitcount = visitcount+1 "
				+" where idx=? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
		}catch (Exception e) {}
		
	}
	
	public DataroomDTO selectView(String idx) {
		
		DataroomDTO dto = null;
		String sql = "select * from dataroom "
				+" where idx=? ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto = new DataroomDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setAttachedfile(rs.getString(6));
				dto.setDowncount(rs.getInt(7));
				dto.setPass(rs.getString(8));
				dto.setVisitcount(rs.getInt(9)); //조회수추가
				
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public boolean isCorrectPassword(String pass, String idx) {
		boolean isCorr = true;
		try {
			String sql = "select count(*) from dataroom where pass=? and idx=? ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, pass);
			psmt.setString(2, idx);
			
			rs= psmt.executeQuery();
			rs.next();
			if(rs.getInt(1)==0) {
				isCorr = false;
			}
			
		} catch (Exception e) {
			
			isCorr = false;
			e.printStackTrace();
		}
		return isCorr;
	}

	public int delete(String idx) {
		int affected = 0;
		try {
			String query="delete from dataroom where idx=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			
			affected = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
	
	public DataroomDAO(ServletContext ctx) {
		try {
			Class.forName(ctx.getInitParameter("JDBCDriver"));
			String id= "kosmo";
			String pw = "1234";
			con= DriverManager.getConnection(ctx.getInitParameter("ConnectionURL"),id,pw);
			System.out.println("DB 연결성공");
		} catch (Exception e) {
			System.out.println("DB 연결실패 ㅜㅜ");
			e.printStackTrace();
		}
	}
	
	public int update(DataroomDTO dto) {
		int affected=0;
		try {
			String query="update dataroom set title=?, name=?, content=?, attachedfile=?, pass=? where idx=?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getAttachedfile());
			psmt.setString(5, dto.getPass());
		
			psmt.setString(6, dto.getIdx());
			
			
			affected=psmt.executeUpdate();
			
			
		} catch (Exception e) {
			System.out.println("update중 예외");
			e.printStackTrace();
		}
		return affected;
	}
	
	public void downCountPlus(String idx) {
		String sql = "update dataroom  set downcount=downcount+1 where idx=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public List<DataroomDTO> selectListPage(Map map){
		List<DataroomDTO> bbs =new Vector<DataroomDTO>();
		
		String sql ="select * from (Select Tb.*, rownum rNum from(select * from dataroom";
		
		if(map.get("Word")!=null) {
			sql+=" where "+map.get("Column")+" "+" like '%"+map.get("Word")+"%' ";
		}
		sql+=" order by idx desc ) Tb ) where rNum between ? and ? ";
		System.out.println("쿼리문 : " + sql);
		
		
		try {

			psmt = con.prepareStatement(sql);
			psmt.setInt(1, Integer.parseInt(map.get("start").toString()));
			psmt.setInt(2, Integer.parseInt(map.get("end").toString()));
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				DataroomDTO dto = new DataroomDTO();

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
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		return bbs;
	}
}





















