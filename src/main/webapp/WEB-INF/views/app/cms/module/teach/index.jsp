<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#teachListForm').submit();

		e.preventDefault();
	});

	$('a#dialog-add').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
		}
		else {
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val() + '&group_idx=' + $('select#group_idx').val() + '&category_idx=' + $('select#category_idx').val() , function( response, status, xhr ) {
				$('#dialog-1').dialog('open')
			});
		}

		e.preventDefault();
	});

	$('a.certificate-btn').on('click', function(e) {
		$('#dialog-2').load('getTeachCertificateList.do?homepage_id=' + $('#homepage_id_1').val() + '&group_idx=' + $(this).attr('keyValue1') + '&category_idx=' + $(this).attr('keyValue2') + '&teach_idx=' + $(this).attr('keyValue3'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open')
		});

		e.preventDefault();
	});

	$('a#dialog-search-cert').on('click', function(e) {
		$('#dialog-3').load('getTeachCertificateListByDate.do?editMode=FIRST&homepage_id=' + $('#homepage_id_1').val(), function( response, status, xhr ) {
			$('#dialog-3').dialog('open')
		});

		e.preventDefault();
	});

	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id_1').val() + '&group_idx=' + $(this).attr('keyValue1') + '&category_idx=' + $(this).attr('keyValue2') + '&teach_idx=' + $(this).attr('keyValue3'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a.delete-btn').on('click', function(e) {
		var msg = $(this).data('attend_cnt') ? '해당 강의를 삭제 하시겠습니까?' : '수강생이 있는 강좌입니다. 그래도 삭제하시겠습니까?';
		if (confirm(msg)) {
			$('#hiddenForm #group_idx').val($(this).attr('keyValue1'));
			$('#hiddenForm #category_idx').val($(this).attr('keyValue2'));
			$('#hiddenForm #teach_idx').val($(this).attr('keyValue3'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});

	$('a#dialog-setting').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
		} else {
			$('#dialog-4').load('setting.do?homepage_id=' + $('#homepage_id_1').val() , function( response, status, xhr ) {
				$('#dialog-4').dialog('open');
			});
		}

		e.preventDefault();
	});

	$('a#excelDownload').on('click', function(e) {
		$('#hiddenForm').attr('action', 'excelDownload.do').submit();
		$('#hiddenForm').attr('action', 'save.do');
		e.preventDefault();
	});

	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			// $('input#homepage_id_1').val($(this).val());
			$('#teachListForm').submit();
		}

		e.preventDefault();
	});

	$('select#large_category_idx').on('change', function() {
		$('#teachListForm select#group_idx option.all').prop('selected', true);
		$('#teachListForm select#category_idx option.all').prop('selected', true);
		$('#teachListForm option.default').prop('selected', true);
		$('#teachListForm #search_text').val('');
		$('#teachListForm #viewPage').val(1);
		$('#teachListForm').submit();
	});

	$('select#group_idx').on('change', function() {
		$('#teachListForm select#category_idx option.all').prop('selected', true);
		$('#teachListForm option.default').prop('selected', true);
		$('#teachListForm #search_text').val('');
		$('#teachListForm #viewPage').val(1);
		$('#teachListForm').submit();
	});

	$('select#category_idx').on('change', function() {
		$('#teachListForm option.default').prop('selected', true);
		$('#teachListForm #search_text').val('');
		$('#teachListForm #viewPage').val(1);
		$('#teachListForm').submit();
	});

	$('#teachListForm select#category_idx option').hide();
	$('#teachListForm select#category_idx option.group_${teach.group_idx}').show();
	$('#teachListForm select#category_idx option.all').show();

	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		$('#hiddenForm').attr('action', 'csvDownload.do').submit();
	});
	
	$('input#checkAll').on('click', function(e) {
		$('input[type = checkbox].teach_idx_arr').prop('checked', $(this).is(':checked'));
	});
	
	$('a#dialog-delete').on('click', function(e) {
		if($('input:checkbox[name = teach_idx_arr]:checked').length < 1) {
			alert('삭제할 강좌를 선택해 주세요.');
			return false;
		}
		
		if (confirm("선택한 강의 삭제 시 강의를 신청한 사용자도 함께 삭제됩니다. 정말 삭제하시겠습니까?")) {
			var checkboxarr = $('input:checkbox[name = teach_idx_arr]:checked');
			var group_idx_arr = new Array();
			var category_idx_arr = new Array();
			var teach_idx_arr = new Array();
			
			checkboxarr.each(function(i) {
				group_idx_arr.push($(this).siblings('input[name = group_idx_1]').val());
				category_idx_arr.push($(this).siblings('input[name = category_idx_1]').val());
				teach_idx_arr.push($(this).val());
			});
			
			$('input#group_idx_arr').val(group_idx_arr);
			$('input#category_idx_arr').val(category_idx_arr);
			$('input#teach_idx_arr').val(teach_idx_arr);
			
			if(doAjaxPost($('#hiddenForm2'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});
	
	$('select#teach_status').on('change', function(e) {
		$('#viewPage').val(1);
		$('#teachListForm').submit();
		
		e.preventDefault();
	});
	
	$('a#dialog-load').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
		} else {
			$('#dialog-5').load('/cms/module/teach/searchTeach.do?homepage_id=' + $('#homepage_id_1').val(), function( response, status, xhr ) {
				$('#dialog-5').dialog('open');
			});
		}
		
		e.preventDefault();
	});

	$('a#dialog-sort').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
		}
		else {
			$('#dialog-6').load('/cms/module/teach/teachSort/index.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val(), function( response, status, xhr ) {
				$('#dialog-6').dialog('open')
			});
		}

		e.preventDefault();
	});


});
</script>
<div class="container-box">
    <div class="page-header">
        <div>강좌관리</div>
    </div>
    <div class="main-content">
    <form:form id="hiddenForm" modelAttribute="teach" action="save.do">
        <form:hidden path="editMode" value="DELETE"/>
        <form:hidden path="homepage_id"/>
        <form:hidden path="group_idx"/>
        <form:hidden path="category_idx"/>
        <form:hidden path="teach_idx"/>
    </form:form>

    <form:form id="hiddenForm2" modelAttribute="teach" action="save.do">
        <form:hidden path="editMode" id="editMode_2" value="DELETESELECT"/>
        <form:hidden path="homepage_id" id="homepage_id_2"/>
        <form:hidden path="group_idx_arr"/>
        <form:hidden path="category_idx_arr"/>
        <form:hidden path="teach_idx_arr"/>
    </form:form>

    <form:form id="teachListForm"  modelAttribute="teach" action="index.do" style="width: 100%">

        <div class="infodesk">
            <c:choose>
                <c:when test="${fn:length(subHomepageList) > 0 and asideHomepageId ne 'h50' and asideHomepageId ne 'h51' and asideHomepageId ne 'h37'}">
                    도서관 : <form:select id="homepage_id_1" path="homepage_id" items="${subHomepageList}" itemLabel="homepage_name" itemValue="homepage_id"></form:select>
                </c:when>

                <c:when test="${asideHomepageId eq 'h50'}">
                    도서관 :
                    <form:select id="homepage_id_1" path="homepage_id">
                        <form:option value="h50">범어</form:option>
                        <form:option value="h54">책숲길</form:option>
                        <form:option value="h55">물망이</form:option>
                        <form:option value="h93">황금책</form:option>
                    </form:select>
                </c:when>


                <c:when test="${asideHomepageId eq 'h51'}">
                    도서관 :
                    <form:select id="homepage_id_1" path="homepage_id">
                        <form:option value="h51">용학</form:option>
                        <form:option value="h56">파동</form:option>
                        <form:option value="h57">무학숲</form:option>
                        <form:option value="h98">그림책</form:option>
                    </form:select>
                </c:when>



                <c:when test="${asideHomepageId eq 'h37'}">
                    도서관 :
                    <form:select id="homepage_id_1" path="homepage_id">
                        <form:option value="h72">도원</form:option>
                        <form:option value="h67">성서</form:option>
                        <form:option value="h68">본리</form:option>
                        <form:option value="h69">달서가족문화</form:option>
                        <form:option value="h66">달서어린이</form:option>
                        <form:option value="h70">달서영어</form:option>
                        <form:option value="h41">독서문화진흥</form:option>
                    </form:select>
                </c:when>

                <c:otherwise>
                    <form:hidden id="homepage_id_1" path="homepage_id"/>
                </c:otherwise>
            </c:choose>

            <div class="table-action-wrapper">
                <div class="btn-wrapper">
                <p class="total-count" style="margin-right: 32px">총 ${teachListCount}건</p>
                <span class="filter-gap">대분류
                    <form:select path="large_category_idx" class="custom-filter">
                        <form:option class="all" value="0" label="전체" />
                        <form:options itemValue="teach_code" itemLabel="code_name" items="${teachLargeCategoryList}"/>
                    </form:select>
                </span>
                <span class="filter-gap">중분류
                    <form:select path="group_idx" class="custom-filter">
                        <form:option class="all" value="0" label="전체" />
                        <form:options itemValue="group_idx" itemLabel="group_name" items="${categoryGroupList}"/>
                    </form:select>
                </span>
                <span class="filter-gap">소분류
                    <form:select path="category_idx" class="custom-filter">
                        <form:option class="all" value="0" label="전체" />
                        <c:forEach items="${categoryList}" var="i">
                                <form:option class="group_${i.group_idx}" value="${i.category_idx}" hidden="hidden">${i.category_name}</form:option>
                            </c:forEach>
                    </form:select>
                </span>
<!--                접수상태-->
<!--                <form:select path="teach_status" class="custom-filter">-->
<!--                    <form:option value="" label="전체"/>-->
<!--                    <form:option value="0,1" label="접수중"/>-->
<!--                    <form:option value="6" label="접수대기"/>-->
<!--                    <form:option value="4,5,9" label="접수마감"/>-->
<!--                </form:select>-->
                </div>
                <div>
                    <c:if test="${authD}">
                        <a href="" class="icon-btn red" id="dialog-delete" >
                            <img src="/resources/cms/img/main/minus.svg" alt="">
                            <div>선택 삭제</div>
                        </a>
                    </c:if>
                    <c:if test="${authC}">
                        <a href="" class="icon-btn navy" id="dialog-add" >
                            <img src="/resources/cms/img/main/plus.svg" alt="">
                            <div>등록</div>
                        </a>
                        <a href="" class="icon-btn black" id="dialog-sort" >
                            <img src="/resources/cms/img/main/plus.svg" alt="">
                            <div>정렬설정</div>
                        </a>
                        <a href="" class="icon-btn black" id="dialog-load" >
                            <img src="/resources/cms/img/main/plus.svg" alt="">
                            <div>강좌불러오기</div>
                        </a>
                        <a href="" class="icon-btn black" id="dialog-search-cert" >
                            <img src="/resources/cms/img/main/plus.svg" alt="">
                            <div>기간별 수료자 조회</div>
                        </a>
                        <!-- <a href="#" class="btn btn4 left" id="dialog-setting"><i class="fa fa-plus"></i><span>설정</span></a> -->
                    </c:if>
                </div>
            </div>
        </div>
        <!-- 교육소식 관리 table -->
        <table class="custom-table">
            <thead>
                <tr>
                    <th><input type="checkbox" id="checkAll"></th>
                    <th>번호</th>
                    <th>상단노출여부</th>
                    <th>강의분류</th>
                    <th>해시태그</th>
                    <th>강의명</th>
                    <th>강의계획서</th>
                    <th>강의대상</th>
                    <th>강좌일</th>
                    <th>강좌시간</th>
                    <th>강의장소</th>
                    <th>참여/모집</th>
                    <th>참여/후보</th>
                    <th>참여/오프</th>
                    <th>기능</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="i" varStatus="status" items="${teachList}">
                    <tr>
                        <td>
                            <input type="hidden" name="group_idx_1" value="${i.group_idx}"/>
                            <input type="hidden" name="category_idx_1" value="${i.category_idx}"/>
                            <form:checkbox path="teach_idx_arr" value="${i.teach_idx}" class="teach_idx_arr"/>
                        </td>
                        <td>${teach.listRowNum - status.index}</td>
                        <td>${i.teach_code_yn}</td>
                        <td>${i.large_category_name}<br/>${i.group_name}<br/>${i.category_name}</td>
                        <td>${i.hashtag_names}</td>
                        <td>
                            ${i.teach_name}
                        </td>
                        <td><c:if test="${i.server_file_name ne null and i.server_file_name ne ''}"><a href="/cms/module/teach/download/${i.homepage_id}/${i.group_idx}/${i.category_idx}/${i.teach_idx}.do"><i class="fa fa-floppy-o"></i>${i.org_file_name}</a></c:if></td>
                        <td>${i.teach_target}</td>
                        <td>
                            ${i.start_date} ~ ${i.end_date}<br/>
                            (
                            <c:choose>
                                <c:when test="${i.teach_day_yn eq 'Y'}">${i.teach_day_txt}</c:when>
                                <c:otherwise>
                                매주&nbsp;
                                <c:forEach var="j" varStatus="status_j" items="${i.teach_day_arr}">
                                    <c:choose>
                                        <c:when test="${j eq '1'}">일</c:when>
                                        <c:when test="${j eq '2'}">월</c:when>
                                        <c:when test="${j eq '3'}">화</c:when>
                                        <c:when test="${j eq '4'}">수</c:when>
                                        <c:when test="${j eq '5'}">목</c:when>
                                        <c:when test="${j eq '6'}">금</c:when>
                                        <c:when test="${j eq '7'}">토</c:when>
                                    </c:choose>
                                    <c:if test="${!status_j.last}">
                                        ,
                                    </c:if>
                                </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            )
                        </td>
                        <td>${i.start_time} ~ ${i.end_time}</td>
                        <td>${i.teach_stage}</td>
                        <td>${i.teach_join_count} / ${i.teach_limit_count}</td>
                        <td>${i.teach_backup_join_count} / ${i.teach_backup_count}</td>
                        <td>${i.teach_off_join_count} / ${i.teach_offline_count}</td>
                        <td>
                            <c:if test="${authU}">
                                <a href="" class="btn dialog-modify" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}">수정</a>
                            </c:if>
                            <c:set value="false" var="attend_cnt"/>
                            <c:if test="${authD}">
                                <c:if test="${i.teach_join_count eq 0 and i.teach_backup_join_count eq 0 and i.teach_off_join_count eq 0}">
                                <c:set value="true" var="attend_cnt"/>
                                </c:if>
                                <a href="" class="btn delete-btn" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}" data-attend_cnt="${attend_cnt}">삭제</a>
                            </c:if>
                            <a href="" class="btn btn1 certificate-btn" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}">수료자 조회</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${teachListCount eq 0}">
                    <tr>
                        <td colspan="13">데이터가 존재하지 않습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
            <jsp:param name="formId" value="#teachListForm"/>
        </jsp:include>
        <div class="table-search-bar">
            <fieldset class="search-bar">
                <form:select path="search_type" cssClass="custom-filter">
                    <form:option class="default" value="">선택</form:option>
                    <form:option value="a.TEACH_NAME">강의명</form:option>
                    <form:option value="a.TEACH_TARGET">강의대상</form:option>
                    <form:option value="a.TEACH_STAGE">강의장소</form:option>
                </form:select>
                <form:input path="search_text" cssClass="custom-search"/>
                <div id="search_btn" class="icon-btn black">
                    <img alt="" src="/resources/cms/img/main/search.svg">
                    <div>검색</div>
                </div>
                <a href="#" id="excelDownload" class="icon-btn green">
                    <img src="/resources/cms/img/main/excel.svg" alt="">
                    <div>엑셀저장</div>
                </a>
                <a href="#" id="csvDownload" class="icon-btn green">
                    <img src="/resources/cms/img/main/csv.svg" alt="">
                    <div>CSV저장</div>
                </a>
            </fieldset>
        </div>

        <br/>
        <div class="ui-state-highlight guide-line">
            <em>강좌 삭제는 해당 강좌에 참여/후보/오프 신청 인원이 없는 강좌만 가능 합니다.</em>
        </div>
    </form:form>

    </div>
</div>
<div id="dialog-1" class="dialog-common" title="강좌 정보"></div>
<div id="dialog-2" class="dialog-common" title="수료자 조회"></div>
<div id="dialog-3" class="dialog-common" title="기간별 수료자 조회"></div>
<div id="dialog-4" class="dialog-common" title="1인당 강좌수 설정"></div>
<div id="dialog-5" class="dialog-common" title="강좌 검색"></div>
<div id="dialog-6" class="dialog-common" title="강좌 정렬 설정"></div>
<div id="dialog-7" class="dialog-common" title="강좌 정렬기준 추가"></div>
