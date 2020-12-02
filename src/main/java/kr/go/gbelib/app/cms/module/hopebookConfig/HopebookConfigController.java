package kr.go.gbelib.app.cms.module.hopebookConfig;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.cms.homepage.HomepageService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/hopeConfig"})
public class HopebookConfigController extends BaseController {
	
	private final String basePath = "/cms/module/hopebookConfig/";
	
	@Autowired
	private HopebookConfigService service;

	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, HopebookConfig hopebookConfig, HttpServletRequest request) {
//		hopebookConfig.setHomepage_id(getAsideHomepageId(request));
//		Homepage homepage = getHomepageOne(hopebookConfig.getHomepage_id());
//		Homepage homepage = getSessionHomepageInfo(request);
//		hopebookConfig.setHomepage_id(homepage.getHomepage_id());

		if ((getAsideHomepageId(request).equals("h37") || getAsideHomepageId(request).equals("h49") || getAsideHomepageId(request).equals("h45") || getAsideHomepageId(request).equals("h53"))) {
			Homepage sessionHomepageInfo = getSessionHomepageInfo(request);
			sessionHomepageInfo.setHomepage_group(getAsideHomepageId(request));
			sessionHomepageInfo.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(sessionHomepageInfo);
			if (StringUtils.isEmpty(hopebookConfig.getHomepage_id())) {
				hopebookConfig.setHomepage_id(subHomepageList.get(0).getHomepage_id());
				model.addAttribute("homepage", subHomepageList.get(0));
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			hopebookConfig.setHomepage_id(getAsideHomepageId(request));
		}

		
		model.addAttribute("hopebookConfig", hopebookConfig);
		model.addAttribute("hopebookConfigList", service.getHopebookList(hopebookConfig));
		model.addAttribute("homepage", getSessionHomepageInfo(request));

		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, HopebookConfig hopebookConfig, HttpServletRequest request) {
		Homepage homepage = getHomepageOne(hopebookConfig.getHomepage_id());
		
		model.addAttribute("hopebookConfig", service.copyObjectPaging(hopebookConfig, service.getHopebookConfigOne(hopebookConfig)));
		model.addAttribute("homepage", homepage);

		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(HopebookConfig hopebookConfig, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "str_date", "사용시작일자를 선택하세요.");
		ValidationUtils.rejectIfEmpty(result, "end_date", "사용종료일자를 선택하세요.");
		ValidationUtils.rejectIfEmpty(result, "str_time", "사용시작시간를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "end_time", "사용종료시간를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "res_msg", "메세지를 입력하세요.");
		ValidationUtils.rejectIfStringLength(result, "res_msg", 1000, "메세지");
		
		SimpleDateFormat sfTime = new SimpleDateFormat("HH:mm");
		sfTime.setLenient(false);
		try {
			String strDate = hopebookConfig.getStr_date();
			String endDate = hopebookConfig.getEnd_date();
			String strTime = hopebookConfig.getStr_time();
			String endTime = hopebookConfig.getEnd_time();
			
			int nstr_time =  Integer.parseInt(strTime.replaceAll(":", ""));
			int nend_time =  Integer.parseInt(endTime.replaceAll(":", ""));
			if(strTime.equals("24:00") || endTime.equals("00:00")) {
				throw new RuntimeException();
			}
			if(strDate.equals(endDate) && nstr_time > nend_time ) {
//				result.reject("시작기간과 종료기간이 같을 경우 시작시간이 종료시간보다 빠를 수 없습니다.");
				result.rejectValue("str_time", "시작기간과 종료기간이 같을 경우 시작시간이 종료시간보다 빠를 수 없습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
//			result.reject("시간입력은 00:00 ~ 23:59 범위 입니다.");
			result.rejectValue("end_time", "시간입력은 00:00 ~ 23:59 범위 입니다.");
		}
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			String strDate = hopebookConfig.getStr_date() + " " + hopebookConfig.getStr_time();
			String endDate = hopebookConfig.getEnd_date() + " " + hopebookConfig.getEnd_time();
			hopebookConfig.setStr_date(strDate);
			hopebookConfig.setEnd_date(endDate);
			
			hopebookConfig.setAdd_id(getSessionMemberId(request));
			service.addHopebookConfig(hopebookConfig);
			res.setValid(true);
			res.setReload(true);
			res.setMessage("등록되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(HopebookConfig hopebookConfig, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			service.deleteHopebookConfig(hopebookConfig);
			res.setValid(true);
			res.setReload(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
