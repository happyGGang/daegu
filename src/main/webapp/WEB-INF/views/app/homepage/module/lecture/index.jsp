<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>

<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>

<script type="text/javascript">
    function goSearch() {
        $('#viewPage').val(1);
        doGetLoad('index.do', serializeCustom($('form#lectureInfo')));
    }

    function lectureRequest(lecture_id) {
        var ajaxData = {
            'lecture_id' : lecture_id,
            'request_type' : '온라인'
        };

        if(confirm('수강신청 하시겠습니까?')) {
            $.ajax({
                url: 'save.do',
                data : ajaxData,
                method: 'POST',
                success: function(response) {
                    if(response.valid) {
                        alert(response.message);
                        location.reload();
                    } else {
                        if ( response.message != null ) {
                            alert(response.message);
                        }
                        else {
                            for(var i =0 ; i < response.result.length ; i++) {
                                alert(response.result[i].code);
                                $('#'+response.result[i].field).focus();
                                break;
                            }
                        }
                    }
                },error: function(response) {
                    alert(response.message);
                }
            });
        }
    }

    // 강좌 정보로 이동
    function view(lecture_id) {
        $('#lecture_id').val(lecture_id);
        doGetLoad('view.do', serializeCustom($('form#lectureInfo')));
    }

    // 마이페이지로 이동
    function myPage() {
        doGetLoad('myPage.do', serializeCustom($('form#lectureInfo')));
    }

    $(function() {

        // 검색 접수기간 시작일
        $('input#start_period').datepicker({
            maxDate: $('input#end_period').val(),
            onClose: function(selectedDate){
                $('input#end_period').datepicker('option', 'minDate', selectedDate);
            }
        });

        // 검색 접수기간 종료일
        $('input#end_period').datepicker({
            minDate: $('input#start_period').val(),
            onClose: function(selectedDate){
                $('input#start_period').datepicker('option', 'maxDate', selectedDate);
            }
        });
    });

</script>

<style>
    .tit {
        display: inline;
        margin-right: 20px;
    }

    .btn-inline {
        display: inline-block;
    }

    .lecture_tit {
        color: #2e9901;
    }

    .lecture_tit:hover {
        color: #0d75c4;
    }
</style>
<form:form modelAttribute="lectureInfo" method="GET" action="index.do">
<form:hidden path="lecture_id"/>

    <div id="apply">
        <div class="detail_search_box col2 dis_table">
            <ul>
                <li class="table">
                    <p class="cell th">교육상태</p>
                    <div class="cell td">
                        <div class="inp">
                            <form:select path="searching_edu_status" cssClass="selectmenu">
                                <form:option value="0">전체</form:option>
                                <form:option value="1">교육대기</form:option>
                                <form:option value="2">교육중</form:option>
                                <form:option value="3">교육마감</form:option>
                            </form:select>
                        </div>
                    </div>
                </li>
            </ul>
            <ul>
                <li class="table"><p class="cell th">접수방법</p>
                    <div class="cell td">
                        <div class="inp">
                            <form:select path="searching_request_type" cssClass="selectmenu">
                                <form:option value="">전체</form:option>
                                <form:option value="선착순">선착순</form:option>
                                <form:option value="추첨제">추첨제</form:option>
                            </form:select>
                        </div>
                    </div>
                </li>
                <li class="table">
                    <p class="cell th">접수기간</p>
                    <div class="cell td">
                        <div class="inp int2">
                            <form:input path="start_period" cssClass="text ui-calendar" readonly="true"/>
                            ~
                            <form:input path="end_period" cssClass="text ui-calendar" readonly="true"/>
                        </div>
                    </div>
                </li>
            </ul>
            <ul>
                <li class="table"><p class="cell th">강좌명</p>
                    <div class="cell td">
                        <div class="inp">
                            <form:input path="search_text" cssClass="text" cssStyle="width: 75%"/>
                        </div>
                    </div>
                </li>
                <li class="table">
                    <div class="cell btn_box">
                        <button class="app_btn app_color1 search" type="button" onclick="goSearch();">검색</button>
                            <%--<button class="app_btn app_color6 reset" type="button" onclick="resetForm();">초기화</button>--%>
                        <a href="#" onclick="myPage()">마이페이지로</a>
                    </div>
                </li>
            </ul>
        </div>
        <!--// 상세검색 -->

        <h4 class="caption">강좌목록(강좌명, 교육기간, 교육시간, 접수기간, 교육장, 모집인원, 접수현황)</h4>
        <p class="total_box">총 <strong class="txt_color4">${paging.totalDataCount}</strong>건이 있습니다. (<strong class="txt_color4">${paging.viewPage}</strong>/${paging.totalPageCount} 페이지)</p>

        <!-- 강좌 리스트 -->
        <div class="lec_list dis_table col1">
            <ul><!--반복 / 1i:10개 = 1page -->
                <c:forEach var="i" varStatus="status" items="${lectureInfoList}">
                    <br>
                    <li class="table">
                        <div class="lecture">

                            <ul class="list">
                                <li>
                                    <p class="tit">강좌이름</p>
                                    <a href="javascript:void(0);" class="lecture_tit" onclick="view('${i.lecture_id}');">${i.lecture_title}</a>
                                </li>
                                <li><p class="tit">교육기간</p>
                                    <span class="con les_no">${i.edu_start_date} ~ ${i.edu_end_date}</span>
                                </li>
                                <li><p class="tit">교육시간</p>
                                    <span class="con les_no">${i.edu_start_time} ~ ${i.edu_end_time}</span>
                                </li>
                                <li><p class="tit">접수기간</p>
                                    <span class="con les_no">${i.request_start_date} ~ ${i.request_end_date}</span>
                                </li>
                                <li><p class="tit">교육장소</p>
                                    <span class="con">
								<span class="txt_color1">${i.edu_school}</span>
								<c:if test="${!empty i.edu_second_school}">
                                    <span class="st2">${i.edu_second_school}</span>
                                </c:if>
							</span>
                                </li>
                                <li><p class="tit">모집인원</p>
                                    <c:if test="${i.request_type eq '선착순'}">
                                    <span class="con les_no"><label class="disnone">현원</label><strong class="txt_color4">${i.online_request_count + i.offline_request_count}</strong>/
									</c:if>
									<label class="disnone">정원</label>${i.online_person_count + i.offline_person_count}</span>
                                </li>
                                <li><p class="tit">접수현황</p>
                                    <span class="con">
							<c:choose>
                                <c:when test="${i.request_type eq '선착순'}">
                                    온라인 <span class="les_no">(<label class="disnone">현원</label><strong class="txt_color4">${i.online_request_count}</strong>/<label class="disnone">정원</label>${i.online_person_count})</span>,
                                    오프라인 <span class="les_no">(<label class="disnone">현원</label><strong class="txt_color4">${i.offline_request_count}</strong>/<label class="disnone">정원</label>${i.offline_person_count})</span>,
                                    대기 <span class="les_no">(<label class="disnone">현원</label><strong class="txt_color4">${i.wait_request_count}</strong>/<label class="disnone">정원</label>${i.wait_person_count})</span>
                                </c:when>
                                <c:when test="${i.request_type eq '추첨제'}">
                                    추첨완료 <span class="les_no">(<label class="disnone">현원</label><strong class="txt_color4">${i.online_request_count}</strong>/<label class="disnone">정원</label>${i.online_person_count})</span>
                                    추첨대기 <span class="les_no">(<label class="disnone">현원</label><strong class="txt_color4">${i.wait_request_count}</strong>/<label class="disnone">정원</label>${i.wait_person_count})</span>
                                </c:when>
                            </c:choose>
							</span>
                                </li>
                                <li><p class="tit">강좌현황</p>
                                    <span class="state_list" style="display: inline-block;">
                                        <c:choose>
                                            <c:when test="${i.lecture_status1 eq '모집예정'}">
                                                <span class="lec_state state1 tit">모집예정</span>
                                            </c:when>
                                            <c:when test="${i.lecture_status1 eq '모집중'}">
                                                <span class="lec_state state4 tit">모집중</span>
                                            </c:when>
                                            <c:when test="${i.lecture_status1 eq '모집마감'}">
                                                <span class="lec_state state4 tit">모집마감</span>
                                            </c:when>
                                            <c:when test="${i.lecture_status1 eq '정원마감'}">
                                                <span class="lec_state state4 tit">정원마감</span>
                                            </c:when>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${i.lecture_status2 eq '교육중'}">
                                                <span class="lec_state state3 tit">교육중</span>
                                            </c:when>
                                            <c:when test="${i.lecture_status2 eq '교육마감'}">
                                                <span class="lec_state state5 tit">교육마감</span>
                                            </c:when>
                                        </c:choose>
                                    </span>
                                </li>
                                <li><p class="tit">신청</p>
                                    <span class="state_list" style="display: inline-block;">
                                        <c:choose>
                                            <c:when test="${i.lecture_status1 eq '모집중'}">
                                                <div class="search" style="margin: 0; padding: 0;">
                                                    <button type="button" onclick="lectureRequest('${i.lecture_id}')"><i class="fa fa-add"></i><span>수강신청</span></button>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="search" style="margin: 0; padding: 0;">
                                                    <button type="button" disabled><span>${i.lecture_status1}</span></button>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <br>
                </c:forEach>
            </ul>
        </div>

        <c:if test="${fn:length(lectureInfoList) < 1}">
            <div>
                등록된 강좌가 없습니다.
            </div>
        </c:if>

        <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
            <jsp:param name="formId" value="#lectureInfo"/>
        </jsp:include>

    </div>

</form:form>