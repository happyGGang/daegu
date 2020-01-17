package kr.go.gbelib.app.module.archive;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.go.gbelib.app.cms.module.archive.Archive;
import kr.go.gbelib.app.cms.module.archive.ArchiveService;

@Controller
@RequestMapping(value = {"/{homepagePath}/module/archive"})
public class ArchiveController extends  BaseController {
	
	private String basePath = "/homepage/%s/module/archive/";
	
	@Autowired
	private ArchiveService service;
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, Archive archive, HttpServletRequest request) throws AuthException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		archive.setHomepage_id(homepage.getHomepage_id());
		
		int count = service.getArchiveBookCount(archive);
		List<Archive> list = service.getArchiveBookList(archive);
		
		archive.setTotalDataCount(count);
		service.setPaging(model, count, archive);
		
		model.addAttribute("archive", archive);
		model.addAttribute("count", count);
		model.addAttribute("archiveBookList", list);
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping(value = {"/view.*"}, method = RequestMethod.GET)
	public String edit(Model model, Archive archive, HttpServletRequest request) throws AuthException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		archive.setHomepage_id(homepage.getHomepage_id());
		
		int count = service.getArchivePageCount(archive);
		List<Archive> list = service.getArchivePageList(archive);
//		archive = service.getArchivePage(archive);
		
		model.addAttribute("archive", archive);
		model.addAttribute("count", count);
		model.addAttribute("archivePageList", list);
		
		return String.format(basePath, homepage.getFolder()) + "view_ajax";
	}
	
}
