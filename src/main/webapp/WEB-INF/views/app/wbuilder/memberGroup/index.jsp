<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${getContextPath}/resources/cms/jqTree/css/jqtree.css">
<script src="${getContextPath}/resources/cms/jqTree/js/tree.jquery.js" type="text/javascript"></script>
<script src="${getContextPath}/resources/cms/js/jq_plugin/jquery.cookie.js" type="text/javascript"></script>
<script type="text/javascript">
var beforeSelected_node = '';
var source = [];
var items = [];
var treeFolder = [];
var $tree;
var selectedTab = 'D';	//D:default, R:Relationship
function treeOnLoad() {
	$.ajax({
		url : 'getMemberGroupTreeList.do',
		async : true ,
		success : function(data) {
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
	                    default_group_yn:default_group_yn
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
	                    default_group_yn:default_group_yn
	                };
	                source[sourceIdx++] = items[id];
	            }
	        }
			var folderIdx = 0;
	        $tree = $('#tree1').tree({
				data : source , 
				autoOpen: true,
				dragAndDrop: false,
				onCreateLi: function(node, $li) {
					// Append a link to the jqtree-element div.
					// The link has an url '#node-[id]' and a data property 'node-id'.
					if(node.id != 0) {
						if (node.isFolder()) {
							treeFolder[folderIdx++] = node;
						}
						node.default_group_yn = items[node.id].default_group_yn;								
						var menuTreeHTML = ''; 
						/* menuTreeHTML += '<a href="#node-'+node.id+'" class="menu_edit" data-node-id="'+node.id +'" style="position: absolute; top:4px; *top:1px;  padding-left:5px; "><img width="42" height="13" src="/resources/cms/jqTree/img/btn_menuEdit.png" alt="메뉴수정하기" /></a>';
						menuTreeHTML += '<a href="#node-'+node.id+'" class="content_edit" data-node-id="'+node.id +'" style="position: absolute; top:4px; *top:1px;  margin-left:50px; "><img width="50" height="13" src="/resources/cms/jqTree/img/btn_contentEdit.png" alt="콘텐츠수정하기" /></a>'; */
// 						$li.find('.jqtree-element').append(menuTreeHTML);
					}
				}
			});

// 	        for (var i=0; i<=treeFolder.length; i++) {
// 	        	try {
// 		        	$tree.tree('closeNode', treeFolder[i]);
// 	        	} catch (e){
// 	        	}
// 	        }
			
			<%-- 왼쪽메뉴 트리 클릭했을 경우 --%>
			$tree.on('tree.click', function(e) {
				// Disable single selection
	            var selected_node = e.node;
	            
    			if(beforeSelected_node!='') {
    				$tree.tree('removeFromSelection', beforeSelected_node);	
    			}
    			$tree.tree('addToSelection', selected_node);
    			
    			beforeSelected_node = selected_node;

    			if(selected_node.id == '0') {
    				<%-- 처음 disable 화면 처리 --%>
    				$('#authLayer').load('memberGroup_ajax.do?editMode=FIRST');
    			} else {
    				$('#authLayer').load('memberGroup_ajax.do?editMode=ADD&member_group_idx=' + selected_node.id);
    				
//     				$.ajax({
// 						url : 'getAuthGroupOne.do?member_group_idx=' + selected_node.id,
// 						async : true ,
// 						success : function(data) {
// 							data = eval(data);
// 							$('td#auth_group_id_left').html(data.auth_group_id);
// 							$('td#auth_group_name_left').html(data.member_group_name);
// 							$('td#remark_left').html(data.remark);
							
// 							$('#authLayer').load('memberGroup.do?editMode=ADD&member_group_idx=' + selected_node.id);
// 						}
// 					});	
    			}
						
    			e.preventDefault();
			});
			
			$('.tree-menu li:last-child').addClass('last');
			

		}
	});
}

$(document).ready(function() {
	
	treeOnLoad();
	<%-- 처음 disable 화면 처리 --%>
	$('#authLayer').load('memberGroup_ajax.do?editMode=FIRST');
	
//     $('li.jqtree_common')[0].click();
//     $('a.jqtree_common')[0].click();
	
	$('#search-btn').on('click', function(e) {
		e.preventDefault();
		var search_text = $('#search_text').val();
		$('.tree-box span').each(function(i, element) {
			element = $(element);
			if ( element.text().indexOf(search_text) != -1 ) {
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
int leftSize = 400; //왼쪽 컨텐츠 사이즈
int leftSizeInput = leftSize-125; //왼쪽 컨텐츠 검색 input 사이즈
%>
<div class="group-menu code-config">
	<div class="tree-area" style="width:<%=leftSize%>px">
		<div class="search">
			<form>
				<fieldset>
					<label class="blind">검색</label>
					<input id="search_text" type="text" class="text" style="width:<%=leftSizeInput%>px"/>
					<button id="search-btn"><i class="fa fa-search"></i><span>검색</span></button>
				</fieldset>
			</form>
		</div>
		<div class="tree-box" style="height:630px;">
			<div class="tree-menu" id="tree1">
			</div>
		</div>
	</div>
	<div class="set-area" style="margin-right:-<%=leftSize%>px">
		<div style="margin-right:<%=leftSize%>px" id="authLayer">
		
		</div>
	</div>
</div>
