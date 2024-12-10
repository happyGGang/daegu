<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld" %>
<tiles:insertAttribute name="header"/>

<script type="text/javascript">
$(function() {
    $('li#menu_${menuOne.parent_menu_idx }').addClass('sub_menu_list_item_active');
    $('li#menu_${menuOne.menu_idx}').addClass('sub_menu_list_item_active');
    let node = $('li#menu_${menuOne.parent_menu_idx }').parent().parent()[0];
    if ( node != null && node.nodeName == 'LI' ) {
        $(node).addClass('sub_menu_list_item_active');
        console.log(${menuOne.parent_menu_idx } + 'asdsad' + ${menuOne.menu_idx} + node + '아');
    } else {
        console.log(${menuOne.parent_menu_idx }+ 'saddadas' + ${menuOne.menu_idx} + '음');
    }
});
</script>

<div class="container">
    <div class="sub_header">
        <div class="header_content">
            <div class="sub_menu_title">
                <c:if test="${menuOne ne null}">
                    ${menuLeftList[0].menu_name}
                </c:if>
            </div>
            <div class="page_title">
                <c:if test="${menuOne.include_menu_name_yn eq 'Y'}">
                    ${menuOne.menu_name}
                </c:if>
            </div>
            <div class="sub_menu_action_btn_wrapper">
                <img src="/resources/homepage/center/img/print.svg" alt="" onclick="contentPrint();"/>
                <img class="share" src="/resources/homepage/center/img/share.svg" alt="" />
            <div class="sns">
                <a href="" class="sub-facebook" keyValue1="${homepage.homepage_id}" keyValue2="${menuOne.menu_idx}" keyValue3="${menuOne.menu_name}" keyValue4="${homepage.homepage_name}">
                    <img src="/resources/homepage/center/img/facebook.svg" alt="" />
                </a>
                <a href="" class="sub-twitter" keyValue1="${homepage.homepage_id}" keyValue2="${menuOne.menu_idx}" keyValue3="${menuOne.menu_name}" keyValue4="${homepage.homepage_name}">
                    <img src="/resources/homepage/center/img/twiiter.svg" alt="" />
                </a>
            </div>
            </div>
        </div>
    </div>

    <div class="content_area">
        <homepageTag:leftSubMenu menuList="${menuLeftList}"/>

        <%--<ul class="sub_menu_list_box">
            <li class="sub_menu_list_item"><div>인사말</div></li>
            <li class="sub_menu_list_item sub_menu_list_item_active"><div>연혁</div></li>
            <li class="sub_menu_list_item"><div>조직 및 직원현황</div></li>
            <li class="sub_menu_list_item">
            <div>강습안내</div>
            <img src="/resources/homepage/center/img/sub_menu_drop.svg" alt="" />
            </li>
            <li class="sub_mini_menu_list">
                <div class="sub_mini_menu_list_item">
                    <div></div>
                    <div class="sub_mini_menu_title">수영</div>
                </div>
                <div class="sub_mini_menu_list_item">
                    <div></div>
                    <div class="sub_mini_menu_title">아쿠아로빅</div>
                </div>
                <div class="sub_mini_menu_list_item">
                    <div class="sub_mini_menu_list_item_img_active"></div>
                    <div class="sub_mini_menu_title sub_mini_menu_title_active">GX프로그램</div>
                </div>
            </li>
        </ul>--%>
        <div class="content_wrapper">
            <div class="legend">
                <a href="/${homepage.context_path}/index.do"><img src="/resources/homepage/center/img/home.svg" alt="" /></a>
                <img src="/resources/homepage/center/img/chevron_forward.svg" alt="" />
                <homepageTag:contentWrapper oneMenu="${menuOne}" menuList="${menuLeftList}"/>
            </div>
            <div class="content">
                <tiles:insertAttribute name="body" />
            </div>
        </div>
    </div>
</div>
<tiles:insertAttribute name="footer"/>


