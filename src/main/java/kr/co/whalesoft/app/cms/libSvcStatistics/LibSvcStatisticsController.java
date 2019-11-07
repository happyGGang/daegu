package kr.co.whalesoft.app.cms.libSvcStatistics;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;

@Controller
@RequestMapping(value={"/cms/libSvcStatistics"})
public class LibSvcStatisticsController extends BaseController {
	
	private final String basePath = "/cms/libSvcStatistics/";
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private LibSvcStatisticsService service;
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, LibSvcStatistics libSvcStatistics, HttpServletRequest request) {
		
		if(StringUtils.isEmpty(libSvcStatistics.getStart_date()) && StringUtils.isEmpty(libSvcStatistics.getEnd_date())) {
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			libSvcStatistics.setEnd_date(sdf.format(cal.getTime()));
			
			cal.add(cal.DATE, -6);
			libSvcStatistics.setStart_date(sdf.format(cal.getTime()));
		}
		
		List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
		List<Homepage> homepageList = homepageService.getNormalHomepage();
		List<Code> codeList = codeService.getCode("c0", "H0001");
		
		List<LibSvcStatistics> memberCnt = service.getMemberCnt(libSvcStatistics, "N");
		
		int j = 0;//listMap용 index
		for(int i = 0; i < homepageList.size(); i++) {
			if (homepageList.get(i).getHomepage_type().equals("homepage")) {
				//홈페이지 유형이 아니라면 continue;
				continue;
			}
			
			String homepage_id = homepageList.get(i).getHomepage_id();
			String homepage_name = homepageList.get(i).getHomepage_name();
			
			listMap.add(new HashMap<String, Object>());
			listMap.get(j).put("homepage_id", homepage_id);
			listMap.get(j).put("homepage_name", homepage_name);
			
			for(Code code : codeList) {
				if(!code.getCode_id().equals("0000") && !code.getCode_id().equals("0040")) {
					libSvcStatistics.setHomepage_id(homepage_id);
					libSvcStatistics.setCode_id(code.getCode_id());
					
					String label = "";
					if(code.getCode_id().equals("0030")) {
						label = "I";
					} else if(code.getCode_id().equals("0010")) {
						label = "C";
					} else if(code.getCode_id().equals("0020")) {
						label = "D";
					} else if(code.getCode_id().equals("0050")) {
						label = "E";
					}
					
					listMap.get(j).put(label, service.getCategoryCnt(libSvcStatistics));
				}
			}
			
			listMap.get(j).put("memberCnt", memberCnt.get(j));
			
			j++;
		}
		
		listMap.add(new HashMap<String, Object>());
		listMap.get(listMap.size()-1).put("homepage_name", "합계");
		for(Code code : codeList) {
			if(!code.getCode_id().equals("0000") && !code.getCode_id().equals("0040")) {
				libSvcStatistics.setHomepage_id(null);
				libSvcStatistics.setCode_id(code.getCode_id());
				
				String label = "";
				if(code.getCode_id().equals("0030")) {
					label = "I";
				} else if(code.getCode_id().equals("0010")) {
					label = "C";
				} else if(code.getCode_id().equals("0020")) {
					label = "D";
				} else if(code.getCode_id().equals("0050")) {
					label = "E";
				}
				
				listMap.get(listMap.size()-1).put(label, service.getCategoryCnt(libSvcStatistics));
				listMap.get(j).put("memberCnt", service.getMemberCnt(libSvcStatistics, "Y").get(0));
			}
		}
		
		int trSize = 0;
		for(Code code : codeList) {
			if(!code.getCode_id().equals("0000") && !code.getCode_id().equals("0040")) {
				trSize++;
			}
		}
		
		model.addAttribute("trSize", trSize);
		
		model.addAttribute("libSvcStatistics", libSvcStatistics);
		model.addAttribute("listMap", listMap);
		model.addAttribute("codeList", codeList);
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public LibSvcStatisticsSearchView excelDownload(Model model, LibSvcStatistics libSvcStatistics, HttpServletRequest request){
		
		List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
		List<Homepage> homepageList = homepageService.getNormalHomepage();
		List<Code> codeList = codeService.getCode("c0", "H0001");
		
		for(Iterator<Code> iterator = codeList.iterator(); iterator.hasNext();) {
			Code code = (Code)iterator.next();
			if(code.getCode_id().equals("0000") || code.getCode_id().equals("0040")) {
				iterator.remove();
			}
		}
		
		int j = 0;//listMap용 index
		
		for(int i = 0; i < homepageList.size(); i++) {
			if (homepageList.get(i).getHomepage_type().equals("homepage")) {
				//홈페이지 유형이 아니라면 continue;
				continue;
			}
			
			String homepage_id = homepageList.get(i).getHomepage_id();
			String homepage_name = homepageList.get(i).getHomepage_name();
			
			listMap.add(new HashMap<String, Object>());
			listMap.get(j).put("homepage_id", homepage_id);
			listMap.get(j).put("homepage_name", homepage_name);
			
			for(Code code : codeList) {
				libSvcStatistics.setHomepage_id(homepage_id);
				libSvcStatistics.setCode_id(code.getCode_id());
				
				String label = "";
				if(code.getCode_id().equals("0030")) {
					label = "I";
				} else if(code.getCode_id().equals("0010")) {
					label = "C";
				} else if(code.getCode_id().equals("0020")) {
					label = "D";
				} else if(code.getCode_id().equals("0050")) {
					label = "E";
				}
				
				listMap.get(j).put(label, service.getCategoryCnt(libSvcStatistics));
			}
			
			j++;
		}
		
		listMap.add(new HashMap<String, Object>());
		listMap.get(listMap.size()-1).put("homepage_name", "합계");
		for(Code code : codeList) {
			libSvcStatistics.setHomepage_id(null);
			libSvcStatistics.setCode_id(code.getCode_id());
			
			String label = "";
			if(code.getCode_id().equals("0030")) {
				label = "I";
			} else if(code.getCode_id().equals("0010")) {
				label = "C";
			} else if(code.getCode_id().equals("0020")) {
				label = "D";
			} else if(code.getCode_id().equals("0050")) {
				label = "E";
			}
			
			listMap.get(listMap.size()-1).put(label, service.getCategoryCnt(libSvcStatistics));
		}
		
//		Gson gson = new Gson();
//		List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
//		Type listType = TypeToken.get(listMap.getClass()).getType();
//		listMap = gson.fromJson(libSvcStatistics.getJsonObj(), listType);
		
//		List<Code> codeList = codeService.getCode("c0", "H0001");
//		for(Iterator<Code> iterator = codeList.iterator(); iterator.hasNext();) {
//			Code code = (Code)iterator.next();
//			if(code.getCode_id().equals("0000") || code.getCode_id().equals("0040")) {
//				iterator.remove();
//			}
//		}
		
		model.addAttribute("listMap", listMap);
		model.addAttribute("codeList", codeList);
		
		return new LibSvcStatisticsSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csvDownload(Model model, LibSvcStatistics libSvcStatistics, HttpServletRequest request, HttpServletResponse response){
		
		List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
		List<Homepage> homepageList = homepageService.getNormalHomepage();
		List<Code> codeList = codeService.getCode("c0", "H0001");
		
		for(Iterator<Code> iterator = codeList.iterator(); iterator.hasNext();) {
			Code code = (Code)iterator.next();
			if(code.getCode_id().equals("0000") || code.getCode_id().equals("0040")) {
				iterator.remove();
			}
		}
		
		int j = 0;//listMap용 index
		
		for(int i = 0; i < homepageList.size(); i++) {
			if (homepageList.get(i).getHomepage_type().equals("homepage")) {
				//홈페이지 유형이 아니라면 continue;
				continue;
			}
			
			String homepage_id = homepageList.get(i).getHomepage_id();
			String homepage_name = homepageList.get(i).getHomepage_name();
			
			listMap.add(new HashMap<String, Object>());
			listMap.get(j).put("homepage_id", homepage_id);
			listMap.get(j).put("homepage_name", homepage_name);
			
			for(Code code : codeList) {
				libSvcStatistics.setHomepage_id(homepage_id);
				libSvcStatistics.setCode_id(code.getCode_id());
				
				String label = "";
				if(code.getCode_id().equals("0030")) {
					label = "I";
				} else if(code.getCode_id().equals("0010")) {
					label = "C";
				} else if(code.getCode_id().equals("0020")) {
					label = "D";
				} else if(code.getCode_id().equals("0050")) {
					label = "E";
				}
				
				listMap.get(j).put(label, service.getCategoryCnt(libSvcStatistics));
			}
			
			j++;
		}
		
		listMap.add(new HashMap<String, Object>());
		listMap.get(listMap.size()-1).put("homepage_name", "합계");
		for(Code code : codeList) {
			libSvcStatistics.setHomepage_id(null);
			libSvcStatistics.setCode_id(code.getCode_id());
			
			String label = "";
			if(code.getCode_id().equals("0030")) {
				label = "I";
			} else if(code.getCode_id().equals("0010")) {
				label = "C";
			} else if(code.getCode_id().equals("0020")) {
				label = "D";
			} else if(code.getCode_id().equals("0050")) {
				label = "E";
			}
			
			listMap.get(listMap.size()-1).put(label, service.getCategoryCnt(libSvcStatistics));
		}
		
		new LibSvcStatisticsXlsToCsv(listMap, codeList, request, response);
	}

}
