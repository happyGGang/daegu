<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${getContextPath}/resources/cms/jqTree/css/jqtree.css">
<script src="${getContextPath}/resources/cms/jqTree/js/tree.jquery.js" type="text/javascript"></script>
<script src="${getContextPath}/resources/cms/js/jq_plugin/jquery.cookie.js" type="text/javascript"></script>
<script type="text/javascript">
    var beforeSelected_node = '';
    var source = [];
    var items = [];

    function treeOnLoad() {
        $.ajax({
            url: '/cms/memberGroup/getMemberGroupTreeList.do',
            async: true,
            success: function (data) {
                data = eval(data);


                var sourceIdx = 0;
                // build hierarchical source.
                for (var i = 0; i < data.length; i++) {
                    var code = data[i];
                    var parent_group_id = code['parent_member_group_idx'];
                    var id = code['member_group_idx'];
                    var title = code['member_group_name'];
                    var default_group_yn = code['default_group_yn'];

                    if (items[parent_group_id]) {
                        var item =
                            {
                                id: id,
                                label: title,
                                default_group_yn: default_group_yn
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
                                label: title,
                                default_group_yn: default_group_yn
                            };
                        source[sourceIdx++] = items[id];
                    }
                }

                var $tree = $('#tree1').tree({
                    data: source,
                    autoOpen: true,
                    dragAndDrop: false,
                    onCreateLi: function (node, $li) {
                        // Append a link to the jqtree-element div.
                        // The link has an url '#node-[id]' and a data property 'node-id'.
                        if (node.id != 0) {
                            node.default_group_yn = items[node.id].default_group_yn;
                            var menuTreeHTML = '';
                            /* menuTreeHTML += '<a href="#node-'+node.id+'" class="menu_edit" data-node-id="'+node.id +'" style="position: absolute; top:4px; *top:1px;  padding-left:5px; "><img width="42" height="13" src="/resources/cms/jqTree/img/btn_menuEdit.png" alt="메뉴수정하기" /></a>';
                            menuTreeHTML += '<a href="#node-'+node.id+'" class="content_edit" data-node-id="'+node.id +'" style="position: absolute; top:4px; *top:1px;  margin-left:50px; "><img width="50" height="13" src="/resources/cms/jqTree/img/btn_contentEdit.png" alt="콘텐츠수정하기" /></a>'; */
// 						$li.find('.jqtree-element').append(menuTreeHTML);
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

                    if (selected_node.id == '0') {
                        <%-- 처음 disable 화면 처리 --%>
                        $('#authLayer').load('memberGroupAuth.do?editMode=FIRST');
                    } else {
                        $('#authLayer').load('memberGroupAuth.do?editMode=ADD&member_group_idx=' + selected_node.id);
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
            $('#dialog-1').load('edit.do?editMode=ADD&parent_member_group_idx=' + beforeSelected_node.id, function (response, status, xhr) {
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
                    alert('권한그룹 모음은 수정할 수 없습니다.');
                } else if (beforeSelected_node.default_group_yn == 'Y') {
                    alert('기본그룹은 수정할 수 없습니다.');
                } else {
                    $('#dialog-1').load('edit.do?editMode=MODIFY&member_group_idx=' + beforeSelected_node.id, function (response, status, xhr) {
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
                    alert('권한그룹 모음은 삭제할 수 없습니다.');
                } else if (beforeSelected_node.default_group_yn == 'Y') {
                    alert('기본그룹은 수정할 수 없습니다.');
                } else {
                    if (confirm('삭제 하시겠습니까?')) {
                        $.ajax({
                            url: 'save.do?editMode=DELETE&member_group_idx=' + beforeSelected_node.id,
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
        $('#authLayer').load('memberGroupAuth.do?editMode=FIRST');


        $('#search-btn').on('click', function (e) {
            e.preventDefault();
            var search_text = $('#search_text').val();
            $('.tree-menu span').each(function (i, element) {
                element = $(element);
                if (element.text().indexOf(search_text) != -1) {
                    element.css('background', 'yellow');
                    element[0].scrollIntoView(true);
                } else {
                    element.css('background', 'white');
                }
            });
        });
    });
</script>

<%
    int leftSize = 320; //왼쪽 컨텐츠 사이즈
    int leftSizeInput = leftSize - 125; //왼쪽 컨텐츠 검색 input 사이즈
%>

<div class="container-box">
    <div class="page-header">
        <div>그룹권한 관리</div>
    </div>

    <div class="main-content">
        <div class="tree-area">
            <div class="tree-area-header">
                <div class="tree-area-title">
                    <img alt="" src="/resources/cms/img/main/tag.png">
                    <div>메뉴목록</div>
                </div>
                <form>
                    <fieldset class="search-bar">
                        <input class="custom-search" id="search_text" style="width:-webkit-fill-available" type="text"/>
                        <div class="icon-btn black" id="search-btn">
                            <img alt="" src="/resources/cms/img/main/search.svg">
                            <div>검색</div>
                        </div>
                    </fieldset>
                </form>
            </div>

            <div class="tree-menu" id="tree1"></div>
        </div>
        <div class="set-area">
            <div id="authLayer"></div>
        </div>
    </div>
</div>