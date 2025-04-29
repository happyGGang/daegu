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
		moveSlides: 1,
		autoControls:true,
		autoControlsCombine:true
	});

	$('.movieContent2 ul').bxSlider({
		auto: true,
		pager:false,
		moveSlides: 1,
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

	$('div.lnb li').on('mouseenter', function() {
		$(this).find('ul').show(300);
	});
	$('div.lnb li').on('mouseleave', function() {
		$(this).find('ul').hide(300);
	});

});

function uiTabsMenu () {
	var $menu = $('.tabMenuS'),
		$contWrap = $('.bx-wrapper'),
		_content ='.bx-viewport',
		curr = 'current';

	if(!$menu.length ) { return }
	$(_content).css('display', 'none');
	$contWrap.each(function(){
		$(this).find('div' + _content +':first').css('display', 'block');
	});
	$menu.on('click','a', function(){
		if(!$(this).hasClass(curr)){
			$(this).addClass(curr).closest('li').siblings('li').find('.' + curr).removeClass(curr);
			$($(this).attr('href')).css('display', 'block').siblings('div'+_content).css('display', 'none');
		}
		this.blur();
		return false;
	});
};

function tabMenuSlider() {
	var $tabmenu = $('.tabMenuS'),
	$contWrap = $('.bx-wrapper'),
	$sliderClass = '.book_photo',
	config = {
		maxSlides:3,
		slideWidth:251,
		slideMargin: 30,
		infiniteLoop:false,
		hideControlOnEnd:false,
		pager:false,
		nextText: '다음 페이지',
		prevText: '이전 페이지'
	};

	var sliders = new Array();
	$($sliderClass).each(function(i, slider) {
		var len = $(slider).find('> li').length;
		if(len < 3) {
			sliders[i] = $(slider).addClass('nonslider');
		} else {
			sliders[i] = $(slider).bxSlider(config);
		}
	});

	if(!$tabmenu.length ) { return }
		$contWrap.each(function(){
			if($(this).find('div.bx-viewport').is(':first')) {
				slider.reloadSlider(config);
			}
		});
	$tabmenu.on('click', ' a', function(e){
		var _target = $(this).attr('href');

		if($(_target).css('display') === 'block') {
			$.each(sliders, function(i, slider){
				if(!slider.hasClass('nonslider')) {
					slider.reloadSlider(config);
				}
			});
		}
		e.preventDefault();
	});
}