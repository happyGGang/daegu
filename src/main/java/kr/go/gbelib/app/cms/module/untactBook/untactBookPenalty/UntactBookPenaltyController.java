package kr.go.gbelib.app.cms.module.untactBook.untactBookPenalty;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value="/cms/module/untactBook/untactLockerSetting")
public class UntactBookPenaltyController extends BaseController {
	                                                          
	private final String basePath = "/cms/module/untactBook/untactBookPenalty/";
	
	@Autowired
	private UntactBookPenaltyService service;
	
}
