<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
  $(function(){
    //모달창 링크 버튼
    $('a#dialog-add').on('click', function(e) {
      $('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
        $('#dialog-1').dialog('open');
      });

      e.preventDefault();
    });

    $('a#dialog-modify').on('click', function(e) {
      $('#dialog-1').load('edit.do?editMode=MODIFY&specialized_services_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
        $('#dialog-1').dialog('open');
      });

      e.preventDefault();
    });

    $('a#delete').on('click', function(e) {
      if(confirm('선택된 팝업을 삭제 하시겠습니까?')) {
        $('input#specialized_services_idx').val($(this).attr('keyValue'));

        $.ajax({
          url : 'delete.do',
          async : false,
          data : serializeObject($('#specializedServices')),
          method : 'POST',
          success : function(data) {
            if(data.valid) {
              alert(data.message);
              location.reload();
            }
            else {
              if ( data.message != null ) {
                alert(data.message);
              }
              else {
                alert(data.result);
              }
            }
          }
        });
      }

      e.preventDefault();
    });

    $('select#homepage_id_1').on('change', function(e) {
      if($(this).val() != '') {
        $('input#homepage_id_1').val($(this).val());
        $('#popup_1').attr('action', 'index.do');
        doGetLoad('index.do', serializeCustom($('#popup_1')));
      }

      e.preventDefault();
    });

    $('button#search_btn').on('click', function(e) {
      $('#viewPage').val(1);
      doGetLoad('index.do', serializeCustom($('#specializedServices')));
    });

    $('select#search_view_yn, select#sortType, select#rowCount').on('change', function() {
      $('#viewPage').val(1);
      doGetLoad('index.do', serializeCustom($('#specializedServices')));
    });

  });
</script>
<form:form modelAttribute="specializedServices" method="POST" action="save.do" onsubmit="return false;">
  <form:hidden  path="editMode"/>
  <form:hidden path="homepage_id"/>
  <form:hidden path="specialized_services_idx"/>

  <div id="editDisable" class="disableBox">
    <div class="infodesk">
      검색 결과 : ${paging.totalDataCount}건
      <form:select path="search_view_yn" class="selectmenu">
        <option value="">노출여부선택</option>
        <form:option value="Y">노출함</form:option>
        <form:option value="N">노출안함</form:option>
      </form:select>
      <form:select path="rowCount" class="selectmenu" style="width:120px;">
        <form:option value="10">10개씩 보기</form:option>
        <form:option value="20">20개씩 보기</form:option>
        <form:option value="30">30개씩 보기</form:option>
        <form:option value="100">100개씩 보기</form:option>
        <form:option value="200">200개씩 보기</form:option>
      </form:select>
      <div class="button btn-group inline">
        <c:if test="${authC}">
          <a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>서비스등록</span></a>
        </c:if>
      </div>
    </div>

    <table class="type1 center">
      <thead>
      <tr>
        <th width="40">순번</th>
        <th width="200">이미지</th>
        <th width="200">홈페이지</th>
        <th width="">서비스명</th>
        <th width="200">링크URL</th>
        <th width="80">노출여부</th>
        <th width="120">등록일</th>
        <th width="100">기능</th>
      </tr>
      </thead>
      <tbody>
      <c:if test="${fn:length(specializedServicesList) < 1}">
        <tr>
          <td colspan="9" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
        </tr>
      </c:if>
      <c:forEach var="i" varStatus="status" items="${specializedServicesList}">
        <tr>
          <td>${specializedServices.listRowNum - status.index}</td>
          <td width="200">
            <div class="item">
              <a href="${i.link_url}" target="_blank">
                <c:if test="${i.org_file_name eq null}">
                  <img src="/resources/cms/img/noimg_135_42.gif" alt="이미지 미리보기 입니다.">
                </c:if>
                <c:if test="${i.org_file_name ne null}">
                  <img width="45%" height="80px" src="${getContextPath}/data/specializedServices/${specializedServices.homepage_id}/${i.server_file_name}" alt="${i.server_file_name}">
                </c:if>
              </a>
            </div>
          </td>
          <td width="200">
            ${i.service_homepage_name}
          </td>
          <td class="left">${i.service_name}</td>
          <td>
            <a href="${i.link_url}" target="_blank">${i.link_url}</a>
          </td>
          <td width="50">${i.view_yn eq 'Y' ? '노출' : '미노출'}</td>
          <td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
          <td>
            <c:if test="${authU}">
              <a href="" class="btn" id="dialog-modify" keyValue="${i.specialized_services_idx}">수정</a>
            </c:if>
            <c:if test="${authD}">
              <a href="" class="btn" id="delete" keyValue="${i.specialized_services_idx}">삭제</a>
            </c:if>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>

    <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
      <jsp:param name="formId" value="#specializedServices"/>
    </jsp:include>

    <div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
      <fieldset>
        <form:select path="search_type" cssClass="selectmenu">
          <form:option value="service_name">서비스명</form:option>
        </form:select>
        <form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
        <button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
      </fieldset>
    </div>
  </div>
</form:form>

<div id="dialog-1" class="dialog-common" title="팝업 정보">
</div>