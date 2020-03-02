package kr.go.gbelib.app.cms.module.portalMember;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/portalMember"})
public class PortalMemberController extends BaseController {
	
	private final String basePath = "/cms/module/portalMember/";
	
	@Autowired
	private PortalMemberService service;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, PortalMember portalMember, HttpServletRequest request) {
		
		service.setPaging(model, service.getPortalMemberCount(portalMember), portalMember);
	
		model.addAttribute("portalMember", portalMember);
		model.addAttribute("portalMemberList", service.getPortalMemberList(portalMember));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, PortalMember portalMember, HttpServletRequest request) throws AuthException {
		if(portalMember.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("portalMember", service.copyObjectPaging(portalMember, service.getPortalMemberOne(portalMember)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("portalMember", portalMember);
		}
		
		model.addAttribute("homepageList", homepageService.getNormalHomepage());
		
		return basePath + "edit_ajax";
	}
	
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(PortalMember portalMember, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		String editMode = portalMember.getEditMode();
		if(editMode.equals("ADD") || editMode.equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "agency_name", "기관명을 입력해주세요.");
			ValidationUtils.rejectOnlyKor(result, "agency_name", "학교명은 한글만 입력할 수 있습니다.");
			ValidationUtils.rejectIfEmpty(result, "agency_id", "아이디를 입력해주세요.");
			ValidationUtils.rejectOnlyEngNum(result, "agency_id", "아이디는 영문/숫자만 사용하실 수 있습니다.");
			
			if(portalMember.getAgency_id().length() > 10) {
    			result.rejectValue("agency_id", "아이디는 10자 이내만 사용하실 수 있습니다.");
    		}
			
			if(editMode.equals("ADD") || StringUtils.isNotEmpty(portalMember.getAgency_password())) {
				ValidationUtils.rejectIfEmpty(result, "agency_password", "비밀번호를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "password_check", "비밀번호를 입력해주세요.");
				
				if(portalMember.getAgency_password().length() < 5) {
        			result.rejectValue("agency_password", "비밀번호는 5자리 이상 입력해주세요.");
        		}
        		if(!StringUtils.equals(portalMember.getAgency_password(), portalMember.getPassword_check())) {
        			result.rejectValue("password_check", "비밀번호가 다릅니다.");
        		}
			}
			
			if(editMode.equals("ADD") && service.getPortalMemberOne(portalMember) != null) {
				res.setValid(false);
				res.setMessage("아이디가 중복됩니다.");
				return res;
			}
    		
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (editMode.equals("ADD")) {
				portalMember.setAdd_id(getSessionMemberId(request));
				service.addPortalMember(portalMember);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (editMode.equals("MODIFY")) {
				portalMember.setModify_id(getSessionMemberId(request));
				service.modifyPortalMember(portalMember);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deletePortalMember(portalMember);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			} else if(editMode.equals("DELETE_CHECK")) {
				service.deletePortalMemberArr(portalMember);
				res.setValid(true);
				res.setMessage("선택 삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value= {"/mysqlToTibero"})
	public void mysqlToTibero(Model model, PortalMember portalMember, HttpServletRequest request) {
		
		List<Map<String, Object>> listMap = service.getPortalMemberMySQL();
		for (Map<String, Object> map : listMap) {
			PortalMember pm = new PortalMember();
			String m_id = String.valueOf(map.get("m_id"));
			
			pm.setPortal_member_idx(Integer.parseInt(String.valueOf(map.get("m_num"))));
			pm.setAgency_name(String.valueOf(map.get("m_name")).equals("") ? "empty" : String.valueOf(map.get("m_name")));
			pm.setAgency_id(m_id.equals("") ? "empty" : m_id);
			pm.setAgency_password(m_id.equals("") ? "empty" : m_id);
			
			String level = String.valueOf(map.get("m_level"));
			String auth_group = "";
			if(level.equals("6")) { // 도서관
				auth_group = "2";
			} else if(level.equals("7") || level.equals("8") || level.equals("9") || level.equals("10")) { // 학교기관
				auth_group = "3";
			} else if(level.equals("3")) { // 사서
				auth_group = "4";
			} else if(level.equals("1")) { // 관리자
				auth_group = "1";
			} else { // 2:비회원, 5:강사, 11:작은도서관
				auth_group = "0";
			}
			pm.setAuth_group(auth_group);
			
			String lib_code = "";
			if(m_id.equals("7240043")) { // 중앙도서관
				lib_code = "122004";
			} else if(m_id.equals("7240044")) { // 두류도서관
				lib_code = "122002";
			} else if(m_id.equals("7240045")) { // 북부도서관
				lib_code = "122003";
			} else if(m_id.equals("7240047")) { // 228기념
				lib_code = "122001";
			} else if(m_id.equals("7240048")) { // 서부도서관
				lib_code = "122008";
			} else if(m_id.equals("7240049")) { // 동부도서관
				lib_code = "122010";
			} else if(m_id.equals("7240050")) { // 남부도서관
				lib_code = "122009";
			} else if(m_id.equals("7240051")) { // 달성도서관
				lib_code = "122011";
			} else if(m_id.equals("7240278")) { // 수성도서관
				lib_code = "122007";
			} else {
				lib_code = null;
			}
			pm.setLibrary_code(lib_code);
			
			try {
    			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    			String last_connect = String.valueOf(map.get("m_lastdate"));
    			
    			if(StringUtils.isNotEmpty(last_connect) && last_connect != "null") {
    				pm.setLast_connect(sdf.parse(last_connect + " 00:00:00"));
    			}
    			
    			pm.setAdd_date(sdf.parse(String.valueOf(map.get("m_date"))));
    			pm.setAdd_id(m_id.equals("") ? "empty" : m_id);
    			
    			String modify_date = String.valueOf(map.get("m_modymate"));
				if(StringUtils.isNotEmpty(modify_date) && modify_date != "null") {
					pm.setModify_date(sdf.parse(modify_date));
					pm.setModify_id(m_id.equals("") ? "empty" : m_id);
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			service.addMyGration(pm);
		}
	}

}
