<%@ page contentType="text/html; charset=UTF-8" language="java"%>


<style>
.ad-close-btn {
	position: absolute;
	top: 8px;
	right: 8px;
	z-index: 5;
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


	<button class="ad-close-btn" id="adCloseBtn" title="광고 닫기">&times;</button>

	<div class="carousel-container" id="carouselContainer">
		<div class="carousel-slide active">
			<a href="https://www.starbucks.co.kr/index.do" target="_blank"> <img
				src="https://i.pinimg.com/736x/f6/2d/d1/f62dd1225e9342250ff6938dfdd1f0ff.jpg"
				alt="광고1">
			</a>
		</div>
		<div class="carousel-slide">
			<a href="https://www.chanel.com/kr/fragrance/" target="_blank"> <img
				src="https://i.pinimg.com/736x/33/3b/3f/333b3f821596bc5fb3adc7132fe991a9.jpg"
				alt="광고2">
			</a>
		</div>
		<button class="carousel-btn prev" type="button">&#10094;</button>
		<button class="carousel-btn next" type="button">&#10095;</button>
		<div class="carousel-dots">
			<span class="carousel-dot active"></span> <span class="carousel-dot"></span>
		</div>
	</div>
</aside>


<script>

    (function() {

        const adSidebar = document.getElementById('adSidebar');
        const adCloseBtn = document.getElementById('adCloseBtn');

        if (adSidebar && adCloseBtn) {
            adCloseBtn.addEventListener('click', function() {

                adSidebar.style.display = 'none';
            });
        }
    })();
</script>