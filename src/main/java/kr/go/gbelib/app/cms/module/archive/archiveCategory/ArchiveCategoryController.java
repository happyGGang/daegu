package kr.go.gbelib.app.cms.module.archive.archiveCategory;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/module/archive/archiveCategory"})
public class ArchiveCategoryController extends BaseController {

	private final String basePath = "/cms/module/archive/archiveCategory/";
	
	@Autowired
	private ArchiveCategoryService service;
	
	@RequestMapping(value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, ArchiveCategory archiveCategory, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		model.addAttribute("archiveCategory", archiveCategory);
		model.addAttribute("largeCodeList", service.getLargeCategoryList());
		return basePath + "index";
	}
	
	@RequestMapping (value = { "/getMidCategoryList.*" }, method = RequestMethod.GET)
	public @ResponseBody List<ArchiveCategory> getMidCodeList(ArchiveCategory archiveCategory, HttpServletRequest request) {
		return service.getMidCategoryList(archiveCategory);
	}

	@RequestMapping (value = { "/getSmallCategoryList.*" }, method = RequestMethod.GET)
	public @ResponseBody List<ArchiveCategory> getSmallCodeList(ArchiveCategory archiveCategory, HttpServletRequest request) {
		return service.getSmallCategoryList(archiveCategory);
	}
	
	@RequestMapping (value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(ArchiveCategory archiveCategory, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if (archiveCategory.getEditMode().equals("ADD") || archiveCategory.getEditMode().equals("MODIFY")) {
			if (archiveCategory.getTempCode().equals("--")) {
				result.reject("카테고리 코드에 --은 사용할 수 없습니다.");
			}
		}

		if ( !result.hasErrors() ) {
			archiveCategory.setCud_id(getSessionMemberId(request));
			if (archiveCategory.getEditMode().equals("ADD")) {
				int dupCheck = service.dupCheck(archiveCategory);
				if (dupCheck == 1) {
					res.setMessage("이미 존재하는 카테고리 코드입니다.");
					res.setValid(false);
				} else if (dupCheck ==2) {
					res.setMessage("이미 존재하는 카테고리 명입니다.");
					res.setValid(false);
				} else {
				
					if(service.addArchiveCategory(archiveCategory) > 0) {
						res.setMessage("등록되었습니다.");
						res.setValid(true);
						res.setData(archiveCategory);
					}else {
						res.setMessage("등록에 실패하였습니다.");
						res.setValid(false);
					}
				}
			} else if (archiveCategory.getEditMode().equals("MODIFY")) {
				int dupCheck = service.dupCheck(archiveCategory);
				if (dupCheck == 1) {
					res.setMessage("이미 존재하는 카테고리 코드입니다.");
					res.setValid(false);
				} else if (dupCheck == 2) {
					res.setMessage("이미 존재하는 카테고리 명입니다.");
					res.setValid(false);
				} else {
					if (service.modifyArchiveCategory(archiveCategory) > 0) {
						res.setMessage("수정되었습니다.");
						res.setValid(true);
						res.setData(archiveCategory);
					} else {
						res.setMessage("수정에 실패하였습니다.");
						res.setValid(false);
					}
					
				}
			} else if (archiveCategory.getEditMode().equals("DELETE")) {
				int childCheck = service.childCheck(archiveCategory);
				if (childCheck > 1) {
					res.setMessage("하위 카테고리가 존재합니다. 하위 카테고리부터 삭제해 주세요.");
					res.setValid(false);
				} else {
					int archiveDataCheck = service.archiveDataCheck(archiveCategory);
					if (archiveDataCheck > 0) {
						res.setMessage("해당 카테고리를 사용하고 있는 아카이브 자료가 있습니다. 아카이브 자료부터 삭제하시길 바랍니다.");
						res.setValid(false);
					} else {
						if (service.deleteArchiveCategory(archiveCategory) > 0) {
							res.setMessage("삭제되었습니다.");
							res.setValid(true);
						} else {
							res.setMessage("삭제에 실패하였습니다.");
							res.setValid(false);
						}
					}
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/saveList.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveList(Model model, @RequestBody ArchiveCategory[] categoryList, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if(categoryList == null || categoryList.length == 0) {
			res.setValid(false);
			res.setMessage("저장할 카테고리가 없습니다.");
		} else {
			service.saveCategoryList(categoryList, getSessionMemberId(request));
			res.setValid(true);
			res.setMessage("저장되었습니다.");
		}

		return res;
	}
	
}
