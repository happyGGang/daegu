<? header("Content-Type: text/html; charset=utf-8"); ?>
<!doctype html>
<html xhtml="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<title>중국문화정보실</title>
<link rel="stylesheet" type="text/css" href="./css/common.css">

<script type="text/javascript" src="js/jquery-1.10.1.js"></script>
<script type="text/javascript" src="js/bxslider.js"></script>
<script type="text/javascript">
//<![CDATA[
	$(function() {
		$('.visual_slide').bxSlider({
			mode:'fade',
			auto:true,
			autoControls:true,
			autoHover:true,
			controls:false,
			pager:true
		});
		$('.banner').bxSlider({
			slideWidth: 172,
			minSlides: 2,
			maxSlides: 5,
			moveSlides: 1,
			slideMargin: 10,
			pager:false,
			autoControls:true,
			auto:true
		});
	});
//]]>
</script>
</head>

<body>
<div id="wrapper">
	<header id="header">
		<h1><a href="index.html"><img src="img/logo.png" alt="도서관 속 작은 중국 중국문화정보실"></a></h1>
		<nav class="navi">
			<ul>
				<li><a href="intro01.html">자료실소개</a></li>
				<li><a href="event01.html">도서관행사</a></li>
				<li><a href="office01.html">유관기관</a></li>
			</ul>
		</nav>
	</header>
	<hr>