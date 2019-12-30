$(document).ready(function(){
	pageMain.init();
});


var pageMain = (function(){
	var init, bindEvent, movieSlider;

	init = function() {
		bindEvent();
		movieSlider();
	};

	bindEvent = function(){

		// TAB
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

	$('.slider-box ul').bxSlider({
		mode:'vertical',
		pager:false
	});

	$('.slider-box2 ul').bxSlider({
		mode:'vertical',
		pager:false
	});
});
