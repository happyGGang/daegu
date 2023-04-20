package kr.go.gbelib.app.cms.module.conversionExample;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.framework.utils.BeanUtils;
import kr.co.whalesoft.framework.utils.PagingUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value={"/cms/conversionExample"})
public class ConversionExampleController extends BaseController {

	private final String basePath = "/cms/module/conversionExample/";
	
	@Autowired
	private ConversionExampleService service;

	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, HttpServletRequest request, Map<String,Object> commonMap, CommonBean commonBean) throws AuthException {
//
		commonBean = new CommonBean(commonMap);
		BeanUtils.putCommonBeanFieldsIntoMap((CommonBean) commonMap.get("commonBean"), commonBean.getCommonMap());

		commonBean.getCommonMap().put("conversion_idx", 1);

		service.setPaging(model, service.totalTestCount(commonBean.getCommonMap()), commonBean);
		List<Map<String, Object>> boardList = service.commonList(commonBean.getCommonMap());

		model.addAttribute("CommonBean", commonBean);
		model.addAttribute("boardList", boardList);
		return basePath + "index";
	}
}
