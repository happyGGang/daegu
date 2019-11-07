package kr.go.gbelib.app.module.bookStore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.bookStore.BookStore;
import kr.co.whalesoft.app.cms.module.bookStore.BookStoreService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.module.myItem.MyItem;


@Controller(value="userBookStore")
@RequestMapping(value = {"/{homepagePath}/module/bookStore"})
public class BookStoreController extends BaseController {

	private String basePath = "/homepage/%s/module/bookStore/";
	
	@Autowired
	private BookStoreService service;
	
	@RequestMapping(value = {"/history.*"})
	public String index(Model model, BookStore bookStore, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if(!"h18".equals(homepage.getHomepage_id())) {
			service.alertMessage("영덕도서관에서 이용가능합니다.", request, response);
			return null;
		}
		
		bookStore.setHomepage_id(homepage.getHomepage_id());
		
		Member member = getSessionMemberInfo(request);
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			bookStore.setBefore_url(String.format("/%s/module/bookStore/history.do?menu_idx=%s", homepage.getContext_path(), bookStore.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bookStore.getMenu_idx(), bookStore.getBefore_url()), request, response);
			return null;
	    }
		
		if(!member.isBookStore()) {
			service.alertMessage("책읽는가게 회원만 이용 가능합니다.", request, response);
			return null;
		}

		bookStore.setLoan_seq(member.getUser_id());
		
		int count = service.getBookStoreListCntUser(bookStore);
		service.setPaging(model, count, bookStore);
		
		model.addAttribute("bookStore", bookStore);
		model.addAttribute("bookStoreList", service.getBookStoreListUser(bookStore));
		model.addAttribute("bookStoreListCount", count);
		return String.format(basePath, homepage.getFolder()) + "history";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(MyItem myItem, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		
		Member member = (Member) getSessionMemberInfo(request);		
		
		BookStore bookStore = new BookStore();
		
		String split_date[] = myItem.getItem_name().split("_");
		
		bookStore.setLoan_seq(member.getUser_id());
		bookStore.setLoan_name(member.getMember_name());
		bookStore.setTitle(split_date[0]);
		bookStore.setClaim_sign(split_date[1]);
		bookStore.setRegist_num(split_date[2]);
		bookStore.setAdd_id(member.getMember_id());
		
		if(!result.hasErrors()) {
			bookStore.setAdd_id(member.getMember_id());

			int count = service.checkApplyCount(bookStore); 
			
			if(count > 0) {
				res.setValid(true);
				res.setMessage("이미 신청된 자료 입니다.");
			} else if(count == 0) {
				service.addBookStore(bookStore);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}			
		
		return res;
	}
	
}
