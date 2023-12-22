package kr.go.gbelib.app.module.archive.archiveCategory;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.archive.archiveCategory.ArchiveCategory;
import kr.go.gbelib.app.cms.module.archive.archiveCategory.ArchiveCategoryService;

@Controller(value="userArchiveCategory")
@RequestMapping(value = {"/{homepagePath}/module/archive/archiveCategory"})
public class ArchiveCategoryController extends BaseController {
	
	@Autowired
	private ArchiveCategoryService service;

	@RequestMapping (value = { "/getMidCategoryList.*" }, method = RequestMethod.GET)
	public @ResponseBody List<ArchiveCategory> getMidCodeList(ArchiveCategory archiveCategory, HttpServletRequest request) {
		return service.getMidCategoryList(archiveCategory);
	}

	@RequestMapping (value = { "/getSmallCategoryList.*" }, method = RequestMethod.GET)
	public @ResponseBody List<ArchiveCategory> getSmallCodeList(ArchiveCategory archiveCategory, HttpServletRequest request) {
		return service.getSmallCategoryList(archiveCategory);
	}
}
