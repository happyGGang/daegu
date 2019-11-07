$(document).ready(function(){
	//퀵메뉴 드롭다운
	$('div.qmenu div.control a').on('click', function(e){
		e.preventDefault();
		$('div.qmenu .section').slideToggle(100);
		$('div.qmenu div.control a').toggleClass('active');
	});
	//관련사이트
	$('div.tnb a.fsite').on('click', function(e){
		e.preventDefault();
		$(this).toggleClass('active').next().slideToggle(100);
		return false;
	});
	$(document).click(function(){
		$('div.tnbl a.fsite').removeClass('active').next().hide();
	});
	
	$('div.main-img').on('focusin',function(){
		$('.qmenu li.bx-clone').html("(hide)");
		return false;
	});
	$('div.qmenu-img').on('focusout',function(){
		$('.qmenu li.bx-clone').html("(show)");
		return false;
	});
	
	var bannerWrap = $('div.banner-wrap');
	var autoType;
	
	if(bannerWrap.hasClass('noAuto')){
		autoType = false;
	}else{
		autoType = true;
	}
	
	var curationLength = $('div.curation-list-section ul.curationRolling').length;
	var curationSlider;
	var _width = $(window).width();

	var Curation = function(){
		if( curationSlider ) curationSlider.destroySlider();

		if( _width < 769 ){
			if (curationLength > 0) {
				curationSlider = $('div.curation-list-section ul.curationRolling').bxSlider({
					slideWidth:230,
					speed:500,
					moveSlides:1,
					maxSlides:2,
					slideMargin:20,
					auto:autoType,
					autoHover:true,
					pager:false,
					controls:true,
					autoReload:true
				});
			}
		}
		else if( _width < 1023 && _width > 769 ){
			if (curationLength > 0) {
				curationSlider = $('div.curation-list-section ul.curationRolling').bxSlider({
					slideWidth:230,
					speed:500,
					moveSlides:1,
					maxSlides:3,
					slideMargin:20,
					auto:autoType,
					autoHover:true,
					pager:false,
					controls:true,
					autoReload:true
				});
			}
		}
		else if( _width < 1281 && _width > 1023 ){
			if (curationLength > 0) {
				curationSlider = $('div.curation-list-section ul.curationRolling').bxSlider({
					slideWidth:230,
					speed:500,
					moveSlides:1,
					maxSlides:4,
					slideMargin:20,
					auto:autoType,
					autoHover:true,
					pager:false,
					controls:true,
					autoReload:true
				});
			}
		}
		else if( _width < 1441 && _width > 1281 ){
			if (curationLength > 0) {
				curationSlider = $('div.curation-list-section ul.curationRolling').bxSlider({
					slideWidth:230,
					speed:500,
					moveSlides:1,
					maxSlides:5,
					slideMargin:20,
					auto:autoType,
					autoHover:true,
					pager:false,
					controls:true,
					autoReload:true
				});
			}
		}
		else {
			if (curationLength > 0) {
				curationSlider = $('div.curation-list-section ul.curationRolling').bxSlider({
					slideWidth:230,
					speed:500,
					moveSlides:1,
					maxSlides:6,
					slideMargin:20,
					auto:autoType,
					autoHover:true,
					pager:false,
					controls:true,
					autoReload:true
				});
			}
		}
	};
	
	var apiData = 'pageIndex=1&recordCountPerPage=10&orderType=2&searchOrder=D&searchType=Tags&searchKeyword=%EA%B2%BD%EC%83%81%EB%B6%81%EB%8F%84%EA%B5%90%EC%9C%A1%EC%B2%AD%EC%A0%95%EB%B3%B4%EC%84%BC%ED%84%B0';
	$.ajax({
		url: '//q.gbelib.kr/curation/api/boardList.json',
		method: "POST",
		dataType: 'jsonp',
		jsonp: "callback",
		data: apiData,
		success: function(data) {
			if(data != null) {
				var html = '';
				for(var i=0; i<data.rows.length; i++) {
					var dataOne = data.rows[i];
					html += '<li>';
					html += '	<div class="curation_img_section">';
					html += '		<a href="' + dataOne.url + '" target="_blank"><img src="' + dataOne.thumbnail_path + '" alt="' + dataOne.title + '"></a>';
					html += '	</div>';
					html += '	<div class="curation_txt_section">';
					html += '		<h3 class="book-title">' + dataOne.title + '</h3>';
					html += '		<p class="book-desc">' + dataOne.cur_desc + '</p>';
					html += '		<span class="curated-info">' + dataOne.nickname + '</span>';
					html += '		<span class="date-info">' + dataOne.reg_dt.substring(0, 11) + '</span>';
					html += '	</div>';
					html += '</li>';
					$('ul.curationRolling').html(html);
				}
			}
			
			Curation();
		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.log('error: ', jqXHR);
		}
	});
	
	$(window).on('resize', function(){
		_width = $(window).width();
		Curation();
	});

	/* 신규 정보센터 추가 - 큐레이션*/
/*	
	if (curationLength > 0) {
		curationSlider = $('div.curation-list-section ul.curationRolling').bxSlider({
			slideWidth:230,
			speed:500,
			moveSlides:1,
			maxSlides:6,
			slideMargin:20,
			auto:autoType,
			autoHover:true,
			pager:false,
			controls:true,
			autoReload:true
		});
	}
*/

	/* 신규 정보센터 추가 - 메인 비쥬얼쪽 텍스트 스크롤*/
	if ($('ul.main_notice').length > 0) {
		$('ul.main_notice').bxSlider({
			mode:'fade',
			auto:true,
			slideWidth:480,
			pager:false,
			autoControls:false,
			pager:false,
			autoHover:true
		});
	}

	if ($('ul.gallery-list').length > 0) {
		$('ul.gallery-list').bxSlider({
			auto:true,
			pager:false,
			autoControls:false,
			pager:false,
			autoHover:true
		});
	}
});

$(window).scroll(
    function(){
        //스크롤의 위치가 상단에서 450보다 크면
        if($(window).scrollTop() > 150){
        /* if(window.pageYOffset >= $('원하는위치의엘리먼트').offset().top){ */
            $('div#wrap').addClass("menu-fixed");
            //위의 if문에 대한 조건 만족시 fixed라는 class를 부여함
        }else{
            $('div#wrap').removeClass("menu-fixed");
            //위의 if문에 대한 조건 아닌경우 fixed라는 class를 삭제함
        }
    }
);