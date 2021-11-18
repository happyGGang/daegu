package kr.go.gbelib.app.module.api;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.go.gbelib.app.cms.module.archive.Archive;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value = {"/api/"})
public class LoanStateApiController extends BaseController {

    private String basePath = "/app/api/";

    @RequestMapping(value = {"/LoanState.*"}, method = RequestMethod.GET)
    public String LoanState(Model model, @RequestParam(value="userKey", required=true) String userKey, @RequestParam(value="orderOption", required=false) String orderOption, @RequestParam(value="currentCount", required=false) String currentCount, @RequestParam(value="pageCount", required=false) String pageCount, @RequestParam(value="comCode", required=false) String comCode, HttpServletRequest request) {
        System.out.println(userKey);
        System.out.println(orderOption);
        System.out.println(currentCount);
        System.out.println(pageCount);
        System.out.println(comCode);

        return basePath + "LoanState";
    }

}
