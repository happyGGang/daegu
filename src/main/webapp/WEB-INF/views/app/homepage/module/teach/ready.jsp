<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<!DOCTYPE html>
<html>
<head>
<title>NetFUNNEL Wait Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/resources/common/netFunnel/netfunnel.js"></script>
<script type="text/javascript" src=/resources/common/netFunnel/test_skin.js></script>
<script type="text/javascript">
function load(){
	var homepage = '${homepage.context_path}';
	if(homepage == 'dgportal' || homepage == 'bukdh' || homepage == 'dmsl' || homepage == 'junggu'){
		NetFunnel_Action({action_id:homepage, service_id:'service_2'},"index_real.do?searchCate1=${teach.searchCate1}&menu_idx=${teach.menu_idx}&editMode=${teach.editMode}&homepage_id=${teach.homepage_id}&teach_idx=${teach.teach_idx}&start_join_date=${teach.start_join_date}&end_join_date=${teach.end_join_date}&start_date=${teach.start_date}&end_date=${teach.end_date}&status=${teach.status}&search_text=${teach.search_text}&search_type=${teach.search_type}&viewPage=${teach.viewPage}&group_idx=${teach.group_idx}&category_idx=${teach.category_idx}");
	} else {
		NetFunnel_Action({action_id:homepage, service_id:'service_1'},"index_real.do?searchCate1=${teach.searchCate1}&menu_idx=${teach.menu_idx}&editMode=${teach.editMode}&homepage_id=${teach.homepage_id}&teach_idx=${teach.teach_idx}&start_join_date=${teach.start_join_date}&end_join_date=${teach.end_join_date}&start_date=${teach.start_date}&end_date=${teach.end_date}&status=${teach.status}&search_text=${teach.search_text}&search_type=${teach.search_type}&viewPage=${teach.viewPage}&group_idx=${teach.group_idx}&category_idx=${teach.category_idx}");
	}
}
</script>
</head>
<body onload="load()">
</body>
</html>
