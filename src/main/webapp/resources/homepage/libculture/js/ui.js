$(function(){
	let isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);

	$(window).resize(function(){
		isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
	})

	/* ==============================
	 * common
	 * ============================== */


	clickMotion();
	layerpopup();
	header(isMobile);
	footer();
	quick();
	ieScroll();
	
	/* ==============================
	 * main
	 * ============================== */
	if($('#headerWrap.main').length){
		main();
	}
	
	/* ==============================
	* content
	* ============================== */
	imgChange();
	form();
	if($('.qprogramWrap .galleryBox').length){
		qprogram();
	}
});

function qprogram(){
	$('.galleryBox .slickWrap').slick({
		dots: false,
		arrows:true,
		infinite: false,
		slidesToShow: 4,
		slidesToScroll: 4,
		responsive: [
			{
			  breakpoint: 1000,
			  settings: {
				slidesToShow: 3,
				slidesToScroll: 3
			  }
			},
			{
			  breakpoint: 767,
			  settings: {
				slidesToShow: 2,
				slidesToScroll: 2
			  }
			},
			{
			breakpoint: 450,
			settings: {
				slidesToShow: 1,
				slidesToScroll: 1
			  }
			},
		  ]
	  })
}

function form(){
	$('.inputFile :file').change(function(){
		$(this).next().find('p').text($(this).val());
	})
}

function main(){
	// nav();
	main1();
	main3();

	function nav(){
		let idx = 0;
		const length = $('#container.main > section').length -1;

		$('#container.main > section').each(function(){
			$('.mainSecNav .nav').append('<span></span>');
		});
		$('.mainSecNav .nav span').eq(idx).addClass('on')
		
	}

	function main1(){
		let idx = 0;
		const length = $('.mainSec01 .visualBg > div').length -1;
		const delay = 5000;
		let time = setInterval(timer, delay);

		$('.mainSec01 .arrow').mouseenter(function(){
			clearInterval(time);
		}).mouseleave(function(){
			time = setInterval(timer, delay);
		})

		$('.mainSec01 .arrow > a').click(function(){
			clearInterval(time);
			let btnIdx = $(this).index();
			if(btnIdx == 0){ 
				idx == 0 ? idx = length : idx--;
			} else {
				idx == length ? idx = 0 : idx++;
			}
			$('.mainSec01 .visualBg > div').eq(idx).addClass('on').siblings().removeClass('on');
			$('.mainSec01 .textBox').eq(idx).addClass('on').siblings().removeClass('on');
			return false;
		})

		function timer(){
			idx == length ? idx = 0 : idx++;
			$('.mainSec01 .visualBg > div').eq(idx).addClass('on').siblings().removeClass('on');
			$('.mainSec01 .textBox').eq(idx).addClass('on').siblings().removeClass('on');
		}
	}

	function main3(){
		const length = $('.mainSec03 .slickWrap > div').length
		$('.mainSec03 .slickWrap').slick({
			dots: false,
			arrows:false,
			infinite: true,
			speed: 300,
			slidesToShow: 3,
			variableWidth: true,
			autoplay: true,
			autoplaySpeed: 5000,
			responsive: [
				{
				  breakpoint: 1000,
				  settings: {
					slidesToShow: 2
				  }
				},
				{
				  breakpoint: 450,
				  settings: {
					slidesToShow: 1,
					variableWidth: false
				  }
				},
			  ]
		  }).on('beforeChange',function(event, slick, currentSlide, nextSlide){
			$('.mainSec03 .slickPlay .status').html('<span>0' + (nextSlide + 1) + '</span> / 0' + length)
		  });

		$('.mainSec03 .arrowBtn a').click(function(){
			if($(this).index() == 0){
				$('.mainSec03 .slickWrap').slick('slickPrev')
			}else{
				$('.mainSec03 .slickWrap').slick('slickNext')
			}
			return false;
		});

		$('.mainSec03 .slickPlay a').click(function(){
			if($(this).hasClass('play')){
				$('.mainSec03 .slickWrap').slick('slickPlay');
			}else {
				$('.mainSec03 .slickWrap').slick('slickPause');
			}
			$(this).hide().siblings('a').show();
			return false;
		})
	}
}

function imgChange(){
	if($('*[data-mo-image]').length){
		resizeImg();
		$(window).resize(function(){
			resizeImg();
		});
		
		function resizeImg(){
			const width = $(window).outerWidth();
			$('*[data-mo-image]').each(function(){
				const name = $(this).prop('tagName');
				if(name === 'IMG'){
					if( width < 768){
						$(this).attr('src',$(this).data('mo-image'));
					} else {
						$(this).attr('src',$(this).data('pc-image'));
					}
				}else{
					if( width < 768){
						$(this).css('background-image','url(' + $(this).data('mo-image') + ')');
					} else {
						$(this).css('background-image','url(' + $(this).data('pc-image') + ')');
					}
				}
			});
		};
	}
};

function header(mobileCheck){
	$(document).on('click','.asideGnb > a',function(){
		if(!$(this).hasClass('menuOpenClose')){
			$('.asideGnb').addClass('on');
			$('.gnbViewBox > div').eq($(this).index()-1).addClass('on').siblings().removeClass('on')
		}else {
			$('.asideGnb').toggleClass('on')
		}
		return false;
	});

	$(document).on('click','.asideGnb .menuView h3 a',function(){
		$(this).parent().toggleClass('on').next('ul').slideToggle();
		return false;
	});

	if(!mobileCheck){
		$(document).on('mouseenter','#header .gnbWrap .gnb > div', function(){
			$('#headerWrap').addClass('hover');
			$('#header .gnbWrap .gnb ul, .headerBg').slideDown();
		});
		$(document).on('mouseleave','#headerWrap', function(){
			$('#headerWrap').removeClass('hover');
			$('#header .gnbWrap .gnb ul, .headerBg').slideUp();
		});
	}

	scrollJS();
	$(window).scroll(function(){
		scrollJS();
	});

	function scrollJS(){
		const scrollTop = $(window).scrollTop();
		if(scrollTop > 100){
			$('#headerWrap.main').addClass('scrollBg')
		}else{
			$('#headerWrap.main').removeClass('scrollBg')
		}
	}
}

function footer(){
	$(document).on('click','#footer .btnTop',function(){
		$('html, body').animate({'scrollTop':0},1000,'easeInOutQuint')
		return false;
	});
}

function clickMotion(){
	$(document).on('click','.clickMotion',function(e){
		const width =  $(window).outerWidth();
		const $this = $(this),
			$delay = 650;
		
		if(!$this.find('.click-in').length) $this.prepend('<i class="click-in"></i>')
		
		let btnIn = $this.find('.click-in'),
			btnMax = Math.max($this.outerWidth(),$this.outerHeight()),
			btnX = e.pageX - $this.offset().left - btnMax/2,
			btnY = e.pageY - $this.offset().top - btnMax/2;

		btnIn.css({'left':btnX,'top':btnY,'width':btnMax,'height':btnMax})
			.addClass('animate').delay($delay).queue(function(next){
				btnIn.remove();
			});
	});
}

function quick(){
	const target = $('.quickWrap');
	let height = 0;
	let index = 0;
	reset();

	$(window).scroll(function(e){
		scrollCheck();
	});

	$(document).on('click','.quickViewCont .quickTab a',function(e){
		index = $(this).index();
		
		$(this).addClass('on').siblings().removeClass('on')
		target.find('.quickCont').find('> div').eq(index).addClass('on').siblings().removeClass('on').addClass('off');
		reset();
		setTimeout(function(){
			target.find('.quickCont').find('> div').removeClass('off');
		}, 300)
		return false;
	});

	$(document).on('click','.quickMenu .quick1',function(){
		target.find('.quickViewWrap').addClass('on');
		$('body').addClass('scrollLock');
		return false;
	});
	
	$(document).on('click','.quickViewWrap .bg,.quickViewCont .quickClose',function(){
		target.find('.quickViewWrap').removeClass('on');
		$('body').removeClass('scrollLock');
		return false;
	});

	$(document).on('click','.quickMenu .btnTop',function(){
		$('html, body').animate({'scrollTop':0},1000,'easeInOutQuint')
		return false;
	});

	function reset(){
		height = target.find('.quickCont').find('> div.on').outerHeight();
		target.find('.quickCont').css('height',height)
	}

	function scrollCheck(){
		const scrollTop = $(window).scrollTop();
		if (scrollTop > 200) {
			target.addClass('show')
		} else {
			target.removeClass('show')
		}
	}
}

function include(){
	$(window).load(function(){
		const $include = $('[data-include]');
		$include.each(function(i,el){
			const $this = $(this)
			const src = $this.data('include');
			const active = $('body').data('menuactive');
			$this.load(src,function(){
				$this.removeAttr('data-include');

				if(active){
					$('#header .gnbWrap .gnb > div').eq(active[0] - 1).children('a').addClass('on').next('ul').find('li').eq(active[1] - 1).find('a').addClass('on');
					$('#header .asideGnb .gnbViewBox .menuView h3').eq(active[0] - 1).addClass('on').next('ul').slideDown()
						.find('li').eq(active[1] - 1).addClass('on');
				}
			});
		});
	});
}

/* 레이어 팝업 */
function layerpopup(){
	$(document).on('click','.layerPopOpen',function(){
		let href = $(this).attr('href');
		if(!href){
			href = $(this).data('href');
		}
		layerPopOpen(href,$(this));
		return false;
	});
}

function layerPopOpen(target,change){
	let cont = $(target).find('.layerPopCont');
	$(target).addClass('on');
	setTimeout(function(){
		cont.focus();
	},30)
	$('body').addClass('scrollLock');
	
	cont.find('.btnPopClose').last().on('keydown',function(e){
		let code = e.which;
		if(code == 9){
			$(this).closest('.layerPopCont').focus();
		};
	});

	if(change.find('img').length){
		const imgSrc = change.find('img').attr('src');
		$(target).find('.imgPopCont img').attr('src',imgSrc)
	}
	
	layerPopClose(change);
}

function layerPopClose(target){
	$(document).on('click','.btnPopClose',function(){
		$(this).closest('.layerPopWrap').removeClass('on');
		$('body').removeClass('scrollLock');
		target.focus();
		
		return false;
	});
	$(document).on('click','.layerPopWrap .bg',function(){
		$(this).closest('.layerPopWrap').removeClass('on');
		$('body').removeClass('scrollLock');
		target.focus();
		return false;
	});

	$(document).on('click','.layerPopWrap',function(e){
		if($(e.originalEvent.target).hasClass('layerPopWrap')){
			$('.layerPopWrap').removeClass('on');
			$('body').removeClass('scrollLock');
			target.focus();
		}
	});
}

function ieScroll(){
	if(navigator.userAgent.match(/Trident\/7\./)){
		$('html,body').on('mousewheel',function(e){
			e.preventDefault();

			var wheelDelta = event.wheelDelta;
			var currentScrollPosition = window.pageYOffset;
			window.scrollTo(0,currentScrollPosition - wheelDelta);
		});
	};
}