package kr.co.whalesoft.app.cms.news;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.app.cms.popup.Popup;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/news"})
public class NewsController extends BaseController {

	private final String basePath = "/cms/news/";

	@Autowired
	private NewsService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, News news, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			news.setHomepage_id(getAsideHomepageId(request));	
//		}
		int count = service.getNewsListCount(news);
		service.setPaging(model, count, news);
		news.setTotalDataCount(count);
		model.addAttribute("news", news);
		model.addAttribute("newsListCount", count);
		model.addAttribute("newsList", service.getNewsList(news));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, News news, HttpServletRequest request) throws AuthException {
		if(news.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("news", service.copyObjectPaging(news, service.getNewsOne(news)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("news", news);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, News news, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		JsonResponse res = new JsonResponse(request);
		String editMode = news.getEditMode();
		
		if(!editMode.equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "news_name", "뉴스명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "link_url", "링크URL을 지정해주세요");
			ValidationUtils.rejectIfEmpty(result, "contents", "뉴스 내용을 입력하세요.");
			ValidationUtils.rejectIfStringLength(result, "contents", 200, null);
		}
		
		if(editMode.equals("ADD")) {
			// 뉴스관리 사용여부 3개 지정
			int use_cnt = service.getUseCnt(news);
			if(use_cnt >= 3 && news.getUse_yn().equals("Y")) {
				res.setValid(false);
				res.setMessage("3개 이상 사용할 수 없습니다.");
				return res;
			}
		}
		
		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				news.setAdd_id(getSessionMemberId(request));
				service.addNews(news, mpRequest);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				news.setModify_id(getSessionMemberId(request));
				service.modifyNews(news, mpRequest);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteNews(news);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(Model model, News news, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(!result.hasErrors()) {;
			service.deleteNews(news);
			res.setValid(true);
			res.setMessage("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}