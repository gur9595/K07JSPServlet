<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%--
    include 지시어 공통으로 사용할 jsp파일을 생성한후
    현재문서에 포함시킬때 사용한다 각각의 jsp파일 상단에는
    반드시 page지시어(Directive)가 삽입되어야한다
    단 하나의 jsp파일에는 page지시어가 중복되어서는 안된다.
     --%>
<%@ include file="IncludePage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀</title>
<!-- CSS코드는 양이 많으므로 외부파일로 선언하여 현재문서에 링크시킨다. -->
<link rel="stylesheet" href="./css/div_layout.css" />
</head>
<body>
<div class ="AllWrap">
	<div class="header">
	<!-- GNB(Global Navigation Bar)영역 -전체공통메뉴 -->
		<%@ include file = "../common/Top.jsp" %>
	</div>
	<div class="body">
		<div class="left_menu">
		<!-- LMB영역(Local Navigation Bar) - 로컬메뉴 -->
		<%@ include file="../common/Left.jsp" %>
		</div>
		<div class="contents">
			<!-- Contents 영역 -->
			<%--
			해당변수는 외부파일에 선언하여 본 문서에 include처리되었다
			include는 문서자채를 포함시키는 개념이므로 발생하지 않는다.
			 --%>
			<h2>오늘의 날짜 : <%=todayStr%></h2>
			<br /><br />
			(서울=연합뉴스) 강병철 서혜림 기자 = 더불어민주당 윤리심판원은 27일 성추행 파문을 일으킨 오거돈 전 부산시장에 대한 제명을 의결했다. 오 전 시장의 시장직 사퇴 나흘만이다.

임채균 원장은 이날 오후 여의도 당사에서 윤리심판원 전체회의를 마친 뒤 기자들과 만나 "사안이 중차대하고 본인도 시인하고 있어 만장일치로 제명을 의결했다"고 밝혔다.

이어 판단 이유에 대해선 "사안의 성격상 피해자 보호도 있어서 구체적인 경위는 말할 수 없고, 제명할 사안으로 봤다"고만 말했다.

오 전 시장의 소명자료 제출 등에 대해선 "소명 자료는 제출하지 않았다. (소명을) 포기한 것"이라며 "(현장조사도) 나름대로 진행했다"고 설명했다.

'이 순간부터 오 전 시장은 민주당원이 아닌 것인가'라는 질문에는 "예"라고 답변했다.

이날 윤리심판원은 재적위원 9명 중 6명이 참석해 전원 일치된 의견으로 제명을 결정했다. 이는 심판원이 결정하는 가장 무거운 징계 수준이다.

징계의 종류로는 경고, 당직자격정지, 당원자격정지, 제명이 있다.

윤리심판원의 결정 내용은 최고위원회에 보고될 예정이다.

앞서 오 전 시장은 최근 시장 집무실에서 한 여성 공무원과 면담하다가 해당 여성의 신체 특정 부위를 만진 사실을 인정하고 지난 23일 사퇴했다.

피해 여성은 부산성폭력상담소를 찾아 성추행 피해 사실을 알렸고, 오 전 시장에게 사퇴를 요구했다.
			<br /><br />
		</div>
	</div>
	<div class="copyright">
		<%@ include file="../common/Copyright.jsp" %>
	</div>
</div>

</body>
</html>