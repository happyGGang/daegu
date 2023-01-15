<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="copyright">
		<div class="pull-left">
<!-- 			&copy; 2016 <strong>WBuilder</strong>. All rights reserved. -->
		</div>
		<div class="pull-right">
			<a href="/dgportal/index.do" target="_blank">대구광역시 통합도서관 바로가기</a>
		</div>
	</div>

</div>

<script type="text/javascript">
$(document).ready(function(){
	//테이블 공통 (tr,th,td 처음과 끝 요소 클래스명 부여)
	$('table tr:first-child').addClass('first');
	$('table tr').each(function(){
		$(this).children('th:first-child,td:first-child').addClass('first');
		$(this).children('th:last-child,td:last-child').addClass('last');
	});

	//달력

	//셀렉트 메뉴
	$('.selectmenu-search').select2({
		//셀렉트 메뉴에 검색 기능 사용
	});
	$('.selectmenu').select2({
		//셀렉트 메뉴에 검색 기능 사용 안함
		minimumResultsForSearch: Infinity
	});

	//type1 테이블에서 체크박스 체크 시 highlight
	$('table.type1 tbody tr').each(function(){
		$(this).on('click',function(){
			if($(this).find('input[type="checkbox"]').is(':checked')){
				$(this).addClass('highlight');
			}else{
				$(this).removeClass('highlight');
			}
		});
	});

	//메뉴 유형 선택 시 추가 옵션 (cont2.jsp)
	$('.menuType').each(function(i){
		var i = i+1;
		$(this).attr('id','menuType'+i);
	});
	$('.menuTypeBox .radio input').each(function(i){
		var i = i+1;
		$(this).on('click',function(){
			$('.menuType').hide();
			$('#menuType'+i).show();
		});
		if($(this).prop('checked')){
			$('.menuType').hide();
			$('#menuType'+i).show();
		}
	});
});
</script>

</body>
</html>