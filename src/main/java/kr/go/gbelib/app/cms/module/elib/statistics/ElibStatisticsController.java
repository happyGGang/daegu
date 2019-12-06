package kr.go.gbelib.app.cms.module.elib.statistics;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategory;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategoryService;
import kr.go.gbelib.app.cms.module.elib.code.ElibCode;
import kr.go.gbelib.app.cms.module.elib.code.ElibCodeService;

@Controller
@RequestMapping(value = {"/cms/module/elib/statistics"})
public class ElibStatisticsController extends BaseController {

	private final String basePath = "/cms/module/elib/statistics/";

	@Autowired
	private ElibStatisticsService service;

	@Autowired
	private ElibCategoryService elibCategoryService;

	@Autowired
	private ElibCodeService elibCodeService;

	@Autowired
	private HomepageService homepageService;

	private void updateDeviceCnt(ElibStatistics elibStatistics) {
		if(elibStatistics != null && elibStatistics.getDevice_cnt() != null) {
			String[] device_cnt_array = elibStatistics.getDevice_cnt().split(",");
			if(device_cnt_array != null) {
				for(String s: device_cnt_array) {
					String[] device_cnt = s.split(":");
					String device = device_cnt[0];
					int cnt = Integer.parseInt(device_cnt[1]);

					if("P".equals(device)) {
						elibStatistics.setP_cnt(cnt);
					} else if("S".equals(device)) {
						elibStatistics.setS_cnt(cnt);
					} else if("A".equals(device)) {
						elibStatistics.setA_cnt(cnt);
					} else if("I".equals(device)) {
						elibStatistics.setI_cnt(cnt);
					} else if("E".equals(device)) {
						elibStatistics.setE_cnt(cnt);
					}
				}
			}
		}
	}

	@RequestMapping(value = {"{menuParam}/index{url}.*"})
	public String book_index(Model model, @PathVariable String menuParam, @PathVariable("url") String url, ElibStatistics elibStatistics, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			elibStatistics.setHomepage_id(getAsideHomepageId(request));
//		}

		elibStatistics.setMenu(menuParam);

		String menu = elibStatistics.getMenu();
		String view = basePath + "index";
		List<ElibStatistics> elibStatisticsList = null;
		int count = 0;

		if("HOUR".equals(menu) || "DAY".equals(menu) || "MONTH".equals(menu) || "PERIOD".equals(menu)) {
			elibStatisticsList = service.getStatisticsByTime(elibStatistics);
			view = basePath + "time";
		} else if("CATEGORY".equals(menu)) {
			Map<String, Integer> elibStatisticsMap = new HashMap<String, Integer>();
			List<Map<String, Object>> elibStatisticsMapList = new ArrayList<Map<String, Object>>();

			ElibCategory cate = new ElibCategory();
			List<ElibCategory> categories = elibCategoryService.getStatCategoryList(cate);

			if(elibStatistics.getSearch_sdt() != null && elibStatistics.getSearch_edt() != null) {
				elibStatisticsMapList = service.getStatisticsByCategory(elibStatistics);
				if(elibStatisticsMapList != null) {
					for(Map<String, Object> row: elibStatisticsMapList) {
						elibStatisticsMap.put(row.get("TYPE")+"."+row.get("PARENT_ID")+"."+row.get("DEVICE"), Integer.parseInt(String.valueOf(row.get("CNT"))));
					}
				}
			}

			model.addAttribute("categories", categories);
			model.addAttribute("elibStatisticsMap", elibStatisticsMap);
			model.addAttribute("elibStatisticsMapList", elibStatisticsMapList);

			if("_excel".equals(url)) {
				view = basePath + "category_excel_ajax";
			} else if("_csv".equals(url)) {
				view = basePath + "csv_ajax";
			} else {
				view = basePath + "category";
			}
		} else if("BOOK".equals(menu)) {
			count = service.getStatisticsByBookCnt(elibStatistics);
			service.setPaging(model, count, elibStatistics);
			elibStatisticsList = service.getStatisticsByBook(elibStatistics);

			for(ElibStatistics one: elibStatisticsList) {
				updateDeviceCnt(one);
			}

			ElibStatistics total = service.getStatisticsByBookTotal(elibStatistics);
			updateDeviceCnt(total);

			model.addAttribute("getStatisticsByBookTotal", total);
			model.addAttribute("elibStatisticsCnt", count);
			view = basePath + "book";
		} else if("MEMBER".equals(menu)) {
			count = service.getStatisticsByMemberCnt(elibStatistics);
			service.setPaging(model, count, elibStatistics);
			elibStatisticsList = service.getStatisticsByMember(elibStatistics);
			model.addAttribute("getStatisticsByMemberTotal", service.getStatisticsByMemberTotal(elibStatistics));
			view = basePath + "member";
			model.addAttribute("elibStatisticsCnt", count);
		} else if("AGE".equals(menu)) {
			elibStatisticsList = service.getStatisticsByAge(elibStatistics);
			view = basePath + "age";
		} else if("COMPANY".equals(menu)) {
			Map<String, Integer> elibStatisticsMap = new HashMap<String, Integer>();

			List<Map<String, Object>> elibStatisticsMapList = service.getStatisticsByCompany(elibStatistics);
			if(elibStatisticsMapList != null) {
				for(Map<String, Object> row: elibStatisticsMapList) {
					elibStatisticsMap.put(row.get("TYPE")+"."+row.get("COM_CODE")+"."+row.get("DEVICE"), Integer.parseInt(String.valueOf(row.get("CNT"))));
				}
			}

			if("_excel".equals(url)) {
				view = basePath + "company_excel_ajax";
			} else if("_csv".equals(url)) {
				view = basePath + "csv_ajax";
			} else {
				view = basePath + "company";
			}

			model.addAttribute("elibStatisticsMap", elibStatisticsMap);
		}

		model.addAttribute("elibStatistics", elibStatistics);
		model.addAttribute("obj", elibStatistics);
		model.addAttribute("elibStatisticsList", elibStatisticsList);
		model.addAttribute("cateList", elibCategoryService.getCategoryList(new ElibCategory(elibStatistics.getType())));
		model.addAttribute("compList", elibCodeService.getCompList(new ElibCode(elibStatistics.getType())));
		model.addAttribute("library_code", getLibraryCode(request));

		return view;
	}

	@RequestMapping(value = {"/summary{url}.*"})
	public String summary(Model model, ElibStatistics elibStatistics, @PathVariable("url") String url, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
		elibStatistics.setHomepage_id(getAsideHomepageId(request));
//		}

		Map<String, Integer> elibStatisticsSummary = new HashMap<String, Integer>();
		Map<String, Integer> elibStatisticsUniqueSummary = new HashMap<String, Integer>();

		if(StringUtils.isNotEmpty(elibStatistics.getSearch_sdt()) || StringUtils.isNotEmpty(elibStatistics.getSearch_edt())) {
			List<ElibStatistics> elibStatisticsSummaryList = service.getStatisticsSummaryList(elibStatistics);
			List<ElibStatistics> elibStatisticsUniqueSummaryList = service.getStatisticsUniqueSummaryList(elibStatistics);

			for(ElibStatistics elem: elibStatisticsSummaryList) {
				elibStatisticsSummary.put(elem.getType() + "." + elem.getAge_group() + "." + elem.getSex(), elem.getLend_cnt());
			}

			for(ElibStatistics elem: elibStatisticsUniqueSummaryList) {
				elibStatisticsUniqueSummary.put(elem.getType() + "." + elem.getAge_group() + "." + elem.getSex(), elem.getLend_cnt());
			}

		}

		model.addAttribute("elibStatistics", elibStatistics);
		model.addAttribute("obj", elibStatistics);
		model.addAttribute("elibStatisticsSummary", elibStatisticsSummary);
		model.addAttribute("elibStatisticsUniqueSummary", elibStatisticsUniqueSummary);
		model.addAttribute("cateList", elibCategoryService.getCategoryList(new ElibCategory(elibStatistics.getType())));
		model.addAttribute("compList", elibCodeService.getCompList(new ElibCode(elibStatistics.getType())));
		model.addAttribute("library_code", getLibraryCode(request));

		if("_excel".equals(url)) {
			return basePath + "summary_excel_ajax";
		} else if("_csv".equals(url)) {
			return basePath + "csv_ajax";
		} else {
			return basePath + "summary";
		}
	}

	@RequestMapping(value = {"{menuParam}/excelDownload.*"}, method = RequestMethod.POST)
	public AbstractJExcelView excel(Model model, ElibStatistics elibStatistics, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String menu = elibStatistics.getMenu();
		List<ElibStatistics> elibStatisticsList = null;
		AbstractJExcelView view = null;

		if("HOUR".equals(menu) || "DAY".equals(menu) || "MONTH".equals(menu) || "PERIOD".equals(menu)) {
			elibStatisticsList = service.getStatisticsByTime(elibStatistics);
			view = new ElibStatisticsTimeExcelView();
		} else if("CATEGORY".equals(menu)) {
//			elibStatisticsList = service.getStatisticsByCategory(elibStatistics);
			view = new ElibStatisticsCategoryExcelView();
		} else if("BOOK".equals(menu)) {
			elibStatisticsList = service.getStatisticsByBookAll(elibStatistics);

			for(ElibStatistics one: elibStatisticsList) {
				updateDeviceCnt(one);
			}

			view = new ElibStatisticsBookExcelView();
		} else if("MEMBER".equals(menu)) {
			elibStatisticsList = service.getStatisticsByMemberAll(elibStatistics);
			view = new ElibStatisticsMemberExcelView();
		} else if("AGE".equals(menu)) {
			elibStatisticsList = service.getStatisticsByAge(elibStatistics);
			view = new ElibStatisticsAgeExcelView();
		}

		model.addAttribute("elibStatistics", elibStatistics);
		model.addAttribute("elibStatisticsList", elibStatisticsList);
		model.addAttribute("libraries", elibCodeService.getLibraryMap());
		model.addAttribute("providers", elibCodeService.getCompMap());
		model.addAttribute("library_code", getLibraryCode(request));

		return view;
	}

	@RequestMapping(value = {"{menuParam}/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, ElibStatistics elibStatistics, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String menu = elibStatistics.getMenu();
		List<ElibStatistics> elibStatisticsList = null;

		if("HOUR".equals(menu) || "DAY".equals(menu) || "MONTH".equals(menu) || "PERIOD".equals(menu)) {
			elibStatisticsList = service.getStatisticsByTime(elibStatistics);
		} else if("CATEGORY".equals(menu)) {
//			elibStatisticsList = service.getStatisticsByCategory(elibStatistics);
		} else if("BOOK".equals(menu)) {
			elibStatisticsList = service.getStatisticsByBookAll(elibStatistics);

			for(ElibStatistics one: elibStatisticsList) {
				updateDeviceCnt(one);
			}
		} else if("MEMBER".equals(menu)) {
			elibStatisticsList = service.getStatisticsByMemberAll(elibStatistics);
		} else if("AGE".equals(menu)) {
			elibStatisticsList = service.getStatisticsByAge(elibStatistics);
		}

		Map<String, String> libraries = elibCodeService.getLibraryMap();
		Map<String, String> providers = elibCodeService.getCompMap();
		String library_code = getLibraryCode(request);

		new ElibStatisticsXlsToCsv(elibStatistics, elibStatisticsList, libraries, providers, library_code, request, response);
	}

	private String getLibraryCode(HttpServletRequest request) {
		String asideHomepageId = getAsideHomepageId(request);

		Homepage homepage = new Homepage(asideHomepageId);
		homepage = homepageService.getHomepageOne(homepage);

		if(homepage == null) {
			return null;
		} else {
			String homepage_code = StringUtils.defaultString(homepage.getLib_code());
			int i = homepage_code.indexOf(",");
			if(i < 0) {
				return homepage_code;
			} else {
				return homepage_code.substring(0, homepage_code.indexOf(","));
			}
		}
	}

}
