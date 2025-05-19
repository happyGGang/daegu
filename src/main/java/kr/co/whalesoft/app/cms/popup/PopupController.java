package kr.co.whalesoft.app.cms.popup;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/popup"})
public class PopupController extends BaseController {

	private final String basePath = "/cms/popup/";
	
	@Autowired
	private PopupService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Popup popup, HttpServletRequest request) throws AuthException {
//		if ( !getSessionIsAdmin(request) ) {
			popup.setHomepage_id(getAsideHomepageId(request));	
//		}
		checkAuth("R", model, request);
		popup.setAuth_id(getSessionMemberInfo(request).getAuth_id());
		int count = service.getPopupCount(popup);
		service.setPaging(model, count, popup);
		popup.setTotalDataCount(count);
		model.addAttribute("popup", popup);
		model.addAttribute("popupList", service.getPopup(popup));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/popup.*"})
	public String popup(Model model, Popup popup) {
		return basePath + "popup_ajax";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Popup popup, HttpServletRequest request) throws AuthException {
		if(popup.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			popup = (Popup)service.copyObjectPaging(popup, service.getPopupOne(popup));
		} else {
			checkAuth("C", model, request);
			popup.setPrint_seq(service.getNextPrintSeq(popup.getHomepage_id()));
			
			if(StringUtils.isEmpty(popup.getUse_yn())) {
				popup.setUse_yn("Y");
			}
			
			if(StringUtils.isEmpty(popup.getLink_target())) {
				popup.setLink_target("CURRENT");
			}
		}
		
		model.addAttribute("popup", popup);
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Popup popup, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		popup.setHomepage_id(getAsideHomepageId(request));	
		
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "popup_name", "팝업명을 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "start_date", "게시 시작일을 지정해주세요.");
		ValidationUtils.rejectIfEmpty(result, "end_date", "게시 종료일을 지정해주세요");

		if(!result.hasErrors()) {
			if(popup.getEditMode().equals("ADD")) {
				popup.setAdd_id(getSessionMemberId(request));
				service.addPopup(popup, mpRequest);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(popup.getEditMode().equals("MODIFY")) {
				popup.setModify_id(getSessionMemberId(request));
				service.modifyPopup(popup, mpRequest);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(popup.getEditMode().equals("DELETE")) {
				service.deletePopup(popup);
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
	public @ResponseBody JsonResponse delete(Model model, Popup popup, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(!result.hasErrors()) {
			service.deletePopup(popup);
			res.setValid(true);
			res.setMessage("삭제 되었습니다.");	
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
//	@RequestMapping(value = {"/imgUpload.*"}, method = RequestMethod.POST)
//	public @ResponseBody JsonResponse imgUpload(Popup popup, BindingResult result, MultipartHttpServletRequest mpRequest, HttpServletRequest request) {
//		JsonResponse res = new JsonResponse(request);
//		
//		if (!result.hasErrors()) {
//			res.setValid(true);
//			res.setData(String.valueOf(service.addImgFile(mpRequest)));
//		} else {
//			res.setValid(false);
//			res.setResult(result.getAllErrors());
//		}
//		
//		return res;
//	}
	
	@RequestMapping(value = {"/imgUpload.*"}, method = RequestMethod.POST)
	public @ResponseBody HashMap<String, ArrayList<HashMap<String, String>>> imgUpload(Popup popup, BindingResult result, MultipartHttpServletRequest mpRequest, HttpServletRequest request) {
		HashMap<String, ArrayList<HashMap<String, String>>> res = new HashMap<String, ArrayList<HashMap<String, String>>>();
		ArrayList<HashMap<String, String>> files = new ArrayList<HashMap<String,String>>(); 
		
		String path = service.addImgFile(getAsideHomepageId(request), mpRequest);
		String[] pathnames = path.split("/");
		String filename = pathnames[pathnames.length-1];
		HashMap<String, String> fileHash = new HashMap<String, String>();
		fileHash.put("name", filename);
		fileHash.put("size", String.valueOf(path.getBytes().length));
		
		String frontURL = getFrontURL(mpRequest);
		
		fileHash.put("url", frontURL + path);
		fileHash.put("thumbnailUrl", frontURL + path);
		fileHash.put("deleteUrl", "");
		fileHash.put("deleteType", "DELETE");
		files.add(fileHash);
		res.put("files", files);
		
		return res;
	}
	
	private String getFrontURL(HttpServletRequest req) {
	    String scheme = req.getScheme();             // http
	    String serverName = req.getServerName();     // hostname.com
	    int serverPort = req.getServerPort();        // 80
//	    String contextPath = req.getContextPath();   // /mywebapp
//	    String servletPath = req.getServletPath();   // /servlet/MyServlet
//	    String pathInfo = req.getPathInfo();         // /a/b;c=123
//	    String queryString = req.getQueryString();          // d=789

	    StringBuilder url = new StringBuilder();
	    url.append(scheme).append("://").append(serverName);

	    if (serverPort != 80 && serverPort != 443) {
	        url.append(":").append(serverPort);
	    }
	    
		return url.toString();
	}
	
}