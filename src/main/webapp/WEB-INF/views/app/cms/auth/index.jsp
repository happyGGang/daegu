<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${getContextPath}/resources/cms/jqTree/css/jqtree.css">
<script src="${getContextPath}/resources/cms/jqTree/js/tree.jquery.js" type="text/javascript"></script>
<script src="${getContextPath}/resources/cms/js/jq_plugin/jquery.cookie.js" type="text/javascript"></script>
<script type="text/javascript">
    var beforeSelected_node = '';

    function treeOnLoad() {
        $.ajax({
            url: 'getAuthGroupTreeList.do',
            async: true,
            success: function (data) {
                data = eval(data);
                var source = [];
                var items = [];
                // build hierarchical source.
                for (var i = 0; i < data.length; i++) {
                    var code = data[i];
                    var parent_group_id = code['parent_auth_group_id'];
                    var id = code['auth_group_id'];
                    var title = code['auth_group_name'];

                    if (items[parent_group_id]) {
                        var item =
                            {
                                id: id,
                                label: title
                            };

                        if (!items[parent_group_id].children) {
                            items[parent_group_id].children = [];
                        }

                        items[parent_group_id].children[items[parent_group_id].children.length] = item;
                        items[id] = item;
                    } else {
                        items[id] =
                            {
                                id: id,
                                label: title
                            };

                        source[0] = items[id];
                    }
                }

                var $tree = $('#tree1').tree({
                    data: source,
                    autoOpen: true,
                    dragAndDrop: true,
                    onCreateLi: function (node, $li) {
                        // Append a link to the jqtree-element div.
                        // The link has an url '#node-[id]' and a data property 'node-id'.
                        if (node.id != 0) {
                            var menuTreeHTML = '';
                            /* menuTreeHTML += '<a href="#node-'+node.id+'" class="menu_edit" data-node-id="'+node.id +'" style="position: absolute; top:4px; *top:1px;  padding-left:5px; "><img width="42" height="13" src="/resources/cms/jqTree/img/btn_menuEdit.png" alt="메뉴수정하기" /></a>';
                            menuTreeHTML += '<a href="#node-'+node.id+'" class="content_edit" data-node-id="'+node.id +'" style="position: absolute; top:4px; *top:1px;  margin-left:50px; "><img width="50" height="13" src="/resources/cms/jqTree/img/btn_contentEdit.png" alt="콘텐츠수정하기" /></a>'; */
                            $li.find('.jqtree-element').append(menuTreeHTML);
                        }
                    }
                });

                <%-- 왼쪽메뉴 트리 클릭했을 경우 --%>
                $tree.on('tree.click', function (e) {
                    // Disable single selection
                    var selected_node = e.node;

                    if (beforeSelected_node != '') {
                        $tree.tree('removeFromSelection', beforeSelected_node);
                    }
                    $tree.tree('addToSelection', selected_node);

                    beforeSelected_node = selected_node;

                    if (selected_node.id == 'ROOT') {
                        <%-- 처음 disable 화면 처리 --%>
                        $('#authLayer').load('auth.do?editMode=FIRST');
                    } else {
                        $.ajax({
                            url: 'getAuthGroupOne.do?auth_group_id=' + selected_node.id,
                            async: true,
                            success: function (data) {
                                data = eval(data);
                                $('td#auth_group_id_left').html(data.auth_group_id);
                                $('td#auth_group_name_left').html(data.auth_group_name);
                                $('td#remark_left').html(data.remark);

                                $('#authLayer').load('auth.do?editMode=ADD&auth_group_id=' + selected_node.id);
                            }
                        });
                    }

                    e.preventDefault();
                });

                $('.tree-menu li:last-child').addClass('last');
            }
        });
    }

    $(document).ready(function () {

        <%-- 권한그룹 신규등록  --%>
        $('a#editGroup_add').on('click', function (e) {
            //열려있는 다이얼로그를 삭제한다.(중복방지)
            //$('.dialog-common').remove();

            $('#dialog-1').load('editAuthGroup.do?editMode=ADD', function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });
            e.preventDefault();
        });

        <%-- 권한그룹 수정 --%>
        $('a#editGroup_modify').on('click', function (e) {
            if (beforeSelected_node.id == null) {
                alert('수정할 권한그룹을 선택하세요.');
            } else {
                if (beforeSelected_node.id == 'ROOT') {
                    alert('권한그룹 모음은 수정할 수 없습니다.')
                } else {
                    $('#dialog-1').load('editAuthGroup.do?editMode=MODIFY&auth_group_id=' + beforeSelected_node.id, function (response, status, xhr) {
                        $('#dialog-1').dialog('open');
                    });
                }
            }

            e.preventDefault();
        });

        <%-- 권한그룹 삭제 --%>
        $('a#editGroup_delete').on('click', function (e) {
            if (beforeSelected_node.id == null) {
                alert('삭제할 권한그룹을 선택하세요.');
            } else {
                if (beforeSelected_node.id == 'ROOT') {
                    alert('권한그룹 모음은 삭제할 수 없습니다.')
                } else {
                    if (confirm('삭제 하시겠습니까?')) {
                        $.ajax({
                            url: 'saveAuthGroup.do?editMode=DELETE&auth_group_id=' + beforeSelected_node.id,
                            async: true,
                            method: 'POST',
                            success: function (data) {
                                alert(data.message);
                                if (data.valid) {
                                    location.reload();
                                }
                            }
                        });
                    }
                }
            }

            e.preventDefault();
        });


        treeOnLoad();
        <%-- 처음 disable 화면 처리 --%>
        $('#authLayer').load('auth.do?editMode=FIRST');

    });
</script>

<%
    int leftSize = 400; //왼쪽 컨텐츠 사이즈
    int leftSizeInput = leftSize - 125; //왼쪽 컨텐츠 검색 input 사이즈
%>
<div class="group-menu code-config">
    <div class="tree-area" style="width:<%=leftSize%>px">
        <div class="search">
            <form>
                <fieldset>
                    <label class="blind">검색</label>
                    <input type="text" class="text" style="width:<%=leftSizeInput%>px"/>
                    <button><i class="fa fa-search"></i><span>검색</span></button>
                </fieldset>
            </form>
        </div>
        <div class="tree-box" style="height:530px;">
            <div class="tree-menu" id="tree1">
            </div>
        </div>
        <div class="table-wrap">
            <table class="border-all">
                <colgroup>
                    <col width="120"/>
                    <col/>
                    <col width="120"/>
                    <col/>
                    <col width="120"/>
                    <col/>
                </colgroup>
                <thead>
                <tr>
                    <th colspan="2">권한그룹 정보</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th>권한그룹ID</th>
                    <td id="auth_group_id_left">${auth.auth_group_id}</td>
                </tr>
                <tr>
                    <th>권한그룹명</th>
                    <td id="auth_group_name_left">${auth.auth_group_name}</td>
                </tr>
                <tr>
                    <th>설명</th>
                    <td id="remark_left">${auth.remark}</td>
                </tr>
                </tbody>
            </table>
            <c:if test="${member.admin}">
                <div class="button">
                    <a href="" class="btn btn5" id="editGroup_add"><i class="fa fa-plus"></i><span>권한그룹 신규등록</span></a>
                    <a href="" class="btn btn1" id="editGroup_modify"><i class="fa fa-pencil"></i><span>수정</span></a>
                    <a href="" class="btn" id="editGroup_delete"><i class="fa fa-minus"></i><span>삭제</span></a>
                </div>
            </c:if>
        </div>
    </div>
    <div class="set-area" style="margin-right:-<%=leftSize%>px">
        <div style="margin-right:<%=leftSize%>px" id="authLayer">

        </div>
    </div>
</div>

<div id="dialog-1" class="dialog-common" title="권한그룹">
</div>