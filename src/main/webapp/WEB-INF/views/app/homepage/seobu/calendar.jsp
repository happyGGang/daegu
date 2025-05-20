<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
  $(document).ready(function () {
    // 행사일 슬라이더
    $('.event-slide').slick({
      slidesToShow: 12,
      slidesToScroll: 1,
      autoplay: false,
      arrows: false,
      dots: false,
      variableWidth: true,
    });

    // 이전/다음 버튼
    $('.event-slide-prev, .event-slide-next').click(function () {
      if ($('.event-slide').hasClass('slick-initialized')) {
        $('.event-slide').slick($(this).hasClass('event-slide-prev') ? 'slickPrev' : 'slickNext');
      }
    });
  });

</script>
<div class="event-area-wrapper">
    <div class="event-area-header">
        <div>이달의 행사일을 확인해보세요</div>
        <a href="/seobu/module/calendarManage/index.do?menu_idx=63">
            <div>더보기</div>
            <img src="/resources/homepage/seobu/img/culture/more-black.svg" alt="">
        </a>
    </div>
    <div class="event-slide-wrapper">
        <c:choose>
            <c:when test="${fn:length(eventDates) > 0}">
                <img class="event-slide-prev" src="/resources/homepage/seobu/img/culture/event-left-arrow.svg" alt="이전"/>
                <div class="event-slide">
                    <c:forEach var="i" items="${eventDates}">
                        <fmt:parseDate var="day" value="${i.start_date}" pattern="yyyy-MM-dd" />
                        <div class="event-slide-item"><fmt:formatDate value="${day}" pattern="dd" /></div>
                    </c:forEach>
                </div>
                <img class="event-slide-next" src="/resources/homepage/seobu/img/culture/event-right-arrow.svg" alt="다음"/>
            </c:when>

            <c:otherwise>
                <div class="book-nodata">행사가 없습니다.</div>
            </c:otherwise>
        </c:choose>
    </div>
</div>


