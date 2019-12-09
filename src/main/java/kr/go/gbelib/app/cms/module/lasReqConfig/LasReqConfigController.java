package kr.go.gbelib.app.cms.module.lasReqConfig;

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
@RequestMapping(value = {"/cms/module/lasReqConfig"})
public class LasReqConfigController extends  BaseController {

	private final String basePath = "/cms/module/lasReqConfig/";

	@Autowired
	private LasReqConfigService service;

	@Autowired
	private CodeService codeService;

	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, LasReqConfig lasReqConfig, HttpServletRequest request) {
		lasReqConfig.setHomepage_id(getAsideHomepageId(request));
		Homepage homepage = getHomepageOne(lasReqConfig.getHomepage_id());

		Map<String, Object> result = LibSearchAPI.getSubLocaInfo("19", homepage.getManage_code());
//
		model.addAttribute("lasReqConfig", lasReqConfig);
		model.addAttribute("lasReqConfigList", service.getLasReqConfigList(lasReqConfig));
		model.addAttribute("lasReqCode", codeService.getCode(lasReqConfig.getHomepage_id(), "C0024"));
		model.addAttribute("subLocation", result.get("LIST_DATA"));

		return basePath + "index";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, LasReqConfig lasReqConfig, HttpServletRequest request) throws AuthException {
		Homepage homepage = getHomepageOne(lasReqConfig.getHomepage_id());

		if(lasReqConfig.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);

			model.addAttribute("lasReqConfig", service.copyObjectPaging(lasReqConfig, service.getLasReqConfigOne(lasReqConfig)));
		} else {
			checkAuth("C", model, request);
			lasReqConfig.setLoca_name(homepage.getHomepage_name());
			lasReqConfig.setLoca_code(homepage.getLib_code());

			model.addAttribute("lasReqConfig", lasReqConfig);
			model.addAttribute("subLacaList", service.getSubLacaList(lasReqConfig));
		}

		Map<String, Object> result = LibSearchAPI.getSubLocaInfo("19", homepage.getManage_code());

		model.addAttribute("homepage", homepage);
		model.addAttribute("lasReqCode", codeService.getCode(lasReqConfig.getHomepage_id(), "C0024"));
		model.addAttribute("subLocation", result.get("LIST_DATA"));

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(LasReqConfig lasReqConfig, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if(lasReqConfig.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "sub_loca_codes", "자료실을 선택하세요.");
		}
		for(int i = 0; i < lasReqConfig.getLas_config_list().size(); i++) {
			if(lasReqConfig.getLas_config_list().get(i).getUse_yn().equals("Y")) {
				ValidationUtils.rejectIfEmpty(result, "las_config_list["+i+"].str_date", "기간시작일자를 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "las_config_list["+i+"].end_date", "기간종료일자를 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "las_config_list["+i+"].str_time", "기간시작시간를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "las_config_list["+i+"].end_time", "기간종료시간를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "las_config_list["+i+"].res_msg", "메세지를 입력하세요.");
				ValidationUtils.rejectIfStringLength(result, "las_config_list["+i+"].res_msg", 1000, "메세지");

				SimpleDateFormat sfTime = new SimpleDateFormat("HH:mm");
				sfTime.setLenient(false);
				try {
					String strDate = lasReqConfig.getLas_config_list().get(i).getStr_date();
					String endDate = lasReqConfig.getLas_config_list().get(i).getEnd_date();
					String strTime = lasReqConfig.getLas_config_list().get(i).getStr_time();
					String endTime = lasReqConfig.getLas_config_list().get(i).getEnd_time();

					int nstr_time =  Integer.parseInt(strTime.replaceAll(":", ""));
					int nend_time =  Integer.parseInt(endTime.replaceAll(":", ""));
					if(strTime.equals("24:00") || endTime.equals("00:00")) {
						throw new RuntimeException();
					}
					if(strDate.equals(endDate) && nstr_time > nend_time ) {
//						result.reject("시작기간과 종료기간이 같을 경우 시작시간이 종료시간보다 빠를 수 없습니다.");
						result.rejectValue("las_config_list["+i+"].str_time", "시작기간과 종료기간이 같을 경우 시작시간이 종료시간보다 빠를 수 없습니다.");
					}
				} catch (Exception e) {
//					result.reject("시간입력은 00:00 ~ 23:59 범위 입니다.");
					result.rejectValue("las_config_list["+i+"].end_time", "시간입력은 00:00 ~ 23:59 범위 입니다.");
				}
			}

		}

		if(!result.hasErrors()) {

			if(lasReqConfig.getEditMode().equals("ADD")) {
				for(int i = 0; i<lasReqConfig.getLas_config_list().size(); i++) {
					LasReqConfig one = lasReqConfig.getLas_config_list().get(i);
					one.setAdd_id(getSessionMemberId(request));

					String strDate = one.getStr_date() + " " + one.getStr_time();
					String endDate = one.getEnd_date() + " " + one.getEnd_time();
					one.setStr_date(strDate.trim());
					one.setEnd_date(endDate.trim());

					one.setHomepage_id(lasReqConfig.getHomepage_id());
					one.setLoca_name(lasReqConfig.getLoca_name());
					one.setLoca_code(lasReqConfig.getLoca_code());

					for(String sub_loca : lasReqConfig.getSub_loca_codes()) {
						one.setLas_req_idx(service.getLasReqIdx(lasReqConfig));
						one.setSub_loca_code(sub_loca);
						service.mergeLasReqConfig(one);
					}
				}
				res.setValid(true);
				res.setReload(true);
				res.setMessage("등록되었습니다.");
			} else if(lasReqConfig.getEditMode().equals("MODIFY")) {

				for(int i = 0; i<lasReqConfig.getLas_config_list().size(); i++) {
					LasReqConfig one = lasReqConfig.getLas_config_list().get(i);
					one.setAdd_id(getSessionMemberId(request));

					String strDate = one.getStr_date() + " " + one.getStr_time();
					String endDate = one.getEnd_date() + " " + one.getEnd_time();
					one.setStr_date(strDate.trim());
					one.setEnd_date(endDate.trim());

					one.setHomepage_id(lasReqConfig.getHomepage_id());
					one.setLoca_name(lasReqConfig.getLoca_name());
					one.setLoca_code(lasReqConfig.getLoca_code());
					one.setSub_loca_code(lasReqConfig.getSub_loca_code());
					service.mergeLasReqConfig(one);
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
	public @ResponseBody JsonResponse delete(LasReqConfig lasReqConfig, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			service.deleteLasReqConfig(lasReqConfig);
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
