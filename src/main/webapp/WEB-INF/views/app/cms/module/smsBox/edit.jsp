<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
var isMMS = true;
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {										
					if ( doAjaxPost($('#smsBoxForm')) ) {
						location.reload();	
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 450,
		height: 390
	});
	
	$('textarea#contents').on('keyup', function(e) {
		calculateBytes($(this).val());
	});
	
	var length = getLength($('#contents').val());
	$('strong#currBytes').text(length);
	
});

function calculateBytes(str) {
	var length = getLength(str);
	
	$('strong#currBytes').text(length);

	if (length < 81) {
		isMMS = false;
	} else {
		isMMS = true;
	}
	
	if (isMMS) {			
		if (length < 81) {
		} else if (length > 4000) {
			str = cutByte(str);
			alert('4000바이트를 초과할 수 없습니다.');
			$('strong#currBytes').text( getLength(str));
			$('textarea#send_msg').val(str);
			return false;
		} else {
			$('span#maxBytes').text('4000');
		}
	} else {
		if (length < 81) {
			isMMS = false;
			$('span#maxBytes').text('80');
		} else {
 			$('span#maxBytes').text('80');
 			str = cutByte80(str);
 			alert('80바이트를 초과할 수 없습니다.');
			$('strong#currBytes').text( getLength(str));
			$('textarea#send_msg').val(str);
		}
	}
}

var cutByte80 = function(str) {
	var l = 0;
	for (var i=0; i<str.length; i++) {
       l += (str.charCodeAt(i) > 128) ? 2 : 1;
       if (l > 80) {
    	   return str.substring(0,i);
       }
	}
	return str;
};

var cutByte = function(str) {
	var l = 0;
	for (var i=0; i<str.length; i++) {
       l += (str.charCodeAt(i) > 128) ? 2 : 1;
       if (l > 4000) {
    	   return str.substring(0,i);
       }
	}
	return str;
};

function getLength(s, b, i, c) {
	for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?2:c>>7?2:1);
	return b;
}

</script>
<form:form id="smsBoxForm" modelAttribute="smsBox" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="box_idx"/>			
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>제목</th>			
	         	<td><form:input path="title" class="text" /></td>
        	</tr>
        	<tr>
        		<th>내용</th>			
	         	<td><form:textarea path="contents" class="text" cssStyle="width:100%; height:150px;"/>
	         	<span class="info_byte"><strong id="currBytes">0</strong> / <span id="maxBytes">4000</span> byte</span></td>
        	</tr>
	        <tr> 
				<th>사용유무</th>
				<td>
					<form:radiobutton path="use_yn" class="Y" value="Y"/> <label for="use_yn1" style="cursor:pointer;">사용함</label>&nbsp;
					<form:radiobutton path="use_yn" class="N" value="N"/> <label for="use_yn2" style="cursor:pointer;">사용안함</label>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
