/**
 *
 */
package kr.go.gbelib.app.cms.module.mapExample;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.base.CommonBean;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtilsFromMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * @author whaleesoft YONGJU 2020. 2. 12.
 *
 */
@Controller
@RequestMapping(value = {"/cms/module/mapExample"})
public class MapExampleController extends BaseController {

	private final String basePath = "/cms/module/mapExample/";

	@Autowired
	private MapExampleService service;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping (value = {"/index{url}.*"}, method = RequestMethod.GET)
	public String index(Model model, CommonBean boy, HttpServletRequest request, @PathVariable ("url") String url) throws AuthException {
		checkAuth("R", model, request);
		boy.put("homepage_id", getAsideHomepageId(request));
		service.setPaging(model, service.getBookOfYearCount(boy.getMap()), boy);

//		service.setPaging(model, service.getBookOfYearCount(boy), boy);
		model.addAttribute("boy", boy.getMap());
		model.addAttribute("boyList", service.getBookOfYearList(boy.getMap()));

		return basePath + "index" + url;
	}

	@RequestMapping (value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, CommonBean boy, HttpServletRequest request) throws AuthException {
		Homepage homepage = homepageService.getHomepageOne(new Homepage(getAsideHomepageId(request)));
		model.addAttribute("homepage", homepage);

		if (boy.get("editMode").equals("MODIFY")) {
			checkAuth("U", model, request);
			boy.putAll(service.getBookOfYearOne(boy.getMap()));
		} else {
			checkAuth("C", model, request);
		}

		model.addAttribute("bookOfYear", boy.getMap());

		return basePath + "edit_ajax";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(CommonBean boy, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if (boy.getEditMode().equals("ADD")) {
			ValidationUtilsFromMap.rejectIfEmpty(res, boy, "book_name", "도서명을 입력하세요.");
		}

		if (!res.hasErrors()) {

			boy.setAdd_id(getSessionMemberId(request));
			boy.setModify_id(getSessionMemberId(request));

			res.setValid(true);
			res.setUrl("index.do");
			if (boy.get("editMode").equals("ADD")) {
				if (service.getBookOfYearOne(boy.getMap()) != null) {
					res.setMessage("해당년도에 선정된 도서가 존재합니다.");
					res.setValid(false);
					res.setUrl("");
				} else {
					service.addBookOfYear(boy.getMap());
					res.setMessage("등록되었습니다.");
				}
			} else if (boy.get("editMode").equals("MODIFY")) {
				service.modifyBookOfYear(boy.getMap());
				res.setMessage("수정되었습니다.");
			} else if (boy.get("editMode").equals("DELETE")) {
				service.deleteBookOfYear(boy.getMap());
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
		}

		return res;
	}
}
