package kr.co.whalesoft.app.board.boardComment;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/board/boardComment"})
public class BoardCommentController extends BaseController {

	private final String basePath = "/board/common/view/";
	
	@Autowired
	private BoardCommentService service;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, BoardComment boardComment, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		
		model.addAttribute("boardCommentList", service.getBoardComment(boardComment));
		model.addAttribute("boardComment", boardComment);
		model.addAttribute("boardManage", boardManage);
		
		if (boardComment.getManage_idx() == 563) {
			Code code = new Code();
			code.setHomepage_id("c0");
			code.setGroup_id("H0003");
			model.addAttribute("phoneList", codeService.getCode(code));
			
			Board board = new Board();
			board.setManage_idx(563);
			board.setBoard_idx(boardComment.getBoard_idx());
			
			board = boardService.getBoardOne(board);
			model.addAttribute("board", board);
		}
		return basePath + "comment_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BoardComment boardComment, BindingResult result, HttpServletRequest request) { 
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "comment_content", "내용을 입력하세요.");
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			if(boardComment.getEditMode().equals("MODIFY")) {
				service.modifyBoardComment(boardComment, request);
				res.setValid(true);
				res.setData(boardComment.getUrlParam("index"));
				res.setMessage("수정 되었습니다.");
			} else if(boardComment.getEditMode().equals("REPLY")) {
				service.addBoardReplyComment(boardComment, request);
				res.setValid(true);
				res.setUrl("/board/boardComment/index.do");
				res.setData(boardComment.getUrlParam("index"));
				res.setMessage("답글이 등록 되었습니다.");
			} else {
				service.addBoardComment(boardComment, request);
				res.setValid(true);
				res.setUrl("/board/boardComment/index.do");
				res.setData(boardComment.getUrlParam("index"));
				res.setMessage("등록 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(BoardComment boardComment, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */
		
		if(!(boardComment.getUser_id().equals(boardComment.getMember_id()))) {
			res.setValid(false);
			res.setMessage("타 사용자의 댓글은 삭제가 불가능합니다.");
			return res;
		}
		
		if(!result.hasErrors()) {
			service.deleteBoardComment(boardComment);
			res.setValid(true);
			res.setMessage("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
}
