<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>03If.jsp</title>
</head>
<body>
	<!-- 
	if 태그
		-JSTL의 if문은 시작태그와 종료태그를 통해서 조건을 판단한다
		-else문이 없기 떄문에 조건이 여러개일떄는 표현이 어렵다
		이때는 주로 choose문을 사용한다
		형식]
			test : 조건
			var : test의 결과를 반환하는 변수설정
			scope : 영역설정(많이 사용되지 않음)
	 -->
	<h2>if태그</h2>
	<c:set var="numVar" value="100" />
	<c:set var="strVar" value="JAVA" />
	
	<!-- 
		if(numVar%2==0) 와 동일한 조건으로 , 해당 조건은 
		true이므로 if블록의 문장이 출력된다 . 그리고 result에 true가 저장된다
	 -->
	<h3>JSTL의 if 태그로 짝수/홀수 판단하기</h3>
	<c:if test="${numVar mod 2 eq 1 }" var="result">
		${numVar }는 짝수 입니다 <br />
	</c:if>
	\${result } : ${result }
	
	<h3>위 if문을 EL식의 삼항식으로 표현</h3>
	${numVar } : ${numVar mod 2== 0 ? "는 짝수" : "는 홀수" }
	
	<!-- 
		JSTL의 if문은 else가 없기 때문에 참 or 거짓의 형태로 만들떄는 
		아래와 같이 참인조건 거짓인조건으로 각각의 if문의 블럭을 만들어야한다
	 -->
	<h3>문자열 비교</h3>	
	<c:if test="${JAVA eq '자바' }">
		${strVar } 는 자바다 <br /> <!-- 조건이 false이므로 출력되지 않음 -->
	</c:if>
	<c:if test="${JAVA ne '자바' }">
		${strVar } 는 자바다 <br /> <!-- 결과 출력됨 -->
	</c:if>
	
	<!-- 
	test속성에 EL식이 아닌 일반값이 들어가면 무조건 false를 반환한다.
	EL식이더라도 {} 양쪽에 공백이 들어가면 무조건 false를 반환한다.
	단 일반값이라도 TRUE(ture)인 경우에는 true를 반환한다.
	 -->
	<h2>if문 사용시 주의사항</h2>
	<h3>항상 출력되거나 출력되지 않는 조건식</h3>
	<c:if test="${true }">
		난 항상 출력되~~
	</c:if>
	<c:if test="${false }">
		난 항상 출력안되~~
	</c:if>
	
	<h3>test속성에 일반값으로 조건 지정</h3>
	<c:if test="100" var="result">
		100은 일반값이므로 무조건 false반환
	</c:if>
	\${result } : ${result } <br />
	
	<c:if test="tRuE" var="result">
		TRUE(true) 대소문자 구분없음 항상 참임 <br />
	</c:if>
	\${result } : ${result } <br />
	<h3>EL 식으로 조건판단시 {}양쪽에 공백이 있으면 무조건 false로 판단됨</h3>
	<c:if test=" ${true} " var="result">
		빈공백이 있어서 무조건 false처리됨
	</c:if>
	\${result } : ${result } <br />
	
	<!-- 
	아이디, 패스워드를 입력후 submit 한후 EL식을 통해 파라미터로 받은후
	"kosmo", "1234" 인 경우에는 "kosmo님 하이룽~" 이라고 출력한다. 
	만약 틀렸다면 "아이디와 비번을 확인하세요" 를 출력한다. 
	EL과 JSTL의 if태그만을 이용해서 구현하시오.
	 -->

	<h3>연습문제 : if태그</h3>
	<form method="get">
		아이디 : <input type="text" name="user" />
		<br />
		패스워드 : <input type="text" name="pass" />
		<br />
		<input type="submit" value="로그인" />
	</form>	
	
	<!-- 로그인을 위한 파라미터가 있는 경우에만 검증을 위한 아래문장을 실행한다 -->
	<c:if test="${not empty param.user }">
		전송된 아이디 : ${param.user } <br/>
		전송된 패스워드 : ${param.pass } <br />
		<!-- 
			첫번째 if문에서의 결과에 따라 두번쨰if문은 반대와결과를
			가지게되는 구조로 작성되었다 즉loginResult 가 true값으로
			설정된다면 두번째if문에서는 false의 값으로 바뀌게된다
		 -->
		<c:if test="${param.user eq 'kosmo' and param.pass eq '1234' }" var="loginResult">
				${param.user }님, 하이룽~
		</c:if>
		<c:if test="${not loginResult }">
				아이디와 비번을 확인하세요
		</c:if>	
	</c:if>
	
</body>
</html>










