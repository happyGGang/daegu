
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<link rel="stylesheet" href="/resources/common/css/search/jqcloud.css" type="text/css">
<script type="text/javascript" src="/resources/common/js/jqcloud.js"></script>
<script type="text/javascript">
</script>

<!-- contents-title-->
<div id="contents-title">
	<h2>도서의 상세 내용<span style="font-weight:300">을 확인하세요</span></h2>
</div>
<!-- /contents-title-->
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="search-wrap">
	<div class="sview">
		<div class="sinfo">
			<div class="thumb">
				<c:choose>
					<c:when test="${(empty detail.aladin or empty detail.aladin.cover) and empty detail.imageUrl}">
				<p class="noImg">
					<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="noImage"/>
				</p>
					</c:when>
					<c:when test="${not empty detail.aladin or not empty detail.aladin.cover}">
						<img src="${detail.aladin.cover}" alt="${detail.TITLE_INFO}">
					</c:when>
					<c:otherwise>
				<p>
					<img src="${detail.imageUrl}" alt="${detail.TITLE_INFO}">
				</p>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="info">
				<ul>
					<li style="line-height: 150%;font-size:20px;"><b>${detail.TITLE_INFO}</b></li>
					<li><strong>저자사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.AUTHOR}</li>
					<li><strong>발행사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.PUBLISHER}, ${detail.PUB_YEAR},  ${detail.MEDIA_NAME}, \ ${detail.PRICE}</li>
					<li><strong>형태사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.PAGE} : ${detail.BOOK_SIZE}</li>
					<c:if test="${detail.MEDIA_CODE eq 'PR' || detail.MEDIA_CODE eq 'EB'}">
					<li><strong>표준부호</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ISBN : ${detail.ISBN}</li>
					</c:if>
					<li><strong>분류기호</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;한국십진분류법 : ${detail.CLASS_NO}</li>
					<c:if test="${not empty detail.APPENDIX_INFO}">
					<c:if test="${detail.APPENDIX_LIST[0].LOAN_CODE eq 'OK'}">
					<li><strong>부록여부</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.APPENDIX_INFO[0].DESCRIPTION} (${detail.APPENDIX_INFO[0].APPENDIX_CNT}개)</li>
					</c:if>
					</c:if>
					<c:if test="${homepage.context_path eq 'dalseolib' || homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj'}">
					<li><strong>영어독서 레벨</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.marc}</li>
					</c:if>
					<c:if test="${detail.MANAGE_CODE eq 'NA' || detail.MANAGE_CODE eq 'NB' || detail.MANAGE_CODE eq 'NE' || detail.MANAGE_CODE eq 'NJ'}">
					<p><font style="color:#f31d1d;font-weight:bold;">★ 해당 도서는 도서관 사정에 따른 유료회원제 자료입니다.</font></p>
					</c:if>
				</ul>
			</div>
		</div>
		<c:if test="${detail.SHELF_LOC_CODE eq 'AD36'}">
			* 소장위치가 대구전자도서관인 경우, 실시간 대출가능 확인이 어렵습니다. 정확한 대출가능여부 확인은 대구전자도서관에 접속 대출가능 확인이 가능합니다.
		</c:if>
		<div class="bookDetailInfo">
			<table class="bookDetailInfoTbl">
			<caption>도서 상태 및 등록 정보</caption>
			<colgroup>
				<col width="20%">
				<col width="15%">
				<col width="20%">
				<col width="15%">
				<c:if test="${detail.SHELF_LOC_CODE ne 'AD36'}">
				<col width="20%">
				</c:if>
			</colgroup>
			<thead>
			<tr>
				<th>청구기호</th>
				<th>등록번호</th>
				<th>자료실</th>
				<th>반납예정일</th>
				<c:if test="${detail.SHELF_LOC_CODE ne 'AD36'}">
				<th>대출상태</th>
				</c:if>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td>${detail.CALL_NO}</td>
				<td>${detail.REG_NO}</td>
				<td>${detail.SHELF_LOC_NAME}</td>
				<td>${detail.RETURN_PLAN_DATE}</td>
				<c:if test="${detail.SHELF_LOC_CODE ne 'AD36'}">
				<td>

					<!-- 대출가능 여부 [START] -->
					<c:choose>
						<c:when test="${homepage.context_path eq 'yonghak' and droneLoanYn eq 'Y'}">
							<span style="color:#ff0000">대출불가(드론대출중)</span>
						</c:when>
						<c:when test="${detail.MANAGE_CODE eq 'HM' || detail.MANAGE_CODE eq 'HQ'}">
							<span style="color:#ff0000">대출불가(임시휴관)</span>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${detail.LOAN_CODE eq 'OK' and detail.MEDIA_NAME eq 'DVD' and detail.MANAGE_CODE eq 'BR'}">
									관내대출가능
								</c:when>
								<c:when test="${detail.LOAN_CODE eq 'OK'}">
									대출가능
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${detail.WORKING_STATUS == 'BOL211O'}">
											<c:choose>
												<c:when test="${detail.MEDIA_NAME eq 'DVD' and detail.MANAGE_CODE eq 'BR'}">
													<span style="color:#ff0000">대출불가(관내대출중)</span>
												</c:when>
												<c:otherwise>
													<span style="color:#ff0000">대출불가(관외대출중)</span>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${detail.WORKING_STATUS == 'BOL213O'}">
											<c:choose>
												<c:when test="${detail.MEDIA_NAME eq 'DVD' and detail.MANAGE_CODE eq 'BR'}">
													<span style="color:#ff0000">대출불가(관내대출중)</span>
												</c:when>
												<c:otherwise>
													<span style="color:#ff0000">대출불가(관외대출중)</span>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${detail.WORKING_STATUS == 'BOL212O'}">
											<span style="color:#ff0000">대출불가(관내대출중)</span>
										</c:when>
										<c:when test="${detail.WORKING_STATUS == 'BOL511O'}">
											<span style="color:#ff0000">대출불가(타관반납중)</span>
										</c:when>
										<c:when test="${detail.WORKING_STATUS == 'BOL611O'}">
											<span style="color:#ff0000">대출불가(타관대출중)</span>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${detail.RESERVATION_CNT > 0}">
													<span style="color:#ff0000">대출불가(예약대출 대기중)</span>
												</c:when>
												<c:otherwise>
													<span style="color:#ff0000">대출불가</span>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					<!-- 대출가능 여부 [ END ] -->
				</td>
				</c:if>
			</tr>
			</tbody>
			</table>
		</div>
		<p></p>
		<div class="sbtn" style="text-align:center;">
			<a href="javascript:history.back();" id="goBack" class="btn"><i class="fa fa-book"></i><span>목록으로</span></a>
		</div>
	</div>
</div>