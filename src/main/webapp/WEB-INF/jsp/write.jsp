<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>새 핫딜 작성</title>
<style>
/* list.jsp와 공통된 스타일 */
html, body { height: 100%; margin: 0; padding: 0; }
.wrapper { min-height: 100vh; display: flex; flex-direction: column; }
main { flex: 1; }
.content-wrapper { display: flex; flex-wrap: wrap; gap: 24px; width: 95%; max-width: 1200px; margin: 40px auto; }
.best-posts { flex: 1; min-width: 220px; border: 1px solid #e0e0e0; border-radius: 4px; padding: 16px; background-color: #fdfdfd; height: fit-content; }
.best-posts h3 { margin-top: 0; font-size: 18px; border-bottom: 2px solid #007bff; padding-bottom: 8px; margin-bottom: 12px; }
.best-posts ul { list-style: none; padding: 0; margin: 0; }
.best-posts li { margin-bottom: 10px; font-size: 14px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.best-posts a { text-decoration: none; color: #333; }
.best-posts a:hover { text-decoration: underline; }

/* 글쓰기 폼 전용 스타일 */
.write-form-container {
    flex: 3;
    min-width: 600px;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background: #fff;
}
.write-form-container h2 {
    margin-top: 0;
    padding-bottom: 10px;
    border-bottom: 2px solid #333;
}
.form-group {
    margin-bottom: 15px;
}
.form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
}
.form-group input[type="text"],
.form-group input[type="number"],
.form-group input[type="file"],
.form-group textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}
.form-group textarea {
    height: 200px;
    resize: vertical;
}
.form-actions {
    text-align: right;
    margin-top: 20px;
}
.form-actions button {
    padding: 10px 20px;
    border: none;
    background-color: #007bff;
    color: white;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
}
.form-actions button:hover {
    background-color: #0056b3;
}
</style>
</head>
<body>
    <div class="wrapper">
        <%@ include file="topMenu.jsp"%>
        <main>
            <div class="content-wrapper">
                <div class="write-form-container">
                    <h2>새 핫딜 등록</h2>
                    <form action="write" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="title">제목</label>
                            <input type="text" id="title" name="title" required>
                        </div>
                        <div class="form-group">
                            <label for="productName">상품명</label>
                            <input type="text" id="productName" name="product.productName" required>
                        </div>
                        <div class="form-group">
                            <label for="category">카테고리</label>
                            <input type="text" id="category" name="product.category" required>
                        </div>
                        <div class="form-group">
                            <label for="shopName">쇼핑몰</label>
                            <input type="text" id="shopName" name="product.shopName" required>
                        </div>
                        <div class="form-group">
                            <label for="price">가격 (원)</label>
                            <input type="number" id="price" name="product.price" required>
                        </div>
                        <div class="form-group">
                            <label for="deliveryFee">배송료 (원, 무료는 0 입력)</label>
                            <input type="number" id="deliveryFee" name="product.deliveryFee" placeholder="숫자만 입력 (예: 3000)" required>
                        </div>
                        <div class="form-group">
                            <label for="relatedUrl">관련 URL</label>
                            <input type="text" id="relatedUrl" name="product.relatedUrl">
                        </div>
                        <div class="form-group">
                            <label for="thumbnailFile">썸네일 이미지</label>
                            <input type="file" id="thumbnailFile" name="thumbnailFile">
                        </div>
                        <div class="form-group">
                            <label for="content">내용</label>
                            <textarea id="content" name="content" required></textarea>
                        </div>
                        <div class="form-actions">
                            <button type="submit">등록하기</button>
                        </div>
                    </form>
                </div>
                
                <%-- bestPosts.jsp 파일을 여기에 포함시킵니다 --%>
                <%@ include file="bestPosts.jsp" %>
            </div>
        </main>
        <%@ include file="footer.jsp"%>
    </div>
</body>
</html>
