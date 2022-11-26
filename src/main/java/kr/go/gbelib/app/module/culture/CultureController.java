package kr.go.gbelib.app.module.culture;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.app.cms.module.survey.Survey;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.app.cms.module.survey.questDetail.QuestDetail;
import kr.co.whalesoft.app.cms.module.survey.questMatrix.QuestMatrix;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.culture.Culture;
import kr.go.gbelib.app.cms.module.culture.CultureService;
import kr.go.gbelib.app.cms.module.specializedServices.SpecializedServices;
import kr.go.gbelib.app.cms.module.specializedServices.SpecializedServicesService;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachService;
import kr.go.gbelib.app.cms.module.teach.hashtag.Hashtag;
import kr.go.gbelib.app.cms.module.teach.hashtag.HashtagService;
import kr.go.gbelib.app.common.api.CultureAPI;
import kr.go.gbelib.app.module.myLibrary.MyLibrary;
import kr.go.gbelib.app.module.myLibrary.MyLibraryDao;
import kr.go.gbelib.app.module.myLibrary.MyLibraryService;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller(value="userCulture")
@RequestMapping(value = {"/{homepagePath}/module/culture"})
public class CultureController extends BaseController {

    private String basePath = "/homepage/%s/module/culture/";

    @Autowired
    private CodeService codeService;

    @Autowired
    private HashtagService hashtagService;

    @Autowired
    private TeachService teachService;

    @Autowired
    private CultureService cultureService;

    @Autowired
    private SpecializedServicesService specializedServicesService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private HomepageService homepageService;

    @Autowired
    private MyLibraryService myLibraryService;

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = {"/teach.*"})
    public String teach(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");

        if (StringUtils.isEmpty(teach.getSearch_yy()) && StringUtils.isEmpty(teach.getSearch_mm())) {
            SimpleDateFormat yyyyFormat = new SimpleDateFormat("yyyy");
            SimpleDateFormat mmFormat = new SimpleDateFormat("MM");
            Date now = new Date();

            teach.setSearch_yy(yyyyFormat.format(now));
            teach.setSearch_mm(mmFormat.format(now));
        }

        Code code = new Code();
        code.setGroup_id("A0000");
        model.addAttribute("areaCodeList", codeService.getCodeList(code));

        code.setGroup_id("TC000");
        model.addAttribute("ageCodeList", codeService.getCodeList(code));

        model.addAttribute("hashtagCodeList", hashtagService.getHashtagUsedList(new Hashtag()));

        teach.setRowCount(8);
        teachService.setPaging(model, teachService.getTeachListForAllSearchCultureCount(teach), teach);
        model.addAttribute("teachList", teachService.getTeachListForAllSearchCulture(teach));

        model.addAttribute("teach", teach);
        return String.format(basePath, homepage.getFolder()) + "teach";
    }

    @RequestMapping(value = {"/performanceExhibition.*"})
    public String carnival(Model model, Culture culture, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");

        Map<String, Object> parameter = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(culture.getSearch_area())) {
            parameter.put("gugun", culture.getSearch_area());
        }

        if (StringUtils.isNotEmpty(culture.getKeyword())) {
            parameter.put("keyword", culture.getKeyword());
        }

        Code code = new Code();
        code.setGroup_id("A0000");
        model.addAttribute("areaCodeList", codeService.getCodeList(code));

        model.addAttribute("list", CultureAPI.areaRequestDetails(new HashMap<String, Object>(), CultureAPI.areaRequest(parameter)));
        model.addAttribute("culture", culture);
        return String.format(basePath, homepage.getFolder()) + "performanceExhibition";
    }

    @RequestMapping(value = {"/exhibition.*"})
    public String exhibition(Model model, Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");

        board.setRowCount(8);

        cultureService.setPaging(model, boardService.getBoardExhibitionCount(board), board);
        model.addAttribute("boardList", boardService.getBoardExhibitionList(board));
        model.addAttribute("board", board);
        model.addAttribute("homepageList", homepageService.cultureHomepageList(new Homepage()));

        return String.format(basePath, homepage.getFolder()) + "exhibition";
    }

    @RequestMapping(value = {"/culture.*"})
    public String culture(Model model, Culture culture, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");

        culture.setRowCount(8);

        cultureService.setPaging(model, cultureService.getCultureCount(culture), culture);
        model.addAttribute("cultureList", cultureService.getCultureList(culture));

        return String.format(basePath, homepage.getFolder()) + "culture";
    }

    @RequestMapping(value = {"/cultureView.*"})
    public String cultureView(Model model, Culture culture, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");

        model.addAttribute("cultureOne", cultureService.getCultureOne(culture));
        model.addAttribute("culture", culture);

        return String.format(basePath, homepage.getFolder()) + "cultureView";
    }

    @RequestMapping(value = {"/specializedServices.*"})
    public String specializedServices(Model model, SpecializedServices specializedServices, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");
        specializedServices.setView_yn("Y");
        specializedServices.setRowCount(8);

        cultureService.setPaging(model, specializedServicesService.getSpecializedServicesCount(specializedServices), specializedServices);
        model.addAttribute("serviceList", specializedServicesService.getSpecializedServicesList(specializedServices));

        return String.format(basePath, homepage.getFolder()) + "specializedServices";
    }

    @RequestMapping(value = {"/movie.*"})
    public String movie(Model model, Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");
        board.setRowCount(8);

        cultureService.setPaging(model, boardService.getBoardMovieCount(board), board);
        model.addAttribute("boardList", boardService.getBoardMovieList(board));
        model.addAttribute("board", board);
        model.addAttribute("homepageList", homepageService.cultureHomepageList(new Homepage()));

        return String.format(basePath, homepage.getFolder()) + "movie";
    }

    @RequestMapping(value = {"/myLibrary.*"})
    public String myLibrary(Model model, MyLibrary myLibrary, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");
        if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
            int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
            String before_url = String.format("/%s/module/culture/myLibrary.do?menu_idx=%s", homepage.getContext_path(),myLibrary.getMenu_idx());
            cultureService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d&before_url=%s", homepage.getContext_path(), loginMenuIdx, before_url), request, response);
            return null;
        }

        Member sessionMemberInfo = getSessionMemberInfo(request);

        myLibrary.setLogin_type(sessionMemberInfo.getLoginType());
        myLibrary.setMember_id(sessionMemberInfo.getMember_id());

        model.addAttribute("myLibraryOne", myLibraryService.getMyLibrary(myLibrary));
        model.addAttribute("myLibrary", myLibrary);
        return String.format(basePath, homepage.getFolder()) + "myLibrary";
    }

    @RequestMapping(value = {"/mypage/dashboard.*"})
    public String myLibrary(Model model, Culture culture, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");
        if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
            int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
            String before_url = String.format("/%s/module/culture/mypage/dashboard.do?menu_idx=%s", homepage.getContext_path(),culture.getMenu_idx());
            cultureService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d&before_url=%s", homepage.getContext_path(), loginMenuIdx, before_url), request, response);
            return null;
        }

        Member sessionMemberInfo = getSessionMemberInfo(request);

        MyLibrary myLibrary = myLibraryService.getMyLibrary(new MyLibrary(sessionMemberInfo.getLoginType(), sessionMemberInfo.getMember_id()));

        String homepage_name = "";

        if (myLibrary != null) {
            if (StringUtils.isNotEmpty(myLibrary.getManage_codes())) {
                homepage.setManage_codes(myLibrary.getManage_codes().split(","));
                homepage_name = homepageService.getHomepageNameInManageCode(homepage);
            }
        }

        Teach teach = new Teach();

        teach.setEndRowNum(5);
        teach.setMember_id(sessionMemberInfo.getMember_id());

        model.addAttribute("applyList", teachService.getApplyListAll(teach));
        model.addAttribute("homepage_name", homepage_name);
        model.addAttribute("culture", culture);
        return String.format(basePath, homepage.getFolder()) + "/mypage/dashboard";
    }

    @RequestMapping(value = {"/mypage/applyHistory.*"})
    public String applyHistory(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");
        if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
            int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
            String before_url = String.format("/%s/module/culture/mypage/applyHistory.do?menu_idx=%s", homepage.getContext_path(),teach.getMenu_idx());
            cultureService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d&before_url=%s", homepage.getContext_path(), loginMenuIdx, before_url), request, response);
            return null;
        }

        Member sessionMemberInfo = getSessionMemberInfo(request);
        teach.setMember_id(sessionMemberInfo.getMember_id());

        teachService.setPaging(model, teachService.getApplyListAllCount(teach), teach);
        model.addAttribute("applyList", teachService.getApplyListAll(teach));
        model.addAttribute("teach", teach);
        return String.format(basePath, homepage.getFolder()) + "/mypage/applyHistory";
    }

    @RequestMapping(value = {"/myLibrarySave.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse myLibrarySave(MyLibrary myLibrary, BindingResult result, HttpServletRequest request) {
        /* 유효성 검증 >>>>> */
        JsonResponse res = new JsonResponse(request);

        Member sessionMemberInfo = getSessionMemberInfo(request);

        myLibrary.setLogin_type(sessionMemberInfo.getLoginType());
        myLibrary.setMember_id(sessionMemberInfo.getMember_id());

        if(!result.hasErrors()) {

            MyLibrary one = myLibraryService.getMyLibrary(myLibrary);

            if (one != null) {
                myLibraryService.modifyLibrary(myLibrary);
                res.setValid(true);
                res.setMessage("나만의 도서관이 등록되었습니다.");
            } else {
                myLibrary.setAdd_id(myLibrary.getMember_id());
                myLibrary.setAdd_ip(request.getRemoteAddr());
                myLibraryService.addMyLibrary(myLibrary);
                res.setValid(true);
                res.setMessage("나만의 도서관이 등록되었습니다.");
            }
        }

        return res;
    };
}
