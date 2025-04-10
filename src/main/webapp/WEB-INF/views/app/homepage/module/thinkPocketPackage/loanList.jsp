<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
  $(function () {

    $('a.btn-view').on('click', function (e) {
      e.preventDefault();
      var formData = 'menu_idx=' + $('#menu_idx').val() + '&think_pocket_package_loan_idx=' + $(this).attr('keyValue') + '&viewPage=' + $('#viewPage').val();
      doGetLoad('loanView.do', formData);
    });

    $('a.return-req').on('click', function (e) {
      e.preventDefault();
      var return_yn = $(this).attr('keyValue2')
      var msg = '';

      $('form#thinkPocketPackage').attr('action', 'loanSave.do');
      $('#think_pocket_package_loan_idx').val($(this).attr('keyValue'));
      $('input[name="return_yn"]').val(return_yn);
      $('input[name="return_yn"]').prop('checked', true);

      if (return_yn == 'Y') {
        $('#editMode').val('returnReq');
        msg = '반납요청을 하시겠습니까?';
      } else {
        $('#editMode').val('returnReqCancel');
        msg = '반납요청을 취소 하시겠습니까?';
      }

      if (confirm(msg)) {
        if (doAjaxPost($('form#thinkPocketPackage'))) {
          location.reload();
        }
      }

    });

    $('a.cancel-btn').on('click', function (e) {
      e.preventDefault();
      if (confirm('해당 대출 신청을 취소하시겠습니까?')) {
        $('#editMode').val('DELETE');
        $('form#thinkPocketPackage').attr('action', 'loanSave.do');
        $('form#thinkPocketPackage').attr('method', 'POST');
        $('#think_pocket_package_loan_idx').val($(this).attr('keyValue'));
        if (doAjaxPost($('form#thinkPocketPackage'))) {
          location.reload();
        }
      }
    });

    var currDate = new Date();
    var year = currDate.getFullYear();
    var currYear = '${thinkPocketPackage.loan_start_date}';
    for (var i = 2016; i <= year; i++) {
      var selected = '';
      if (currYear == i) {
        selected = 'selected="selected"';
      }
      $('select#loan_start_date').append('<option value="' + i + '" ' + selected + '>' + i + '</option>');
    }

    $('input[name="return_yn"]').on('click', function () {
      $('#viewPage').val(1);
      doGetLoad('loanList.do', $('form#thinkPocketPackage').serialize());
    });

    $('button#search_btn').on('click', function (e) {
      $('#viewPage').val(1);
      doGetLoad('loanList.do', $('form#thinkPocketPackage').serialize());
    });

    $('select#request_status, select#loan_start_date, select#rowCount').on('change', function () {
      $('#viewPage').val(1);
      doGetLoad('loanList.do', $('form#thinkPocketPackage').serialize());
    });

    $('#allChk').on('click', function (e) {
      e.preventDefault();
      if ($(this).attr('keyValue') == 'N') {
        $(this).attr('keyValue', 'Y');
        $('.loan_chk').prop('checked', true);
      } else {
        $(this).attr('keyValue', 'N');
        $('.loan_chk').prop('checked', false);
      }
    });

    $('#status-change').on('click', function (e) {
      e.preventDefault();

      if ($('input[name="think_pocket_package_loan_arr"]:checked').length < 1) {
        alert('변경할 신청 리스트를 선택하세요.');
        return false;
      }

      if ($('select#statusAll option:selected').val() == '') {
        alert('변경할 상태를 선택하세요.');
        return false;
      }

      $('select#request_status').val($('select#statusAll').val()).prop('selected', true);
      $('#editMode').val('STATUS');
      $('#thinkPocketPackage').attr('action', 'loanSave.do');
      $('#thinkPocketPackage').attr('method', 'POST');
      if (doAjaxPost($('#thinkPocketPackage'))) {
        location.reload();
      }
    });

    $('a#excelDownload').on('click', function (e) {
      e.preventDefault();
      if ('${fn:length(loanList)}' > 0) {
        $('#editMode').val('thinkPocketPackageLoan');
        $('#thinkPocketPackage').attr('method', 'POST');
        $('#thinkPocketPackage').attr('action', 'excelDownload.do').submit();
        $('form#thinkPocketPackage').submit();

        $('#thinkPocketPackage').attr('method', 'GET');
        $('#thinkPocketPackage').attr('action', 'loanList.do');
      } else {
        alert('해당 내역이 없습니다.');
      }
    });

  });
</script>
<style type="text/css">
  input[name="return_yn"] {
    display: none;
  }

  input[name="return_yn"] + label, input[name="return_yn"].customCheck:checked + label {
    display: inline-block;
    cursor: pointer;
    padding-left: 30px;
    padding-right: 15px;
  }

  input[name="return_yn"] + label {
    color: #222;
    background: url("/resources/common/img/icon_cate_chk.png") no-repeat;
  }

  input[name="return_yn"]:checked + label {
    color: #1ba8ed;
    background: url("/resources/common/img/icon_cate_chk_on.png") no-repeat;
  }

  p.point-txt {
    display: inline-block;
    padding-left: 22px;
    background: url(/resources/common/img/icon_point.gif) no-repeat 0 1px;
    font-size: 13px;
    line-height: 17px;
    color: #222;
    word-break: keep-all;
  }

  span.status {
    display: block;
    padding: 0 5px;
    border-radius: 3px;
    font-size: 12px;
    letter-spacing: -0.05em;
    color: #fff;
  }

  span.status.status1 {
    background-color: #36bc74;
  }

  span.status.status2 {
    background-color: #7d57de;
  }

  span.status.status3 {
    background-color: #1ba8ed;
  }

  span.status.status4 {
    background-color: #E5BA0F;
  }

  span.status.status5 {
    background-color: #CE3419;
  }

  span.status.status6 {
    background-color: #787b80;
  }

  a.sub-btn {
    display: inline-block;
    padding: 0 5px;
    border-radius: 3px;
    font-size: 12px;
  }

  a.return {
    border: 1px solid #e94949;
    color: #e94949;
  }

  a.return2 {
    background: #e94949;
    color: #fff;
  }

  a.cancel-btn {
    border: 1px solid #787b80;
    color: #787b80;
  }
</style>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>

<div class="tabmenu on tab1">
    <ul>
        <li class="active"><a title="대출현황조회(책·미니·주제)" href="#tabCon1" keyvalue="tabCon1">대출현황조회(책·미니·주제)</a></li>
    </ul>
</div>

<form:form modelAttribute="thinkPocketPackage" action="loanList.do" method="GET">
    <form:hidden path="editMode"/>
    <form:hidden path="menu_idx"/>
    <form:hidden path="think_pocket_package_loan_idx"/>

    <div>
        <form:checkbox path="return_yn" value="Y" label="반납요청"/>
    </div>
    <div class="infodesk">
        검색 결과 : 총 ${paging.totalDataCount}건
        <form:select path="request_status" cssClass="selectmenu">
            <form:option value="">상태전체</form:option>
            <form:option value="0">신청상태</form:option>
            <form:option value="1">예약상태</form:option>
            <form:option value="2">대출상태</form:option>
            <form:option value="3">반납완료</form:option>
            <form:option value="4">관리자취소</form:option>
            <form:option value="5">반납요청완료</form:option>
            <form:option value="6">승인</form:option>
        </form:select>
        <form:select path="rowCount" cssClass="selectmenu">
            <form:option value="10">10개씩보기</form:option>
            <form:option value="20">20개씩보기</form:option>
            <form:option value="30">30개씩보기</form:option>
            <form:option value="50">50개씩보기</form:option>
            <form:option value="100">100개씩보기</form:option>
            <form:option value="${paging.totalDataCount}">전체 보기</form:option>
        </form:select>

        <div class="button">
            <a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
        </div>
    </div>
    <div class="search txt-center">
        <fieldset>
            <form:select path="search_type" cssClass="selectmenu">
                <form:option value="think_pocket_package_subject">생각 주머니명</form:option>
                <form:option value="request_name">신청자</form:option>
            </form:select>
            <form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
            <button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
        </fieldset>
    </div>
    <div style="text-align: right;margin-bottom: 5px;">
        <p class="point-txt"><strong>반납요청중</strong>을 클릭하면 반납요청을 취소할 수 있습니다.</p>
    </div>
    <table class="type1 center">
        <colgroup>
            <c:if test="${member.admin}">
                <col width="6%"/>
            </c:if>
            <col width="6%"/>
            <col width="20%"/>
<%--            <col width="12%"/>--%>
            <col width="15%"/>
            <col width="12%"/>
            <col width="11%"/>
            <col width="7%"/>
            <col width="10%"/>
            <col width="8%"/>
        </colgroup>
        <thead>
        <tr>
            <c:if test="${member.admin}">
                <th>선택</th>
            </c:if>
            <th>번호</th>
            <th>생각 주머니명</th>
<%--            <th>대출기간</th>--%>
            <th>신청자</th>
            <th>신청일자</th>
            <th>상태</th>
            <th>권수</th>
            <th>수령 및 반납장소</th>
            <th>반납요청</th>
            <th>취소</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="i" varStatus="status" items="${loanList}">
            <tr>
                <c:if test="${member.admin}">
                    <td>
                        <label>
                            <input type="checkbox" name="think_pocket_package_loan_arr" class="loan_chk" value="${i.think_pocket_package_loan_idx}"/>
                        </label>
                    </td>
                </c:if>
                <td class="num">${paging.listRowNum - status.index}</td>
                <td class="left">
                    <a href="#" class="btn-view" keyValue="${i.think_pocket_package_loan_idx}">${i.think_pocket_package_subject}</a>
                    <br/>
                    <c:if test="${i.request_status eq '1'}">
                        <span>(예약일: ${i.loan_start_date}~${fn:substring(i.loan_end_date, 5, 10)})</span>
                    </c:if>
                </td>
<%--                <td class="center">--%>
<%--                    <c:if test="${i.request_status ne '1'}">--%>
<%--                        ${i.loan_start_date}<br/>--%>
<%--                        <span>~</span>${i.loan_end_date}--%>
<%--                    </c:if>--%>
<%--                </td>--%>
                <td>
                        ${i.request_name}
                </td>
                <td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
                <td>
                    <c:choose>
                        <c:when test="${i.request_status eq '0'}"><span class="status status1">신청중</span></c:when>
                        <c:when test="${i.request_status eq '1'}"><span class="status status2">예약상담중</span></c:when>
                        <c:when test="${i.request_status eq '2'}"><span class="status status3">대출중</span></c:when>
                        <c:when test="${i.request_status eq '3'}"><span class="status status4">반납완료</span></c:when>
                        <c:when test="${i.request_status eq '4'}"><span class="status status5">관리자취소</span></c:when>
                        <c:when test="${i.request_status eq '5'}"><span class="status status6">반납요청완료</span></c:when>
                        <c:when test="${i.request_status eq '6'}"><span class="status status6">승인</span></c:when>
                    </c:choose>
                </td>
                <td>${i.loan_count}권</td>
                <td>${i.loan_place}</td>
                <td>
                    <c:if test="${i.request_status eq '2'}">
                        <c:choose>
                            <c:when test="${i.return_yn eq 'N'}">
                                <a href="#" class="return-req sub-btn return" keyValue="${i.think_pocket_package_loan_idx}" keyValue2="Y">반납요청</a>
                            </c:when>
                            <c:otherwise>
                                <a href="#" class="return-req sub-btn return2" keyValue="${i.think_pocket_package_loan_idx}" keyValue2="N">반납요청중</a>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </td>
                <td>
                    <c:if test="${i.request_status eq '0' or i.request_status eq '1'}">
                        <a href="#" class="cancel-btn sub-btn" keyValue="${i.think_pocket_package_loan_idx}">취소</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(loanList) < 1}">
            <tr>
                <td colspan="9">조회된 자료가 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
        <jsp:param name="formId" value="#thinkPocketPackage"/>
        <jsp:param name="pagingUrl" value="loanList.do"/>
    </jsp:include>
</form:form>