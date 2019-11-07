<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script>
$(function() {
// 	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
// 		autoOpen: false,
// 		resizable: true,
// 		modal: true, 
// 	    open: function(){
// 	        $('.ui-widget-overlay').addClass('custom-overlay');
// 	    },
// 	    close: function(){
// 	        $('.ui-widget-overlay').removeClass('custom-overlay');
// 	    }
// 	});
	
// 	$('div#ageLoanBest').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
// 		width: 1000,
// 		height: 800
// 	});
	$('a.loanBestSearch').on('click', function(e) {
		e.preventDefault();
		$('input#sub_search1').prop('checked', false);
		$('#librarySearch #allBookListStr').val('');
		$('#librarySearch #search_type').val('SEARCH');
		$('#librarySearch #search_text').val($(this).next('span').text().trim());
     	$('#librarySearch #do-search').click();
	});
	
	$('div#ageLoanBest').load('ageLoanBest.do');
});
</script>
<h3>3개월간 연령별 대출 순위</h3>
<div id="ageLoanBest">

	<div style="text-align: center; padding-top: 100px;">
	<img id="loading_img" alt="loading" src="/resources/common/img/viewLoading.gif" />
	<br/><br/>
	대출 순위 불러오는 중
	</div>

</div>
