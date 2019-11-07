package kr.go.gbelib.app.cms.module.beacon;

import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.RequestUtils;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/beacon"})
public class BeaconController extends BaseController{

	private final String basePath = "/cms/module/beacon/";
	
	@Autowired
	private BeaconService service;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, Beacon beacon, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		if (StringUtils.isEmpty(beacon.getLib_code())) {
			beacon.setLib_code(getHomepageOne(getAsideHomepageId(request)).getHomepage_code());
		}
		
		if (getAsideHomepageId(request).startsWith("h")) {
			Homepage homepage = homepageService.getHomepageOne(new Homepage(getAsideHomepageId(request)));
			
			if(homepage.getHomepage_code() != null) {
				beacon.setLib_code(homepage.getHomepage_code().substring(0, 8));
			}
		}
		
		int count = service.getBeaconListCount(beacon);
		service.setPaging(model, count, beacon);
		
		model.addAttribute("beacon", beacon);
		model.addAttribute("beaconListCount", count);
		model.addAttribute("beaconList", service.getBeaconList(beacon));
		
		
		
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, Beacon beacon, HttpServletRequest request) throws AuthException{
		if ( beacon.getEditMode().equals("ADD") ) {
			checkAuth("C", model, request);
			beacon.setLib_code(getHomepageOne(getAsideHomepageId(request)).getHomepage_code());
			model.addAttribute("beacon", beacon);
		} else if ( beacon.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request);
			model.addAttribute("beacon", service.copyObjectPaging(beacon, service.getBeaconOne(beacon)));
		}
						
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Beacon beacon, BindingResult result, HttpServletRequest request) {
		
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		if ( beacon.getEditMode().equals("ADD") || beacon.getEditMode().equals("MODIFY") ) {
			ValidationUtils.rejectIfEmpty(result, "lib_code", "도서관을 선택해주세요.");
			ValidationUtils.rejectIfEmpty(result, "type", "비콘 타입을 선택해주세요.");
			ValidationUtils.rejectIfEmpty(result, "content", "내용을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "minor", "MINOR를 입력해주세요.");
			ValidationUtils.rejectExceptNumber(result, "minor", "MINOR는 숫자만 입력 가능합니다.");		
			
			if ( beacon.getMinor() == 0 ) {
				res.setValid(false);
				res.setMessage("MINOR 항목은 0 보다 커야 합니다.");
				return res;
			}
			
			if ( beacon.getEditMode().equals("ADD") ) {
				ValidationUtils.rejectIfEmpty(result, "major", "MAJOR를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "distance", "DISTANCE를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "uuid", "UUID를 입력해주세요.");
				ValidationUtils.rejectExceptNumber(result, "major", "MAJOR는 숫자만 입력 가능합니다.");
				ValidationUtils.rejectIfStringLength(result, "uuid", 36, "UUID");
				ValidationUtils.rejectIfStringLength(result, "major", 10, "MAJOR");
				ValidationUtils.rejectIfStringLength(result, "distance", 30, "DISTANCE");
				
				if ( beacon.getMajor() == 0 ) {
					res.setValid(false);
					res.setMessage("MAJOR 항목은 0 보다 커야 합니다.");
					return res;
				}
			}
			
			ValidationUtils.rejectIfStringLength(result, "minor", 10, "MINOR");
			ValidationUtils.rejectIfStringLength(result, "content", 2000, "CONTENT");
			
			if ( service.checkMinor(beacon) > 0 ) {
				res.setValid(false);
				res.setMessage("중복되는 MINOR 값이 있습니다.");
				return res;
			}
			
		}
		
		if ( !result.hasErrors() ) {
			Member member = getSessionMemberInfo(request);
			beacon.setMod_id(member.getMember_id());
			beacon.setMod_nm(member.getMember_name());
			beacon.setMod_ip(RequestUtils.getClientIpAddr(request));
			if ( beacon.getEditMode().equals("ADD") ) {
				service.addBeacon(beacon);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} 
			else if ( beacon.getEditMode().equals("MODIFY") ) {
				service.modifyBeacon(beacon);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if ( beacon.getEditMode().equals("FILEDELETE") ) {
				service.deleteBeaconFile(beacon);
				res.setValid(true);
				res.setMessage("파일 정상 삭제 되었습니다.");
			}
			else if ( beacon.getEditMode().equals("DELETE") ) {
				service.deleteBeacon(beacon);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} 
		else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
}
