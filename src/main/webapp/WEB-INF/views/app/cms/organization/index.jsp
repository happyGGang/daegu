<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${getContextPath}/resources/cms/jqTree/css/jqtree.css">
<script src="${getContextPath}/resources/cms/jqTree/js/tree.jquery.js" type="text/javascript"></script>
<script src="${getContextPath}/resources/cms/js/jq_plugin/jquery.cookie.js" type="text/javascript"></script>
<script type="text/javascript">
var beforeSelected_node = '';

function treeOnLoad() {
	$.ajax({
		url : 'getOrganizationTreeList.do?homepage_id=${orga.homepage_id}',
		async : true ,
		success : function(data) {
			data = eval(data);
			var source = [];
	        var items = [];
	        // build hierarchical source.
	        for (var i = 0; i < data.length; i++) {
	            var code = data[i];
	            var parent_orga_idx = code['parent_orga_idx'];
	            var id = code['orga_idx'];
	            var title = code['orga_name'];

	            if (items[parent_orga_idx]) {
	                var item =
	                {
	                	id: id,
	                    label: title
	                };

	                if (!items[parent_orga_idx].children) {
	                    items[parent_orga_idx].children = [];
	                }

	                items[parent_orga_idx].children[items[parent_orga_idx].children.length] = item;
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
    				<%-- 처음 disable 화면 처리 --%>
    				//$('#memberLayer').load('auth.do?editMode=FIRST');
    				$('td#orga_id_left').html('');
					$('td#orga_name_left').html('');
					$('td#orga_phone_left').html('');
    			} else {
    				$.ajax({
						url : 'getOrganizationOne.do?homepage_id=${orga.homepage_id}&orga_idx=' + selected_node.id,
						async : true ,
						success : function(data) {
							data = eval(data);
							$('td#orga_id_left').html(data.orga_idx);
							$('td#orga_name_left').html(data.orga_name);
							$('td#orga_phone_left').html(data.orga_phone);
							
							$('#memberLayer').load('memberOrga.do?homepage_id=${orga.homepage_id}&orga_idx=' + selected_node.id);
						}
					});	
    			}
						
    			e.preventDefault();
			});
			
			$tree.on('tree.move', function(event) {
				if(confirm(event.move_info.moved_node.name + ' 을(를)\n\n' + event.move_info.target_node.name + '의 하위조직으로 이동 하시겠습니까?')) {
					if(confirm(event.move_info.moved_node.name + ' 의 모든 하위조직들도 함께 이동됩니다.\n\n이동 하시겠습니까?')) {
						$('#parent_orga_idx').val(event.move_info.target_node.id);
						$('#orga_idx').val(event.move_info.moved_node.id);
						$('#editMode').val('PARENTMOVE');
						
						jQuery.ajaxSettings.traditional = true;
						
						if ( doAjaxPost($('#parentMoveForm')) ) {
							location.reload();
						} 
					}
				}
				return false;
			});
			
			$('.tree-menu li:last-child').addClass('last');
		}
	});
}

$(document).ready(function() {
	
	<%-- 권한그룹 신규등록  --%>
	$('a#editOrga_add').on('click', function(e) {
		//열려있는 다이얼로그를 삭제한다.(중복방지)
		//$('.dialog-common').remove();
		e.preventDefault();
		
		if ( beforeSelected_node.id == null ) {
			alert('등록할 조직의 상위 조직을 선택해주세요.');
			return false;
		}
		
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=${orga.homepage_id}&parent_orga_idx=' + beforeSelected_node.id, function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		 
	});
	
	<%-- 권한그룹 수정 --%>
	$('a#editOrga_modify').on('click', function(e) {
		if(beforeSelected_node.id == null) {
			alert('수정할 조직을 선택하세요.');			
		} else{
			if(beforeSelected_node.id == 0) {
				alert('최상위 "조직"은 수정할 수 없습니다.')				
			} else {
				$('#dialog-1').load('edit.do?editMode=MODIFY&orga_idx=' + beforeSelected_node.id, function( response, status, xhr ) {
					$('#dialog-1').dialog('open');
				});
			}
		}
		
		e.preventDefault(); 
	});
	
	<%-- 권한그룹 삭제 --%>
	$('a#editOrga_delete').on('click', function(e) {
		if(beforeSelected_node.id == null) {
			alert('삭제할 조직을 선택하세요.');			
		} else{
			if(beforeSelected_node.id == 0) {
				alert('최상위 "조직"은 삭제할 수 없습니다.')				
			} else {
				if(confirm('삭제 하시겠습니까?')) {
					$.ajax({
						url : 'save.do?editMode=DELETE&homepage_id=${orga.homepage_id}&orga_idx=' + beforeSelected_node.id,
						async : true ,
						method : 'POST',
						success : function(data) {
							alert(data.message);
							if(data.valid) {
								location.reload();
							}
						}
					});
				}	
			}
		}	
		
		e.preventDefault(); 
	});
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			doGetLoad('index.do', serializeCustom($('#orgaIndexForm')));
		}
		
		e.preventDefault();
	});
	
	$('#search-btn').on('click', function(e) {
		var search_text = $('#search_text').val();
		$('.tree-box span').each(function(i, element) {
			element = $(element);
			if ( element.text().indexOf(search_text) != -1 ) {
				element.css('background', 'yellow');
				
				element[0].scrollIntoView(true);	
			}
			else {
				element.css('background', 'white');
			}
		});
	});
	
	treeOnLoad();
	<%-- 처음 disable 화면 처리 --%>
	//$('#memberLayer').load('auth.do?editMode=FIRST');
	$('#memberLayer').load('memberOrga.do?editMode=FIRST');
});
</script>
 
<%
int leftSize = 400; //왼쪽 컨텐츠 사이즈
int leftSizeInput = leftSize-125; //왼쪽 컨텐츠 검색 input 사이즈
%>

<form:form id="parentMoveForm" modelAttribute="orga" action="save.do">
	<form:hidden path="editMode" value="PARENTMOVE"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="parent_orga_idx"/>
	<form:hidden path="orga_idx"/>
</form:form>

<form:form id="orgaIndexForm" modelAttribute="orga" action="index.do">
<form:hidden id="homepage_id_1" path="homepage_id"/>
</form:form>

<div class="group-menu code-config">
	<div class="tree-area" style="width:<%=leftSize%>px">
		<div class="search">
			<label class="blind">검색</label>
			<input id="search_text" type="text" class="text" style="width:<%=leftSizeInput%>px"/>
			<button id="search-btn"><i class="fa fa-search"></i><span>검색</span></button>
		</div>
		<div class="tree-box" style="height:530px;">
			<div class="tree-menu" id="tree1">
			</div>
		</div>
		<div class="table-wrap">
			<table class="border-all">
				<colgroup>
					<col width="130"/>
					<col/>
					<col width="130"/>
					<col/>
					<col width="130"/>
					<col/>
				</colgroup>
				<thead>
					<tr>
						<th colspan="2">조직 정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>조직ID</th>
						<td id="orga_id_left"></td>
					</tr>
					<tr>
						<th>조직명</th>
						<td id="orga_name_left"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td id="orga_phone_left"></td>
					</tr>
				</tbody>
			</table>
			<c:if test="${member.auth_id <= 200}">
				<div class="button">
					<a href="" class="btn btn5" id="editOrga_add"><i class="fa fa-plus"></i><span>조직 신규등록</span></a>
					<a href="" class="btn btn1" id="editOrga_modify"><i class="fa fa-pencil"></i><span>수정</span></a>
					<a href="" class="btn" id="editOrga_delete"><i class="fa fa-minus"></i><span>삭제</span></a>
				</div>
			</c:if> 
		</div>
	</div>
	<div class="set-area" style="margin-right:-<%=leftSize%>px">
		<div style="margin-right:<%=leftSize%>px" id="memberLayer">
		
		</div>
	</div>
</div>

<div id="dialog-1" class="dialog-common" title="조직정보">
</div>