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
/*
		$(document).on('click', '.tabMenuV a.tab-link', function(){
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tabV');
			$(this).closest('.tabMenuV').find('li').removeClass('on');
			$(this).parent('li').addClass('on');

			$box.find('.con').hide();
			$box.find('[data-tab="'+target+'"]').show();
		});

		$(document).on('click', '.tabMenu a', function(){
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tab');
			$(this).closest('.tabMenu').find('li').removeClass('on');
			$(this).parent('li').addClass('on');

			$box.find('.con').hide();
			$box.find('[data-tab="'+target+'"]').show();
		});
*/
	};

	return {
		init: init
	}
})();

$(function(){
	
	$(document).on('click', '.tab .tabMenuS a', function(){
		if (!$(this).hasClass('more-more')) {
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tabS');
			var moreUrl = $(this).data('url');
			
			$box.find('.active').removeClass('active');
			$(this).parent().addClass('active');
			
			$box.find('.cont').hide();
			$box.find('[data-tab="'+target+'"]').show();
			$box.find('.more-more').attr('href', moreUrl);
		}
	});

	$(document).on('click', '.tabV .tabMenuV a', function(){
		if (!$(this).hasClass('more')) {
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tabV');
			var moreUrl = $(this).data('link');
			
			$box.find('.active').removeClass('active');
			$(this).parent().addClass('active');
			
			$box.find('.cont').hide();
			$box.find('[data-tab="'+target+'"]').show();
			$box.find('.more').attr('href', moreUrl);
		}
	});

});

