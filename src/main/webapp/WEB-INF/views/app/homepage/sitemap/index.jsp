<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>

<script>
$(function() {
	$('div.sitemap a').on('click', function(e) {
		var next = $(this).next('ul');
		if (next.length > 0) {
			var a = $(next).find('a');
			var next2 = $(a).next('ul');
			if (next2.length > 0) {
				var b = $(next).find('a');
				var next3 = $(b).next('ul');
				if (next3.length > 0) {

				} else {
					location.href = $(b).attr('href');
				}
			} else {
				location.href = $(a).attr('href');
			}
		}

	});

})
</script>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="sitemap">
<homepageTag:sitemap menuList="${menuTreeList}"/>
</div>