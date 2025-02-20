<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- flatpickr 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<script src="${pageContext.request.contextPath}/resources/cms/js/chart/chart.umd.min.js" type="text/javascript"></script>

<script type="text/javascript">
  $(function () {

    $('#searchBtn').on('click', function () {
      $('input#viewPage').val(1);
      $('#authenticationLog').submit();
    });

    //달력(통계 기간 선택 오류 방지)
    $('input#startDate').datepicker({
      maxDate: $('input#dateEnd').val(),
      onClose: function (selectedDate) {
        $('input#endDate').datepicker('option', 'minDate', selectedDate);
      }
    });
    $('input#endDate').datepicker({
      minDate: $('input#startDate').val(),
      onClose: function (selectedDate) {
        $('input#startDate').datepicker('option', 'maxDate', selectedDate);
      }
    });

    $('#dateType').on('change', function () {
      var dateType = $(this).val(); // 선택된 값 가져오기

      $('#dayInput').hide();
      $('#monthInput').hide();
      $('#yearInput').hide();

      if (dateType === 'DAY') {
        $('#dayInput').show();
      } else if (dateType === 'MONTH') {
        $('#monthInput').show();
      } else if (dateType === 'YEAR') {
        $('#yearInput').show();
      }
    });

    $('#dateType').trigger('change');

    $('a#excelDownload').on('click', function (e) {
      if ($('#homepageId').val() && $('#dateType').val()) {
        $('#authenticationLog').attr('action', '/cms/module/authenticationLog/downloadExcel.do');
        $('#authenticationLog').submit();
      }
      e.preventDefault();
    });

    $('a#csvDownload').on('click', function (e) {
      if ($('#homepageId').val() && $('#dateType').val()) {
        $('#authenticationLog').attr('action', '/cms/module/authenticationLog/downloadCSV.do');
        $('#authenticationLog').submit();
      }
      e.preventDefault();
    });

  })
</script>
<form:form id="authenticationLog" name="authenticationLog" modelAttribute="authenticationLog" action="index.do" method="get">
    <c:choose>
        <c:when test="${member.admin}">
            <form:select id="homepageId" path="homepage_id" class="selectmenu-search" style="width:250px">
                <option disabled>홈페이지 선택</option>
                <option value="ALL" ${authenticationLog.homepage_id == 'ALL' ? 'selected' : ''}>전체</option>
                <c:forEach var="i" varStatus="status" items="${homepageList}">
                    <option value="${i.homepage_id}" ${authenticationLog.homepage_id == i.homepage_id ? 'selected' : ''}>${i.homepage_name}</option>
                </c:forEach>
            </form:select>
        </c:when>
        <c:otherwise>
            <form:hidden id="homepageId" path="homepage_id" value="${asideHomepageId}"/>
        </c:otherwise>
    </c:choose>
    <form:select path="dateType" class="selectmenu-search" style="width:200px">
        <option disabled>날짜 분류 선택</option>
        <form:option value="DAY" label="일간별"/>
        <form:option value="MONTH" label="월간별"/>
        <form:option value="YEAR" label="연간별"/>
    </form:select>
    <form:select path="homepage_type" class="selectmenu-search" style="width:200px">
        <option disabled>홈페이지 분류 선택</option>
        <form:option value="0" label="전체"/>
        <form:option value="1" label="홈페이지"/>
        <form:option value="2" label="검색대"/>
    </form:select>
    <div id="dateInputs">
        <div id="dayInput">
            <form:input type="text" path="startDate" id="startDate" class="text ui-calendar"/>
            <span id="tilde" style="font-size:12px">~</span>
            <form:input type="text" path="endDate" id="endDate" class="text ui-calendar"/>
        </div>

        <div id="monthInput" style="display:none;">
            <form:select path="startMonthYear" id="startMonthYear" class="selectmenu-search" style="width:100px">
                <c:forEach var="year" begin="2025" end="2030">
                    <form:option value="${year}" label="${year}"/>
                </c:forEach>
            </form:select>
        </div>

        <div id="yearInput" style="display:none;">
            <form:select path="startYear" id="startYear" class="selectmenu-search" style="width:100px">
                <c:forEach var="year" begin="2025" end="2030">
                    <form:option value="${year}" label="${year}"/>
                </c:forEach>
            </form:select>
            <span id="tilde" style="font-size:12px">~</span>
            <form:select path="endYear" id="endYear" class="selectmenu-search" style="width:100px;">
                <c:forEach var="year" begin="2025" end="2030">
                    <form:option value="${year}" label="${year}"/>
                </c:forEach>
            </form:select>
        </div>
    </div>
    <button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
    <br><br><br>
    <a href="javascript:void(0);" id="excelDownload" class="btn btn2">
        <i class="fa fa-file-excel-o"></i><span>엑셀저장</span>
    </a>
    <a href="javascript:void(0);" id="csvDownload" class="btn btn2">
        <i class="fa fa-file-excel-o"></i><span>csv저장</span>
    </a>
    <span>총 건수 : ${paging.totalDataCount}건</span>

    <div id="chartData">
        <canvas id="myChart" width="50" height="50"></canvas>
    </div>

    <div id="tableData">
        <table>
            <thead>
            <tr>
                <th>홈페이지</th>
                <th>사용자명</th>
                <th>생년월일</th>
                <th>휴대폰번호</th>
                <th>접근IP</th>
                <th>홈페이지타입(홈페이지/검색대)</th>
                <th>브라우저타입</th>
                <th>인증일시</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="i" varStatus="status" items="${authenticationLogList}">
                <tr>
                    <td>${i.homepage_name}</td>
                    <td>${i.user_name}</td>
                    <td>${i.user_birth}</td>
                    <td>${i.user_phone}</td>
                    <td>${i.user_ip}</td>
                    <td>${i.homepage_type_name}</td>
                    <td>${i.browser_type}</td>
                    <td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
                </tr>
            </c:forEach>
            <c:if test="${empty authenticationLogList}">
                <tr>
                    <td colspan="8">검색 결과가 없습니다.</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
    <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
        <jsp:param name="formId" value="#authenticationLog"/>
    </jsp:include>
</form:form>

<script>
  const chartData = [
    <c:forEach var="data" items="${chartData}" varStatus="loop">
    {
      chart_label: "${data.chart_label}",
      homepage_chart_count: ${data.homepage_chart_count},
      search_chart_count: ${data.search_chart_count}
    }
    <c:if test="${!loop.last}">, </c:if>
    </c:forEach>
  ];

  const labels = chartData.map(data => data.chart_label); // X축 라벨
  const homepageCount = chartData.map(data => data.homepage_chart_count);
  const searchCount = chartData.map(data => data.search_chart_count);

  const ctx = document.getElementById('myChart').getContext('2d');
  const myChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: labels, // 동적 X축 라벨
      datasets: [
        {
          label: '홈페이지',
          data: homepageCount,
          backgroundColor: 'rgba(54, 162, 235, 0.6)',
          borderColor: 'rgba(54, 162, 235, 1)',
          borderWidth: 1
        },
        {
          label: '검색대',
          data: searchCount,
          backgroundColor: 'rgba(255, 99, 132, 0.6)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 1
        }
      ]
    },
    options: {
      responsive: true,
      plugins: {
        legend: {position: 'top'},
        title: {display: true, text: '홈페이지 타입별 인증 로그'}
      },
      scales: {
        y: {beginAtZero: true}
      }
    }
  });

</script>


