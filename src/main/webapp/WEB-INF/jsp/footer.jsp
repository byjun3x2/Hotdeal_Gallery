
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<style>
.footer {
	width: 100%;
	background: #fff;
	color: #666;
	border-top: 1px solid #eee;
	font-size: 14px;
	min-height: 48px;
	height: 52px;
	display: flex;
	align-items: center;
	justify-content: center;
	box-sizing: border-box;
	margin-top: 40px;
	padding: 0;
}

.footer-inner {
	width: 900px;
	max-width: 96vw;
	margin: 0 auto;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.footer-left {
	font-weight: bold;
	color: #222;
	font-size: 16px;
	letter-spacing: 1px;
}

.footer-links {
	display: flex;
	align-items: center;
	gap: 18px;
}

.footer-links a {
	color: #666;
	text-decoration: none;
	font-size: 14px;
	transition: color 0.2s;
}

.footer-links a:hover {
	color: #0056b3;
	text-decoration: underline;
}

.footer-copy {
	color: #aaa;
	font-size: 13px;
	margin-left: 28px;
}

@media ( max-width : 700px) {
	.footer-inner {
		flex-direction: column;
		align-items: center;
		justify-content: center;
		width: 98vw;
		gap: 4px;
	}
	.footer {
		height: auto;
		min-height: 48px;
		padding: 8px 0;
	}
	.footer-copy {
		margin-left: 0;
	}
}
</style>
<link rel="shortcut icon" href="<c:url value='/resources/favicon.ico'/>"
	type="image/x-icon" />
<div class="footer">
	<div class="footer-inner">
		<div class="footer-left">핫딜 갤러리</div>
		<div class="footer-links">
			<a href="about">About</a> <a href="faq">FAQ</a> <a href="contact">Contact</a>
			<a href="privacy">개인정보처리방침</a> <a href="terms">이용약관</a>
		</div>
		<div class="footer-copy">
			&copy; <span id="footer-year"></span> 핫딜갤러리
		</div>
	</div>
</div>
<script>
    document.getElementById('footer-year').textContent = new Date().getFullYear();
</script>
