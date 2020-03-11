package kr.go.gbelib.app.cms.module.archive;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller(value="cmsArchiveController")
@RequestMapping(value = {"/cms/module/archive"})
public class ArchiveController extends  BaseController {

	private final String basePath = "/cms/module/archive/";

	@Autowired
	private ArchiveService service;

	@Autowired
	private CodeService codeService;

	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, Archive archive, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		archive.setHomepage_id(getAsideHomepageId(request));

		int count = service.getArchiveBookCountCms(archive);
		archive.setTotalDataCount(count);
		service.setPaging(model, count, archive);

		List<Archive> list = service.getArchiveBookListCms(archive);

		model.addAttribute("archive", archive);
		model.addAttribute("count", count);
		model.addAttribute("archiveBookList", list);

		model.addAttribute("categoryList", codeService.getCode(getAsideHomepageId(request), "H0004"));

		return basePath + "index";
	}

	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, Archive archive, HttpServletRequest request) throws AuthException {

		if("MOD".equals(archive.getEditMode())) {
			archive = service.getArchiveBook(archive);
			archive.setEditMode("MOD");
		}

		model.addAttribute("archive", archive);
		model.addAttribute("homepage_id", getAsideHomepageId(request));

		model.addAttribute("categoryList", codeService.getCode(getAsideHomepageId(request), "H0004"));

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Archive archive, BindingResult result, HttpServletRequest request) throws AuthException {
		JsonResponse res = new JsonResponse(request);
		archive.setHomepage_id(getAsideHomepageId(request));

		String editMode = archive.getEditMode();

		if(!"REORDER".equals(editMode)) {
			ValidationUtils.rejectIfEmpty(result, "subject", "제목을 입력하세요.");
		}

		if(!result.hasErrors()) {
			String member_id = getSessionMemberId(request);
			archive.setAdd_id(member_id);
			archive.setMod_id(member_id);
			if("ADD".equals(editMode)) {
				service.addArchiveBook(archive);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if("MOD".equals(editMode)) {
				service.modArchiveBook(archive);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if("REORDER".equals(editMode)) {
				service.reorderArchiveBook(archive);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(Model model, Archive archive, BindingResult result, HttpServletRequest request) throws AuthException {
		JsonResponse res = new JsonResponse(request);
		archive.setHomepage_id(getAsideHomepageId(request));

		if(!result.hasErrors()) {
			service.delArchiveBook(archive);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/page_index.*"}, method = RequestMethod.GET)
	public String page_index(Model model, Archive archive, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);

		int count = service.getArchivePageCount(archive);
		List<Archive> list = service.getArchivePageListCms(archive);
//		archive = service.getArchivePage(archive);

		model.addAttribute("archive", archive);
		model.addAttribute("count", count);
		model.addAttribute("archivePageList", list);

		return basePath + "page_index";
	}

	@RequestMapping(value = {"/page_save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse page_save(Model model, Archive archive, BindingResult result, MultipartHttpServletRequest request) throws AuthException {
		JsonResponse res = new JsonResponse(request);
		String editMode = archive.getEditMode();

//		ValidationUtils.rejectIfEmpty(result, "subject", "제목을 입력하세요.");

		if(!result.hasErrors()) {
			String member_id = getSessionMemberId(request);
			archive.setAdd_id(member_id);
			archive.setMod_id(member_id);
			archive.setHomepage_id(getAsideHomepageId(request));
			if("ADD".equals(editMode)) {
				service.addArchivePage(archive);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if("MOD".equals(editMode)) {
				service.modArchivePage(archive);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}


	@RequestMapping(value = {"/page_delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse page_delete(Model model, Archive archive, BindingResult result, HttpServletRequest request) throws AuthException {
		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			service.delArchivePage(archive);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/page_delete_image.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse page_delete_image(Model model, Archive archive, BindingResult result, HttpServletRequest request) throws AuthException {
		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			service.delArchivePageFile(archive);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/page_move_up.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse page_move_up(Model model, Archive archive, BindingResult result, HttpServletRequest request) throws AuthException {
		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			service.moveUpArchivePage(archive);
			res.setValid(true);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/page_move_down.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse page_move_down(Model model, Archive archive, BindingResult result, HttpServletRequest request) throws AuthException {
		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			service.moveDownArchivePage(archive);
			res.setValid(true);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
