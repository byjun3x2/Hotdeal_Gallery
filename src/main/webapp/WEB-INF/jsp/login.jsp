<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="topMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
        /* 페이지 전체 배경 및 레이아웃 */
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .main-content {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* 로그인 컨테이너 (이미지 + 로그인 박스) */
        .login-container {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 50px; /* 이미지와 박스 사이 간격 */
            padding: 40px;
        }

        /* 로고 이미지 */
        .login-image-wrapper img {
            width: 250px;
            height: auto;
            animation: float_effect 4s ease-in-out infinite; /* 애니메이션 적용 */
        }
        
        /* 이미지 애니메이션 효과 */
        @keyframes float_effect {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        /* 로그인 박스 스타일 */
        .login-box {
            width: 320px; /* 너비 살짝 줄임 */
            border: 1px solid #ddd;
            padding: 40px;
            border-radius: 8px;
            background: #fff;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07); /* 그림자 효과 추가 */
        }
        .login-box h2 {
            margin-top: 0;
            margin-bottom: 25px;
            text-align: center;
            font-size: 24px;
        }
        .login-box label {
            display: block;
            margin-bottom: 7px;
            color: #333;
            font-weight: bold;
        }
        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 15px;
            box-sizing: border-box; /* 패딩 포함해서 너비 계산 */
        }
        .login-box button {
            width: 100%;
            padding: 12px 0;
            background: #007bff;
            color: #fff;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            margin-top: 10px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .login-box button:hover {
            background: #0056b3;
        }
        .login-box .error-msg {
            color: #c00;
            margin-bottom: 15px;
            text-align: center;
            font-size: 14px;
        }
        .login-box .join-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
        }
        .login-box .join-link a {
            color: #007bff;
            text-decoration: none;
        }
        .login-box .join-link a:hover {
            text-decoration: underline;
        }

        /* 반응형: 화면이 좁아지면 세로로 배치 */
        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
                gap: 20px;
            }
            .login-image-wrapper img {
                width: 200px;
            }
        }
    </style>
</head>
<body>
    <div class="main-content">
        <div class="login-container">
            <div class="login-image-wrapper">
                <img src="<c:url value='/resources/images/hotdeal-logo.png'/>" alt="핫딜 로고">
            </div>
            <div class="login-box">
                <h2>로그인</h2>
                <c:if test="${not empty msg}">
                    <div class="error-msg">${msg}</div>
                </c:if>
                <form method="post" action="login">
                    <label for="username">아이디</label>
                    <input type="text" name="username" id="username" required maxlength="30">
            
                    <label for="password">비밀번호</label>
                    <input type="password" name="password" id="password" required maxlength="30">
            
                    <button type="submit">로그인</button>
                </form>
                <div class="join-link">
                    <a href="join">회원가입</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>