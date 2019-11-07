package kr.co.whalesoft.app.homepage.sns;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller(value="userSNS")
@RequestMapping(value = {"/sns"})
public class SNSAccessController extends BaseController{

	@Autowired
	private SNSAccessService service;
	
	@RequestMapping(value = {"/access.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse access(Model model, SNSAccess snsAccess, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request); 
		if(!result.hasErrors()) {
			if ( snsAccess.getType().equals("TWITTER") ) {
				service.mergeTwitter(snsAccess);
			}
			else if ( snsAccess.getType().equals("FACEBOOK") ) {
				service.mergeFacebook(snsAccess);
			}
			else if ( snsAccess.getType().equals("KAKAOSTORY") ) {
				service.mergeKakaostory(snsAccess);
			}
			
			res.setValid(true);
		}
		
		return res;
	}
}
