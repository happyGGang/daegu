<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<tiles:insertAttribute name="header" />
<script type="text/javascript">
$(function() {
	$('li#menu_${menuOne.parent_menu_idx }').addClass('active');
	$('li#menu_${menuOne.menu_idx}').addClass('active');
	var halbaeNode = $('li#menu_${menuOne.parent_menu_idx }').parent().parent()[0];
	if ( halbaeNode != null && halbaeNode.nodeName == 'LI' ) {
		$(halbaeNode).addClass('active');
	}

	if (location.href.indexOf('html.do?') > -1) {
// 		$('div#menuRatingDiv').load('/${homepage.context_path}/module/menuRating/index.do?menu_idx=${param.menu_idx}');
	}

	<c:choose>
		<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
			$('li#menu_4').remove();
			$('li#menu_5').remove();
			$('li#menu_6').remove();
			$('li#menu_7').remove();
			$('li#menu_8').remove();
		</c:when>
		<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
			$('li#menu_4').remove();
			$('li#menu_5').remove();
			$('li#menu_6').remove();
			$('li#menu_7').remove();
			$('li#menu_8').remove();
		</c:when>
		<c:otherwise>
			$('li#menu_95').remove();
			$('li#menu_96').remove();
		</c:otherwise>
	</c:choose>
});
</script>

<script>
function link()
{
    document.form1.action = "https://www.nl.go.kr/NL/contents/N30502000000.do";
	document.form1.lib_name.value = "대구2.28기념학생도서관";
    document.form1.lib_id.value = "122001";
    document.form1.target="mashup";
    document.form1.submit();
}
</script>

<form name="form1" method="post">
<input type=hidden name='lib_name'>
<input type=hidden name='lib_id'>
</form>

<div id="wrap">

	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	<div id="container" class="subpage">
		<div class="sub-visual" >
			<div class="doc-info-bg">
				<div class="doc-info">
					<ol>
						<li class="first"><a href="/${homepage.context_path}/index.do"><i class="fa fa-home"></i></a></li>
						<homepageTag:docInfo oneMenu="${menuOne}" menuList="${menuLeftList}"/>
					</ol>
					<jsp:include page="/WEB-INF/views/app/homepage/common/snsShareBox.jsp" flush="false" />
					<div class="end"></div>
				</div>
			</div>
		</div>

		<div class="section">
			<c:if test="${menuOne ne null}">
			<div class="lnb">
				<c:choose>
					<c:when test="${menuLeftList[0].menu_idx eq '110'}">
				<h2>
					<b>
						학교도서관<br/>집중지원센터
					</b>
				</h2>
					</c:when>
					<c:otherwise>
				<h2>
					<b>
						${menuLeftList[0].menu_name}
					</b>
				</h2>
					</c:otherwise>
				</c:choose>
				<homepageTag:leftMenu menuList="${menuLeftList}"/>
			</div>
			</c:if>
			<div class="content">
				<div class="doc">
					<div class="doc-head">
						<div class="doc-title">
							<h3>${menuOne.menu_name}</h3>
							<!-- <div class="v-img" <c:if test="${not empty menuOne.menu_img}">style="background: url('/data/menu/${menuOne.homepage_id}/${menuOne.menu_img}') no-repeat 100% 0"</c:if>></div> -->
							<c:if test="${param.menu_idx eq '138' || param.menu_idx eq '238' || param.menu_idx eq '144' || param.menu_idx eq '145' || param.menu_idx eq '152'}">
								<!-- <div style="box-sizing:border-box;padding:3px 7px;border:1px solid #ccc;border:-radius:7px;position:absolute;right:0;top:2px;font-size:12px;">2023년 회계연도 업무 처리기한(마감)에 따라<br/>2023.12.8.(금)까지 대출반납배송요청된 건에<br/>한해서 배송가능합니다. <a href="/228/board/view.do?menu_idx=136&manage_idx=210&board_idx=505401&viewPage=1&category1" class="btn btn4" style="padding:1px 7px;">자세히보기</a></div> -->
							</c:if>
						</div>
					</div>
					<div class="doc-body con${menuOne.menu_idx}" id="contentArea">
						<div class="body">
							<tiles:insertAttribute name="body" />
							<div id="menuRatingDiv"></div>
						</div>
					</div>
					<c:if test="${not empty menuOne.manager_dept and not empty menuOne.manager_name and not empty menuOne.manager_phone}">
					<div class="doc-admin">
						<c:if test="${menuOne.manager_dept ne null and menuOne.manager_dept ne ''}"><span><label>담당부서</label> <em>: ${menuOne.manager_dept}</em></span></c:if>
						<c:if test="${menuOne.manager_name ne null and menuOne.manager_name ne ''}"><span><label>담당자</label> <em>: ${menuOne.manager_name}</em></span></c:if>
						<c:if test="${menuOne.manager_phone ne null and menuOne.manager_phone ne ''}"><span><label>전화번호</label> <em>: ${menuOne.manager_phone}</em></span></c:if>
					</div>
					</c:if>
				</div>
			</div>
		</div>

		<div class="end"></div>
	</div>

</div>

<tiles:insertAttribute name="footer" />
