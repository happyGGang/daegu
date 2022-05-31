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
<script type="text/javascript">
function load()
{
NetFunnel_Action({},"index.do?menu_idx=30");
}
</script>
</head>
<body onload="load()">
</body>
</html>
