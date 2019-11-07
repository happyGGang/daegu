package kr.go.gbelib.app.cms.module.newBookDream;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.homepage.module.bookDream.BookDream;
import kr.co.whalesoft.app.homepage.module.bookDream.BookDreamService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.file.Download;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StrUtil;
import kr.go.gbelib.app.common.api.PushAPI;

@Controller
@RequestMapping(value = {"/cms/module/bookDream"})
public class NewBookDreamController extends BaseController{

	private final String basePath = "/cms/module/newBookDream/";
	
	@Autowired
	private BookDreamService service;

	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, NewBookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Member member = getSessionMemberInfo(request);
		checkAuth("R", model, request);

		if (bookDream.getSearch_state() == null) {
			List<String> list = new ArrayList<String>();
			list.add("0");
			list.add("10");
			list.add("13");
			list.add("15");
			list.add("17");
			list.add("20");
			list.add("30");
			list.add("40");
			list.add("50");
			list.add("-10");
			list.add("-20");
			list.add("-90");
			bookDream.setSearch_state(list);
		}
		if (bookDream.getSearch_lib() == null) {
			List<String> list = new ArrayList<String>();
			if (StringUtils.equals(getAsideHomepageId(request), "h3")) {
				list.add("andong");
			} else if (StringUtils.equals(getAsideHomepageId(request), "h4")) {
				list.add("yongsang");
			} else if (StringUtils.equals(getAsideHomepageId(request), "h5")) {
				list.add("pungsan");
			} else if (member.isAdmin()) {
				list.add("andong");
				list.add("yongsang");
				list.add("pungsan");
			}
			bookDream.setSearch_lib(list);
		}
		if (StringUtils.equals(bookDream.getSortField(), "add_date")) {
			bookDream.setSortField("r_created");
		}

		service.setPaging(model, service.getRequestListCountCMS(bookDream), bookDream);
		model.addAttribute("bookDream", bookDream);
		model.addAttribute("bookDreamList", service.getRequestListCMS(bookDream));


		return basePath + "index";
	}

	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, NewBookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);
		checkAuth("C", model, request);
		checkAuth("U", model, request);

		model.addAttribute("bookDream", bookDream);
		model.addAttribute("bookDreamOne", service.getBookDreamOne(bookDream));
		model.addAttribute("bookDreamHistory", service.getBookDreamOneHistory(bookDream));

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(NewBookDream newBookDream, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			newBookDream.setRh_ip(request.getRemoteAddr());
			newBookDream.setRh_url(request.getHeader("referer"));
			newBookDream.setRh_referer(request.getHeader("referer"));
			newBookDream.setRh_set(newBookDream.getR_state());
			service.modifyBookDream(newBookDream);
			res.setValid(true);
			res.setMessage("수정되었습니다.");
			res.setReload(true);
			try {
				BookDream user = service.getBookDreamOne(newBookDream);
				String homepageCode = user.getR_src();
				String fromTel = "";
//				00147010 안동
//				 * 00147011 용상
//				 * 00147039풍산
				if (homepageCode.equals("andong")) {
					homepageCode ="00147010";
					fromTel = user.getFromTel();
				} else if (homepageCode.equals("yongsang")) {
					homepageCode ="00147011";
					fromTel = user.getFromTel2();
				} else if (homepageCode.equals("pungsan")) {
					homepageCode ="00147039";
					fromTel = user.getFromTel3();
				}

				Homepage homepage = new Homepage();
				homepage.setHomepage_code(homepageCode);
				homepage = homepageService.getHomepageOneByCode(homepage);
				
				BookDream config = service.getBookDreamConfigByState(newBookDream);
				
				if(config != null && StringUtils.isNotEmpty(config.getC_value())) {
					String smsMsg = config.getC_value();
					smsMsg =  smsMsg.replace("{{BookName}}", StrUtil.cutStr(user.getR_title(), 20));
					if(user.getR_return_close() != null) {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						smsMsg =  smsMsg.replace("{{D_DAY}}", sdf.format(user.getR_return_close()));
					}
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, user.getR_hp(), smsMsg, fromTel, false);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = { "/manage.*" }, method = RequestMethod.GET)
	public String manage(Model model, NewBookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);
		checkAuth("C", model, request);
		checkAuth("U", model, request);
		checkAuth("D", model, request);


		model.addAttribute("bookDream", bookDream);
		model.addAttribute("bookDreamManage", bookDream);
		model.addAttribute("bookDreamConfig", service.getNewBookConfig());


		return basePath + "manage";
	}


	@RequestMapping(value = { "/saveConfig.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveConfig(NewBookDream newBookDream, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			service.modifyBookDreamConfig(newBookDream);
			res.setValid(true);
			res.setMessage("저장되었습니다.");
			res.setReload(true);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}


	@RequestMapping(value = { "/store.*" }, method = RequestMethod.GET)
	public String store(Model model, NewBookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);

		model.addAttribute("bookDream", bookDream);
		model.addAttribute("bookDreamManage", bookDream);
		model.addAttribute("bookDreamStore", service.getNewBookStore());


		return basePath + "store";
	}


	@RequestMapping(value = { "/storeEdit.*" }, method = RequestMethod.GET)
	public String storeEdit(Model model, NewBookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("C", model, request);
		checkAuth("U", model, request);
		checkAuth("D", model, request);

		model.addAttribute("bookDream", bookDream);
		if (bookDream.getEditMode().equals("ADD")) {
			model.addAttribute("bookDreamStoreEdit", bookDream);
		} else {
			model.addAttribute("bookDreamStoreEdit", service.copyObjectPaging(bookDream, service.getNewBookStoreOne(bookDream)));
		}


		return basePath + "storeEdit_ajax";
	}


	@RequestMapping(value = { "/saveStore.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveStore(NewBookDream newBookDream, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		ValidationUtils.rejectIfEmpty(result, "s_name", "서점명을 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "s_owner", "대표자명을 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "s_tel", "전화번호를 입력해주세요.");
		if (newBookDream.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "s_id", "아이디를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "s_pw", "비밀번호를 입력해주세요.");
		}

		if (!result.hasErrors()) {
			if (newBookDream.getEditMode().equals("DELETE")) {
				service.deleteBookDreamStore(newBookDream);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
				res.setReload(true);
			} else if (newBookDream.getEditMode().equals("MODIFY")) {
				service.modifyBookDreamStore(newBookDream);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
				res.setReload(true);
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/batch.*"})
	public @ResponseBody JsonResponse batchModify(NewBookDream newBookDream, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			newBookDream.setRh_ip(request.getRemoteAddr());
			newBookDream.setRh_url(request.getHeader("referer"));
			newBookDream.setRh_referer(request.getHeader("referer"));
			service.modifyState(newBookDream);
			res.setValid(true);
			res.setMessage("수정되었습니다.");
			res.setReload(true);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public void certDownload(Model model, NewBookDream newBookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Download down = new Download(request, response, "bookDream.xls");
		service.writeExcelData(newBookDream, down.getOutputStream(), request);

		down.close();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csvDownload(Model model, NewBookDream newBookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<BookDream> bookDreamList = service.getRequestListCMS2(newBookDream);
		
		new NewBookDreamWriteCsv(bookDreamList, "bookDream.csv", request, response);
	}

}
