package kr.go.gbelib.app.module.readingNotes;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicant;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecord;
import kr.go.gbelib.app.cms.module.readingNotes.ReadingNotes;
import kr.go.gbelib.app.cms.module.readingNotes.ReadingNotesService;

@Controller(value = "userReadingNotes")
@RequestMapping(value = {"/{homepagePath}/module/readingNotes"})
public class ReadingNotesController extends BaseController {

	private final String basePath = "/homepage/%s/module/readingNotes/";
	
	@Autowired
	private ReadingNotesService service;
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, ReadingNotes readingNotes, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}
		
		readingNotes.setHomepage_id(homepage.getHomepage_id());
		readingNotes.setMember_id(getSessionMemberId(request));
		
		service.setPaging(model, service.getReadingNotesCount(readingNotes), readingNotes);
		model.addAttribute("readingNotes", readingNotes);
		model.addAttribute("readingNotesList", service.getReadingNotesList(readingNotes));
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ReadingNotes readingNotes, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		if (readingNotes.getEditMode().equals("ADD")) {
			readingNotes.setAdd_date(new Date());
			readingNotes.setHomepage_id(homepage.getHomepage_id());
			readingNotes.setMember_id(getSessionMemberId(request));

			int readingNotesMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 170));
			readingNotes.setMenu_idx(readingNotesMenuIdx);
			model.addAttribute("readingNotes", readingNotes);
		} else {
			readingNotes.setHomepage_id(homepage.getHomepage_id());
			readingNotes.setMember_id(getSessionMemberId(request));
			model.addAttribute("readingNotes", service.copyObjectPaging(readingNotes, service.getReadingNotesOne(readingNotes)));
		}

		return String.format(basePath, homepage.getFolder()) + "edit";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	@ResponseBody
	public JsonResponse save(ReadingNotes readingNotes, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		Member member = getSessionMemberInfo(request);
		
		
		/********* 유효성 검증 ***********/
		if (readingNotes.getEditMode().equals("ADD") || readingNotes.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "book_name", "도서명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "publisher", "출판사를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "author", "작가를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "isbn", "isbn을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "book_type", "책 종류를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "read_success_date", "완독일을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "contents", "내용을 입력하세요.");
			
			if(member == null) {
				result.reject("로그인 후 이용가능합니다.");
			}
			
			Date read_success_date_parse = null;
			String read_success_date = readingNotes.getRead_success_date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			try {
				read_success_date_parse = sdf.parse(read_success_date);
			} catch (ParseException e) {
				result.reject("완독일을 정확하게 입력하세요.");
			}
			
			Date date = new Date();
			
			int compareTo = read_success_date_parse.compareTo(date);
			if(compareTo > 0) {
				result.reject("완독일은 현재보다 이후일 수 없습니다.");
			}
		}
		
		/****************************/
		
		if (!result.hasErrors()) {
			int readingNotesMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 170));
			if (readingNotes.getEditMode().equals("ADD")) {
				readingNotes.setMember_id(member.getMember_id());
				readingNotes.setMember_name(member.getMember_name());
				readingNotes.setUser_no(member.getUser_no());
				service.addReadingNotes(readingNotes);
				res.setUrl(String.format("/%s/module/readingNotes/index.do?menu_idx=%s", homepage.getContext_path(), readingNotesMenuIdx));
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (readingNotes.getEditMode().equals("MODIFY")) {
				readingNotes.setMember_id(member.getMember_id());
				service.modifyReadingNotes(readingNotes);
				res.setUrl(String.format("/%s/module/readingNotes/index.do?menu_idx=%s", homepage.getContext_path(), readingNotesMenuIdx));
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if (readingNotes.getEditMode().equals("DELETE")) {
				readingNotes.setMember_id(member.getMember_id());
				service.deleteReadingNotes(readingNotes);
				res.setUrl(String.format("/%s/module/readingNotes/index.do?menu_idx=%s", homepage.getContext_path(), readingNotesMenuIdx));
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}
			
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/viewMemberNotesOneExcelDown.*"}) //나의 일지노트 엑셀 다운
	public String viewApplicantExcelDown(Model model, ReadingNotes readingNotes, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}
		
		Member member = getSessionMemberInfo(request);

		readingNotes.setMember_id(getSessionMemberId(request));
		List<ReadingNotes> readingNotesList = service.getReadingNotesList(readingNotes);
		
		model.addAttribute("readingNotesList", readingNotesList);
		request.setAttribute("readingNotes", readingNotes);
		request.setAttribute("member", member);
		return basePath + "viewMemberNotesOneExcelDown_ajax";
	}
}
