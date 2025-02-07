<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
  $(function () {
    $('#list_btn').on('click', function (e) {
      e.preventDefault();
      history.back();
    });
  });
</script>
<style type="text/css">
  table.type2 th, table.type2 td {
    padding: 10px 15px;
  }

  table.type2 tbody tr td dl dt {
    display: inline-block;
    border-right: 1px solid silver;
    padding-right: 5px;
    margin-right: 5px;
  }

  table.type2 tbody tr td dl dd {
    display: inline-block;
    margin-right: 15px;
  }
</style>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>
<form:form modelAttribute="thinkPocketPackage" action="index.do" method="GET">
    <form:hidden path="menu_idx"/>
    <form:hidden path="viewPage"/>
    <form:hidden path="editMode"/>
    <form:hidden path="think_pocket_package_idx"/>
    <div>
        <table class="type2">
            <thead>
            <tr>
                <th style="font-size:18px;">${thinkPocketPackage.think_pocket_package_subject}</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    <dl>
                        <dt>작가</dt>
                        <dd>${thinkPocketPackage.author}</dd>
                        <dt>출판사</dt>
                        <dd>${thinkPocketPackage.publisher}</dd>
                        <dt>출판년도</dt>
                        <dd>${thinkPocketPackage.publish_year}</dd>
                    </dl>
                </td>
            </tr>
            <tr>
                <td>
                    <dl>
                        <dt>ISBN</dt>
                        <dd>${thinkPocketPackage.isbn}</dd>
                        <dt>대출가능권수</dt>
                        <dd>${thinkPocketPackage.loan_count}권</dd>
                    </dl>
                </td>
            </tr>
            <tr>
                <td>
                    <dl>
                        <dt>수준법</dt>
                        <dd>
                            <c:choose>
                                <c:when test="${thinkPocketPackage.grade eq '1'}">유아</c:when>
                                <c:when test="${thinkPocketPackage.grade eq '2'}">초등</c:when>
                            </c:choose>
                        </dd>
                    </dl>
                </td>
            </tr>
            <tr>
                <td>
                    <c:choose>
                        <c:when test="${not empty thinkPocketPackage.image_link}">
                            <a href="${i.desc_link}" target="_blank">
                                <img src="${thinkPocketPackage.image_link}" alt="${thinkPocketPackage.think_pocket_package_subject}">
                            </a>
                        </c:when>
                        <c:when test="${not empty thinkPocketPackage.server_file_name}">
                            <a href="#">
                                <img src="${getContextPath}/data/thinkPocketPackage/${thinkPocketPackage.server_file_name}" alt="${thinkPocketPackage.think_pocket_package_subject}" style="max-width: 500px;margin: 0 auto;">
                            </a>
                        </c:when>
                    </c:choose>
                    <br>
                        ${thinkPocketPackage.content}
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</form:form>
<div class="button bbs-btn center">
    <a href="" class="btn btn1 list" id="list_btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
</div>