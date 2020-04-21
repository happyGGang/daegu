<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${homepage.context_path eq '228lib'}">
<script type="text/javascript">
	location.href="/${homepage.context_path}/index.do";
	return;
</script>
</c:if>

<style>
table.integration2Table tbody th, table.integration2Table tbody td {text-align: center;padding:6px 0px!important;}


/*조언*/
.doc-body .txt-box-adv2 {border: 1px solid #e8e5e2;padding: 2% 2% 1% 2%;margin: 0 0 1% 0;border-radius: 5px;color: #c10064;overflow: hidden;background: #f9f7f5;font-size: 14px;}
.doc-body .txt-box-adv:after {background: url('/resources/homepage/dgportal/img/icon_adv.png') no-repeat 0 0;}

/*인증*/
.dataF-wr{position: relative;}
.ataF-wr .info_list:before {content:'';position:absolute;left:50%;width: 135px;height: 134px;margin-left: -70px;margin-top: 210px;transition: all 0.3s;}
.dataF-wr .tit {background-color:#2c469c;color:#fff;text-align:center;font-size:20px;max-width:35%;padding:10px 30px;margin:auto;font-weight:normal;}
span.dts{font-size:13px;color: #555;border-radius:30px;background:#eee;padding:10px 10px;margin:20px auto;display:block;width:30%;}

.dataF-wr .info_list{/* margin-top: 35px; */}
.dataF-wr .info_list:after{content:'';display:block;clear:both;}
.dataF-wr .info_list > li{float:left;width:50%;padding: 40px 25px 25px 25px;box-sizing:border-box;border:1px solid #e0e0e0;margin: -1px 0 0 -1px;min-height: 450px;text-align:center;}
.dataF-wr .info_list > li.dw01{float:left;width:50%;padding: 40px 25px 25px 25px;box-sizing:border-box;border:1px solid #e0e0e0;margin: -1px 0 0 -1px;min-height: 400px;text-align:center;}
.dataF-wr .info_list > li.dw02{float:left;width:50%;padding: 40px 25px 25px 25px;box-sizing:border-box;border:1px solid #e0e0e0;margin: -1px 0 0 -1px;min-height: 400px;text-align:center;}
.dataF-wr .info_list .title{font-size: 1.5em;color:#333;font-weight:500;line-height:30px;margin-top:10px;font-weight: bold;}
.dataF-wr .info_list .dot_txt_list{margin-top:20px;padding: 0 15px 0 15px;}
.dataF-wr .info_list .dot_txt_list > li{line-height: 25px;text-align:left;}

@media screen and (max-width:1024px){
.dataF-wr .info_list{display: flex;flex-wrap:wrap;}
.dataF-wr .info_list:before {content:'';position:absolute;left:50%;width: 167px;height: 238px;margin-left: -90px;margin-top: -150px;}
.dataF-wr .info_list > li{padding:30px 15px;height:auto;margin: -1px 0 0 0;}
}

@media screen and (max-width:768px){
.dataF-wr .info_list:before {content:'';position:absolute;left:50%;width: 167px;height: 238px;margin-left: -90px;margin-top: -150px;}
.doc-body .txt-box-adv2 {padding: 5% 2% 2% 2%;background: #f9f7f5;}
}

@media screen and (max-width:690px){
.dataF-wr .info_list{/* margin-top: 145px; */}
.dataF-wr .info_list > li{width:100%;padding:30px 15px;margin:-1px 0 0 0;min-height:340px}
.dataF-wr .info_list .title{font-size:18px;line-height:26px;margin-top:8px;}
.dataF-wr .info_list .dot_txt_list{margin-top:15px}
.dataF-wr .info_list .dot_txt_list > li{line-height:22px}
}
</style>
<script type="text/javascript">
$(function() {

});
</script>
<div class="dataF-wr mg15f">
  <ul class="info_list">
       <li>
      <div class="list_cell">
        <p class="icon"><img src="/resources/common/img/dw02.png" alt="" width="164"></p>
        <p class="title">대구시민인증</p>
        <ul class="dot_txt_list">
          <li>자격 확인이 필요한 행정·공공 서비스 이용 신청 시 신청인이 직접 본인 동의하에 행정안전부 행정정보공동이용 시스템을 통해 신청 자격을 확인하는 서비스입니다.<br>
            독서교육종합지원시스템(DLS)에 가입된 회원이 아닌 일반 이용자분들은 아래의 <strong>대구시민인증</strong> 버튼을 클릭하시면 추가 인증 페이지로 이동합니다.</li>
        </ul>
      </div>
    </li>
	
	<li>
      <div class="list_cell">
        <p class="icon"><img src="/resources/common/img/dw01.png" alt="" width="164"></p>
        <p class="title">대구학생인증</p>
        <ul class="dot_txt_list">
          <li>독서교육종합지원시스템(DLS)에 가입된 회원은 추가 인증을 통해 비대면 회원가입으로 전자도서관 이용이 가능합니다.<br>
            아래의 <strong>대구학생인증</strong> 버튼을 클릭하시면 추가 인증 페이지로 이동합니다.</li>
        </ul>
      </div>
    </li>
  </ul>
</div>
<div class="txt-box-adv2">
   <ul class="con">
       <li>신규 회원가입하여 로그인 후 인증 가능합니다. (기존 회원은 통합회원 인증 후 사용 가능)</li>
       <li><b>비대면 인증 회원은 원칙적으로 전자도서관만 이용할 수 있으며</b>, 임시휴관 기간 동안 한시적으로 워킹스루 예약대출 서비스를 이용할 수 있습니다. (무인예약 및 스마트도서관 제외) </li> 
    </ul>
</div>
<div class="btn-wrap" style="text-align:center;padding:20px 0">
	<a href="untactForm.do?menu_idx=${untactMenuIdx}" class="btn btn02" style="background: #f56627;border: 1px solid #f56627;color:#fff;">대구시민인증</a>
	<a href="dls.do?menu_idx=${dlsMenuIdx}" class="btn btn01" style="background: #3c6ad9;border: 1px solid #3c6ad9;color:#fff;">대구학생인증</a>
	<a href="/dgportal/index.do" class="btn btn03">메인으로</a> </div>
