<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
	<head>
	    <meta charset="UTF-8">
		<title>오류페이지</title>
		<link rel="stylesheet" type="text/css" href="/resources/cms/css/default.css" />
		<style>
			#errorWrap { width:692px; margin:120px auto 0; }
			#errorWrap .outBox { background:url('/resources/cms/img/user/common/bar.gif') no-repeat; margin-top:10px; padding:20px 0; border-bottom:2px solid #efefef;  }
			#errorWrap .outBox .cont { width:500px; margin-top:30px; padding-bottom:20px; float:left;   }
			#errorWrap .outBox .visual { width:166px; float:left; margin-top:60px;  }
			#errorWrap .outBox .cont p { font-size:12px; line-height:150%; margin-bottom:3px;  }
			#errorWrap .outBox .cont h2 { font-size:32px; color:#f5a546; margin:0; }
			#errorWrap .outBox .cont .eng { font-size:32px; font-weight:bold; color:#cbcbcb; padding-bottom:10px;  }
			#errorWrap .outBox .btns { clear:both; padding:5px 0 15px;   }
			#errorWrap .outBox .btns a { margin-right:5px; }
			#errorWrap address { padding:20px 0; text-align:center; }
		</style>
	</head>
	
	<body>
		<div id="errorWrap">
			<h1><a href="/"><img width="86px" height="46px" src="/resources/cms/img/common/logo.jpg" alt="섬유개발연구원" /></a></h1>
			<div class="outBox error">
				<div class="cont">
					<h2>오류가 발생하였습니다.</h2>
					<p class="eng">ERROR OCCURRED</p>
					<p>죄송합니다. 오류가 발생하여 해당 페이지에 접근할 수 없습니다.</p>
					<p>관련 문의사항은 고객센터에 알려주시면 친절하게 안내해 드리겠습니다.</p>
					<p>감사합니다.</p>
				</div>
				<div class="visual">
					<img width="166" height="182" src="/resources/cms/img/user/common/error.gif" alt="에러페이지" />
				</div>
				<div class="btns">
					<a href="/index.ws"><img width="125"  height="32" src="/resources/cms/img/user/common/btn_goMain.gif" alt="메인페이지로 이동"/></a>
					<a href="javascript:history.back();"><img width="125"  height="32" src="/resources/cms/img/user/common/btn_goPrev.gif" alt="이전페이지로 이동"/></a>
				</div>
			</div>
			<address>COPYRIGHT ⓒ CRETEX. All rights reserved.</address>
		</div>
	</body>
</html>
