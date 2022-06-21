if(typeof NetFunnel == "object"){

NetFunnel.SkinUtil.add('default',{
		htmlStr:' \
			<div id="NetFunnel_Skin_Top" style="background-color:#ffffff;border:1px solid #9ab6c4;overflow:hidden;width:250px;-moz-border-radius: 5px; -webkit-border-radius: 5px; -khtml-border-radius: 5px; border-radius: 5px;" > \
				<div style="background-color:#ffffff;border:6px solid #eaeff3;-moz-border-radius: 5px; -webkit-border-radius: 5px; -khtml-border-radius: 5px; border-radius: 5px;"> \
					<div style="text-align:right;padding-top:5px;padding-right:5px;line-height:25px;"> \
					</div>\
					<div style="padding-top:5px;padding-left:5px;padding-right:5px"> \
						<div style="text-align:center;font-size:12pt;color:#001f6c;height:22px"><b><span style="color:#013dc1">접속대기 중</span>입니다.</b></div> \
						<div style="text-align:right;font-size:9pt;color:#4d4b4c;padding-top:4px;height:17px;" ><b>예상시간 : <span id="NetFunnel_Loading_Popup_TimeLeft" class="%M분 %02S초^ ^false"></span></b></div> \
						<div style="padding-top:6px;padding-bottom:6px;vertical-align:center;width:200px;" id="NetFunnel_Loading_Popup_Progressbar"></div> \
						<div style="background-color:#ededed;padding-bottom:8px;overflow:hidden;width:228px"> \
							<div style="padding-left:5px"> \
								<div style="text-align:center;font-size:8pt;color:#4d4b4c;padding:3px;padding-top:10px;padding-bottom:10px;height:10px">앞에 <b><span style="color:#2a509b"><span id="NetFunnel_Loading_Popup_Count" class="'+NetFunnel.TS_LIMIT_TEXT+'"></span></span></b> 명, 뒤에 <b><span style="color:#2a509b"><span id="NetFunnel_Loading_Popup_NextCnt" class="'+NetFunnel.TS_LIMIT_TEXT+'"></span></span></b> 명의 대기자가 있습니다.</div> \
								<div style="text-align:center;font-size:8pt;color:#4d4b4c;padding:3px;height:12px">현재 접속자가 많아 대기 중이며</div> \
								<div style="text-align:center;font-size:8pt;color:#4d4b4c;padding:3px;height:10px;">잠시만 기다리시면</div> \
								<div style="text-align:center;font-size:8pt;color:#4d4b4c;padding:3px;height:10px;">서비스로 자동 접속 됩니다.</div> \
								<div style="text-align:center;font-size:9pt;color:#2a509b;padding-top:10px;"> \
									<b>[<span id="NetFunnel_Countdown_Stop" style="cursor:pointer">중지</span>]</b> \
								</div> \
							</div> \
						</div> \
					<div style="height:5px;"></div> \
				</div> \
			</div>'
	},'mobile');

NetFunnel.tstr = '\
	<div id="NetFunnel_Skin_Top" style="background-color:#ffffff;border:1px solid #9ab6c4;width:500px;-moz-border-radius: 5px; -webkit-border-radius: 5px; -khtml-border-radius: 5px; border-radius: 5px;"> \
		<div style="background-color:#ffffff;border:6px solid #eaeff3;-moz-border-radius: 5px; -webkit-border-radius: 5px; -khtml-border-radius: 5px; border-radius: 5px;"> \
			<div style="text-align:right;padding-top:5px;padding-right:5px;line-height:25px;"> \
			<b><span id="NetFunnel_Loding_Popup_Debug_Alerts" style="text-align:left;color:#ff0000"></span></b> \
			<span style="text-align:right;"><a href="'+NetFunnel.gLogoURL+'" target="_blank" style="cursor:pointer;text-decoration:none;">';

if((NetFunnel.BrowserDetect.browser == "Explorer" && NetFunnel.BrowserDetect.version == "6") ||  NetFunnel.gLogoData == ""){
	NetFunnel.tstr += '<b style="font-size:12px;">'+NetFunnel.gLogoText+'</b></a>';
}else{
	NetFunnel.tstr += '<b style="font-size:12px;">'+NetFunnel.gLogoText+'</b><img style="height:16px;color:black;font-size:11px;" border=0 src="data:image/gif;base64,'+NetFunnel.gLogoData+'" ></a>';
}
NetFunnel.tstr +=	'</span></div> \
			<div style="padding-top:0px;padding-left:25px;padding-right:25px;padding-bottom:20px;"> \
				<div style="text-align:left;font-size:12pt;color:#001f6c;height:22px"><b>서비스 <span style="color:#013dc1">접속대기 중</span>입니다.</b></div> \
				<div style="text-align:right;font-size:9pt;color:#4d4b4c;padding-top:4px;height:17px" ><b>예상대기시간 : <span id="NetFunnel_Loading_Popup_TimeLeft" class="%H시간 %M분 %02S초^ ^false"></span></b></div> \
				<div style="padding-top:6px;padding-bottom:6px;vertical-align:center;width:400px;height:20px" id="NetFunnel_Loading_Popup_Progressbar"></div> \
				<div style="background-color:#ededed;width:440px;padding-bottom:8px;overflow:hidden;margin-top:15px;"> \
					<div style="padding-left:5px"> \
						<div style="text-align:left;font-size:8pt;color:#4d4b4c;padding:3px;padding-top:10px;height:10px">고객님 앞에 <b><span style="color:#2a509b"><span id="NetFunnel_Loading_Popup_Count" class="'+NetFunnel.TS_LIMIT_TEXT+'"></span></span></b> 명, 뒤에 <b><span style="color:#2a509b"><span id="NetFunnel_Loading_Popup_NextCnt" class="'+NetFunnel.TS_LIMIT_TEXT+'"></span></span></b> 명의 대기자가 있습니다.  </div> \
						<div style="text-align:left;font-size:8pt;color:#4d4b4c;padding:3px;height:10px">현재 접속 사용자가 많아 대기 중이며, 잠시만 기다리시면 </div> \
						<div style="text-align:left;font-size:8pt;color:#4d4b4c;padding:3px;height:10px;">서비스로 자동 접속 됩니다.</div> \
						<div style="text-align:center;font-size:9pt;color:#2a509b;padding-top:10px;"> \
							<b>※ 재 접속하시면 대기시간이 더 길어집니다. <span id="NetFunnel_Countdown_Stop" style="cursor:pointer">[중지]</span> </b> \
						</div> \
					</div> \
				</div> \
				<div style="height:5px;"></div> \
			</div> \
		</div> \
	</div>';
NetFunnel.SkinUtil.add('default',{htmlStr:NetFunnel.tstr},'normal');

}