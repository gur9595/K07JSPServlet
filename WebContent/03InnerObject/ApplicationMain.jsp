<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ApplicationMain.jsp</title>
</head>
<body>
<!--
웹어플리케이ㅕㄴ(컨택스트)을 구성하는 모든 JSP에서
String 타입의 상수를 공유할 목적으로 사용한다 
web.xml에 <context=param> 엘리먼트를 통해 등록한다.
 -->
	<h3>web.xml에 설정한 내용 읽어오기</h3>
	<ul>
	<li>오라클드라이버 :
	<%=application.getInitParameter("JDBCDriver") %>
	</li>
	<li>오라클접속URL :
	<%=application.getInitParameter("ConnectionURL") %>
	</li>
	</ul>
	
	<!-- 
	컨택스트 초기화 파라미터의 <param-name>속성 전체를 가져온다
	 -->
	<h3>컨텍스트 초기화 파라미터명 전체목록보기</h3>
	<ul>
	<%
	Enumeration<String> names= application.getInitParameterNames();
	while(names.hasMoreElements()){
		String name=names.nextElement();
		String value =application.getInitParameter(name);
	%>
		<li><%=name %> : <%=value %></li>
	<%
	}
	%>
	
	<!-- 
	ServletContext의 메소드린 getRealPath()로 서버의 물리적경로를 얻어올수있따
	사용시 conttext root를 제와한 /로 시작하는 절대경로를 입력해야한다.
	 -->
	</ul>
	<h2>서버의 물리적 경로 얻어오기</h2>
	<ul>
	
	<li>
	application 내장객체: <%=application.getRealPath("/images") %>
	</li>
	
	<li>
	reguset내장객체 : <%=request.getServletContext().getRealPath("/images") %>
	</li>
	
	<li>
	request내장객체(주로 서블릿에서 사용) : <%=request.getRealPath("/images") %>
	</li>
	
	<li>
	session내장객체 : <%=session.getServletContext().getRealPath("/images") %>
	</li>
	
	<li>
	config내장객체 : <%=config.getServletContext().getRealPath("/images") %>
	</li>
	
	<li>
	this키워드(주로 선언부에서사용) : <%=this.getServletContext().getRealPath("/images") %>
	</li>
	
	</ul>
	
	<!-- 
	선언부에서 JSP의 내장객체를 사용할깨는 해당 내장객체의 클래스타입으로 사용해야한다

	 -->
	<h2>선언부에서 물리적경로 사용하기</h2>
	<%!
	//1.this키워드 사용하기
	String getRealPath(){
		return
				this.getServletContext().getRealPath("/images");
	}
	//2.매개변수로 내장객체를 전달하기
	String getRealPath(ServletContext app1){
		return app1.getRealPath("/images");
	}
	//3.멤버변수 사용하기
	ServletContext app2;
	String getRealParhString(){
		return app2.getRealPath("/images");
	}
	%>
	
	<ul>
		<li>this키워드로 사용 : <%=getRealPath() %></li>
		<li>매개변수로 전달 : <%=getRealPath(application) %></li>
		<%
		this.app2=application;
		%>
		<li>멤버변수 : <%=getRealParhString() %></li>
	</ul>
	
</body>
</html>








