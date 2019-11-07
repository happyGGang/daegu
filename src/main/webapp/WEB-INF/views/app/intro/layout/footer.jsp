<%@ page language="java" pageEncoding="utf-8" %>

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
    if (idleTime >= 5) {
		if (document.location.href.indexOf('join/edit') < 0 && document.location.href.indexOf('join/integration3') < 0) {
			location.href = "http://www.gbelib.kr/intro/${homepage.context_path}/index.do";
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
});
</script>
</body>
</html>