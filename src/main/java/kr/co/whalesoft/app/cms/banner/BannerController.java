package kr.co.whalesoft.app.cms.banner;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/banner"})
public class BannerController extends BaseController {
	private final String basePath = "/cms/banner/";
	
	@Autowired
	private BannerService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Banner banner, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		banner.setHomepage_id(getAsideHomepageId(request));	
		int count = service.getBannerCount(banner);
		service.setPaging(model, count, banner);
		banner.setTotalDataCount(count);
		model.addAttribute("banner", banner);
		model.addAttribute("bannerList", service.getBanner(banner));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Banner banner, HttpServletRequest request) throws AuthException{
		if(banner.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			banner = (Banner)service.copyObjectPaging(banner, service.getBannerOne(banner));
		} else {
			checkAuth("C", model, request);
			banner.setPrint_seq(service.getNextPrintSeq(banner.getHomepage_id()));
			
			if(StringUtils.isEmpty(banner.getUse_yn())) {
				banner.setUse_yn("Y");
			}
		}
		
		model.addAttribute("banner", banner);
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Banner banner, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "banner_name", "타이틀을 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "banner_link", "배너 링크를 입력해주세요.");
		
		
		if(!result.hasErrors()) {
			if(banner.getEditMode().equals("ADD")) {
				if ( mpRequest.getFileMap().get("org_file_name_temp") == null ) {
					res.setValid(false);
					res.setMessage("이미지 파일을 지정해주세요.");
					return res;
				}	
			}
			
			if(banner.getEditMode().equals("ADD")) {
				banner.setAdd_id(getSessionMemberId(request));
				service.addBanner(banner, mpRequest);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(banner.getEditMode().equals("MODIFY")) {
				banner.setModify_id(getSessionMemberId(request));
				service.modifyBanner(banner, mpRequest);
				res.setValid(true); 
				res.setMessage("수정 되었습니다.");
			} else if(banner.getEditMode().equals("DELETE")) {
				service.deleteBanner(banner);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}	
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(Model model, Banner banner, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(!result.hasErrors()) {
			service.deleteBanner(banner);
			res.setValid(true);
			res.setResult("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/imgUpload.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse imgUpload(Banner banner, BindingResult result, MultipartHttpServletRequest mpRequest, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			res.setValid(true);
			res.setData(String.valueOf(service.addImgFile(getAsideHomepageId(request), mpRequest)));
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}
