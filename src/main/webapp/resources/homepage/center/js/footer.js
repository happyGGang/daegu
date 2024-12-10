$(document).ready(function () {
	// 기관 로고 스와이퍼
	const BadgeSwiper = new Swiper('.badge_swiper .swiper', {
		speed: 900,
		autoplay: true,
		loop: true,
		slidesPerView: 5,
		spaceBetween: 60,
		loopAddBlankSlides: true,
		navigation: {
			nextEl: '.badge_swiper .swiper-button-next',
			prevEl: '.badge_swiper .swiper-button-prev',
		},
		breakpoints: {
			// 노트북 & 태블릿 가로: 1024px - 1279px
			1024: {
				slidesPerView: 5,
				spaceBetween: 10,
			},
			// 태블릿 가로: 768px - 1023px
			768: {
				slidesPerView: 5,
			},
			// 모바일 가로 & 태블릿 세로: 480px - 767px
			480: {
				slidesPerView: 5,
			},
			// 모바일: -479px
			0: {
				slidesPerView: 2,
				spaceBetween: 15,
			},
		},
	});

	// 기관 로고 스와이퍼 재생 OR 정지 기능
	const autoplayButton = document.querySelector('.badge_autoplay');

	autoplayButton.addEventListener('click', () => {
		if (BadgeSwiper.autoplay.running) {
			BadgeSwiper.autoplay.stop();
			updateAutoplayButton('/resources/homepage/center/img/popup_play.svg', '재생버튼');
			autoplayButton.alt = '재생버튼';
		} else {
			BadgeSwiper.autoplay.start();
			updateAutoplayButton('/resources/homepage/center/img/popup_stop.svg', '정지버튼');
		}
	});

	function updateAutoplayButton(src, alt) {
		autoplayButton.src = src;
		autoplayButton.alt = alt;
	}

	// 스크롤탑 클릭시 section1 으로 이동
	$('.scroll_top').click(function (event) {
		event.preventDefault();

		// fullpage.js를 사용하는 경우
		if (typeof fullpage_api !== 'undefined' && fullpage_api.moveTo) {
			fullpage_api.moveTo(1); // fullpage.js의 첫 번째 섹션으로 이동
		} else {
			// fullpage.js가 없을 경우 윈도우 스크롤탑으로 이동
			$('html, body').animate({ scrollTop: 0 }, 500);
		}
	});
});
