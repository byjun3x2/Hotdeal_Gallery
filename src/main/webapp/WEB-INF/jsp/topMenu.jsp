<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%-- 외부 다크모드 CSS 파일을 head에 추가 --%>


<style>
.top-menu-bar {
    width: 100%;
    background: #fff;
    border-bottom: 1px solid #eee;
    padding: 8px 0;
    font-size: 13px;
    color: #666;
    box-sizing: border-box;
}
.top-menu-bar .menu-links {
    display: inline-block;
    margin-right: 20px;
}
.top-menu-bar .menu-links a, .top-menu-bar .menu-links button {
    margin-right: 8px;
    color: #666;
    text-decoration: none;
    background: none;
    border: none;
    font: inherit;
    cursor: pointer;
    outline: none;
    padding: 0 8px;
    transition: color 0.2s;
}
.top-menu-bar .menu-links a:hover, .top-menu-bar .menu-links button:hover {
    text-decoration: underline;
    color: #0056b3;
}
.top-menu-bar .login-form,
.top-menu-bar .user-info {
    display: inline-block;
    float: right;
    vertical-align: middle;
}
.top-menu-bar input[type="text"], .top-menu-bar input[type="password"] {
    padding: 3px 5px;
    margin-left: 4px;
    font-size: 13px;
    width: 80px;
}
.top-menu-bar label {
    margin-left: 6px;
    font-size: 13px;
}
.top-menu-bar button[type="submit"] {
    padding: 3px 10px;
    margin-left: 6px;
    font-size: 13px;
    background: #007bff;
    color: #fff;
    border-radius: 4px;
    border: none;
}
.top-menu-bar .login-error {
    color: #c00;
    font-size: 13px;
    margin-left: 10px;
    display: inline-block;
}

</style>
<div class="top-menu-bar">
    <div class="menu-links">
        커스텀 핫딜 |
        <a href="join">회원 가입</a> |
        <button id="darkModeToggle" type="button">
            <span id="darkModeIcon">🌙</span>
            <span id="darkModeText">다크모드 켜기</span>
        </button>
    </div>
    <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
            <div class="user-info">
                <span><b>${sessionScope.loginUser.username}</b>님 환영합니다!</span>
                <a href="logout">로그아웃</a>
            </div>
        </c:when>
        <c:otherwise>
            <form class="login-form" method="post" action="login" style="margin:0; display:inline;">
                <input type="text" name="username" placeholder="아이디" required />
                <input type="password" name="password" placeholder="암호" required />
                <label>
                    <input type="checkbox" name="autoLogin" /> 자동 로그인
                </label>
                <button type="submit">로그인</button>
                <c:if test="${not empty loginError}">
                    <span class="login-error">${loginError}</span>
                </c:if>
            </form>
        </c:otherwise>
    </c:choose>
    <div style="clear:both;"></div>
</div>
<script>
function applyDarkMode(enabled) {
    if(enabled) {
        document.body.classList.add('dark-mode');
        document.getElementById('darkModeIcon').textContent = '☀️';
        document.getElementById('darkModeText').textContent = '다크모드 끄기';
    } else {
        document.body.classList.remove('dark-mode');
        document.getElementById('darkModeIcon').textContent = '🌙';
        document.getElementById('darkModeText').textContent = '다크모드 켜기';
    }
}
function toggleDarkMode() {
    let enabled = !document.body.classList.contains('dark-mode');
    applyDarkMode(enabled);
    localStorage.setItem('darkMode', enabled ? 'enabled' : 'disabled');
}
// 페이지 로드시 상태 복원
(function() {
    let darkMode = localStorage.getItem('darkMode');
    applyDarkMode(darkMode === 'enabled');
})();
document.getElementById('darkModeToggle').onclick = toggleDarkMode;
</script>
