<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="topMenu.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핫딜 새글 등록</title>
<link rel="shortcut icon" href="<c:url value='/resources/favicon.ico'/>"
	type="image/x-icon" />
<style>
.write-box {
	width: 500px;
	margin: 40px auto;
	border: 1px solid #ddd;
	padding: 30px;
	border-radius: 8px;
	background: #fafbfc;
}

.write-box h2 {
	margin-bottom: 20px;
	text-align: center;
}

.write-box label {
	display: block;
	margin-bottom: 7px;
	color: #333;
	font-weight: bold;
}

.write-box input[type="text"], .write-box input[type="number"],
	.write-box textarea, .write-box select {
	width: 100%;
	padding: 7px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 15px;
	box-sizing: border-box;
}

.write-box input[type="file"] {
	margin-bottom: 15px;
}

.write-box button {
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

.write-box button:hover {
	background: #0056b3;
}

.write-box .info {
	font-size: 13px;
	color: #888;
	margin-bottom: 10px;
}

.write-box textarea {
	resize: none;
}

.char-counter {
	text-align: right;
	font-size: 12px;
	color: #888;
	margin-top: -10px;
	margin-bottom: 15px;
}

.warning-msg {
	color: red;
	display: none; /* 평소에는 숨김 */
	margin-left: 5px;
}

.error-msg {
	color: #c00;
	font-size: 14px;
	text-align: center;
	margin-bottom: 15px;
}
</style>
</head>
<body>
	<div class="write-box">
		<h2>핫딜 새글 등록</h2>
		<c:if test="${not empty msg}">
			<div class="error-msg">${msg}</div>
		</c:if>
		<form method="post" action="write" enctype="multipart/form-data"
			onsubmit="return validateForm()">
			<label for="productCategory">상품 카테고리</label> <select
				name="product.category" id="productCategory">
				<option value="">-- 카테고리 선택 --</option>
				<option value="먹거리">먹거리</option>
				<option value="sw/게임">sw/게임</option>
				<option value="pc제품">pc제품</option>
				<option value="가전제품">가전제품</option>
				<option value="생활용품">생활용품</option>
				<option value="의류">의류</option>
				<option value="세일정보">세일정보</option>
				<option value="화장품">화장품</option>
				<option value="모바일/상품권">모바일/상품권</option>
				<option value="해외핫딜">해외핫딜</option>
				<option value="기타">기타</option>
			</select> <label for="shopName">쇼핑몰명</label> <input type="text"
				name="product.shopName" id="shopName" maxlength="100"> <label
				for="productName">상품명</label> <input type="text"
				name="product.productName" id="productName" maxlength="200">

			<label for="price">가격</label> <input type="number"
				name="product.price" id="price" min="0" step="1"
				placeholder="숫자만 입력 (예: 3000)"> <label for="deliveryFee">배송비</label>
			<input type="text" name="product.deliveryFee" id="deliveryFee"
				maxlength="20"> <label for="relatedUrl">관련 URL</label> <input
				type="text" name="product.relatedUrl" id="relatedUrl"
				maxlength="500" placeholder="예: https://www.example.com"> <label
				for="title">제목</label> <input type="text" name="title" id="title"
				required maxlength="200">

			<div class="char-counter">
				<span id="titleWarning" class="warning-msg">허용되는 글자수가
					초과되었습니다.</span> <span id="titleCharCount">(0/200)</span>
			</div>

			<label for="thumbnail">썸네일 이미지 URL</label> <input type="text"
				name="thumbnail" id="thumbnail" maxlength="500">
			<div class="info">이미지 URL 또는 파일 업로드 중 하나만 입력하세요. (둘 다 입력하면 파일
				업로드가 우선 적용됩니다)</div>
			<div class="info">허용 가능한 이미지 포맷 (jpeg, jpg, png)</div>
			<label for="thumbnailFile">썸네일 이미지 업로드</label> <input type="file"
				name="thumbnailFile" id="thumbnailFile" accept="image/*">

			<c:if test="${sessionScope.loginUser.role == 'ROLE_ADMIN'}">
				<div style="margin-bottom: 15px;">
					<label for="isNotice"
						style="display: inline-block; font-weight: normal;"> <input
						type="checkbox" name="isNotice" id="isNotice" value="Y"> 이
						글을 공지로 등록합니다.
					</label>
				</div>
			</c:if>

			<label for="content">내용</label>
			<textarea name="content" id="content" rows="8" required></textarea>

			<button type="submit">등록</button>
		</form>
	</div>
	<script>
		function validateForm() {
			const urlInput = document.getElementById('relatedUrl');
			const urlValue = urlInput.value.trim();
			if (urlValue !== '' && urlValue !== 'https://') {
				try {
					let fullUrl = urlValue;
					if (!/^https?:\/\//i.test(fullUrl)) {
						fullUrl = 'http://' + fullUrl;
					}
					new URL(fullUrl);
				} catch (e) {
					alert('입력된 URL 형식이 올바르지 않습니다.');
					urlInput.focus();
					return false;
				}
			} else {
				urlInput.value = '';
			}

			const titleInput = document.getElementById('title');
			if (titleInput.value.length > 200) {
				alert('제목은 200자를 초과할 수 없습니다.');
				titleInput.focus();
				return false;
			}

			return true;
		}

		document
				.addEventListener(
						'DOMContentLoaded',
						function() {
							const urlInput = document
									.getElementById('relatedUrl');
							const titleInput = document.getElementById('title');
							const titleCharCountSpan = document
									.getElementById('titleCharCount');
							const titleWarningSpan = document
									.getElementById('titleWarning');
							const maxLength = 200;

							urlInput.addEventListener('focus', function() {
								if (this.value.trim() === '') {
									this.value = 'https://';
								}
							});
							urlInput.addEventListener('blur', function() {
								if (this.value.trim() === 'https://') {
									this.value = '';
								}
							});

							titleInput
									.addEventListener(
											'input',
											function() {
												const currentLength = this.value.length;

												titleCharCountSpan.textContent = `(${currentLength}/${maxLength})`;

												if (currentLength > maxLength) {
													titleCharCountSpan.style.color = 'red';
													titleWarningSpan.style.display = 'inline';
												} else {
													titleCharCountSpan.style.color = '#888';
													titleWarningSpan.style.display = 'none';
												}
											});
						});
	</script>
</body>
</html>