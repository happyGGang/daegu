/**
****************************************************
TouchEnNx.js
****************************************************
| Version     작성자        수정일        변경사항 
 ---------  -------  -----------  ----------   
| v1.0.0.9    강남준    2023.02.01		
| v1.0.0.8    강남준    2019.06.11		
| v1.0.0.7    강남준    2019.04.01
| v1.0.0.6    강남준    2018.12.14    
| v1.0.0.5    백서린    2018.11.12    
| v1.0.0.4    강남준    2018.10.25   
| v1.0.0.3    강남준    2018.02.09   
| v1.0.0.2    허혜림    2017.12.20      
| v1.0.0.1    백서린    2017.01.20      최초
****************************************************
 Copyright ⒞ RaonSecure Co., Ltd. 
* 본 코드에 대한 모든 권한은 (주)라온시큐어 있으며 동의없이 사용/배포/가공할 수 없습니다.
****************************************************
**/

var nxbasepath = "/raonnx";

var TouchEnNxConfig = {};

TouchEnNxConfig.path = {
		url : window.location.protocol + "//" + window.location.host,			
		base : nxbasepath
};

TouchEnNxConfig.path.base = TouchEnNxConfig.path.url + TouchEnNxConfig.path.base;

/** 최소 지원브라우저 버전정보 설정 */
TouchEnNxConfig.moduleMinVer = {
	
		MSIE			:	"6",
		chromeMinVer	:	"38",
		FireFoxMinVer	:	"36",
		OperaMinVer	 	:	"27",
		SafariMinVer	:	"5",
		SafariMinVerMac :   "6", //nxCR mac Safari 지원사양 다름
		Edge			:	"ALL"
};
	
/**	라이선스 */
TouchEnNxConfig.lic ="eyJ2ZXJzaW9uIjoiMi4wIiwiaXNzdWVfZGF0ZSI6IjIwMjMwOTA4MTQ0NzQ3IiwicHJvdG9jb2xfbmFtZSI6InRvdWNoZW5leCIsInV1aWQiOiIxZjBlYzlmYzZjYjQ0YjQ0OTY2YzIwYzUyYzM2NTFhZiIsImxpY2Vuc2UiOiIxNWdlS25ucVZmSldJOU1mU3NiNHJcLzB4a3JBMkpaMG9XT1wvY0M5TzNMcVEreU1mSEtocHhCTU1teG10dHUxZFR6WlBVMEczM0RjendsanQ2Z1FkMlJrUzk1SUJpQ0lQRlJua2duU3dTR1dZaDlXOGFaeTRJYVBmR0psQ0lodHFLJGhBUFBVVjc0ajBJdjA5ckk0ZHhQVHA0dU5ISGlLNWRqa3N0b0VRT1liampwN0ZqT0ttcXJcL3I3V04wRzVlMkdveE9cL1R3SDFSeFdsUVoyenNheitVMWNwaVZlUUVBWDRIN0NxNkhtYm8wWklpZ1RIZTZkRnRjQ1o3XC9VbXZsZDBjV2c5M3ZwK2kyXC9TaWdyeGpzeCtlQUJjVHkyek1yUGgwelorZG1OaVNTeEJGSlpPNFMzaEUxcEJyK2hIT0ZxTHMweURXbWJ5bitjNUFPXC9CYzBLSTlLU21qdjRpbmZObnVrcDJLT21naWlMOWQ3OWszS1ZEV1JOemorSW1Gc0ZacGprSFdnQTQyY3ZpVTJZaUdHQ3hrVkVJeUNHQWZxOExxa3VkRDBzUkZ1XC8xS0ozVGZhMkNSZ042RlFudzFaaHlYVit1TzRTZEhJNGNnUzlNQk9PZ3B2Zz09In0=";
/** exproto debug */
TouchEnNxConfig.isDebug = false;

/** 모듈 자동 실행 여부*/
TouchEnNxConfig.onload = false;

/** 제품 별 사용 여부  */
TouchEnNxConfig.use	=	{
		nxkey	:	true,
		nxcr	:	false,
		nxweb	:	false,
		nxfw	:	false,
		ksbiz	: 	false,
		ksbizcompulsion : false
};
/** 제품 별 강제 설치 여부  */
TouchEnNxConfig.forcedinstall	=	{
		nxkey	:	true,
		nxcr	:	false,
		nxweb	:	false,
		nxfw	:	false,
		ksbiz	: 	false
};

/** 클라이언트 설치 시 이동할 페이지 */
TouchEnNxConfig.installPage = {
		tos		: TouchEnNxConfig.path.base + "/install/install.html"+"?"+"&url=" + encodeURIComponent(window.location.href),
		nxkey	: TouchEnNxConfig.path.base + "/install/install_nxkey.html"+"?"+"&url=" + encodeURIComponent(window.location.href),
/*		nxcr	: TouchEnNxConfig.path.base + "/install/install_nxcr.html"+"?"+"&url=" + encodeURIComponent(window.location.href),
		nxweb	: TouchEnNxConfig.path.base + "/install/install_nxweb.html"+"?"+"&url=" + encodeURIComponent(window.location.href),
		nxfw	: TouchEnNxConfig.path.base + "/install/install_nxfw.html"+"?"+"&url=" + encodeURIComponent(window.location.href),
		ksbiz	: TouchEnNxConfig.path.base + "/install/install_ksbiz.html"+"?"+"&url=" + encodeURIComponent(window.location.href)*/
};

/** 클라이언트 설치 후 이동할 페이지 */
TouchEnNxConfig.tkMainpage = {
		tos		: "/index.html",
		nxkey	: "",
		nxcr	: "",
		nxweb	: "",
		nxfw	: "",
		ksbiz	: ""
};

/** 프로그래스바 사용 유무 */
/** 엣지브라우저에서 1sec 정도의 설치체크 시간이 필요 함으로 필수 사용을 권장한다.*/
TouchEnNxConfig.processingbar = {
		use	: true,
		path : TouchEnNxConfig.path.base + "/image/processing.gif"
};

/** demon 사용 브라우저 설정*/
TouchEnNxConfig.daemon = {
		SupportBrowser : ["EDGE", "CHROME", "FIREFOX", "OPERA"],
		macSupportBrowser : ["SAFARI"], //일단 mac은 safari만 데몬 지원
		linuxSupportBrowser : [],
		info			: {
			isUse			: true,
			portChecker		: TouchEnNxConfig.path.base + "/cmn/TouchEnNx_port_checker.js",
			localhost		: "wss://127.0.0.1",
			edgeStartPort	: 34581,
			portChkCnt		: 3,
			allSupport		: false
		}
};


// IE 11 데몬 적용설정 (true)
var TK_IEDaemon = false;

/**
 * CHROME, FIREFOX, OPERA 브라우저에 대해 아래와 같이 동작한다.
 * mainextension : case1 : 데몬미설치,익스텐션 설치시 익스텐션으로 동작 
 *                 case2 : 데몬설치 ,익스텐션 미설치시 데몬으로 동작
 *                 case3 : 둘다 미설치일경우 데몬설치
 * onlydaemon    : 데몬으로 동작 및 설치
 * 공백 일 경우 ("")  : 익스텐션 동작 및 설치 
 */
 
TouchEnNxConfig.runtype	= "onlydaemon"; //windows용 runtype
TouchEnNxConfig.macRuntype = ""; //mac용 runtype
TouchEnNxConfig.linuxRuntype = ""; //linux용 runtype