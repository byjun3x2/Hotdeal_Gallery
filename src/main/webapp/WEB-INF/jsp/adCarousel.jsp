<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%-- [ADD] 닫기 버튼을 위한 CSS 스타일 추가 --%>
<style>
    .ad-close-btn {
        position: absolute;
        top: 8px;
        right: 8px;
        z-index: 5; /* 캐러셀 이미지보다 위에 표시되도록 설정 */
        cursor: pointer;
        background-color: rgba(0, 0, 0, 0.4);
        color: white;
        border: none;
        border-radius: 50%;
        width: 24px;
        height: 24px;
        font-size: 16px;
        line-height: 24px;
        text-align: center;
        font-weight: bold;
        transition: background-color 0.2s;
    }
    .ad-close-btn:hover {
        background-color: rgba(0, 0, 0, 0.7);
    }
</style>

<aside class="ad-sidebar-left" id="adSidebar">
    
    <%-- [ADD] 광고 닫기 버튼 추가 --%>
    <button class="ad-close-btn" id="adCloseBtn" title="광고 닫기">&times;</button>

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
        <button class="carousel-btn prev" type="button">&#10094;</button>
        <button class="carousel-btn next" type="button">&#10095;</button>
        <div class="carousel-dots">
            <span class="carousel-dot active"></span>
            <span class="carousel-dot"></span>
        </div>
    </div>
</aside>

<%-- [ADD] 닫기 버튼의 동작을 처리하는 JavaScript 추가 --%>
<script>
    // 페이지의 다른 스크립트와 충돌하지 않도록 즉시 실행 함수로 감쌉니다.
    (function() {
        // adSidebar와 adCloseBtn 요소가 존재하는지 확인 후 스크립트 실행
        const adSidebar = document.getElementById('adSidebar');
        const adCloseBtn = document.getElementById('adCloseBtn');

        if (adSidebar && adCloseBtn) {
            adCloseBtn.addEventListener('click', function() {
                // 광고 사이드바 전체를 보이지 않게 처리
                adSidebar.style.display = 'none';
            });
        }
    })();
</script>