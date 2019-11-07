package kr.go.gbelib.app.cms.module.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardApiService extends BaseService {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ApiLogService apiLogService;
	
	@Autowired
	private HomepageService homepageService;
	
	public Map<String, Object> getData(Board board, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> libMap = libMap();
		
		String libCode = request.getParameter("libCode");
		
		if (libMap.get(libCode) == null) {
			String errmsg = "잘못된 libCode 파라미터";
			apiLogService.addApiLog(new ApiLog("BOARD", "-1", errmsg, makeParamUrl(board, libCode), request.getRemoteAddr()));
			return ApiController.error("-1", errmsg);
		}
			
		BoardManage boardManage = new BoardManage();
		boardManage.setBoard_type("NORMAL");
		board.setManage_idx(Integer.parseInt(String.valueOf(libMap.get(libCode))));
		
		board.setTotalDataCount(boardService.getBoardCount(boardManage, board));
		List<Board> list = boardService.getBoardApi(boardManage, board);
		List<Map<String, Object>> boardMapList = new ArrayList<Map<String, Object>>();
		
		for(Board obj: list) {
			boardMapList.add(toMap(obj, libCode, request));
		}
		
		map.put("code", "1");
		map.put("msg", "");
		map.put("rowCount", board.getRowCount());
		map.put("viewPage", board.getViewPage());
		map.put("totalDataCount", board.getTotalDataCount());
		map.put("totalPageCount", board.getTotalPageCount());
		map.put("data", boardMapList);
		
		apiLogService.addApiLog(new ApiLog("BOARD", "0", "", makeParamUrl(board, libCode), request.getRemoteAddr()));
		
		return map;
	}
	

	public Map<String, Object> toMap(Board board, String libCode, HttpServletRequest request) {
		Homepage homepage = new Homepage();
		homepage.setHomepage_code(libCode);
		homepage = homepageService.getHomepageOneByCode(homepage);
		if (homepage == null) {
			homepage = new Homepage();
			homepage.setContext_path("gbelib");
			homepage = homepageService.getHomepageOneInPath(homepage);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> libMap2 = libMap2();
		map.put("board_idx", board.getBoard_idx());
		map.put("title", board.getTitle());
		if (libCode.equals("00147000")) {
			map.put("url", String.format("%s/%s/board/view.do?menu_idx=%s&manage_idx=%s&board_idx=%s", homepage.getDomain(), board.getImsi_v_19(), board.getImsi_n_2(), board.getManage_idx(), board.getBoard_idx()));
			map.put("moreUrl", String.format("%s/%s/board/index.do?menu_idx=%s&manage_idx=%s", homepage.getDomain(), board.getImsi_v_19(), board.getImsi_n_2(), board.getManage_idx()));
			map.put("alias", board.getImsi_v_20());
		} else {
			map.put("url", String.format("%s/%s/board/view.do?menu_idx=%s&manage_idx=%s&board_idx=%s", homepage.getDomain(), String.valueOf(libMap2.get(libCode)), board.getMenu_idx(), board.getManage_idx(), board.getBoard_idx()));
			map.put("moreUrl", String.format("%s/%s/board/index.do?menu_idx=%s&manage_idx=%s", homepage.getDomain(), String.valueOf(libMap2.get(libCode)), board.getMenu_idx(), board.getManage_idx()));
		}
		
		return map;
	}


	private String makeParamUrl(Board board, String libCode) {
		StringBuilder sb = new StringBuilder();
		
		sb.append("libCode=" + libCode);
		sb.append("&rowCount=" + board.getRowCount());
		sb.append("&viewPage=" + board.getViewPage());
		
		return sb.toString();
	}
	
	private Map<String, Object> libMap() {
		Map<String, Object> libMap = new HashMap<String, Object>();
		
		libMap.put("00147046", "1");
//		libMap.put("00147046", 1);
		libMap.put("00147002", "491");
		libMap.put("00147003", "132");
		libMap.put("00147007", "476");
		libMap.put("00147004", "196");
		libMap.put("00147008", "147");
		libMap.put("00147040", "191");
		libMap.put("00147009", "153");
		libMap.put("00147010", "388");
		libMap.put("00147011", "400");
		libMap.put("00147039", "421");
		libMap.put("00147031", "172");
		libMap.put("00147012", "435");
		libMap.put("00147013", "43");
		libMap.put("00147032", "333");
		libMap.put("00147024", "338");
		libMap.put("00147014", "535");//영천금호
		libMap.put("00147015", "305");
		libMap.put("00147016", "96");
		libMap.put("00147017", "528");//울릉
		libMap.put("00147018", "342");
		libMap.put("00147019", "496");
		libMap.put("9999999", "415");
		libMap.put("00147020", "198");
		libMap.put("00147006", "198");
		libMap.put("00147021", "97");
		libMap.put("00147022", "226");
		libMap.put("00147023", "340");
		libMap.put("00147000", "521");

		return libMap;
//		경상북도교육정보센터 도서관	00147046
//		고령공공도서관	00147002
//		구미도서관	00147003
//		봉화공공도서관	00147007
//		삼국유사군위도서관	00147004
//		상주도서관	00147008
//		상주도서관 화령분관	00147040
//		성주공공도서관	00147009
//		안동도서관	00147010
//		안동도서관 용상분관	00147011
//		안동도서관 풍산분관	00147039
//		영덕공공도서관	00147031
//		영양공공도서관	00147012
//		영일공공도서관	00147013
//		영주공공도서관	00147032
//		영주공공도서관 풍기분관	00147024
//		영천금호도서관	00147014
//		예천공공도서관	00147015
//		외동공공도서관	00147016
//		울릉공공도서관	00147017
//		울진공공도서관	00147018
//		의성공공도서관	00147019
//		전자도서관	9999999
//		점촌공공도서관	00147020
//		점촌공공도서관 가은분관	00147006
//		청도공공도서관	00147021
//		청송공공도서관	00147022
//		칠곡공공도서관	00147023
		
	}
	
	private Map<String, Object> libMap2() {
		Map<String, Object> libMap = new HashMap<String, Object>();
		
		libMap.put("00147046", "geic");
//		libMap.put("00147046", "geiclib");
		libMap.put("00147002", "gr");
		libMap.put("00147003", "gm");
		libMap.put("00147007", "bh");
		libMap.put("00147004", "gw");
		libMap.put("00147008", "sj");
		libMap.put("00147040", "sjhr");
		libMap.put("00147009", "sjl");
		libMap.put("00147010", "ad");
		libMap.put("00147011", "adys");
		libMap.put("00147039", "adps");
		libMap.put("00147031", "yd");
		libMap.put("00147012", "yy");
		libMap.put("00147013", "yi");
		libMap.put("00147032", "yj");
		libMap.put("00147024", "yjpg");
		libMap.put("00147014", "ycgh");
		libMap.put("00147015", "yc");
		libMap.put("00147016", "od");
		libMap.put("00147017", "ul");
		libMap.put("00147018", "uj");
		libMap.put("00147019", "us");
		libMap.put("9999999 ", "elib");
		libMap.put("00147020", "jc");
		libMap.put("00147006", "jc");
		libMap.put("00147021", "cd");
		libMap.put("00147022", "cs");
		libMap.put("00147023", "cg");
		libMap.put("00147000", "gbelib");
		
		return libMap;
		
	}
}
