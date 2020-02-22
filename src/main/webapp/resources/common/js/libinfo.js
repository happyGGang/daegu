$(function() {

	$('a.mp1on').on('click', function(e) {
		e.preventDefault();

		$('div.mapBg1').addClass('on');
		$('div.mapBg2').removeClass('on');
		$('div.mapBg3').removeClass('on');
		$('div.mapBg4').removeClass('on');
		$('div.mapBg5').removeClass('on');
		$('div.mapBg6').removeClass('on');
		$('div.mapBg7').removeClass('on');
		$('div.mapBg8').removeClass('on');

		$('a.mp1on').addClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').removeClass('on');

		$('.all-lib').css('display','none');
		$('.donggu').css('display','block');
		$('.bukgu').css('display','none');
		$('.suseonggu').css('display','none');
		$('.junggu').css('display','none');
		$('.namgu').css('display','none');
		$('.seogu').css('display','none');
		$('.dalseogu').css('display','none');
		$('.dalseonggun').css('display','none');
	});

	$('a.mp2on').on('click', function(e) {
		e.preventDefault();

		$('div.mapBg1').removeClass('on');
		$('div.mapBg2').addClass('on');
		$('div.mapBg3').removeClass('on');
		$('div.mapBg4').removeClass('on');
		$('div.mapBg5').removeClass('on');
		$('div.mapBg6').removeClass('on');
		$('div.mapBg7').removeClass('on');
		$('div.mapBg8').removeClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').addClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').removeClass('on');

		$('.all-lib').css('display','none');
		$('.donggu').css('display','none');
		$('.bukgu').css('display','block');
		$('.suseonggu').css('display','none');
		$('.junggu').css('display','none');
		$('.namgu').css('display','none');
		$('.seogu').css('display','none');
		$('.dalseogu').css('display','none');
		$('.dalseonggun').css('display','none');
	});

	$('a.mp3on').on('click', function(e) {
		e.preventDefault();

		$('div.mapBg1').removeClass('on');
		$('div.mapBg2').removeClass('on');
		$('div.mapBg3').addClass('on');
		$('div.mapBg4').removeClass('on');
		$('div.mapBg5').removeClass('on');
		$('div.mapBg6').removeClass('on');
		$('div.mapBg7').removeClass('on');
		$('div.mapBg8').removeClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').addClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').removeClass('on');

		$('.all-lib').css('display','none');
		$('.donggu').css('display','none');
		$('.bukgu').css('display','none');
		$('.suseonggu').css('display','block');
		$('.junggu').css('display','none');
		$('.namgu').css('display','none');
		$('.seogu').css('display','none');
		$('.dalseogu').css('display','none');
		$('.dalseonggun').css('display','none');
	});

	$('a.mp4on').on('click', function(e) {
		e.preventDefault();

		$('div.mapBg1').removeClass('on');
		$('div.mapBg2').removeClass('on');
		$('div.mapBg3').removeClass('on');
		$('div.mapBg4').addClass('on');
		$('div.mapBg5').removeClass('on');
		$('div.mapBg6').removeClass('on');
		$('div.mapBg7').removeClass('on');
		$('div.mapBg8').removeClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').addClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').removeClass('on');

		$('.all-lib').css('display','none');
		$('.donggu').css('display','none');
		$('.bukgu').css('display','none');
		$('.suseonggu').css('display','none');
		$('.junggu').css('display','block');
		$('.namgu').css('display','none');
		$('.seogu').css('display','none');
		$('.dalseogu').css('display','none');
		$('.dalseonggun').css('display','none');
	});

	$('a.mp5on').on('click', function(e) {
		e.preventDefault();

		$('div.mapBg1').removeClass('on');
		$('div.mapBg2').removeClass('on');
		$('div.mapBg3').removeClass('on');
		$('div.mapBg4').removeClass('on');
		$('div.mapBg5').addClass('on');
		$('div.mapBg6').removeClass('on');
		$('div.mapBg7').removeClass('on');
		$('div.mapBg8').removeClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').addClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').removeClass('on');

		$('.all-lib').css('display','none');
		$('.donggu').css('display','none');
		$('.bukgu').css('display','none');
		$('.suseonggu').css('display','none');
		$('.junggu').css('display','none');
		$('.namgu').css('display','block');
		$('.seogu').css('display','none');
		$('.dalseogu').css('display','none');
		$('.dalseonggun').css('display','none');
	});

	$('a.mp6on').on('click', function(e) {
		e.preventDefault();

		$('div.mapBg1').removeClass('on');
		$('div.mapBg2').removeClass('on');
		$('div.mapBg3').removeClass('on');
		$('div.mapBg4').removeClass('on');
		$('div.mapBg5').removeClass('on');
		$('div.mapBg6').addClass('on');
		$('div.mapBg7').removeClass('on');
		$('div.mapBg8').removeClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').addClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').removeClass('on');

		$('.all-lib').css('display','none');
		$('.donggu').css('display','none');
		$('.bukgu').css('display','none');
		$('.suseonggu').css('display','none');
		$('.junggu').css('display','none');
		$('.namgu').css('display','none');
		$('.seogu').css('display','block');
		$('.dalseogu').css('display','none');
		$('.dalseonggun').css('display','none');
	});

	$('a.mp7on').on('click', function(e) {
		e.preventDefault();

		$('div.mapBg1').removeClass('on');
		$('div.mapBg2').removeClass('on');
		$('div.mapBg3').removeClass('on');
		$('div.mapBg4').removeClass('on');
		$('div.mapBg5').removeClass('on');
		$('div.mapBg6').removeClass('on');
		$('div.mapBg7').addClass('on');
		$('div.mapBg8').removeClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').addClass('on');
		$('a.mp8on').removeClass('on');

		$('.all-lib').css('display','none');
		$('.donggu').css('display','none');
		$('.bukgu').css('display','none');
		$('.suseonggu').css('display','none');
		$('.junggu').css('display','none');
		$('.namgu').css('display','none');
		$('.seogu').css('display','none');
		$('.dalseogu').css('display','block');
		$('.dalseonggun').css('display','none');
	});

	$('a.mp8on').on('click', function(e) {
		e.preventDefault();

		$('div.mapBg1').removeClass('on');
		$('div.mapBg2').removeClass('on');
		$('div.mapBg3').removeClass('on');
		$('div.mapBg4').removeClass('on');
		$('div.mapBg5').removeClass('on');
		$('div.mapBg6').removeClass('on');
		$('div.mapBg7').removeClass('on');
		$('div.mapBg8').addClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').addClass('on');

		$('.all-lib').css('display','none');
		$('.donggu').css('display','none');
		$('.bukgu').css('display','none');
		$('.suseonggu').css('display','none');
		$('.junggu').css('display','none');
		$('.namgu').css('display','none');
		$('.seogu').css('display','none');
		$('.dalseogu').css('display','none');
		$('.dalseonggun').css('display','block');
	});
});