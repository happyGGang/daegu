package kr.go.gbelib.app.module.taskManage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuHtml;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuHtmlService;
import kr.co.whalesoft.app.cms.site.Site;
import kr.co.whalesoft.app.cms.site.SiteService;
import kr.co.whalesoft.app.cms.taskManage.TaskManage;
import kr.co.whalesoft.app.cms.taskManage.TaskManageService;
import kr.co.whalesoft.framework.base.BaseController;

@Controller(value="userTaskManage")
@RequestMapping(value = {"/{homepagePath}/module/taskManage"})
public class TaskManageController extends BaseController {

	private String basePath = "/homepage/%s/module/taskManage/";

	@Autowired
	private TaskManageService taskManageService;
	
	@Autowired
	private SiteService siteService;

	@Autowired
	private MenuHtmlService menuHtmlService;
	
	@ModelAttribute("siteList")
	public List<Site> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return siteService.getSiteListAll(new Site(homepage.getHomepage_id()));
	}
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, TaskManage taskManage, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		if ( menuOne != null ) {
			model.addAttribute("html", menuHtmlService.getLastMenuHtmlOne(new MenuHtml(homepage.getHomepage_id(), menuOne.getMenu_idx())));	
		}
		
		taskManage.setHomepage_id(homepage.getHomepage_id());
		
		List<TaskManage> taskTypeList = taskManageService.getTaskTypeList(taskManage);
		List<TaskManage> taskManageList = taskManageService.getTaskListAll(taskManage);
		
		model.addAttribute("taskTypeList", taskTypeList);
		model.addAttribute("taskRepo", makeTaskManageRepo(taskTypeList, taskManageList));
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	/**
	 * 부서 별 직원 현황을 Repo 로 만든다.
	 * key 는 부서명이 되고, value 는 해당 부서의 직원 현황이다.
	 * 
	 * @param taskTypeList 등록된 부서의 GROUP BY 리스트다.
	 * @param taskManageList 모든 업무의 리스트다.
	 */
	private Map<String, List<TaskManage>> makeTaskManageRepo(List<TaskManage> taskTypeList, List<TaskManage> taskManageList) {
		Map<String, List<TaskManage>> taskRepo = new HashMap<String, List<TaskManage>>();
		
		for ( TaskManage one : taskTypeList ) {
			List<TaskManage> manageList = new ArrayList<TaskManage>(); 
			taskRepo.put(one.getDept_name(), manageList);
		}
		
		for ( TaskManage oneManage : taskManageList ) {
			String deptName = oneManage.getDept_name();
			oneManage.setTask_desc(oneManage.getTask_desc().replaceAll("\n", "<br/> "));
			
			if ( taskRepo.containsKey(deptName) ) {
				List<TaskManage> manageList = taskRepo.get(deptName);
				manageList.add(oneManage);
				taskRepo.put(deptName, manageList);
			}
		}

		return taskRepo;
	}
}