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
            box-sizing: border-box;
        }
        /* submit 버튼만 100% */
        .register-box button[type="submit"] {
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
        .register-box button[type="submit"]:hover {
            background: #0056b3;
        }
        .error-msg {
            color: #c00;
            font-size: 13px;
            margin-bottom: 8px;
        }
        .success-msg {
            color: #008800;
            font-size: 13px;
            margin-bottom: 8px;
        }
        .register-box .flex-row {
            display: flex;
            gap: 8px;
            align-items: stretch;
        }
        .register-box .flex-row input[type="text"],
        .register-box .flex-row input[type="email"] {
            flex: 1;
            height: 36px;
            font-size: 15px;
            box-sizing: border-box;
            margin-bottom: 0;
        }
        /* 중복체크 버튼만 width:auto로! */
        .register-box .flex-row button {
            width: auto;
            height: 36px;
            font-size: 15px;
            padding: 0 16px;
            margin-top: 0;
            border-radius: 4px;
            background: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            white-space: nowrap;
            transition: background 0.2s;
        }
        .register-box .flex-row button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<div class="register-box">
    <h2>회원가입</h2>
    <form method="post" action="join" id="registerForm" autocomplete="off">
        <label for="username">아이디</label>
        <div class="flex-row">
            <input type="text" name="username" id="username" maxlength="30" required>
            <button type="button" id="checkIdBtn">중복체크</button>
        </div>
        <div id="idCheckMsg" class="error-msg"></div>

        <label for="password">비밀번호</label>
        <input type="password" name="password" id="password" maxlength="30" required>
        <div id="pwCheckMsg" class="error-msg"></div>

        <label for="passwordConfirm">비밀번호 확인</label>
        <input type="password" id="passwordConfirm" maxlength="30" required>
        <div id="pwConfirmMsg" class="error-msg"></div>

        <label for="name">이름</label>
        <input type="text" name="name" id="name" maxlength="30" required>

        <label for="email">이메일</label>
        <div class="flex-row">
            <input type="email" name="email" id="email" maxlength="50" required>
            <button type="button" id="checkEmailBtn">중복체크</button>
        </div>
        <div id="emailCheckMsg" class="error-msg"></div>

        <button type="submit">회원가입</button>
    </form>
</div>

<script>
// [추가] 아이디, 이메일 중복체크 성공 여부를 추적하는 플래그
let isIdCheckedAndAvailable = false;
let isEmailCheckedAndAvailable = false;

function validatePassword(password) {
    // 8~30자, 영문+숫자 혼용, 특수문자 허용
    return /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]{8,30}$/.test(password);
}

document.addEventListener('DOMContentLoaded', function() {
    const usernameInput = document.getElementById('username');
    const emailInput = document.getElementById('email');

    // [추가] 아이디를 수정하면, 중복체크 상태를 리셋
    usernameInput.addEventListener('input', function() {
        isIdCheckedAndAvailable = false;
        document.getElementById('idCheckMsg').textContent = "";
    });

    // [추가] 이메일을 수정하면, 중복체크 상태를 리셋
    emailInput.addEventListener('input', function() {
        isEmailCheckedAndAvailable = false;
        document.getElementById('emailCheckMsg').textContent = "";
    });

    // 비밀번호 조건 실시간 체크
    document.getElementById('password').addEventListener('input', function() {
        const msg = document.getElementById('pwCheckMsg');
        if (!validatePassword(this.value)) {
            msg.textContent = "비밀번호는 8~30자, 영문과 숫자를 모두 포함해야 합니다.";
        } else {
            msg.textContent = "";
        }
        checkPasswordConfirm();
    });

    // 비밀번호 확인 실시간 체크
    document.getElementById('passwordConfirm').addEventListener('input', checkPasswordConfirm);

    function checkPasswordConfirm() {
        const pw = document.getElementById('password').value;
        const pw2 = document.getElementById('passwordConfirm').value;
        const msg = document.getElementById('pwConfirmMsg');
        if (pw2.length > 0 && pw !== pw2) {
            msg.textContent = "비밀번호가 일치하지 않습니다.";
        } else {
            msg.textContent = "";
        }
    }

    // 아이디 중복체크
    document.getElementById('checkIdBtn').onclick = function() {
        const username = usernameInput.value.trim();
        if (username.length < 4) {
            document.getElementById('idCheckMsg').textContent = "아이디는 4자 이상이어야 합니다.";
            isIdCheckedAndAvailable = false; // [추가]
            return;
        }
        fetch('checkUsername?username=' + encodeURIComponent(username))
            .then(res => res.json())
            .then(data => {
                const idCheckMsg = document.getElementById('idCheckMsg');
                if (data.exists) {
                    idCheckMsg.textContent = "이미 사용 중인 아이디입니다.";
                    idCheckMsg.className = "error-msg";
                    isIdCheckedAndAvailable = false; // [추가]
                } else {
                    idCheckMsg.textContent = "사용 가능한 아이디입니다.";
                    idCheckMsg.className = "success-msg";
                    isIdCheckedAndAvailable = true; // [추가]
                }
            });
    };

    // 이메일 중복체크
    document.getElementById('checkEmailBtn').onclick = function() {
        const email = emailInput.value.trim();
        if (!/^[^@]+@[^@]+\.[^@]+$/.test(email)) {
            document.getElementById('emailCheckMsg').textContent = "이메일 형식이 올바르지 않습니다.";
            isEmailCheckedAndAvailable = false; // [추가]
            return;
        }
        fetch('checkEmail?email=' + encodeURIComponent(email))
            .then(res => res.json())
            .then(data => {
                const emailCheckMsg = document.getElementById('emailCheckMsg');
                if (data.exists) {
                    emailCheckMsg.textContent = "이미 등록된 이메일입니다.";
                    emailCheckMsg.className = "error-msg";
                    isEmailCheckedAndAvailable = false; // [추가]
                } else {
                    emailCheckMsg.textContent = "사용 가능한 이메일입니다.";
                    emailCheckMsg.className = "success-msg";
                    isEmailCheckedAndAvailable = true; // [추가]
                }
            });
    };

    // [REVISED] 폼 제출 시 최종 검증 로직 강화
    document.getElementById('registerForm').onsubmit = function(e) {
        let isValid = true;
        const pw = document.getElementById('password').value;
        const pw2 = document.getElementById('passwordConfirm').value;

        // 중복체크 여부 검사
        if (!isIdCheckedAndAvailable) {
            alert('아이디 중복체크를 완료해주세요.');
            isValid = false;
        } else if (!isEmailCheckedAndAvailable) {
            alert('이메일 중복체크를 완료해주세요.');
            isValid = false;
        }
        // 비밀번호 유효성 검사
        else if (!validatePassword(pw)) {
            document.getElementById('pwCheckMsg').textContent = "비밀번호는 8~30자, 영문과 숫자를 모두 포함해야 합니다.";
            isValid = false;
        }
        // 비밀번호 일치 여부 검사
        else if (pw !== pw2) {
            document.getElementById('pwConfirmMsg').textContent = "비밀번호가 일치하지 않습니다.";
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault(); // 폼 제출 중단
        }
    };
});
</script>
</body>
</html>
