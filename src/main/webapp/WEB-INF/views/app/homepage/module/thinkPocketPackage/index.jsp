<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
  $(function () {

    $('.view-btn').on('click', function (e) {
      e.preventDefault();
      var formData = 'menu_idx=' + $('#menu_idx').val() + '&viewPage=' + $('#viewPage').val() + '&think_pocket_package_idx=' + $(this).attr('keyValue');
      doGetLoad('view.do', formData);
    });

    $('.delete-btn').on('click', function (e) {
      e.preventDefault();
      if (confirm('삭제하시겠습니까?')) {
        $('#think_pocket_package_idx_d').val($(this).attr('keyValue'));
        if (doAjaxPost($('form#thinkPocketPackageDel'))) {
          location.reload();
        }

      }
    });

    // 책 꾸러미 대출 신청
    $('.request-btn').on('click', function (e) {
      e.preventDefault();
      var formData = 'editMode=ADD&menu_idx=' + $('#menu_idx').val() + '&think_pocket_package_idx=' + $(this).attr('keyValue');
      doGetLoad('loanEdit.do', formData);
    });

    $('input#chkAll').on('click', function () {
      $('.categoryChk').prop('checked', false);
      $('#viewPage').val(1);
      doGetLoad('index.do', $('form#thinkPocketPackage').serialize());
    });

    $('.categoryChk').on('click', function () {
      $('input#chkAll').prop('checked', false);
      $('#viewPage').val(1);
      doGetLoad('index.do', $('form#thinkPocketPackage').serialize());
    });

    $('select#grade, select#lender_count').on('change', function () {
      $('#viewPage').val(1);
      doGetLoad('index.do', $('form#thinkPocketPackage').serialize());
    });

    $('button#search_btn').on('click', function (e) {
      $('#viewPage').val(1);
      doGetLoad('index.do', $('form#thinkPocketPackage').serialize());
    });

    $('a#excelDownload').on('click', function (e) {
      e.preventDefault();
      if ('${fn:length(thinkPocketPackageList)}' > 0) {
        $('#editMode').val('thinkPocketPackage');
        $('#thinkPocketPackage').attr('method', 'POST');
        $('#thinkPocketPackage').attr('action', 'excelDownload.do').submit();
        $('form#thinkPocketPackage').submit();

        $('#thinkPocketPackage').attr('method', 'GET');
        $('#thinkPocketPackage').attr('action', 'index.do');
      } else {
        alert('해당 내역이 없습니다.');
      }
    });

    $('#all-check').on('click', function (e) {
      e.preventDefault();
      if ($(this).attr('keyValue') == 'N') {
        $(this).attr('keyValue', 'Y');
        $('.book_check').prop('checked', true);
      } else {
        $(this).attr('keyValue', 'N');
        $('.book_check').prop('checked', false);
      }
    });

    $('#delete-check').on('click', function (e) {
      e.preventDefault();
      if ($('.book_check:checked').length == 0) {
        alert('삭제할 리스트를 선택하세요.');
        return false;
      }
      if (confirm('선택 항목들을 삭제하시겠습니까?')) {
        $('form#thinkPocketPackage').attr('action', 'save.do');
        $('form#thinkPocketPackage').attr('method', 'POST');
        $('#editMode').val('DELETE_CHECK');
        if (doAjaxPost($('form#thinkPocketPackage'))) {
          location.reload();
        }
      }
    });

    $('a.tit-search-btn').on('click', function (e) {
      e.preventDefault();
      var title = $(this).parent('div.btn-box').siblings('div.content-box').find('div.subject a').text();
      var data = 'menu_idx=140&manage_idx=212&search_type=title%2Bcontent&search_text=' + title.replace(/ ([(][A-Z][)])| [A-Z]$/g, '');
      doGetLoad('/${homepage.context_path}/board/index.do', data);
    });

  });

  $(function () {
    $('.tabmenu a').on('click', function () {
      var key = $(this).attr('keyValue');
      if (key == 'tabCon1') {
      } else if (key == 'tabCon2') {
        doGetLoad('../thinkPocketPackageBundle/index.do?menu_idx=${fn:escapeXml(param.menu_idx)}');
      }
    });
  });

</script>
<link rel="stylesheet" href="/resources/common/css/thinkPocketPackage.css"/>
<div class="tab_wrap">
<div class="tabmenu on tab1">
    <ul>
        <li class="active"><a title="대출신청(책·미니·주제)" href="#tabCon1" keyvalue="tabCon1">대출신청(책·미니·주제)</a></li>
    </ul>
</div>
<div class="phone_num" style="float:right;">문의 : 독서문화과(☎231-2059)</div>
</div>
<div class="tabCon active" id="tabCon1">
    <form:form modelAttribute="thinkPocketPackage" id="thinkPocketPackageDel" action="save.do" method="POST">
        <form:hidden path="editMode" id="editMode_d" value="DELETE"/>
        <form:hidden path="think_pocket_package_idx" id="think_pocket_package_idx_d"/>
        <input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>
    </form:form>

    <input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>
    <form:form modelAttribute="thinkPocketPackage" action="index.do" method="GET">
        <form:hidden path="menu_idx"/>
        <form:hidden path="editMode"/>
        <form:hidden path="think_pocket_package_idx"/>

        <div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
            <fieldset>
                <form:select path="search_type" cssClass="selectmenu new_select_box">
                    <form:option value="think_pocket_package_subject">서명</form:option>
                    <form:option value="keyword">키워드</form:option>
                </form:select>
                <form:input path="search_text" cssClass="text new_text01" cssStyle="width:200px;"/>
                <button id="search_btn" style="background-color:#2c75cb;border-color:#1962ba;background-image:none;padding:6px 10px;"><i class="fa fa-search"></i><span>검색</span></button>
            </fieldset>
        </div>
        <div class="infodesk">
            <form:select path="grade" cssClass="selectmenu new_select_box">
                <form:option value="">수준별보기</form:option>
                <form:option value="1">유아</form:option>
                <form:option value="2">초등</form:option>
            </form:select>
            <form:select path="lender_count" cssClass="selectmenu new_select_box">
                <form:option value="-1">상태전체</form:option>
                <form:option value="1">대출중</form:option>
                <form:option value="0">대출가능</form:option>
            </form:select>
            <div class="button">
			 <!--<a href="https://library.daegu.go.kr/board/boardFile/download/28/530508/376117/%EC%B1%85%EA%BE%B8%EB%9F%AC%EB%AF%B8%20%EB%82%B4%EB%A0%A4%EB%B0%9B%EA%B8%B0%20%EB%AA%A9%EB%A1%9D.xls.do" id="excelDownload" class="btn btn2" download>-->
                <a href="https://library.daegu.go.kr/board/boardFile/download/28/530508/376117/%EC%B1%85%EA%BE%B8%EB%9F%AC%EB%AF%B8%20%EB%82%B4%EB%A0%A4%EB%B0%9B%EA%B8%B0%20%EB%AA%A9%EB%A1%9D.xls.do" class="btn btn2" download title="책꾸러미 도서목록 다운로드"><i class="fa fa-file-excel-o"></i><span>도서목록 다운받기</span></a>
            </div>
        </div>
        <div>
            <c:forEach items="${thinkPocketPackageList}" var="i" varStatus="status">
                <div class="group-box">
                    <div class="img-box">
                        <c:choose>
                            <c:when test="${not empty i.image_link and empty i.server_file_name}">
                                <a href="${i.desc_link}" target="_blank">
                                    <img src="${i.image_link}" alt="${i.think_pocket_package_subject}" width="100%" height="100%">
                                </a>
                            </c:when>
                            <c:when test="${not empty i.server_file_name}">
                                <a href="#">
                                    <img src="${getContextPath}/data/thinkPocketPackage/${i.server_file_name}" alt="${i.think_pocket_package_subject}" width="100%" height="100%">
                                </a>
                            </c:when>
                            <c:otherwise>
                                <img src="/resources/common/img/noimg-gall.png" alt="no-image" height="100%">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="content-box">
                        <div class="subject">
                            <c:if test="${i.lender_count > 0}">

                                <span class="ing">대출중 ${request_status}</span>
                            </c:if>
                            <a href="#" class="view-btn" keyValue="${i.think_pocket_package_idx}">${i.think_pocket_package_subject}</a>
                        </div>
                        <div>
                            <c:if test="${not empty i.grade}">
				<span class="step1">
				<c:choose>
                    <c:when test="${i.grade eq '1'}">유아</c:when>
                    <c:when test="${i.grade eq '2'}">초등</c:when>
                </c:choose>
				</span>
                            </c:if>
                        </div>
                        <div>
                            <ul class="pub_info">
                                <li>${i.author}</li>
                                <li>|</li>
                                <li>${i.publisher}</li>
                                <li>|</li>
                                <li>${i.publish_year}</li>
                            </ul>
                        </div>
                        <div class="book-desc">
                                ${fn:substring(i.content, 0, 85)}
                            <c:if test="${fn:length(i.content) > 85}">...</c:if>
                        </div>
                        <div class="keyword-box">
                            <c:forTokens items="${i.keyword}" delims="," var="keyword">
                                <span class="keyword">${keyword}</span>
                            </c:forTokens>
                        </div>
                    </div>
                    <div class="btn-box">
                        <c:choose>
                            <c:when test="${i.lender_count == 0}">
                                <a href="#" class="request-btn loan" keyValue="${i.think_pocket_package_idx}">대출신청</a>
                            </c:when>
                            <c:when test="${i.lender_count <= 1}">
                                <a href="#" class="request-btn reserv" keyValue="${i.think_pocket_package_idx}">예약신청</a>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:void(0)" class=" " keyValue="${i.think_pocket_package_idx}">예약마감</a>
                            </c:otherwise>
                        </c:choose>
                        <span class="loan-cnt">
				<strong>${i.loan_count}</strong>권
			</span>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${fn:length(thinkPocketPackageList) < 1}">
                <div align="center">
                    <h3>등록된 생각 주머니 리스트가 없습니다.</h3>
                </div>
            </c:if>
        </div>

        <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
            <jsp:param name="formId" value="#thinkPocketPackage"/>
        </jsp:include>

    </form:form>
</div>