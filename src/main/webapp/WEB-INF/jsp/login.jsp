<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="topMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
        .login-box {
            width: 340px;
            margin: 60px auto;
            border: 1px solid #ddd;
            padding: 30px;
            border-radius: 8px;
            background: #fafbfc;
        }
        .login-box h2 {
            margin-bottom: 20px;
            text-align: center;
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
            padding: 7px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 15px;
        }
        .login-box button {
            width: 100%;
            padding: 10px 0;
            background: #007bff;
            color: #fff;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            margin-top: 10px;
            cursor: pointer;
        }
        .login-box button:hover {
            background: #0056b3;
        }
        .login-box .error-msg {
            color: #c00;
            margin-bottom: 15px;
            text-align: center;
        }
        .login-box .join-link {
            display: block;
            margin-top: 15px;
            text-align: center;
        }
        .login-box .join-link a {
            color: #007bff;
            text-decoration: none;
        }
        .login-box .join-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
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
</body>
</html>
