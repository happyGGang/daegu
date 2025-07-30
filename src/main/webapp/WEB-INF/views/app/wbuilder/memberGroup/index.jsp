<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="${getContextPath}/resources/cms/jqTree/css/jqtree.css" rel="stylesheet">

<link href="/resources/cms/css/reset.css" rel="stylesheet" type="text/css"/>
<link href="/resources/cms/css/font.css" rel="stylesheet" type="text/css"/>
<link href="/resources/cms/css/common.css" rel="stylesheet" type="text/css"/>

<script src="${getContextPath}/resources/cms/jqTree/js/tree.jquery.js" type="text/javascript"></script>
<script src="${getContextPath}/resources/cms/js/jq_plugin/jquery.cookie.js" type="text/javascript"></script>
<script type="text/javascript">
    var beforeSelected_node = '';
    var source = [];
    var items = [];
    var treeFolder = [];
    var $tree;
    var selectedTab = 'D';
    function treeOnLoad() {
        $.ajax({
            url: 'getMemberGroupTreeList.do',
            async: true,
            success: function (data) {
                data = eval(data);

                var sourceIdx = 0;
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
                var folderIdx = 0;
                $tree = $('#tree1').tree({
                    data: source,
                    autoOpen: true,
                    dragAndDrop: false,
                    onCreateLi: function (node, $li) {
                        if (node.id != 0) {
                            if (node.isFolder()) {
                                treeFolder[folderIdx++] = node;
                            }
                            node.default_group_yn = items[node.id].default_group_yn;
                            var menuTreeHTML = '';
                        }
                    }
                });

                $tree.on('tree.click', function (e) {
                    var selected_node = e.node;

                    if (beforeSelected_node != '') {
                        $tree.tree('removeFromSelection', beforeSelected_node);
                    }
                    $tree.tree('addToSelection', selected_node);

                    beforeSelected_node = selected_node;

                    if (selected_node.id == '0') {
                        $('#authLayer').load('memberGroup_ajax.do?editMode=FIRST');
                    } else {
                        $('#authLayer').load('memberGroup_ajax.do?editMode=ADD&member_group_idx=' + selected_node.id);
                    }
                    e.preventDefault();
                });

                $('.tree-menu li:last-child').addClass('last');
            }
        });
    }

    $(document).ready(function () {
        treeOnLoad();

        $('#authLayer').load('memberGroup_ajax.do?editMode=FIRST');

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

<div class="container-box">
    <div class="page-header">
        <div>그룹 관리</div>
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
        <div class="set-area" id="editLayer">
            <div id="authLayer"></div>
        </div>
    </div>
</div>