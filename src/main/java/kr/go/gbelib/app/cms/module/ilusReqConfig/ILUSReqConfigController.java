package kr.go.gbelib.app.cms.module.ilusReqConfig;

import java.text.SimpleDateFormat;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.common.api.LibSearchAPI;

@Controller
@RequestMapping(value = {"/cms/module/ilusReqConfig"})
public class ILUSReqConfigController extends  BaseController {

	private final String basePath = "/cms/module/ilusReqConfig/";

	@Autowired
	private ILUSReqConfigService service;

	@Autowired
	private CodeService codeService;

	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, ILUSReqConfig ilusReqConfig, HttpServletRequest request) {
		ilusReqConfig.setHomepage_id(getAsideHomepageId(request));
		Homepage homepage = getHomepageOne(ilusReqConfig.getHomepage_id());

//		Map<String, Object> result = LibSearchAPI.getSubLocaInfo(homepage.getHomepage_code());
//
//		model.addAttribute("ilusReqConfig", ilusReqConfig);
//		model.addAttribute("ilusReqConfigList", service.getILusReqConfigList(ilusReqConfig));
//		model.addAttribute("ilusReqCode", codeService.getCode(ilusReqConfig.getHomepage_id(), "C0024"));
//		model.addAttribute("subLocation", result.get("dsLibInfo"));

		return basePath + "index";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ILUSReqConfig ilusReqConfig, HttpServletRequest request) throws AuthException {
		Homepage homepage = getHomepageOne(ilusReqConfig.getHomepage_id());

		if(ilusReqConfig.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);

			model.addAttribute("ilusReqConfig", service.copyObjectPaging(ilusReqConfig, service.getILUSReqConfigOne(ilusReqConfig)));
		} else {
			checkAuth("C", model, request);
			ilusReqConfig.setLoca_name(homepage.getHomepage_name());
			ilusReqConfig.setLoca_code(homepage.getLib_code());

			model.addAttribute("ilusReqConfig", ilusReqConfig);
			model.addAttribute("subLacaList", service.getSubLacaList(ilusReqConfig));
		}

//		Map<String, Object> result = LibSearchAPI.getSubLocaInfo(homepage.getHomepage_code());
//
//		model.addAttribute("homepage", homepage);
//		model.addAttribute("ilusReqCode", codeService.getCode(ilusReqConfig.getHomepage_id(), "C0024"));
//		model.addAttribute("subLocation", result.get("dsLibInfo"));

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(ILUSReqConfig ilusReqConfig, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if(ilusReqConfig.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "sub_loca_codes", "자료실을 선택하세요.");
		}
		for(int i = 0; i < ilusReqConfig.getIlus_config_list().size(); i++) {
			if(ilusReqConfig.getIlus_config_list().get(i).getUse_yn().equals("Y")) {
				ValidationUtils.rejectIfEmpty(result, "ilus_config_list["+i+"].str_date", "기간시작일자를 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "ilus_config_list["+i+"].end_date", "기간종료일자를 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "ilus_config_list["+i+"].str_time", "기간시작시간를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "ilus_config_list["+i+"].end_time", "기간종료시간를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "ilus_config_list["+i+"].res_msg", "메세지를 입력하세요.");
				ValidationUtils.rejectIfStringLength(result, "ilus_config_list["+i+"].res_msg", 1000, "메세지");

				SimpleDateFormat sfTime = new SimpleDateFormat("HH:mm");
				sfTime.setLenient(false);
				try {
					String strDate = ilusReqConfig.getIlus_config_list().get(i).getStr_date();
					String endDate = ilusReqConfig.getIlus_config_list().get(i).getEnd_date();
					String strTime = ilusReqConfig.getIlus_config_list().get(i).getStr_time();
					String endTime = ilusReqConfig.getIlus_config_list().get(i).getEnd_time();

					int nstr_time =  Integer.parseInt(strTime.replaceAll(":", ""));
					int nend_time =  Integer.parseInt(endTime.replaceAll(":", ""));
					if(strDate.equals(endDate) && nstr_time > nend_time ) {
						result.reject("시작기간과 종료기간이 같을 경우 시작시간이 종료시간보다 빠를 수 없습니다.");
					}
				} catch (Exception e) {
					result.reject("시간입력은 00:00 ~ 23:59 범위 입니다.");
				}
			}

		}

		if(!result.hasErrors()) {

			if(ilusReqConfig.getEditMode().equals("ADD")) {
				for(int i = 0; i<ilusReqConfig.getIlus_config_list().size(); i++) {
					ILUSReqConfig one = ilusReqConfig.getIlus_config_list().get(i);
					one.setAdd_id(getSessionMemberId(request));

					String strDate = one.getStr_date() + " " + one.getStr_time();
					String endDate = one.getEnd_date() + " " + one.getEnd_time();
					one.setStr_date(strDate.trim());
					one.setEnd_date(endDate.trim());

					one.setHomepage_id(ilusReqConfig.getHomepage_id());
					one.setLoca_name(ilusReqConfig.getLoca_name());
					one.setLoca_code(ilusReqConfig.getLoca_code());

					for(String sub_loca : ilusReqConfig.getSub_loca_codes()) {
						one.setIlus_req_idx(service.getILUSReqIdx(ilusReqConfig));
						one.setSub_loca_code(sub_loca);
						service.mergeILUSReqConfig(one);
					}
				}
				res.setValid(true);
				res.setReload(true);
				res.setMessage("등록되었습니다.");
			} else if(ilusReqConfig.getEditMode().equals("MODIFY")) {

				for(int i = 0; i<ilusReqConfig.getIlus_config_list().size(); i++) {
					ILUSReqConfig one = ilusReqConfig.getIlus_config_list().get(i);
					one.setAdd_id(getSessionMemberId(request));

					String strDate = one.getStr_date() + " " + one.getStr_time();
					String endDate = one.getEnd_date() + " " + one.getEnd_time();
					one.setStr_date(strDate.trim());
					one.setEnd_date(endDate.trim());

					one.setHomepage_id(ilusReqConfig.getHomepage_id());
					one.setLoca_name(ilusReqConfig.getLoca_name());
					one.setLoca_code(ilusReqConfig.getLoca_code());
					one.setSub_loca_code(ilusReqConfig.getSub_loca_code());
					service.mergeILUSReqConfig(one);
				}

				res.setValid(true);
				res.setReload(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(ILUSReqConfig ilusReqConfig, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			service.deleteILUSReqConfig(ilusReqConfig);
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
