<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="${getContextPath}/resources/cms/jqTree/css/jqtree.css" rel="stylesheet">
<script src="${getContextPath}/resources/cms/jqTree/js/tree.jquery.js" type="text/javascript"></script>
<script src="${getContextPath}/resources/cms/js/jq_plugin/jquery.cookie.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var beforeSelected_node = '';

        $.ajax({
            url: 'getAdminMenuTreeList.do',
            async: true,
            success: function (data) {
                data = eval(data);
                var source = [];
                var items = [];
                // build hierarchical source.
                for (var i = 0; i < data.length; i++) {
                    var menu = data[i];
                    var parent_menu_id = menu['parent_menu_idx'];
                    var id = menu['menu_idx'];
                    var title = menu['menu_name'];
                    var menu_type = menu['menu_type'];

                    if (items[parent_menu_id]) {
                        var item =
                                {
                                    id: id,
                                    label: title,
                                    menu_type: menu_type
                                };

                        if (!items[parent_menu_id].children) {
                            items[parent_menu_id].children = [];
                        }

                        items[parent_menu_id].children[items[parent_menu_id].children.length] = item;
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

                var $tree = $('#tree1').unbind().tree({
                    data: source,
                    autoOpen: false,
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

                $tree.on('tree.click', function (e) {
                    //열려있는 다이얼로그를 삭제한다.(중복방지)
                    $('.dialog-common').remove();
                    // Disable single selection
                    var selected_node = e.node;
                    if (beforeSelected_node != '') {
                        $tree.tree('removeFromSelection', beforeSelected_node);
                    }

                    $tree.tree('addToSelection', selected_node);
                    beforeSelected_node = selected_node;

                    $('input#menu_idx_1').val(selected_node.id);

                    $('input#homepage_id_1').val($('select#homepage_id_1').val());

                    if (e.node.id != '0') {
                        $('input#editMode_1').val('MODIFY');
                        $('div#editLayer').load('edit.do?' + $('form#form_1').serialize());
                    } else {
                        $('input#editMode_1').val('ADD');
                        $('div#editLayer').load('edit.do?editMode=FIRST');
                    }

                    e.preventDefault();
                });

                <c:if test="${member.admin}">
                    $tree.on('tree.move', function(event) {
                    if(confirm(event.move_info.moved_node.name + ' 을(를)\n\n' + event.move_info.target_node.name + '의 하위메뉴로 이동 하시겠습니까?')) {
                    if(confirm(event.move_info.moved_node.name + ' 의 모든 하위메뉴들도 함께 이동됩니다.\n\n이동 하시겠습니까?')) {
                    $('#move_target_menu_idx_1').val(event.move_info.target_node.id);
                    $('#menu_idx_1').val(event.move_info.moved_node.id);
                    $('#editMode_1').val('parentAdminMenuModify');

                    jQuery.ajaxSettings.traditional = true;

                    var option = {
                    type: 'POST',
                    url: 'save.do',
                    data: $('#form_1').serialize(),
                    success: function(response){
                    if(response.valid) {
                    if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
                    alert(response.message);
                    location.reload();
                }
                } else {
                    for(var i =0 ; i < response.result.length ; i++) {
                    alert(response.result[i].code);
                    $('#'+response.result[i].field).focus();
                    break;
                }
                }
                },
                    error: function(jqXHR, textStatus, errorThrown) {
                    alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
                }
                };

                    $("#form_1").ajaxSubmit(option);

                    <%--
                    console.log('moved_node', event.move_info.moved_node);
                    console.log('target_node', event.move_info.target_node);
                    console.log('position', event.move_info.position);
                    console.log('previous_parent', event.move_info.previous_parent);
                    --%>
                }
                }

                    return false;
                });
                </c:if>
                $('.tree-menu li:last-child').addClass('last');
            }
        });

        <%--메뉴삭제-- % >
        $('a#delete').on('click', function (e) {
            e.preventDefault();
            if (confirm('삭제 하시겠습니까?')) {
                $.ajax({
                    type: 'POST',
                    url: 'save.do',
                    data: 'editMode=DELETE&menu_idx=' + beforeSelected_node.id,
                    success: function (response) {
                        if (response.valid) {
                            if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
                                alert(response.message);
                                location.reload();
                            }

                        } else {
                            for (var i = 0; i < response.result.length; i++) {
                                alert(response.result[i].code);
                                $('#' + response.result[i].field).focus();
                                break;
                            }
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
                    }
                });
            }
        });

        <%--메뉴추가-- % >
        $('a#add').on('click', function (e) {
            var node_id;
            if (beforeSelected_node.id == undefined || beforeSelected_node.id == '') {
                node_id = 0;
            } else {
                node_id = beforeSelected_node.id;
            }
            $('input#parent_menu_idx_1').val(node_id);
            $('input#editMode_1').val('ADD');

            //열려있는 다이얼로그를 삭제한다.(중복방지)
            $('.dialog-common').remove();
            $('div#editLayer').load('edit.do?' + $('#form_1').serialize());
            e.preventDefault();
        });

        <%--처음
        disable
        화면
        처리-- % >
        $('div#editLayer').load('edit.do?editMode=FIRST');
    });
</script>

<form:form id="form_1" modelAttribute="adminMenu" onsubmit="return false;">
    <form:hidden id="parent_menu_idx_1" path="parent_menu_idx"/>
    <form:hidden id="move_target_menu_idx_1" path="move_target_menu_idx"/>
    <form:hidden id="menu_idx_1" path="menu_idx"/>
    <form:hidden id="editMode_1" path="editMode"/>
</form:form>

<div class="container-box">
    <div class="page-header">
        <div>CMS관리자 메뉴</div>
    </div>
    <div class="main-content">
        <div class="tree-area">
            <div class="tree-area-header">
                <div class="tree-area-title">
                    <img alt="" src="/resources/cms/img/main/tag.png">
                    <div>메뉴목록</div>
                </div>
                <div class="tree-action">
                    <c:if test="${member.admin}">
                        <a class="icon-btn navy" href="" id="add">
                            <img alt="" src="/resources/cms/img/main/plus.svg">
                            <div>추가</div>
                        </a>
                        <a class="icon-btn red" href="" id="delete">
                            <img alt="" src="/resources/cms/img/main/delete.svg">
                            <div>삭제</div>
                        </a>
                    </c:if>
                </div>
            </div>
            <div class="tree-menu" id="tree1"></div>
        </div>
        <div class="set-area" id="editLayer"></div>
    </div>
</div>
