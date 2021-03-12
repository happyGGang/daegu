<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.mmenu.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/login.css"/>
<link rel="stylesheet" type="text/css" href="/resources/board/css/default.css"/>
<link rel="stylesheet" href="${getContextPath}/resources/cms/jqTree/css/jqtree.css">
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/default.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script src="${getContextPath}/resources/cms/jqTree/js/tree.jquery.js" type="text/javascript"></script>
<script src="${getContextPath}/resources/cms/js/jq_plugin/jquery.cookie.js" type="text/javascript"></script>
<script type="text/javascript">
var beforeSelected_node = '';

function treeOnLoad() {
	$.ajax({
		url : 'getMyStorageTreeList.do?homepage_id=${homepage.homepage_id}&member_key=${member.seq_no}',
		async : true ,
		success : function(data) {
			data = eval(data);
			if (data.length == 1) {
				if ('${member.loginType}' != 'HOMEPAGE') {
					alert('보관함은 회원만 이용 가능합니다.');
					window.close();
					return false;
				}
				if (confirm('생성된 보관함이 없습니다. 보관함 페이지로 이동합니다.')) {
					opener.location.href='goMyStorage.do';
					window.close();
				} else {
					window.close();
				}
			}
			var source = [];
	        var items = [];
	        // build hierarchical source.
	        for (var i = 0; i < data.length; i++) {
	            var code = data[i];
	            var parent_storage_idx = code['parent_storage_idx'];
	            var id = code['storage_idx'];
	            var title = code['storage_name'];

	            if (items[parent_storage_idx]) {
	                var item =
	                {
	                	id: id,
	                    label: title
	                };

	                if (!items[parent_storage_idx].children) {
	                    items[parent_storage_idx].children = [];
	                }

	                items[parent_storage_idx].children[items[parent_storage_idx].children.length] = item;
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
				data : source ,
				autoOpen: true,
				dragAndDrop: true,
				onCreateLi: function(node, $li) {
					// Append a link to the jqtree-element div.
					// The link has an url '#node-[id]' and a data property 'node-id'.
					if(node.id != 0) {
						var menuTreeHTML = '';
						/* menuTreeHTML += '<a href="#node-'+node.id+'" class="menu_edit" data-node-id="'+node.id +'" style="position: absolute; top:4px; *top:1px;  padding-left:5px; "><img width="42" height="13" src="/resources/cms/jqTree/img/btn_menuEdit.png" alt="메뉴수정하기" /></a>';
						menuTreeHTML += '<a href="#node-'+node.id+'" class="content_edit" data-node-id="'+node.id +'" style="position: absolute; top:4px; *top:1px;  margin-left:50px; "><img width="50" height="13" src="/resources/cms/jqTree/img/btn_contentEdit.png" alt="콘텐츠수정하기" /></a>'; */
						$li.find('.jqtree-element').append(menuTreeHTML);
					}
				}
			});

			<%-- 왼쪽메뉴 트리 클릭했을 경우 --%>
			$tree.on('tree.click', function(e) {
				// Disable single selection
	            var selected_node = e.node;

    			if(beforeSelected_node!='') {
    				$tree.tree('removeFromSelection', beforeSelected_node);
    			}
    			$tree.tree('addToSelection', selected_node);

    			beforeSelected_node = selected_node;

    			if(selected_node.id == 0) {
    				alert("'보관함' 에는 담을수 없습니다.");
    				$('#addItemForm #storage_idx').val(0);
    			} else {
    				$('#addItemForm #storage_idx').val(beforeSelected_node.id);
    			}

    			e.preventDefault();
			});

			$('.tree-menu li:last-child').addClass('last');
		}
	});
}

$(document).ready(function() {

	treeOnLoad();

	$('a.add').on('click', function(e) {
		e.preventDefault();
		if ( $('#addItemForm #storage_idx').val() > 0 ) {
			$('#addItemForm #storage_idx').val(beforeSelected_node.id);
			if ( doAjaxPost($('#addItemForm')) ) {
				window.close();
			}
		}
		else {
			alert('저장할 보관함을 선택해주세요.');
		}
	});

	$('a.close').on('click', function(e) {
		e.preventDefault();
		window.close();
	});



});
</script>
<div style="padding:10px;">
	<form:form id="addItemForm" modelAttribute="myItem" action="/${homepage.context_path}/module/myStorage/saveItem.do" method="post" onsubmit="return false;">
		<form:hidden path="editMode" value="ADD"/>
		<form:hidden path="storage_idx" />
		<form:hidden path="item_name"/>
		<form:hidden path="author"/>
		<form:hidden path="publer"/>
		<form:hidden path="loca"/>
		<form:hidden path="ctrl_no"/>
		<form:hidden path="call_no"/>
		<form:hidden path="img_url"/>
		<form:hidden path="item_type"/>
		<form:hidden path="strList"/>
	</form:form>
	<div class="group-menu code-config">
		<div class="tree-area" style="width:100%;">
			<div class="tree-box" style="height:280px;border:1px solid #ddd;">
				<div class="tree-menu" id="tree1">
				</div>
			</div>
			* 담을 보관함을 선택 후 '담기' 버튼을 클릭하세요.
		</div>
	</div>
	<br/>
	<div class="center">
		<a class="btn btn1 add">담기</a>
		<a class="btn btn6 close" style="font-weight:bold;font-size:14px;">창닫기</a>
	</div>
</div>