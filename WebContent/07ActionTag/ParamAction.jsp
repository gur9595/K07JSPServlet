<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
/*
포워드된 페이지나 인클루된 페이지로 파라미터를 전달하는 경우
한글이 포함되어있다면 반드시 시켜는 최초페이지에서 인코딩을 시작해야한다.
*/
request.setCharacterEncoding("UTF-8");
request.setAttribute("member", new MemberDTO("sung","9999","성춘",null));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ParamAction.jsp</title>
</head>
<body>
<h2>인클루드 되는 페이지로 파라미터 전달하기</h2>
<!-- 
아래와 같이 설정하면 퀴리스트링 형태로 파라미터가 전달된다
 -->
<jsp:include page="ParamActionIncludeResult.jsp"></jsp:include> 
<jsp:param value="이몽룡" name="name"/>
<jsp:param value="Lee" name="id"/>
<%
String pageURL="ParamActionIncludeResult.jsp?query=반갑습니다";
String paramValue="KOSM";
request.setAttribute("member", new MemberDTO("Lee","7777","이몽룡",null))
%>
<%-- <jsp:forward page="<%=pageURL %>">
	<jsp:param value="한국소프트웨어 인재개발원" name="name"/>
	<jsp:param value="<%=paramValue %>" name="id"/>
</jsp:forward> --%>
</body>
</html>