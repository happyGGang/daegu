<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<form name="" id="">
<input type="text" name="keyword" id="keyword" style="width:100%" />
</form>
<a href="javascript:search();" class="btn btn1" style="width:100%;box-sizing:border-box;text-align:center;margin-top:3px;">확인</a>

<script type="text/javascript">
$(function() {
	
});

function search()
{
	keyword = $('#keyword').val();
	apiSample(keyword);
}

function apiSample(keyword){
    $("#resultArea").html("");
    $.ajax({
        type: "GET",
        url: "https://map.ngii.go.kr/openapi/search.xml",
        data: {
            target:"poi",
            onePageRows:"100",
            currentPage:"1",
            apikey:"2375C203D51981F12172FEAB7D7AFD44",
            keyword:keyword
        },
        dataType : "jsonp",
        crossDomain:true,
        success: function(result) {
            var xmlData = jQuery.parseXML(result.xmlStr);
            var header = $(xmlData).find("header");
            var responseCode = header.find("responseCode").text();
            var responseMessage = header.find("responseMessage").text();

            if(responseCode!="0"&&responseCode!="100"){
                $("#resultArea").html(responseMessage);
            } else {
                var htmlStr = "";
                var poiArry = $(xmlData).find("contents").find("poi");
                if(poiArry.length==0){
                    $("#resultArea").html("검색결과가 없습니다.");
                } else {
                    htmlStr+="<table style='width:100%;margin-top:5px;'>";
					htmlStr+="<tr>";
					htmlStr+="<th>명칭</th>";
					htmlStr+="<th>도로명주소</th>";
					htmlStr+="<th>지번주소</th>";
					htmlStr+="<th>X좌표</th>";
					htmlStr+="<th>Y좌표</th>";
					htmlStr+="</tr>";
                    for(var i=0;i<poiArry.length;i++){
                        htmlStr+="<tr>";
                        htmlStr+="<td style='width:20%;'>"+$(poiArry[i]).find("name").text()+"</td>";
                        htmlStr+="<td style='width:20%;'>"+$(poiArry[i]).find("roadAdres").text()+"</td>";
                        htmlStr+="<td style='width:20%;'>"+$(poiArry[i]).find("jibunAdres").text()+"</td>";
                        htmlStr+="<td style='width:20%;'>"+$(poiArry[i]).find("x").text()+"</td>";
                        htmlStr+="<td style='width:20%;'>"+$(poiArry[i]).find("y").text()+"</td>";
                        htmlStr+="</tr>";
                    }
                    htmlStr+="</table>";
                    $("#resultArea").html(htmlStr);
                }
            }
        },
        error : function(xhr, ajaxSettings, thrownError){
        }
    });
}
</script>

<div id="resultArea">
