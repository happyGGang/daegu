<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<tiles:insertAttribute name="header" />

<link rel="stylesheet" type="text/css" href="/resources/homepage/center/css/sub_design_new.css" />
<link rel="stylesheet" type="text/css" href="/resources/homepage/center/css/center_sub_content.css" />
<link rel="stylesheet" type="text/css" href="/resources/homepage/center/css/sub_design_contents.css" />




<script type="text/javascript">

  $(function () {
    // 1. 스크롤 상단 이동 버튼 클릭 이벤트
    $('#homeup, #homeup-mobile').click(function () {
        $('body,html').animate({ scrollTop: 0 }, 800);
        return false;
    });

    // 2. 메뉴 활성화 처리
    const parentMenu = `li#menu_${menuOne.parent_menu_idx}`;
    const currentMenu = `li#menu_${menuOne.menu_idx}`;

    $(parentMenu).addClass('active');
    $(currentMenu).addClass('active');

    const halbaeNode = $(parentMenu).parent().parent()[0];
    if (halbaeNode && halbaeNode.nodeName === 'LI') {
        $(halbaeNode).addClass('active');
    }

    // 3. 특정 URL에 따른 동작 (현재 주석 처리)
    if (location.href.includes('html.do?')) {
        // $('div#menuRatingDiv').load(`/${homepage.context_path}/module/menuRating/index.do?menu_idx=${param.menu_idx}`);
    }

    // 4. 스크롤 이벤트 처리 (스크롤 시 공유 레이어 숨기기)
    $(window).scroll(function () {
        if ($(this).scrollTop() > 0) {
            $('#share_layer').hide();
        }
    });

    // 5. 모바일 로고 및 메뉴 스타일 설정
    $('h1.mobile-logo a').css('background', "url('/resources/homepage/beomeo/img/beomeo_logo_b.png')");
    $('.m-menu a').css('color', '#000');

    // 6. 공유 버튼 클릭 이벤트 처리
    let isShareOpen = false;

    $('#snsBtn').on('click', function (e) {
        e.preventDefault();

        if (!isShareOpen) {
            $('#share_layer').show(); // 쉐어 박스 열기
            $('#snsBtn img').attr('src', '/resources/homepage/center/img/close_sub.svg'); // 버튼 이미지 변경
			$('#snsBtn').addClass('close_sub');
        } else {
            $('#share_layer').hide(); // 쉐어 박스 닫기
            $('#snsBtn img').attr('src', '/resources/homepage/center/img/share_sns.png'); // 원래 이미지로 복구
			$('#snsBtn').removeClass('close_sub');
        }

        isShareOpen = !isShareOpen; // 상태 변경
    });
});

</script>

<div id="wrap">
  <tiles:insertAttribute name="top" />
  <tiles:insertAttribute name="topMenu" />

    <div id="container" class="subpage">

        <div class="sub-visual">

            <div class="doc-info">
                <div class="doc-title">
                    <c:if test="${menuOne.include_menu_name_yn eq 'Y'}">
                        <h3>${menuOne.menu_name}</h3>
                    </c:if>
                 <div class="shareArea">
                        <ul>
                            <li><a href="#" onclick="contentPrint();"><img src="/resources/homepage/center/img/print.svg" alt="현재페이지 인쇄"></a></li>
                            <li><a href="#" class="shareBtn snsBtn" id="snsBtn"><img src="/resources/homepage/center/img/share_sns.png" alt="sns 바로가기"></a>

                                <div id="share_layer"  style="display:none;">
                                    <div class="shareAllBtns">
                                        <ul class="shareBox">
                                            <li><a href="" class="sub-facebook" keyValue1="${homepage.homepage_id}" keyValue2="${menuOne.menu_idx}" keyValue3="${menuOne.menu_name}" keyValue4="${homepage.homepage_name}"><img src="/resources/homepage/center/img/facebook0.svg" alt="${homepage.homepage_name} 페이스북 바로가기" class="shareIcon" style="padding-left:3px;padding-right:3px;margin:0"></a></li>

                                            <li><a href="" class="sub-twitter" keyValue1="${homepage.homepage_id}" keyValue2="${menuOne.menu_idx}" keyValue3="${menuOne.menu_name}" keyValue4="${homepage.homepage_name}"><img src="/resources/homepage/center/img/twiiter0.svg" alt="${homepage.homepage_name} 트위터로 공유하기" class="shareIcon" style="padding-left:3px;padding-right:3px;margin:0"></a></li>
                                        </ul>
                                    </div>
                                </div>

                            </li>
                           
                        </ul>
                    </div>
                </div>
                <div class="end"></div>
            </div>

        </div>

        <div class="sections">
            <c:if test="${menuOne ne null}">
                <div class="lnb">
                    <h2><b>${menuLeftList[0].menu_name}</b></h2>
                    <homepageTag:leftMenu menuList="${menuLeftList}" />
                </div>
            </c:if>
            <div class="content">
                <div class="sub_location">
                    <ol>
                        <li class="first"><a href="/${homepage.context_path}/index.do"><img src="/resources/homepage/center/img/home_loca.svg"></a></li>
                        <homepageTag:docInfo oneMenu="${menuOne}" menuList="${menuLeftList}" />
                    </ol>
                </div>
                <div class="doc">
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

    <div id="foot_section">
        <tiles:insertAttribute name="footer" />
        
    </div>

</div>
