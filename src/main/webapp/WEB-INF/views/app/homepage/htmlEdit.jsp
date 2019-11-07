<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
<c:when test="${menuHtml ne null}">
<script type="text/javascript" src="/resources/common/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script>
var oEditors = [];
$(document).ready(function() {
	wrap_and_insert($('textarea#html').val());
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "html",
		sSkinURI: "/cms/menu/${contextPath}/se2skin.do",
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function() {
			
		},
		fCreator: "createSEditor2"
	});
	
	$('a#_save_html').on('click', function(e) {
		e.preventDefault();
		oEditors.getById["html"].exec("UPDATE_CONTENTS_FIELD", []);
		
		var html = $('textarea#html').val();
		var html_without_doc_body = $('<div/>').append($(html)).find('div.doc-body > div.body');
		if(html_without_doc_body.length > 0) {
			$('textarea#html').val(html_without_doc_body[0].innerHTML);
		}
		
		if(doAjaxPost($('#menuHtml'))) {
			location.href = '/${homepage.context_path}/html.do?menu_idx=${menuHtml.menu_idx}';
		};
	})
});

function wrap_and_insert(html) {
	if($('<div/>').append($(html)).find('div.doc-body > div.body').length == 0) {
		$('textarea#html').val('<div class="doc-body"><div class="body">' + html + '</div></div>');
	}
}
</script>
<form:form modelAttribute="menuHtml" action="/cms/menu/save_html.do" method="POST" onsubmit="return false;">
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<div class="textareaBox">
<c:set var="html" value="${menuHtml.html}"/>
<%-- <c:set var="html" value="<div class=\"doc-body con30\"><div class=\"body\">${menuHtml.html}</div></div>"/> --%>
	<textarea id="html" name="html" style="width:100%;height:625px;">${fn:escapeXml(html)}</textarea>
</div>
</form:form>
<br/>
<br/>
<div class="button center">
	<a id="_save_html" class="btn">저장</a>
</div>
</c:when>
<c:otherwise>
<div class="comming-soon">
	<p class="t1">이용에 불편을 드려 죄송합니다.</p>
	<strong>페이지 <em>준비중</em>입니다.</strong>
	<p class="t2">COMMING SOON</p>
</div>
</c:otherwise>
</c:choose>
