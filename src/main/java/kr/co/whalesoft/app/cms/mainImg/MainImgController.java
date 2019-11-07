package kr.co.whalesoft.app.cms.mainImg;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/mainImg"})
public class MainImgController extends BaseController {

	private final String basePath = "/cms/mainImg/";

	@Autowired
	private MainImgService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, MainImg mainImg, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			mainImg.setHomepage_id(getAsideHomepageId(request));	
//		}
		int count = service.getMainImgListCount(mainImg);
		service.setPaging(model, count, mainImg);
		mainImg.setTotalDataCount(count);
		model.addAttribute("mainImg", mainImg);
		model.addAttribute("mainImgListCount", count);
		model.addAttribute("mainImgList", service.getMainImgList(mainImg));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, MainImg mainImg, HttpServletRequest request) throws AuthException {
		if(mainImg.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("mainImg", service.copyObjectPaging(mainImg, service.getMainImgOne(mainImg)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("mainImg", mainImg);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, MainImg mainImg, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = mainImg.getEditMode();
	/*	if(!teach.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "homepage_name", "홈페이지명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "homepage_type", "홈페이지 유형을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "domain", "도메인명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "folder", "폴더명을 입력하세요.");
		}*/
		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				service.addMainImg(mainImg);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				service.modifyMainImg(mainImg);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteMainImg(mainImg);
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