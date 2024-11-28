package kr.go.gbelib.app.module.myPost;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping(value = "/{homepagePath}/module/myPost")
public class MyPostController extends BaseController {

    private final String basePath = "/homepage/%s/module/myPost/";

    @Autowired
    private MyPostService service;

    @RequestMapping(value = "/index.*")
    public String index(Model model, MyPost myPost, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");

        if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
            service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s", homepage.getContext_path(), myPost.getMenu_idx()), request, response);
            return null;
        }

        if (StringUtils.isEmpty(myPost.getHomepage_id())) {
            myPost.setHomepage_id(homepage.getHomepage_id());
        }

        myPost.setAdd_id(getSessionMemberId(request));

        service.setPaging(model, service.getPostCount(myPost), myPost);
        List<MyPost> libraryList = service.getLibraryList(myPost);
        model.addAttribute("myPostList", service.getPostList(myPost));  //글 목록
        model.addAttribute("myPost", myPost);
        model.addAttribute("libraryList", libraryList); //도서관 목록
        model.addAttribute("boardList", service.getBoardList(myPost));   //게시판 목록

        return String.format(basePath, homepage.getFolder()) + "index";
    }
}
