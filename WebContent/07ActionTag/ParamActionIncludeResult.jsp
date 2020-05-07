<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ParamActionIncludeResult.jsp</title>
</head>
<body>
<h2>인클루드 된 페이지</h2>
<!-- 
아래와 같이 설정하면 쿼리스트링 형태로 파라미터가 전달된다
액션태그 사이에 주석은 사용할수 없다 에러발생
 -->
<h3>param액션태그로 전달된 값 출력하기</h3>
<ul>
	<il>quertString:<%=request.getParameter("query") %> </il>
	<il>name:<%=request.getParameter("name") %> </il>
	<il>id: <%=request.getParameter("query") %></il>
</ul>
<!-- MemberDTo객체에 오버라이딩 처리한 toString 메소드를 통해서 객체의 속성이 출력된다 -->
<h3>영역에 저장된 데이터 읽기</h3>
<%=request.getParameter("member") %>
</body>
</html>