package kr.go.gbelib.app.cms.module.schoolSupport;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/module/schoolSupport"})
public class SchoolSupportController extends BaseController {

	private final String basePath = "/cms/module/schoolSupport/";

	@Autowired
	private SchoolSupportService service;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, SchoolSupport schoolSupport, HttpServletRequest request) {
		schoolSupport.setHomepage_id(getAsideHomepageId(request));	
		
		if ( StringUtils.isEmpty(schoolSupport.getPlan_date()) ) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
			schoolSupport.setPlan_date(sf.format(new Date()));	
		}
		
		//schoolSupport.makeCalendar();
		model.addAttribute("calendarList", service.getCalendar(schoolSupport));
		model.addAttribute("schoolSupport", schoolSupport);
		model.addAttribute("schoolSupportRepo", service.makeRepo(service.getSupportList(schoolSupport), schoolSupport.getPlan_date()));
		model.addAttribute("areaList", codeService.getCode(schoolSupport.getHomepage_id(), "C0019"));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, SchoolSupport schoolSupport) {
		model.addAttribute("managerTypeList", codeService.getCode(schoolSupport.getHomepage_id(), "C0018"));
		model.addAttribute("areaList", codeService.getCode(schoolSupport.getHomepage_id(), "C0019"));
		if(schoolSupport.getEditMode().equals("MODIFY")) {
			model.addAttribute("schoolSupport", service.copyObjectPaging(schoolSupport, service.getSupportOne(schoolSupport)));
		} else {
			model.addAttribute("schoolSupport", schoolSupport);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, SchoolSupport schoolSupport, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = schoolSupport.getEditMode();
		if(!editMode.equals("DELETE")) {
			//ValidationUtils.rejectIfEmpty(result, "facility_name", "시설물명을 입력하세요.");
		}
		if(!result.hasErrors()) {
			schoolSupport.setAdd_id(getSessionMemberId(request));
			schoolSupport.setMod_id(getSessionMemberId(request));
			if(editMode.equals("ADD")) {
				schoolSupport.setSupport_status("1");
				service.addSupport(schoolSupport);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				service.modifySupport(schoolSupport);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteSupport(schoolSupport);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/list.*"})
	public String reqList(Model model, SchoolSupport schoolSupport, HttpServletRequest request) {
		int count = service.getSupportListByStatusCount(schoolSupport);
		service.setPaging(model, count, schoolSupport);
		model.addAttribute("schoolSupportList", service.getSupportListByStatus(schoolSupport));
		model.addAttribute("schoolSupportListCount", count);
		model.addAttribute("areaList", codeService.getCode(schoolSupport.getHomepage_id(), "C0019"));
		model.addAttribute("schoolSupport", schoolSupport);
		return basePath + "list_ajax";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public SchoolSupportSearchView excelDownload(Model model, SchoolSupport schoolSupport, HttpServletRequest request, HttpServletResponse response) throws Exception{
		model.addAttribute("schoolSupport", schoolSupport);
		model.addAttribute("result", service.makeRepo(service.getSupportListByExcel(schoolSupport), schoolSupport.getPlan_date()));
		return new SchoolSupportSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csvDownload(Model model, SchoolSupport schoolSupport, HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, List<SchoolSupport>> result = service.makeRepo(service.getSupportListByExcel(schoolSupport), schoolSupport.getPlan_date());
		
		new SchoolSupportXlsToCsv(schoolSupport, result, "학교도서관지원 리스트.csv", request, response);
	}
	
}