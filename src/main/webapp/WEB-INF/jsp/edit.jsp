<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="topMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <style>
        .edit-box {
            width: 500px;
            margin: 40px auto;
            border: 1px solid #ddd;
            padding: 30px;
            border-radius: 8px;
            background: #fafbfc;
        }
        .edit-box h2 {
            margin-bottom: 20px;
            text-align: center;
        }
        .edit-box label {
            display: block;
            margin-bottom: 7px;
            color: #333;
            font-weight: bold;
        }
        .edit-box input[type="text"],
        .edit-box input[type="number"],
        .edit-box input[type="email"],
        .edit-box textarea,
        .edit-box select {
            width: 100%;
            padding: 7px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 15px;
            box-sizing: border-box;
        }
        .edit-box input[type="file"] {
            margin-bottom: 15px;
        }
        .edit-box button {
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
        .edit-box button:hover {
            background: #0056b3;
        }
        .edit-box .info {
            font-size: 13px;
            color: #888;
            margin-bottom: 10px;
        }
        .edit-box img {
            max-width: 100%;
            border-radius: 6px;
            margin-bottom: 12px;
            display: block;
        }
        .error-msg {
            color: #c00;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="edit-box">
    <h2>게시글 수정</h2>
    <c:if test="${not empty msg}">
        <div class="error-msg">${msg}</div>
    </c:if>
    <form method="post" action="edit" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${deal.id}" />
        <input type="hidden" name="product.productId" value="${deal.product.productId}" />

        <label for="productCategory">상품 카테고리</label>
        <select name="product.category" id="productCategory" required>
            <option value="">-- 카테고리 선택 --</option>
            <option value="먹거리" <c:if test="${deal.product.category == '먹거리'}">selected</c:if>>먹거리</option>
            <option value="sw/게임" <c:if test="${deal.product.category == 'sw/게임'}">selected</c:if>>sw/게임</option>
            <option value="pc제품" <c:if test="${deal.product.category == 'pc제품'}">selected</c:if>>pc제품</option>
            <option value="가전제품" <c:if test="${deal.product.category == '가전제품'}">selected</c:if>>가전제품</option>
            <option value="생활용품" <c:if test="${deal.product.category == '생활용품'}">selected</c:if>>생활용품</option>
            <option value="의류" <c:if test="${deal.product.category == '의류'}">selected</c:if>>의류</option>
            <option value="세일정보" <c:if test="${deal.product.category == '세일정보'}">selected</c:if>>세일정보</option>
            <option value="화장품" <c:if test="${deal.product.category == '화장품'}">selected</c:if>>화장품</option>
            <option value="모바일/상품권" <c:if test="${deal.product.category == '모바일/상품권'}">selected</c:if>>모바일/상품권</option>
            <option value="해외핫딜" <c:if test="${deal.product.category == '해외핫딜'}">selected</c:if>>해외핫딜</option>
            <option value="기타" <c:if test="${deal.product.category == '기타'}">selected</c:if>>기타</option>
        </select>

        <label for="shopName">쇼핑몰명</label>
        <input type="text" name="product.shopName" id="shopName" value="${deal.product.shopName}" maxlength="100" required>

        <label for="productName">상품명</label>
        <input type="text" name="product.productName" id="productName" value="${deal.product.productName}" maxlength="200" required>

        <label for="price">가격</label>
        <input type="number" name="product.price" id="price" value="${deal.product.price}" min="0" step="1" required>

        <label for="deliveryFee">배송비</label>
        <input type="text" name="product.deliveryFee" id="deliveryFee" value="${deal.product.deliveryFee}" maxlength="20" required>

        <label for="relatedUrl">관련 URL</label>
        <input type="text" name="product.relatedUrl" id="relatedUrl" value="${deal.product.relatedUrl}" maxlength="500">

        <label for="title">제목</label>
        <input type="text" name="title" id="title" value="${deal.title}" required maxlength="200">

        <label for="thumbnail">썸네일 이미지 URL</label>
        <input type="text" name="thumbnail" id="thumbnail" value="${deal.thumbnail}" maxlength="500">
        <div class="info">이미지 URL 또는 파일 업로드 중 하나만 입력하세요. (둘 다 입력하면 파일 업로드가 우선 적용됩니다)</div>

        <img id="thumbnailPreview" src="${deal.thumbnail}" alt="현재 썸네일">

        <label for="thumbnailFile">썸네일 이미지 업로드</label>
        <input type="file" name="thumbnailFile" id="thumbnailFile" accept="image/*">

        <%-- [수정] 관리자일 경우에만 공지 등록 체크박스 표시 --%>
        <c:if test="${sessionScope.loginUser.role == 'ROLE_ADMIN'}">
            <div style="margin-bottom: 15px;">
                <label for="isNotice" style="display: inline-block; font-weight: normal;">
                    <input type="checkbox" name="isNotice" id="isNotice" value="Y" 
                           <c:if test="${deal.isNotice == 'Y'}">checked</c:if> >
                    이 글을 공지로 등록합니다.
                </label>
            </div>
        </c:if>

        <label for="content">내용</label>
        <textarea name="content" id="content" rows="8" required>${deal.content}</textarea>

        <button type="submit">수정 완료</button>
    </form>
</div>
<script>
document.getElementById('thumbnailFile').addEventListener('change', function(e) {
    const file = e.target.files[0];
    const preview = document.getElementById('thumbnailPreview');
    if (file) {
        const reader = new FileReader();
        reader.onload = function(ev) {
            preview.src = ev.target.result;
        };
        reader.readAsDataURL(file);
    } else {
        preview.src = document.getElementById('thumbnail').value;
    }
});
document.getElementById('thumbnail').addEventListener('input', function(e) {
    const fileInput = document.getElementById('thumbnailFile');
    const preview = document.getElementById('thumbnailPreview');
    if (!fileInput.value) {
        preview.src = e.target.value;
    }
});
</script>
</body>
</html>