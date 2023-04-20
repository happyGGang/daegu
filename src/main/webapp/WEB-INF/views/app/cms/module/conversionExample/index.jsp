<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
  $(function() {

    $('button#search_btn').on('click', function(e) {
      $('#viewPage').val(1);
      $('#CommonBean').submit();
    });

    $('a.delete-btn').on('click', function(e) {
      if (confirm("해당 서평을 리스트 목록에서 삭제하시겠습니까?")) {
        $('form#bookReviewForm').attr('action', 'save.do');
        $('input#book_review_idx').val($(this).attr('keyValue'));
        $('input#editMode').val('DELETE');

        doAjaxPost($('#bookReviewForm'));
      }
    });

    $('select#homepage_id').on('change', function(e) {
      if($(this).val() != '') {
        $('#CommonBean').submit();
      }
      e.preventDefault();
    });
  });

</script>
<form:form id="CommonBean" modelAttribute="CommonBean" action="index.do" method="GET">
    <table class="type1 center">
        <colgroup>
            <col width="5%" />
            <col width="15%" />
            <col width="10%" />
        </colgroup>
        <thead>
        <tr>
            <th>번호</th>
            <th>작성자</th>
            <th>서평 점수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="i" varStatus="status" items="${boardList}">
            <tr>
                <td> ${i.CONVERSION_IDX}</td>
                <td> ${i.CONVERSION_NAME}</td>
                <td> ${i.CONVERSION_CONTENT}</td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(boardList) < 1}">
            <tr>
                <td colspan="7">조회된 자료가 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
        <jsp:param name="formId" value="#CommonBean"/>
    </jsp:include>

    <div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
        <fieldset>
            <form:select path="search_type" cssClass="selectmenu">
                <form:option value="CONVERSION_NAME">작성자</form:option>
                <form:option value="CONVERSION_CONTENT">서평내용</form:option>
            </form:select>
            <form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
            <button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
        </fieldset>
    </div>
</form:form>
