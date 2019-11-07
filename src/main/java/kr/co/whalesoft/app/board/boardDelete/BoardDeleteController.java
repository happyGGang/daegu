package kr.co.whalesoft.app.board.boardDelete;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.board.boardFile.BoardFileService;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.app.cms.boardManage.fieldManage.FieldManage;
import kr.co.whalesoft.app.cms.boardManage.fieldManage.FieldManageService;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StrUtil;

@Controller
@RequestMapping(value = {"/boardDelete", "/{homepagePath}/boardDelete"})
public class BoardDeleteController extends BaseController {

	private String basePath = "";
	
	@Autowired
	private BoardService service;
	@Autowired
	private CodeService codeService;
	@Autowired
	private BoardFileService boardFileService;
	@Autowired
	private FieldManageService fieldManageService;
	@Autowired
	private BoardManageService boardManageService;
	
	/** 공통 **/
	private void attributeInit(HttpServletRequest request, Model model, Board board, String mode) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		String homepageFolder = "";
		String contextPath = null;
		if(homepage != null) {
			homepageFolder = "/homepage/" + homepage.getFolder();
			contextPath = "/" + homepage.getContext_path();
		}
		
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		
		if(model != null) {
			model.addAttribute("boardManage", boardManage);
			
			if(boardManage.getBoard_type().indexOf("CUSTOM") > -1) {
				List<FieldManage> fieldList = null;
				
//				if(mode != null && mode.equals("EDIT")) {
//					fieldList = fieldManageService.getBoardFieldManageByEdit(new FieldManage(boardManage.getManage_idx()));
//					model.addAttribute("fieldList", fieldList);
//				} else if(mode != null && mode.equals("REPLY")) {
//					fieldList = fieldManageService.getBoardFieldManageByReply(new FieldManage(boardManage.getManage_idx()));
//					model.addAttribute("fieldList", fieldList);
//				} else {
//					fieldList = fieldManageService.getBoardFieldManageByList(new FieldManage(boardManage.getManage_idx()));
//					model.addAttribute("fieldList", fieldList);
//				}
				
				List<String> columnList = new ArrayList<String>();
//				for(FieldManage fieldManage : fieldList) {
//					columnList.add(fieldManage.getBoard_column());
//				}
				
				board.setBoard_field_list(columnList);
			}
			
//			if(boardManage.getCategory_use_yn() != null && boardManage.getCategory_use_yn().equals("Y")) {
//				if(boardManage.getCategory1() != null && !boardManage.getCategory1().equals("")) {
//					model.addAttribute("category1List", codeService.getCode(boardManage.getCategory1()));
//				}
//				if(boardManage.getCategory2() != null && !boardManage.getCategory2().equals("")) {
//					model.addAttribute("category2List", codeService.getCode(boardManage.getCategory2()));
//				}
//				if(boardManage.getCategory3() != null && !boardManage.getCategory3().equals("")) {
//					model.addAttribute("category3List", codeService.getCode(boardManage.getCategory3()));
//				}
//			}
		}
		
		basePath = homepageFolder + "/board/" + boardManage.getBoard_type() + "/";
	}
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, Board board, HttpServletRequest request) throws AuthException {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		checkAuth("R", model, request);
		String homepageFolder = "";
		String contextPath = null;
		
		if(homepage != null) {
			homepageFolder = "/homepage/" + homepage.getFolder();
			contextPath = "/" + homepage.getContext_path();
		}
		
		String basePath = homepageFolder + "/board/" + boardManage.getBoard_type() + "/";
		
		board.setDelete_yn("Y");
		// 삭제게시물의 경우 자식글도 모두 봐야한다.
		board.setReply_list_yn("Y");
		attributeInit(request, model, board, null);
		
		service.setPaging(model, service.getDeleteBoardCount(boardManage, board), board);
		model.addAttribute("boardNoticeList", service.getBoardNotice(board));
		model.addAttribute("boardList", service.getDeleteBoard(boardManage, board));
		model.addAttribute("board", board);
		
		if (boardManage.getBoard_type().equals("FAQ")){
			if(StrUtil.isInStr(board.getBoard_mode(), "admin")){
				return basePath + "index_normal";
			}
		}
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/view.*"}, method = RequestMethod.GET)
	public String view(Model model, Board board, HttpServletRequest request) throws AuthException {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		checkAuth("R", model, request);
		String homepageFolder = "";
		String contextPath = null;
		
		if(homepage != null) {
			homepageFolder = "/homepage/" + homepage.getFolder();
			contextPath = "/" + homepage.getContext_path();
		}
		
		String basePath = homepageFolder + "/board/" + boardManage.getBoard_type() + "/";
		
		board.setDelete_yn("Y");
		
		//조회수 증가		
		service.addViewCount(board);
		
		Board boardData = null;
		
		if (boardManage.getBoard_type().equals("MOVIE")) {
			boardData = (Board)service.copyObjectPaging(boardManage, board, service.getMoviewBoardOne(board));
		} else {
			boardData = (Board)service.copyObjectPaging(boardManage, board, service.getBoardOne(board));
		}
		
		if(boardManage.getBoard_type().equals("QNA")) {
			model.addAttribute("boardQnaList", service.getQnABoard(boardData));
		}
		
		
		model.addAttribute("board", boardData);
		//model.addAttribute("boardFile", boardFileService.getBoardFile(board.getBoard_idx()));
		model.addAttribute("prevBoard", service.getPrevBoardOne(board));
		model.addAttribute("nextBoard", service.getNextBoardOne(board));
		
		if(boardData.getFile_count() > 0) {
			model.addAttribute("boardFile", boardFileService.getBoardFile(board.getBoard_idx()));
		}

		if(boardManage.isAdmin_auth_check()) {
//			model.addAttribute("boardManageAll", boardManageService.getBoardManageAllParam(boardManage));
		}
		
		if(boardManage.isAdmin_auth_check()) {
			return basePath + "view";
		} else {			
			return basePath + "view";
		}
	}
	
	@RequestMapping(value = {"/recovery.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Board board, BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");

		String homepageFolder = "";
		String contextPath = null;
		
		if(homepage != null) {
			homepageFolder = "/homepage/" + homepage.getFolder();
			contextPath = "/" + homepage.getContext_path();
		}
		
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			service.recoveryBoard(board);
			res.setValid(true);
			res.setUrl(contextPath + "/boardDelete/index.do");
			res.setData(board.getUrlParam(boardManage, "index"));
			res.setMessage("게시물이 복구 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/drop.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(Board board, BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		
		String homepageFolder = "";
		String contextPath = null;
		
		if(homepage != null) {
			homepageFolder = "/homepage/" + homepage.getFolder();
			contextPath = "/" + homepage.getContext_path();
		}
		
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			service.dropBoard(board);
			res.setValid(true);
			
			if ( contextPath != null ) {
				res.setUrl(contextPath + "/boardDelete/index.do");	
			}
			else {
				res.setUrl("index.do");
			}
			
			res.setData(board.getUrlParam(boardManage, "index"));
			res.setMessage("게시물이 완전 삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
}