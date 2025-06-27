<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!-- 광고 캐러셀 영역 (스타일과 스크립트는 list.jsp에 있음) -->
<aside class="ad-sidebar-left" id="adSidebar">
    <div class="carousel-container" id="carouselContainer">
        <div class="carousel-slide active">
            <a href="https://www.starbucks.co.kr/index.do" target="_blank">
                <img src="https://i.pinimg.com/736x/f6/2d/d1/f62dd1225e9342250ff6938dfdd1f0ff.jpg" alt="광고1">
            </a>
        </div>
        <div class="carousel-slide">
            <a href="https://www.chanel.com/kr/fragrance/" target="_blank">
                <img src="https://i.pinimg.com/736x/33/3b/3f/333b3f821596bc5fb3adc7132fe991a9.jpg" alt="광고2">
            </a>
        </div>
        <!-- 화살표 버튼은 숨김 처리됨 -->
        <button class="carousel-btn prev" type="button">&#10094;</button>
        <button class="carousel-btn next" type="button">&#10095;</button>
        <div class="carousel-dots">
            <span class="carousel-dot active"></span>
            <span class="carousel-dot"></span>
        </div>
    </div>
</aside>
