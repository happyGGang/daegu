package kr.go.gbelib.app.module.culture;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.culture.Culture;
import kr.go.gbelib.app.cms.module.culture.CultureService;
import kr.go.gbelib.app.cms.module.specializedServices.SpecializedServices;
import kr.go.gbelib.app.cms.module.specializedServices.SpecializedServicesService;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachService;
import kr.go.gbelib.app.cms.module.teach.hashtag.Hashtag;
import kr.go.gbelib.app.cms.module.teach.hashtag.HashtagService;
import kr.go.gbelib.app.common.api.CultureAPI;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

        return String.format(basePath, homepage.getFolder()) + "movie";
    }
}
