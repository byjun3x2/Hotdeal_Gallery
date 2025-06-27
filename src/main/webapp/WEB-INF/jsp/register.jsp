<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="topMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        .register-box {
            width: 360px;
            margin: 40px auto;
            border: 1px solid #ddd;
            padding: 30px;
            border-radius: 8px;
            background: #fafbfc;
        }
        .register-box h2 {
            margin-bottom: 20px;
            text-align: center;
        }
        .register-box label {
            display: block;
            margin-bottom: 7px;
            color: #333;
            font-weight: bold;
        }
        .register-box input[type="text"],
        .register-box input[type="password"],
        .register-box input[type="email"] {
            width: 100%;
            padding: 7px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 15px;
        }
        .register-box button {
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
        .register-box button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<div class="register-box">
    <h2>회원가입</h2>
    <form method="post" action="join">
        <label for="username">아이디</label>
        <input type="text" name="username" id="username" required maxlength="30">

        <label for="password">비밀번호</label>
        <input type="password" name="password" id="password" required maxlength="30">

        <label for="name">이름</label>
        <input type="text" name="name" id="name" required maxlength="30">

        <label for="email">이메일</label>
        <input type="email" name="email" id="email" required maxlength="50">

        <button type="submit">회원가입</button>
    </form>
</div>
</body>
</html>
