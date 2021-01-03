$(document).ready(function(){
	pageMain.init();
});


var pageMain = (function(){
	var init, bindEvent;

	init = function() {
		bindEvent();
		movieSlider();
	};

	bindEvent = function(){

		// TAB
		$(document).on('click', '.tabMenuS a.t-tabs', function(){
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tabS');
			var moreUrl = $(this).data('link');

			$(this).closest('.tabMenuS').find('li').removeClass('on');
			$(this).parent('li').addClass('on');

			$box.find('.con').hide();
			$box.find('[data-tab="'+target+'"]').show();
			$box.find('.more-more').attr('href', moreUrl);
		});

		$(document).on('click', '.tabMenuSS a.t-tabs', function(){
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tabSS');
			var moreUrl = $(this).data('link');

			$(this).closest('.tabMenuSS').find('li').removeClass('on');
			$(this).parent('li').addClass('on');

			$box.find('.cont').hide();
			$box.find('[data-tab="'+target+'"]').show();
			$box.find('.more-more').attr('href', moreUrl);
		});
	};

	movieSlider = function(){
		if($('.movieContent ul li').length >0) {
			$('.movieContent ul').bxSlider({
				auto: true,
				pager:false,
				autoControls:true,
				autoControlsCombine:true
			});
		}
	};

	return {
		init: init
	}
})();

$(function(){

	// 팝업존
	if ($('.popZone ul').length > 0) {
		$('.popZone ul').bxSlider({
			mode:'fade',
			pager: true,
			pagerType: 'short',
			auto: true,
			autoControls: true,
			autoControlsCombine: true
		});
	}


	// 상단팝업존
	if ($('.topPopZone ul').length > 0) {
		$('.topPopZone ul').bxSlider({
			mode:'fade',
			pause: 7000,
			speed: 1000,
			pager: true,
			auto: true,
			autoHover : true,
			autoControls: true,
			autoControlsCombine: true
		});
	}
});
