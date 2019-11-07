package kr.co.whalesoft.app.cms.deptMng;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/deptMng"})
public class DeptMngController extends BaseController {
	
	private final String basePath = "/cms/deptMng/";
	
	@Autowired
	private DeptMngService service;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, DeptMng deptMng, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		deptMng.setHomepage_id(getAsideHomepageId(request));
		
		int count = service.getWorkMngCnt(deptMng);
		service.setPaging(model, count, deptMng);
		
		List<DeptMng> workList = service.getWorkMngList(deptMng);
		for (DeptMng one : workList) {
			one.setWork_info(one.getWork_info().replaceAll("\n", "<br/>"));
		}
		
		model.addAttribute("deptMng", deptMng);
		model.addAttribute("workList", workList);
		model.addAttribute("deptList", service.getDeptList(deptMng));
		model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(deptMng.getHomepage_id())));

		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, DeptMng deptMng, HttpServletRequest request) throws AuthException {
		if(deptMng.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			deptMng = (DeptMng)service.copyObjectPaging(deptMng, service.getWorkMngOne(deptMng));
		} else {
			checkAuth("C", model, request);
			deptMng.setPrint_seq(service.getNextPrintSeq(deptMng));
		}
		
		model.addAttribute("deptMng", deptMng);
		model.addAttribute("deptList", service.getDeptList(deptMng));
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(DeptMng deptMng, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "position", "'직위' 필수 입력 항목입니다.");
		ValidationUtils.rejectIfStringLength(result, "position", 50, "직위");
		ValidationUtils.rejectIfEmpty(result, "worker", "'성명' 필수 입력 항목입니다.");
		ValidationUtils.rejectIfStringLength(result, "worker", 50, "담당자");
		ValidationUtils.rejectIfEmpty(result, "phone", "'전화번호' 필수 입력 항목입니다.");
		ValidationUtils.rejectIfStringLength(result, "phone", 13, "전화번호");
		ValidationUtils.rejectIfEmpty(result, "work_info", "'업무' 필수 입력 항목입니다.");
		ValidationUtils.rejectIfStringLength(result, "work_info", 2000, "업무내용");
		ValidationUtils.rejectIfEmpty(result, "print_seq", "'출력순서' 필수 입력 항목입니다.");
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			if(deptMng.getEditMode().equals("ADD")) {
				deptMng.setAdd_id(getSessionMemberId(request));
				service.addWorkMng(deptMng);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if(deptMng.getEditMode().equals("MODIFY")) {
				deptMng.setMod_id(getSessionMemberId(request));
				service.modifyWorkMng(deptMng);
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
	public @ResponseBody JsonResponse delete(DeptMng deptMng, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			service.deleteWorkMng(deptMng);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/deptEdit.*"})
	public String deptEdit(Model model, DeptMng deptMng, HttpServletRequest request) throws AuthException {
		deptMng.setChart_yn(service.getdeptChartYN(deptMng));
		deptMng.setAbove_idx(-1);
		model.addAttribute("deptMng", deptMng);
		model.addAttribute("deptList", service.getDeptList(deptMng));
		
		return basePath + "deptEdit_ajax";
	}
	
	@RequestMapping(value = {"/deptSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deptSave(DeptMng deptMng, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "dept_name", "'부서' 필수 입력 항목입니다.");
		ValidationUtils.rejectIfStringLength(result, "dept_name", 100, "부서");
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			if(deptMng.getEditMode().equals("ADD")) {
				deptMng.setAdd_id(getSessionMemberId(request));
				deptMng.setDept_print_seq(service.getDeptNextPrintSeq(deptMng));
				service.addDeptMng(deptMng);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if(deptMng.getEditMode().equals("MODIFY")) {
				deptMng.setMod_id(getSessionMemberId(request));
				service.modifyDeptMng(deptMng);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/deptDelete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deptDelete(DeptMng deptMng, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			service.deleteDeptMng(deptMng);
			service.deleteWorkAll(deptMng);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/chartMod.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse chartMod(DeptMng deptMng, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			service.modChardYN(deptMng);
			res.setValid(true);
			res.setMessage("조직도 표시여부가 변경되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
}
