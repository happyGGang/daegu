$(document).ready(function () {


	function updateAutoplayButton(src, alt) {
		autoplayButton.src = src;
		autoplayButton.alt = alt;
	}

	// 스크롤탑 클릭시 section1 으로 이동
	$('.scroll_top').click(function (event) {
		event.preventDefault();

		// fullpage.js를 사용하는 경우
		if ($(window).width() < 1025) 
		{
			console.log('되나1?');
			$('html,body').animate({scrollTop:0},500);
		} else {
			console.log('되나2?');
			fullpage_api.moveTo(1); // fullpage.js의 첫 번째 섹션으로 이동
		}

	});
});
