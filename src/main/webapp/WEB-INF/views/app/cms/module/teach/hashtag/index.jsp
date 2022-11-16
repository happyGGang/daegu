<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
  $(function() {

    $('a.dialog-add').on('click', function(e) {

      if($('#homepage_id').val() == "") {
        alert('홈페이지를 선택해주세요.');
        return false;
      }

      $('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function( response, status, xhr ) {
        $('#dialog-1').dialog('open');
      });

      e.preventDefault();
    });

    $('a.dialog-modify').on('click', function(e) {
      $('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&hashtag_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
        $('#dialog-1').dialog('open');
      });

      e.preventDefault();
    });


  });
</script>
<form:form id="hashtag"  modelAttribute="hashtag" action="index.do" >
    <div class="infodesk">
        검색 결과 : 총 ${fn:length(hashtagList)}건
        <div class="button">
            <c:if test="${authC}">
                <a href="" class="btn btn5 dialog-add" ><i class="fa fa-plus"></i><span>등록</span></a>
            </c:if>
        </div>
    </div>
    <table class="type1 center">
        <colgroup>
            <col width="50" />
            <col width="" />
            <col width="">
            <col width="120" />
            <col width="120" />
            <col width="120" />
            <col width="120" />
            <col width="120" />
            <col width="150" />
        </colgroup>
        <thead>
        <tr>
            <th>번호</th>
            <th>해시태그코드</th>
            <th>해시태그명</th>
            <th>사용유무</th>
            <th>등록일</th>
            <th>등록자</th>
            <th>수정일</th>
            <th>수정자</th>
            <th>기능</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="i" varStatus="status" items="${hashtagList}">
            <tr>
                <td>${status.count}</td>
                <td>${i.hashtag_code}</td>
                <td>${i.hashtag_name}</td>
                <td>${i.use_yn eq 'Y' ? '사용' : '미사용'}</td>
                <td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
                <td>${i.add_id}</td>
                <td><fmt:formatDate value="${i.modify_date}" pattern="yyyy.MM.dd"/></td>
                <td>${i.modify_id}</td>
                <td>
                    <c:if test="${authU}">
                        <a href="" class="btn dialog-modify" keyValue="${i.hashtag_idx}">수정</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(hashtagList) < 1}">
            <tr>
                <td colspan="9">조회된 자료가 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</form:form>

<div id="dialog-1" class="dialog-common" title="문화강좌_해시태그 정보"></div>