package kr.go.gbelib.app.cms.module.teach.teachSort;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.teachCode.TeachCode;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = {"/cms/module/teach/teachSort"})
public class TeachSortController extends BaseController {

	private final String basePath = "/cms/module/teach/teachSort/";

	@Autowired
	private TeachSortService service;

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, TeachSort teachSort, HttpServletRequest request) throws AuthException {


		model.addAttribute("teachSortList", service.getTeachSortList(teachSort));
		model.addAttribute("teachSetSortList", service.getTeachSetSortList(teachSort));
		return basePath + "index_ajax";
	}

	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, @RequestBody TeachSort[] teachSortList , BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);
		if (teachSortList != null && teachSortList.length > 0) {

			TeachSort teachSort = new TeachSort();
			teachSort.setHomepage_id(teachSortList[0].getHomepage_id());
			if (teachSortList[0].getSort_num() > 0){
				service.deleteTeachSort(teachSort);
				for (TeachSort sort : teachSortList) {
					TeachSort sortOne = service.getTeachSortOne(sort);
					sort.setSort_column_name(sortOne.getSort_column_name());
					sort.setSort_order(sortOne.getSort_order());
					sort.setAdd_id(getSessionMemberId(request));
					service.addTeachSort(sort);
				}
			}
		}else {
			res.setValid(true);
			res.setMessage("등록 되었습니다.");
		}

		if ( !result.hasErrors() ) {
			res.setValid(true);
			res.setMessage("등록 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
