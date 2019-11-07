$(function(){
	//테이블 공통 (tr,th,td 처음과 끝 요소 클래스명 부여)
	$('table tr:first-child').addClass('first');
	$('table tr').each(function(){
		$(this).children('th:first-child,td:first-child').addClass('first');
		$(this).children('th:last-child,td:last-child').addClass('last');
	});
	
	//셀렉트 메뉴
	/*$('.selectmenu-search').select2({
		//셀렉트 메뉴에 검색 기능 사용
	});
	$('.selectmenu').select2({
		//셀렉트 메뉴에 검색 기능 사용 안함
		minimumResultsForSearch: Infinity
	});*/
	
	//테이블에서 체크박스 체크 시 highlight
	$('table tbody tr').each(function(){
		$(this).on('click',function(){
			if($(this).find('input[type="checkbox"]').is(':checked')){
				$(this).addClass('highlight');
			}else{
				$(this).removeClass('highlight');
			}
		});
	});

	//댓글
	$('.bbs-comment-textarea').on('click',function(){
		$(this).children().focus();
	});
	$('.bbs-comment-textarea textarea').on('focus focusin',function(){
		$(this).parent().addClass('current');
		$(this).parent().parent().find('.checkbox').show();
	});
	$('.bbs-comment-textarea textarea').on('blur focusout',function(){
		$(this).parent().removeClass('current');
	});
});