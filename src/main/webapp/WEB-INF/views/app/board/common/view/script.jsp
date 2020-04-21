<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<script src="${getContexPath}/resources/board/js/jquery.watermark.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    <%-- 수정하기 --%>
    $('a#board_edit_btn').on('click', function(e) {
//     	if ( '${boardManage.board_type}' == 'QNA' ) {
//     		if ( '${board.password_yn}' == 'Y') {
//     			var password = prompt('비밀번호를 입력하세요.');
//         		var beforeAction = $('#board').attr('action');
//         		$('#board #user_password').val(password);
//         		if ( password == null || password == '' ) {
//         			return false;
//         		}
//     		}
//     	}
    	$('#editMode').val('MODIFY');
		var url = 'edit.do';
		var formData = serializeCustom($('#board'));
		doGetLoad(url, formData);

		e.preventDefault();
	});
    <%-- 수정하기 --%>
    $('a#anonymous_edit_btn').on('click', function(e) {
//     	if ( '${boardManage.board_type}' == 'QNA' ) {
//     		if ( '${board.password_yn}' == 'Y' ) {
//     			var password = prompt('비밀번호를 입력하세요.');
//         		var beforeAction = $('#board').attr('action');
//         		$('#board #user_password').val(password);
//         		if ( password == null || password == '' ) {
//         			return false;
//         		}
//     		}
//     	}
    	$('#editMode').val('MODIFY');
		var url = 'edit.do';
		var formData = serializeCustom($('#board'));
		doGetLoad(url, formData);

		e.preventDefault();
	});

    <%-- 삭제하기 --%>
    $('a#board_delete_btn').on('click', function(e) {
    	e.preventDefault();
    	if(confirm('삭제 하시겠습니까?')) {
    		$('#board').attr('action', 'delete.do');
    		doAjaxPost($('#board'));
    	}
	});

    <%-- 삭제하기 --%>
    $('a#anonymous_delete_btn').on('click', function(e) {
    	e.preventDefault();
		if ('${!authMBA and sessionScope.member.member_id ne board.add_id and board.add_id ne "ANONYMOUS"}' == 'true') {
			alert('권한이 없습니다.');
			return false;
		}
    	if(confirm('삭제 하시겠습니까?')) {
    		$('div#dialog-1').dialog({
    		    modal : true,
    		    buttons : [
    		    	{
    					text: "확인",
    					"class": 'btn btn1',
    					click: function() {
    						var p = $('input#tmpPass').val();
    						if (p == null || p == '') {
    							alert('비밀번호를 입력하세요.');
    							$('input#tmpPass').focus();
    							return alse;
    						}

    						if ($('input#up').length > 0) {
    							$('input#up').val(p);
    						} else {
		   						var up = $('<input type="hidden" id="up" name="user_password">');
		   						up.val(p);
		   						$('#board').append(up);
    						}
    						$('#board').attr('action', 'delete.do');
    						doAjaxPost($('#board'));
    					}
    				},{
    					text: "취소",
    					"class": 'btn',
    					click: function() {
    						$('input#tmpPass').val('');
    						$('#dialog-1').dialog('destroy');
    					}
    				}
    		    ],
    		    close : function() {
    		    	$('input#tmpPass').val('');
    		    }
    		});
    	}
	});


    <%-- 목록가기 --%>
	$('a#board_index_btn').on('click', function(e) {
		e.preventDefault();
		<c:choose>
		<c:when test="${boardManage.manage_idx == 282 or boardManage.manage_idx == 195}">
		var url = 'index.do';
		$('input#manage_idx').val('282');
		var formData = serializeParameter(['manage_idx', 'menu_idx', 'category1', 'rowCount', 'viewPage', 'search_type', 'search_text']);
		doGetLoad(url, formData);
		</c:when>
		<c:otherwise>
		var url = 'index.do';
		var formData = serializeParameter(['manage_idx', 'menu_idx', 'category1', 'rowCount', 'viewPage', 'search_type', 'search_text', 'imsi_v_1', 'imsi_v_2']);
		doGetLoad(url, formData);
		</c:otherwise>
		</c:choose>

	});

	<%-- 답변하기 --%>
	$('a#board_reply_btn').on('click', function(e) {
		e.preventDefault();
		var url = 'reply.do';
		var formData = serializeCustom($('#board'));
		doGetLoad(url, formData);
	});

	<c:if test="${board.delete_yn eq 'Y'}">
	<%-- 게시물 복구 --%>
	$('a#board_recovery_btn').on('click', function(e) {
		e.preventDefault();
		if(confirm('게시물을 복구 하시겠습니까?')) {
			$('input#boardIdxArray').val($('input#board_idx').val());
    		$('#board').attr('action', 'recovery.do');
    		doAjaxPost($('#board'));
    	}
	});
	</c:if>

	$('a#board_move_btn').on('click', function(e) {
		e.preventDefault();
		if(confirm('해당 게시판으로 게시물을 이동 하시겠습니까?')) {
			if($('select#moveTarget_manage_idx').val()!='') {
				$('input#target_manage_idx').val($('select#moveTarget_manage_idx').val());
	    		$('#board').attr('action', 'moveBoard.do');
	    		doAjaxPost($('#board'));
			} else {
				alert('이동할 게시판을 선택하세요.');
			}
    	}
	});

	$('a#board_move_btn_category').on('click', function(e) {
		e.preventDefault();
		if(confirm('해당 카테고리로 게시물을 이동 하시겠습니까?')) {
			if($('select#moveTarget_category_id').val()!='') {
				$('input#target_category').val($('select#moveTarget_category_id').val());
	    		$('#board').attr('action', 'moveBoardCategory.do');
	    		doAjaxPost($('#board'));
			} else {
				alert('이동할 카테고리를 선택하세요.');
			}
    	}
	});

	$('a.twitter').on('click', function(e) {
		e.preventDefault();
		var title = $('div.bbs-view-header:eq(0) > dl > dt').text();
		var txtVal = HTMLDecode(title);
		var url = '${conPath}/board/view.do?manage_idx=${board.manage_idx}&menu_idx=${menuOne.menu_idx}&board_idx=${board.board_idx}';
		window.open('http://twitter.com/share?text='+encodeURIComponent(txtVal)+'&url='+encodeURIComponent(url),'ttsharer','width=500,height=300');
	});

	$('a.facebook').on('click', function(e) {
		e.preventDefault();
		var title = $('div.bbs-view-header:eq(0) > dl > dt').text();
		var txtVal = HTMLDecode(title);
		var url = '${conPath}/board/view.do?manage_idx=${board.manage_idx}&menu_idx=${menuOne.menu_idx}&board_idx=${board.board_idx}';
		window.open('http://www.facebook.com/sharer.php?u='+encodeURIComponent(url)+'&t='+encodeURIComponent(txtVal),'fbsharer','width=500,height=300');

	});

	$('a#board_print_btn').on('click', function(e) {
		e.preventDefault();

		if( navigator.appName.indexOf("Microsoft") > -1 ){
		    if( navigator.appVersion.indexOf("MSIE 6")!=-1)    {
		        alert('익스플로어6 버전 에서는 지원하지 않는 기능입니다.');
		        return;
		    }
		}
		window.print();
	});

	$('a#ebook_btn').on('click', function(e) {
		e.preventDefault();
		var code = $(this).attr('keyValue');

		if(code.substring(0,20) == 'http://www.dge.go.kr') {
			window.open(code);
		} else {
			code = code.substring(code.indexOf('=')+1,100);
			var iacts_ebook = window.open('http://ebook.dge.go.kr/html/main.jsp?code=' + code+'&', 'iacts_ebook', 'top=0,left=0,toolbar=0,menubar=0,scrollbars=0,resizable=0,status=0,location=0,directories=0,height=740,width=1024');
			iacts_ebook.focus();
		}
	});

	$('a#board_approval_btn').on('click', function(e) {
		e.preventDefault();
		$.ajax({
			url : 'addApproval.do?board_idx=${board.board_idx}',
			async : true ,
			method : 'post',
			dataType : 'json',
			success : function(data) {
				data = eval(data);
				alert(data.message);
				location.reload();
			}
		});
	});

	$('a#board_contrary_btn').on('click', function(e) {
		e.preventDefault();
		$.ajax({
			url : 'addContrary.do?board_idx=${board.board_idx}',
			async : true ,
			method : 'post',
			dataType : 'json',
			success : function(data) {
				data = eval(data);
				alert(data.message);
				location.reload();
			}
		});
	});

	if('${boardManage.comment_use_yn}' == 'Y') {
		var url = '/board/boardComment/index.do';
		var formData = 'board_idx=${board.board_idx}&manage_idx=${board.manage_idx}';
		doAjaxLoad('div#bbs-comment', url, formData);
	} else {
		$('a[href="#bbs-comment"]').hide();
	}

	$('a#board_scrab_btn').on('click', function(e) {
		e.preventDefault();
		/* if ( doAjaxPost($('storageReqForm')) ) {

		} */
		$('form#storageReqForm input#img_url').val(location.href);

		window.open("/${homepage.context_path}/module/myStorage/viewStorage.do?"+serializeCustom($('#storageReqForm')), "", "width=350, height=350");
	});

// 	$('div.bbs-view-body img').watermark({
// 		text: '${homepage.homepage_name}',
// 		textWidth : 180,
// 		textSize : 15,
// 		gravity: 'sw',
// 	    opacity: 0.7,
// 	    margin: 15,
// 	    textColor : 'black',
// 	    textBg : 'rgba(255, 255, 255, 0.2)',
// 	    outputType : 'png'
// 	});
});

function HTMLDecode(str) {
	str = str.replace(/&lt;/gi,"<");
   	str = str.replace(/&amp;/gi,"&");
   	return str;
}
</script>