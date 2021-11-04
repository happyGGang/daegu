package kr.go.gbelib.app.cms.module.newelib.comment;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.newelib.category.ElibCategory;
import kr.go.gbelib.app.cms.module.newelib.category.ElibCategoryService;
import kr.go.gbelib.app.cms.module.newelib.code.ElibCode;
import kr.go.gbelib.app.cms.module.newelib.code.ElibCodeService;

@Controller(value = "commentControllerNew")
public class CommentController extends BaseController {
	
	private final String basePath = "/cms/module/newelib/comment/";

//	@Autowired
//	private BookService service;
	
	@Autowired
	private ElibCategoryService elibCategoryService;
	
	@Autowired
	private ElibCodeService elibCodeService;
	
	@Autowired
	private CommentService service;
	
	@RequestMapping(value = {"/cms/module/newelib/comment/index.*"})
	public String index(Model model, Comment comment, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		comment.setHomepage_id(getAsideHomepageId(request));
		
//		if(book.getSortType() == null) book.setSortType("ASC");
//		
//		String sortField = book.getSortField();
//		if(StringUtils.equals(sortField, "TITLE")) {
//			book.setSortField("book_name");
//			book.setSortType("ASC");
//		} else if(StringUtils.equals(sortField, "lend_total")) {
//			book.setSortType("DESC");
//		}
		
		int count = service.getCommentListCmsCnt(comment);
		service.setPaging(model, count, comment);
		List<Comment> commentList = service.getCommentListCms(comment);
		
		model.addAttribute("comment", comment);
		model.addAttribute("obj", comment);
		model.addAttribute("commentListCnt", count);
		model.addAttribute("commentList", commentList);
		model.addAttribute("cateList", elibCategoryService.getCategoryList(new ElibCategory(comment.getType())));
		model.addAttribute("compList", elibCodeService.getCompList(new ElibCode(comment.getType())));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/cms/module/newelib/comment/edit.*"})
	public String edit(Model model, Comment comment, HttpServletRequest request) throws AuthException {
		checkAuth("U", model, request);
		comment.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("comment", service.getComment(comment));
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/cms/module/newelib/comment/save.*"})
	public @ResponseBody JsonResponse comment_save(Model model, Comment comment,  BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = comment.getEditMode();
		
		if(!comment.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "user_comment", "서평을 입력하세요.");
		}
		
		if(!result.hasErrors()) {
			comment.setMember_id(getSessionMemberId(request));
			
			if(editMode.equals("MODIFY")) {
				service.modifyComment(comment);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteCommentCms(comment);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/cms/module/newelib/comment/excelDownload.*"}, method = RequestMethod.POST)
	public CommentExcelView excel(Model model, Comment comment, HttpServletRequest request, HttpServletResponse response) throws Exception{
		model.addAttribute("comment", comment); 
		model.addAttribute("commentList", service.getCommentListAll(comment));
		return new CommentExcelView();
	}
	
	@RequestMapping(value = {"/cms/module/newelib/comment/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, Comment comment, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Comment> commentList = service.getCommentListAll(comment);
		
		new CommentXlsToCsv(comment, commentList, request, response);
	}
	
}