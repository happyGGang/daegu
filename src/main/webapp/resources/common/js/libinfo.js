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
		$('div.mapBg9').removeClass('on');

		$('a.mp1on').addClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').removeClass('on');
		$('a.mp9on').removeClass('on');
		$('a.mp9on').removeClass('on');

		$('select#category1').val('0002').attr('selected', 'true');
		$('select#category2').val('').attr('selected', 'true');
		$('select#category1').change();
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
		$('div.mapBg9').removeClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').addClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').removeClass('on');
		$('a.mp9on').removeClass('on');

		$('select#category1').val('0005').attr('selected', 'true');
		$('select#category2').val('').attr('selected', 'true');
		$('select#category1').change();
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
		$('div.mapBg9').removeClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').addClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').removeClass('on');
		$('a.mp9on').removeClass('on');

		$('select#category1').val('0007').attr('selected', 'true');
		$('select#category2').val('').attr('selected', 'true');
		$('select#category1').change();
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
		$('div.mapBg9').removeClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').addClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').removeClass('on');
		$('a.mp9on').removeClass('on');

		$('select#category1').val('0001').attr('selected', 'true');
		$('select#category2').val('').attr('selected', 'true');
		$('select#category1').change();
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
		$('div.mapBg9').removeClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').addClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').removeClass('on');
		$('a.mp9on').removeClass('on');

		$('select#category1').val('0004').attr('selected', 'true');
		$('select#category2').val('').attr('selected', 'true');
		$('select#category1').change();
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
		$('div.mapBg9').removeClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').addClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').removeClass('on');
		$('a.mp9on').removeClass('on');

		$('select#category1').val('0003').attr('selected', 'true');
		$('select#category2').val('').attr('selected', 'true');
		$('select#category1').change();
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
		$('div.mapBg9').removeClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').addClass('on');
		$('a.mp8on').removeClass('on');
		$('a.mp9on').removeClass('on');

		$('select#category1').val('0006').attr('selected', 'true');
		$('select#category2').val('').attr('selected', 'true');
		$('select#category1').change();
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
		$('div.mapBg9').addClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').addClass('on');
		$('a.mp9on').addClass('on');

		$('select#category1').val('0008').attr('selected', 'true');
		$('select#category2').val('').attr('selected', 'true');
		$('select#category1').change();
	});

	$('a.mp9on').on('click', function(e) {
		e.preventDefault();

		$('div.mapBg1').removeClass('on');
		$('div.mapBg2').removeClass('on');
		$('div.mapBg3').removeClass('on');
		$('div.mapBg4').removeClass('on');
		$('div.mapBg5').removeClass('on');
		$('div.mapBg6').removeClass('on');
		$('div.mapBg7').removeClass('on');
		$('div.mapBg8').addClass('on');
		$('div.mapBg9').addClass('on');

		$('a.mp1on').removeClass('on');
		$('a.mp2on').removeClass('on');
		$('a.mp3on').removeClass('on');
		$('a.mp4on').removeClass('on');
		$('a.mp5on').removeClass('on');
		$('a.mp6on').removeClass('on');
		$('a.mp7on').removeClass('on');
		$('a.mp8on').addClass('on');
		$('a.mp9on').addClass('on');

		$('select#category1').val('0008').attr('selected', 'true');
		$('select#category2').val('').attr('selected', 'true');
		$('select#category1').change();
	});
});