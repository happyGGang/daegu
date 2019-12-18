/**
 *
 */
package kr.co.whalesoft.app.cms.recommendSite;

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
import kr.co.whalesoft.framework.utils.ValidationUtils;

/**
 * @author whaleesoft YONGJU 2019. 11. 28.
 *
 */
@Controller
@RequestMapping (value = {"/cms/recommendSite"})
public class RecommendSiteController extends BaseController {

	private final String basePath = "/cms/recommendSite/";

	@Autowired
	private RecommendSiteService service;

	@RequestMapping (value = {"/index.*"})
	public String index(Model model, RecommendSite recommendSite, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		// if ( !getSessionIsAdmin(request) ) {
		recommendSite.setHomepage_id(getAsideHomepageId(request));
		// }

		int count = service.getRecommendSiteListCount(recommendSite);
		service.setPaging(model, count, recommendSite);
		recommendSite.setTotalDataCount(count);
		model.addAttribute("recommendSite", recommendSite);
		model.addAttribute("siteListCount", count);
		model.addAttribute("siteList", service.getRecommendSiteList(recommendSite));

		return basePath + "index";
	}

	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, RecommendSite recommendSite, HttpServletRequest request) throws AuthException {
		if (recommendSite.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("recommendSite", service.copyObjectPaging(recommendSite, service.getRecommendSiteOne(recommendSite)));
		} else {
			checkAuth("C", model, request);
			recommendSite.setPrint_seq(service.getNextPrintSeq(recommendSite.getHomepage_id()));
			
			model.addAttribute("recommendSite", recommendSite);
		}

		return basePath + "edit_ajax";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, RecommendSite recommendSite, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = recommendSite.getEditMode();
		
		if(!editMode.equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "recommend_site_name", "사이트명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "link_target", "링크를 입력하세요.");
		}

		if (!result.hasErrors()) {
			if (editMode.equals("ADD")) {
				recommendSite.setAdd_id(getSessionMemberId(request));
				service.addRecommendSite(recommendSite);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if (editMode.equals("MODIFY")) {
				recommendSite.setModify_id(getSessionMemberId(request));
				service.modifyRecommendSite(recommendSite);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if (editMode.equals("DELETE")) {
				service.deleteRecommendSite(recommendSite);
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
