$(document).ready(function(){
	pageMain.init();
});


var pageMain = (function(){
	var init, bindEvent;

	init = function() {
		bindEvent();
	};

	bindEvent = function(){

		// TAB
		/*
		$(document).on('click', '.tabMenuS a', function(){
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tabS');
			var moreUrl = $(this).data('link');

			$(this).closest('.tabMenuS').find('li').removeClass('on');
			$(this).parent('li').addClass('on');

			$box.find('.con').hide();
			$box.find('[data-tab="'+target+'"]').show();
			$box.find('.more-more').attr('href', moreUrl);

		});
		*/

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

	};

	return {
		init: init
	}
})();

$(function(){
	
	// 팝업존(중앙도서관)
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

	$('.movieContent ul').bxSlider({
		auto: true,
		pager:false,
		autoControls:true,
		autoControlsCombine:true
	});

	$('.event-box > ul').bxSlider({
		mode:'vertical',
		pager:false
	});

	$('.holiday-box > ul').bxSlider({
		mode:'vertical',
		pager:false
	});
});
