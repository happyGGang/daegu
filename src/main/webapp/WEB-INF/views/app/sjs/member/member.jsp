<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	
	
	//모달창 링크 버튼
	
	
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&member_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	

	
	var isPassChangeEvent = parent.aside.document.getElementById('passChangeEvent').value;
// 	console.log(isPassChangeEvent);
	if ( isPassChangeEvent == 'true' ) {
		var member_id = parent.aside.document.getElementById('passChangeEventValue').value;
		parent.aside.document.getElementById('passChangeEvent').value = false;
		$('a#dialog-modify-' + member_id).click();
	}
	
});	
</script>


