<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ok.jsp</title>
</head>
<body>
	sub.jsp 에서 확인 버튼 누르면 이 페이지가 나옴<br>
	<%
		String tel = request.getParameter("tel");
		String name = request.getParameter("name");
	%>
	당신이 입력한 이름은 : <%=name %><br>
	당신이 입력한 폰 번호는 : <%=tel %>
	
	DB에 저장
	
	<%
	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost/thedb?serverTimezone=Asia/Seoul", "root", "1234");
		System.out.println("연결 성공");
		String sql = "INSERT INTO bunho_tb (name, tel) VALUES(?, ?)";
		pstmt = conn.prepareStatement(sql);
		// 4. 데이터 binding
		pstmt.setString(1, name);
		pstmt.setString(2, tel);
		
		int count = pstmt.executeUpdate();
		if (count == 0) {
			System.out.println("데이터 입력 실패");
		} else {
			System.out.println("데이터 입력 성공");
		}

	} catch (Exception e) {
		System.out.println("에러: " + e);
	} finally {
		try {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
			if( pstmt != null && !pstmt.isClosed()){
                pstmt.close();
            }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	%>
</body>
</html>