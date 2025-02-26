<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
  $(function () {

    $('#save-btn').on('click', function (e) {
      e.preventDefault();

      if ($('#loan_start_date').val() == '') {
        alert('대출시작기간을 선택하세요.');
        $('#loan_start_date').focus();
        return false;
      }
      if ($('#loan_end_date').val() == '') {
        alert('대출종료기간을 선택하세요.');
        $('#loan_end_date').focus();
        return false;
      }
      if ($('#request_name').val() == '') {
        alert('신청자를 입력하세요.');
        $('#request_name').focus();
        return false;
      }
      if ($('#phone_2').val() == '') {
        alert('휴대폰을 입력하세요.');
        $('#phone_2').focus();
        return false;
      }
      if ($('#phone_3').val() == '') {
        alert('휴대폰을 입력하세요.');
        $('#phone_3').focus();
        return false;
      }

      if ($('#agree').prop('checked') == false && $('#editMode').val() == 'ADD') {
        alert('개인정보 수집 및 이용에 동의를 하셔야 합니다.');
        $('#agree').focus();
        return false;
      }

      doAjaxPost($('#thinkPocketPackageLoan'));
    });

    $('#cancel-btn').on('click', function (e) {
      e.preventDefault();
      history.back();
    });

    $('#school_name').focus();

  });
  $(document).on("keyup", "input:text[numberOnly]", function() {
    $(this).val($(this).val().replace(/[^0-9]/gi, ""));
  });
</script>
<style>
  input[type="checkbox"]:focus {
    outline: 1px solid red;
  }

  .title-info {
    position: relative;
    border: 2px solid #d2dfe8;
    padding: 28px;
    margin-bottom: 30px;
  }

  .title-info h3 {
    display: inline-block;
    font-weight: bold;
    color: #e94949;
    padding: 10px 0 0 120px;
    background: url(/resources/common/img/icon0105.gif) no-repeat;
    min-height: 150px;
  }

  .title-info ul {
    position: absolute;
    top: 80px;
    left: 145px;
  }

  .title-info ul li {
    font-size: 14px;
    color: #222;
    margin-left: 20px;
    margin-bottom: 6px;
    list-style-type: disc;
  }

  @media all and (max-width: 920px) {
    .title-info h3 {
      min-height: 200px;
    }
  }

  @media all and (max-width: 540px) {
    .title-info h3 {
      background: none;
      padding: 10px;
    }

    .title-info ul {
      left: 30px;
    }
  }
</style>
<div class="title-info">
    <h3>꼭 읽어주세요!</h3>
    <ul>
        <li style="font-weight:bold;color:blue;">1가정당 1꾸러미 신청 가능합니다.</li>
        <li style="font-weight:bold;color:blue;">신청 후 대출 승인 안내 문자를 받으면 승인날짜 포함하여 3일 내로 대출해 가시면 됩니다.</li>
        <li>대출 기간은 배송 기간 포함입니다.</li>
        <li>다음 학교가 희망하는 일자부터 사용할 수 있도록 대출 기간을 반드시 지켜주십시오.</li>
    </ul>
</div>
<form:form id="thinkPocketPackageLoan" modelAttribute="thinkPocketPackage" action="loanSave.do" method="POST">
    <form:hidden path="editMode"/>
    <form:hidden path="menu_idx"/>
    <form:hidden path="viewPage"/>
    <form:hidden path="rowCount"/>
    <form:hidden path="think_pocket_package_idx"/>
    <form:hidden path="think_pocket_package_loan_idx"/>
    <form:hidden path="think_pocket_package_subject"/>
    <table class="type2">
        <colgroup>
            <col width="130"/>
            <col width="*"/>
        </colgroup>
        <tbody>
        <tr>
            <th> 생각주머니명</th>
            <td>${thinkPocketPackage.think_pocket_package_subject}</td>
        </tr>
        <tr style="display: none">
            <th>대출기간(<span style="color: red;font-weight: bold;">*</span>)</th>
            <td>
                <form:input path="loan_start_date" cssClass="text ui-calendar" readonly="true"/>
                <span>~</span>
                <form:input path="loan_end_date" cssClass="text ui-calendar" readonly="true"/>
                <div class="ui-state-highlight">
                    <i class="fa fa-question-circle"></i>
                    <em>대출 기간은 30일로 고정 됩니다. </em>
                </div>
            </td>
        </tr>
        <tr>
            <th>신청자(<span style="color: red;font-weight: bold;">*</span>)</th>
            <td>
                <form:input path="request_name" cssClass="text" cssStyle="width:100px;"/>
            </td>
        </tr>
        <tr>
            <th>휴대폰(<span style="color: red;font-weight: bold;">*</span>)</th>
            <td>
                <form:select path="phone_1" cssClass="selectmenu">
                    <form:option value="010">010</form:option>
                    <form:option value="011">012</form:option>
                    <form:option value="016">016</form:option>
                    <form:option value="017">017</form:option>
                    <form:option value="018">018</form:option>
                    <form:option value="019">019</form:option>
                </form:select>
                <span>-</span>
                <form:input path="phone_2" cssClass="text" cssStyle="width:50px;" maxlength="4" numberonly="true"/>
                <span>-</span>
                <form:input path="phone_3" cssClass="text" cssStyle="width:50px;" maxlength="4" numberonly="true"/>
            </td>
        </tr>
        <tr>
            <th>수령(대출) 및 수거(반납)장소</th>
            <td>
                <form:select path="loan_place" cssClass="selectmenu">
                    <form:option value="3층 유아자료실">3층 유아자료실</form:option>
                </form:select>
            </td>
        </tr>
        <tr>
            <th>진행상태</th>
            <td>
                <c:choose>
                    <c:when test="${!member.admin}">
                        <c:if test="${thinkPocketPackage.lender_count == 0}">
                            <form:hidden path="request_status" value="0"/>신청
                        </c:if>
                        <c:if test="${thinkPocketPackage.lender_count > 0}">
                            <form:hidden path="request_status" value="1"/>예약
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <form:select path="request_status" cssClass="selectmenu">
                            <form:option value="0">신청상태</form:option>
                            <form:option value="1">예약상태</form:option>
                            <form:option value="2">대출상태</form:option>
                            <form:option value="3">반납완료</form:option>
                            <form:option value="4">관리자취소</form:option>
                            <form:option value="5">반납요청완료</form:option>
                            <form:option value="6">승인</form:option>
                        </form:select>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        </tbody>
    </table>
</form:form>
<br/>
<c:if test="${thinkPocketPackage.editMode eq 'ADD'}">
    <div>
        <h3>개인정보 수집 및 이용 안내</h3>
        <ul>
            <li>기재해주신 개인정보(이름, 연락처 등)는 도서관 서비스 제공을 위한 목적으로만 사용합니다.</li>
        </ul>
        <div class="agree_box">
            <input type="checkbox" id="agree"><label for="agree">도서관 서비스를 제공 받기 위해 상기 개인정보(이름, 연락처 등) 제공 및 이용에 동의합니다.</label>
        </div>
    </div>
</c:if>
<br/>
<div class="txt-right">
    <button id="save-btn" class="btn btn2">신청하기</button>
    <button id="cancel-btn" class="btn btn5">취소</button>
</div>
