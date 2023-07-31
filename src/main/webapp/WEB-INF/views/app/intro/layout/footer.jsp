<%@ page language="java" pageEncoding="utf-8" %>

<!--
<script type="text/javascript">
function detectIE(){
    var ua = window.navigator.userAgent;
    var msie = ua.indexOf('MSIE ');
    if(msie > 0){
        return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
    }
    var trident = ua.indexOf('Trident/');
    if(trident > 0){
        var rv = ua.indexOf('rv:');
        return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
    }
    var edge = ua.indexOf('Edge/');
    if(edge > 0){
       return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
    }
    return false;
}
var verNumber = parseInt(detectIE(),10);
if(verNumber < 9){
	document.body.setAttribute('class', 'old-ie ie'+verNumber);
}

var idleTime = 0;
function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime >= 2) {
		if (document.location.href.indexOf('join/edit') < 0 && document.location.href.indexOf('join/integration3') < 0) {
			//location.href = "/intro/${homepage.context_path}/login/logout.do";
			location.href = "/intro/${context_path}/index.do";
		}
    }
}

$(document).ready(function() {
    var idleInterval = setInterval(timerIncrement, 60000);
    $(this).mousemove(function (e) {
        idleTime = 0;
    });
    $(this).keypress(function (e) {
        idleTime = 0;
    });

	$('a.not-hope').on('click', function(e) {
		e.preventDefault();
		alert('해당년도 희망도서신청 예산 소진으로 내년 1월 1일부터 희망도서 신청을 받으며 현재는 기존 신청 내역 확인만 가능합니다. \n\r이용에 불편함을 드려 죄송합니다.');
		location.href='/intro/${context_path}/search/hope/index.do';
	});
});


</script>
-->
<c:choose>
<c:when test="${not empty sessionScope.member and sessionScope.member.login}">
<script type="text/javascript">
var idleTime = 0;
function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime >= 2) {
		//if (document.location.href.indexOf('join/edit') < 0 && document.location.href.indexOf('join/integration3') < 0) {
			location.href = "/intro/${homepage.context_path}/login/logout.do";
			//location.href = "/intro/${context_path}/index.do";
		//}
    }
}

$(document).ready(function() {
    var idleInterval = setInterval(timerIncrement, 60000);
    $(this).mousemove(function (e) {
        idleTime = 0;
    });
    $(this).keypress(function (e) {
        idleTime = 0;
    });

	$('a.not-hope').on('click', function(e) {
		e.preventDefault();
		alert('해당년도 희망도서신청 예산 소진으로 내년 1월 1일부터 희망도서 신청을 받으며 현재는 기존 신청 내역 확인만 가능합니다. \n\r이용에 불편함을 드려 죄송합니다.');
		location.href='/intro/${context_path}/search/hope/index.do';
	});
});
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
var idleTime = 0;
function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime >= 2) {
		location.href = "/intro/${context_path}/index.do";
    }
}

$(document).ready(function() {
    var idleInterval = setInterval(timerIncrement, 60000);
    $(this).mousemove(function (e) {
        idleTime = 0;
    });
    $(this).keypress(function (e) {
        idleTime = 0;
    });

	$('a.not-hope').on('click', function(e) {
		e.preventDefault();
		alert('해당년도 희망도서신청 예산 소진으로 내년 1월 1일부터 희망도서 신청을 받으며 현재는 기존 신청 내역 확인만 가능합니다. \n\r이용에 불편함을 드려 죄송합니다.');
		location.href='/intro/${context_path}/search/hope/index.do';
	});
});
</script>
</c:otherwise>
</c:choose>
</body>
</html>