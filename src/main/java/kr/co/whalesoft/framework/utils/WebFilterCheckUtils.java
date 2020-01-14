package kr.co.whalesoft.framework.utils;

import net.sf.classifier4J.util.WFMultiPartPost;

public class WebFilterCheckUtils {

	private static final WFMultiPartPost WFSEND = new WFMultiPartPost("gbelib.kr", "117.111.136.240", 80);

	public static String webFilterCheck(String writer, String subject, String body) {
		/*
		 * WFMultiPartPost(웹서버도메인, 웹필터서버아이피, 웹필터서버포트)
		 */

		/*
		 * WFMultiPartPost.sendWebFilter(작성자, 제목, 내용, 첨부파일경로)   - 첨부파일이 여러개 존재 시 , 로 구분하여 전송
		 * 웹필터서버 응답  : 	Y = 차단		 N = 등록			B = 바이패스
		 */

//		String fileList = "";
//		String wfResponse = null;
//
//		try {
//			wfResponse = WFSEND.sendWebFilter(writer, subject, body, fileList);
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
////		String wfResponse = wfsend.sendWebFilter(memberName, board.getTitle(), board.getContent(), "/data/homepage/data/board/229/80089/1487227701749.txt");
////		String wfResponse = wfsend.sendWebFilter("홍길동", "제목테스트 101111-1111111", "내용테스트 101111-1111111", "D:/101010.PNG");
//
//		if(wfResponse.equals("Y")){
//			return WFSEND.getDenyURL();
//		} else if(wfResponse.equals("N")){
//			return null;
//		} else if(wfResponse.equals("B")){
//			return null;
//		} else {
//			return null;
//		}
		return null;
	}

}
