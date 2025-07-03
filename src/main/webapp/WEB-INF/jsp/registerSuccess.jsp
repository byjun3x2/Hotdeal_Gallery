<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="topMenu.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>
<style>
.success-box {
	width: 400px;
	margin: 80px auto;
	text-align: center;
	border: 1px solid #ddd;
	padding: 40px;
	border-radius: 8px;
	background: #f8f9fa;
}

.success-box h2 {
	color: #007bff;
}

.success-box a {
	display: inline-block;
	margin-top: 20px;
	padding: 10px 20px;
	background: #007bff;
	color: #fff;
	text-decoration: none;
	border-radius: 4px;
}

.success-box a:hover {
	background: #0056b3;
}
</style>
<link rel="shortcut icon" href="<c:url value='/resources/favicon.ico'/>"
	type="image/x-icon" />
</head>
<body>
	<div class="success-box">
		<h2>🎉 회원가입이 완료되었습니다!</h2>
		<p>핫딜 갤러리의 회원이 되신 것을 환영합니다.</p>
		<a href="<c:url value='/login'/>">로그인 하러 가기</a>
	</div>
</body>
</html>