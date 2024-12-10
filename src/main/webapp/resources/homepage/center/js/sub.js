$(document).ready(function () {
	$('.share').click(function () {
		const $sns = $('.sns');
		const $shareBtn = $(this);

		if ($sns.is(':visible')) {
			$sns.animate(
				{
					opacity: 0,
					marginTop: '-100px',
				},
				300,
				function () {
					$sns.css('display', 'none');
					$sns.css({ opacity: '', marginTop: '' });
				}
			);
			$shareBtn.attr('src', '/resources/homepage/center/img/share.svg');
		} else {
			$sns.css({ opacity: 0, display: 'block', marginTop: '-100px' });
			$sns.animate(
				{
					opacity: 1,
					marginTop: '0',
				},
				300
			);
			$shareBtn.attr('src', '/resources/homepage/center/img/close.svg');
		}
	});
});
