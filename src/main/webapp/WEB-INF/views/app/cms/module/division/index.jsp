<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<html>
<head>
    <title>분류관리</title>
    <style>
        .container { display: flex; gap: 20px; }
        .column { width: 33%; border: 1px solid #ccc; padding: 10px; }
        .selected { background-color: #eef; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 6px; }
        button { margin-left: 4px; }
    </style>
</head>
<body>
<h2>분류 관리</h2>

<div class="container">
    <!-- 대분류 -->
    <div class="column">
        <h3>대분류 정보</h3>
        <button onclick="openRegisterModal(1, null)">신규등록</button>
        <table>
            <tr><th>이름</th><th>기능</th></tr>
            <c:forEach var="item" items="${divisionList}">
                <tr class="depth1-row" data-id="${item.idx}">
                    <td>${item.name}</td>
                    <td>
                        <button onclick="selectDepth1(${item.idx})">선택</button>
                        <button onclick="openEditModal(${item.idx})">수정</button>
                        <button onclick="deleteItem(${item.idx})">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <!-- 중분류 -->
    <div class="column" id="depth2-area">
        <h3>중분류 정보</h3>
        <button onclick="openRegisterModal(2, selectedDepth1)">신규등록</button>
        <table id="depth2-table">
            <tr><th>이름</th><th>기능</th></tr>
        </table>
    </div>

    <!-- 소분류 -->
    <div class="column" id="depth3-area">
        <h3>소분류 정보</h3>
        <button onclick="openRegisterModal(3, selectedDepth2)">신규등록</button>
        <table id="depth3-table">
            <tr><th>이름</th><th>코드</th><th>기능</th></tr>
        </table>
    </div>
</div>

<script>
    let selectedDepth1 = null;
    let selectedDepth2 = null;

    function selectDepth1(idx) {
        selectedDepth1 = idx;
        selectedDepth2 = null;
        $(".depth1-row").removeClass("selected");
        $(`.depth1-row[data-id='${idx}']`).addClass("selected");

        $("#depth2-table").find("tr:gt(0)").remove();
        $("#depth3-table").find("tr:gt(0)").remove();

        $.ajax({
            url: "/cms/module/division/list.do",
            method: "GET",
            data: { depth: 2, parent_idx: idx },
            dataType: "json",
            cache: true, // 캐시 방지용 파라미터 제거
            success: function(data) {
                console.log("data : "+data);

                $.each(data, function(i, item) {
                    console.log("item idx : "+item.idx);
                    console.log("item name : "+item.name);

                    $("#depth2-table").append(
                      '<tr class="depth2-row" data-id="' + item.idx + '">' +
                        '<td>' + item.name + '</td>' +
                        '<td>' +
                          '<button onclick="selectDepth2(' + item.idx + ')">선택</button>' +
                          '<button onclick="openEditModal(' + item.idx + ')">수정</button>' +
                          '<button onclick="deleteItem(' + item.idx + ')">삭제</button>' +
                        '</td>' +
                      '</tr>'
                    );
                });
            }
        });
    }


    function selectDepth2(idx) {
        selectedDepth2 = idx;
        $(".depth2-row").removeClass("selected");
        $(`.depth2-row[data-id='${idx}']`).addClass("selected");

        $("#depth3-table").find("tr:gt(0)").remove();

        $.ajax({
            url: "/cms/module/division/list.do",
            method: "GET",
            data: { depth: 3, parent_idx: idx },
            dataType: "json",
            cache: true,
            success: function(data) {
                $.each(data, function(i, item) {
                    $("#depth3-table").append(
                      '<tr>' +
                        '<td>' + item.name + '</td>' +
                        '<td>' +
                          '<button onclick="openEditModal(' + item.idx + ')">수정</button>' +
                          '<button onclick="deleteItem(' + item.idx + ')">삭제</button>' +
                        '</td>' +
                      '</tr>'
                    );
                });
            }
        });
    }

    function openRegisterModal(depth, parent_idx) {
        alert("신규등록 모달 열기 - depth: " + depth + ", parent_idx: " + parent_idx);
    }

    function openEditModal(idx) {
        alert("수정 모달 열기 - idx: " + idx);
    }

    function deleteItem(idx) {
        if (confirm("정말 삭제하시겠습니까?")) {
            $.ajax({
                url: "/division/delete/" + idx,
                type: "DELETE",
                success: function () {
                    alert("삭제되었습니다.");
                    location.reload();
                }
            });
        }
    }
</script>

</body>
</html>