package kr.go.gbelib.app.cms.module.specializedServices;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.popup.Popup;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.Serializers.Base;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping(value = { "/cms/module/specializedServices" })
public class SpecializedServicesController extends BaseController {

    private final String basePath = "/cms/module/specializedServices/";

    @Autowired
    private SpecializedServicesService service;

    @Autowired
    private HomepageService homepageService;

    @RequestMapping(value = {"/index.*"})
    public String index(Model model, SpecializedServices specializedServices, HttpServletRequest request) throws AuthException {
//		if ( !getSessionIsAdmin(request) ) {
        specializedServices.setHomepage_id(getAsideHomepageId(request));
//		}
        checkAuth("R", model, request);
        specializedServices.setAuth_id(getSessionMemberInfo(request).getAuth_id());
        int count = service.getSpecializedServicesCount(specializedServices);
        service.setPaging(model, count, specializedServices);
        specializedServices.setTotalDataCount(count);
        model.addAttribute("specializedServices", specializedServices);
        model.addAttribute("specializedServicesList", service.getSpecializedServicesList(specializedServices));

        return basePath + "index";
    }

    @RequestMapping(value = {"/edit.*"})
    public String edit(Model model, SpecializedServices specializedServices , HttpServletRequest request) throws AuthException {

        if(specializedServices.getEditMode().equals("MODIFY")) {
            checkAuth("U", model, request);
            specializedServices = (SpecializedServices) service.copyObjectPaging(specializedServices, service.getSpecializedServicesOne(specializedServices));
        }

        specializedServices.setHomepage_id(getAsideHomepageId(request));

        model.addAttribute("homepageList", homepageService.getHomepage2());
        model.addAttribute("specializedServices", specializedServices);

        return basePath + "edit_ajax";
    }

    @RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse save(Model model, SpecializedServices specializedServices, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
        specializedServices.setHomepage_id(getAsideHomepageId(request));
        JsonResponse res = new JsonResponse(request);

        if ("ADD".equals(specializedServices.getEditMode())) {
            ValidationUtils.rejectIfEmpty(result, "service_homepage_id", "홈페이지를 선택해주세요.");
        }
        ValidationUtils.rejectIfEmpty(result, "service_name", "서비스명을 입력해주세요.");
        ValidationUtils.rejectIfEmpty(result, "link_url", "링크URL을 지정해주세요");
        ValidationUtils.rejectIfEmpty(result, "description", "설명을 입력해주세요");

        if(!result.hasErrors()) {
            if("ADD".equals(specializedServices.getEditMode())) {
                specializedServices.setAdd_id(getSessionMemberId(request));
                service.addSpecializedServices(specializedServices, mpRequest);
                res.setValid(true);
                res.setMessage("등록 되었습니다.");
            } else if ("MODIFY".equals(specializedServices.getEditMode())){
                specializedServices.setModify_id(getAsideHomepageId(request));
                service.modifySpecializedServices(specializedServices, mpRequest);
                res.setValid(true);
                res.setMessage("수정 되었습니다");
            }
        } else {
            res.setValid(false);
            res.setResult(result.getAllErrors());
        }

        return res;
    }

    @RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse delete(Model model, SpecializedServices specializedServices, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        if(!result.hasErrors()) {
            service.deleteSpecializedServices(specializedServices);
            res.setValid(true);
            res.setMessage("삭제 되었습니다.");
        } else {
            res.setValid(false);
            res.setResult(result.getAllErrors());
        }

        return res;
    }

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
