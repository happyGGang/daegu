package kr.go.gbelib.app.cms.module.themeBook;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/module/themeBook"})
public class ThemeBookController extends BaseController{

	private final String basePath = "/cms/module/themeBook/";
	
	@Autowired
	private ThemeBookService service;
	
	@Autowired
	private BoardManageService boardManageService;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, ThemeBook themeBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			themeBook.setHomepage_id(getAsideHomepageId(request));	
//		}
		
		if (StringUtils.isEmpty(themeBook.getSearchYear())) {
			themeBook.setSearchYear(new SimpleDateFormat("yyyy").format(new Date()));
		}
		
		String currentYear = new SimpleDateFormat("yyyy").format(new Date());
		
		List<String> yearList = new ArrayList<String>();
		for (int i = Integer.parseInt(currentYear); i >= 2015; i--) {
			yearList.add(String.valueOf(i));
		}
		
		if (themeBook != null) {
			if (StringUtils.isNotEmpty(themeBook.getHomepage_id()) && themeBook.getManage_idx() > 0) {
				BoardManage boardManageOne = boardManageService.getBoardManageOne(new BoardManage(themeBook.getHomepage_id(), themeBook.getManage_idx()));
				if (boardManageOne != null && StringUtils.isNotEmpty(boardManageOne.getCategory1())) {
					List<Code> category1List = codeService.getCode(themeBook.getHomepage_id(), boardManageOne.getCategory1());
					if (category1List != null && category1List.size() > 0 && StringUtils.isEmpty(boardManageOne.getCategory1())) {
						themeBook.setCategory1(category1List.get(0).getCode_id());
					}
					model.addAttribute("category1List", category1List);
				}
			}
		}
		model.addAttribute("yearList", yearList);
		model.addAttribute("themeBook", themeBook);
		model.addAttribute("themeBookList", service.getThemeBookList(themeBook));
		model.addAttribute("boardManageList", boardManageService.getThemeBookBoardManage(new BoardManage(themeBook.getHomepage_id(), themeBook.getManage_idx())));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, ThemeBook themeBook, HttpServletRequest request) throws AuthException {

		if (themeBook.getEditMode().equals("ADD")) {
			checkAuth("C", model, request);
			model.addAttribute("themeBookOne", themeBook);
		} else if (themeBook.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("themeBookOne", service.copyObjectPaging(themeBook, service.getThemeBookOne(themeBook)));
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(ThemeBook themeBook, BindingResult result, HttpServletRequest request) {

		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		
		if (!themeBook.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "homepage_id", "홈페이지를 설정해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "subject", "주제를 입력해주세요.");
		}

		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			themeBook.setCud_id(getSessionMemberId(request));
			if (themeBook.getEditMode().equals("ADD")) {
				service.addThemeBook(themeBook);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if (themeBook.getEditMode().equals("MODIFY")) {
				service.modifyThemeBook(themeBook);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if (themeBook.getEditMode().equals("DELETE")) {
				service.deleteThemeBook(themeBook);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
