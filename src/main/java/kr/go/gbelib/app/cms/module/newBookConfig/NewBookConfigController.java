package kr.go.gbelib.app.cms.module.newBookConfig;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.cms.homepage.HomepageService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.ListUtils;
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
import kr.go.gbelib.app.common.api.LibSearchAPI;

@Controller
@RequestMapping(value = {"/cms/module/newBookConfig"})
public class NewBookConfigController extends BaseController {
	
	private final String basePath = "/cms/module/newBookConfig/";
	
	@Autowired
	private NewBookConfigService service;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, NewBookConfig newBookConfig, HttpServletRequest request) {
//		String homepage_id = getAsideHomepageId(request);
//		Homepage homepage = getHomepageOne(homepage_id);
//		newBookConfig.setHomepage_id(homepage_id);

		if ((getAsideHomepageId(request).equals("h37") || getAsideHomepageId(request).equals("h49") || getAsideHomepageId(request).equals("h45") || getAsideHomepageId(request).equals("h53"))) {
			Homepage sessionHomepageInfo = getSessionHomepageInfo(request);
			sessionHomepageInfo.setHomepage_group(getAsideHomepageId(request));
			sessionHomepageInfo.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(sessionHomepageInfo);
			if (StringUtils.isEmpty(newBookConfig.getManage_code())) {
				newBookConfig.setHomepage_id(subHomepageList.get(0).getHomepage_id());
				newBookConfig.setManage_code(subHomepageList.get(0).getManage_code());
			} else {
				for (Homepage homepage : subHomepageList) {
					if (newBookConfig.getManage_code().equals(homepage.getManage_code())) {
						newBookConfig.setHomepage_id(homepage.getHomepage_id());
						break;
					}
				}
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			newBookConfig.setHomepage_id(getAsideHomepageId(request));
			String homepage_id = getAsideHomepageId(request);
			Homepage homepage = getHomepageOne(homepage_id);
			newBookConfig.setHomepage_id(homepage_id);
			newBookConfig.setManage_code(homepage.getManage_code());
		}


		Map<String, Object> subLocaInfo = LibSearchAPI.getSubLocaInfo("19", newBookConfig.getManage_code());
		List<Map<String, Object>> result = LibSearchAPI.getListData(subLocaInfo, "LIST_DATA");
		List<String> code_arr = service.getShelfCodeList(newBookConfig);
		if (CollectionUtils.isNotEmpty(code_arr)) {
			for (Map<String, Object> map : result) {
				if(code_arr == null) {
					break;
				}

				if(code_arr.contains(map.get("CODE"))) {
					map.put("CHECKED", "checked");
				}
			}
		}

		model.addAttribute("shelfList", result);
		model.addAttribute("newBookConfig", newBookConfig);
//		model.addAttribute("homepage", homepage);

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(NewBookConfig newBookConfig, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			String add_id = getSessionMemberId(request);
			String[] code_arr = newBookConfig.getShelf_code_arr();
			service.newBookConfigDelete(newBookConfig);
			for (String code : code_arr) {
				NewBookConfig one = new NewBookConfig();
				one.setHomepage_id(newBookConfig.getHomepage_id());
				one.setAdd_id(add_id);
				one.setShelf_code(code);
				service.newBookConfigSave(one);
			}
			res.setValid(true);
			res.setMessage("등록되었습니다.");
			res.setReload(true);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
