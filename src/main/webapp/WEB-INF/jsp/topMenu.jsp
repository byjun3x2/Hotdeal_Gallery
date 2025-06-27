<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
.top-menu-bar .menu-links a {
    margin-right: 8px;
    color: #666;
    text-decoration: none;
}
.top-menu-bar .menu-links a:hover {
    text-decoration: underline;
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
.top-menu-bar button {
    padding: 3px 10px;
    margin-left: 6px;
    font-size: 13px;
}
.top-menu-bar .login-error {
    color: #c00;
    font-size: 13px;
    margin-left: 10px;
    display: inline-block;
}
/* 다크모드 스타일 */
body.dark-mode {
    background: #181a1b !important;
    color: #e0e0e0 !important;
}
body.dark-mode .top-menu-bar {
    background: #23272f !important;
    color: #e0e0e0 !important;
    border-bottom: 1px solid #444 !important;
}
body.dark-mode .menu-links a,
body.dark-mode .top-menu-bar .user-info,
body.dark-mode .top-menu-bar label,
body.dark-mode .top-menu-bar button {
    color: #b0c4de !important;
}
body.dark-mode .menu-links a:hover {
    color: #fff !important;
}
body.dark-mode input[type="text"], body.dark-mode input[type="password"] {
    background: #222 !important;
    color: #fff !important;
    border-color: #444 !important;
}
body.dark-mode .login-error {
    color: #ff5555 !important;
}
</style>
<div class="top-menu-bar">
    <div class="menu-links">
        할인마켓
        <a href="join">회원 가입</a> |
        <a href="findPassword">비번 찾기</a> |
        <a href="certMail">인증 메일 재발송</a> |
        <a href="#" id="darkModeToggle" onclick="toggleDarkMode();return false;">다크OFF</a>
        
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
        document.getElementById('darkModeToggle').textContent = '다크ON';
    } else {
        document.body.classList.remove('dark-mode');
        document.getElementById('darkModeToggle').textContent = '다크OFF';
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
</script>
