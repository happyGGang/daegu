$(document).ready(function () {
	// 백그라운드 이미지 10초에 한번씩 변경
	const images = ['/resources/homepage/center/img/main1.svg', '/resources/homepage/center/img/main2.svg', '/resources/homepage/center/img/main3.svg'];
	let currentIndex = 0;

	function changeBackgroundImage() {
		currentIndex = (currentIndex + 1) % images.length;

		$('#section1').css('animation', 'none');
		$('#section1 .caption').css('animation', 'none');
		$('#section1').css('background-image', `url(${images[currentIndex]})`);

		setTimeout(function () {
			$('#section1').css('animation', 'backgrounds 1.5s ease-out forwards');
			$('#section1 .caption').css('animation', 'fadeInUp 2s ease-out forwards');
		}, 10);
	}

	setInterval(changeBackgroundImage, 10000);

	// 백그라운드 이미지 인디케이터
	let currentActiveIndex = 0;
	const indicator = $('.indicator');

	function switchActivePage() {
		$(indicator[currentActiveIndex]).removeClass('active_indicator');

		currentActiveIndex = (currentActiveIndex + 1) % indicator.length;

		$(indicator[currentActiveIndex]).addClass('active_indicator');
	}

	setInterval(switchActivePage, 10000);

	// 공지사항 스와이퍼
	const noticeSwiper = new Swiper('.right_area .swiper', {
		loop: true,
		direction: 'vertical',
		autoplay: {
			delay: 3000,
			disableOnInteraction: false,
		},
	});

	// 공지사항 스와이퍼 재생 OR 정지
	const autoplayButton = document.querySelector('.notice_autoplay');

	autoplayButton.addEventListener('click', () => {
		if (noticeSwiper.autoplay.running) {
			noticeSwiper.autoplay.stop();
			updateAutoplayButton('/resources/homepage/center/img/play.svg', '재생버튼');
		} else {
			noticeSwiper.autoplay.start();
			updateAutoplayButton('/resources/homepage/center/img/stop.svg', '정지버튼');
		}
	});

	function updateAutoplayButton(src, alt) {
		autoplayButton.src = src;
		autoplayButton.alt = alt;
	}
});
