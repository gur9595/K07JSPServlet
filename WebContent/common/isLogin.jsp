<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("USER_ID")==null){
%>
<script>
	alert("로그인 후 이용해주세요");
	location.href="../06Session/Login.jsp";
</script>
<%
return;
} 
%>