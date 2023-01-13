package kr.go.gbelib.app.cms.module.nearbyLib;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibDevice.NearbyLibDevice;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibDevice.NearbyLibDeviceService;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibLocker.NearbyLibLocker;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibLocker.NearbyLibLockerService;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibReserveConfig.NearbyLibReserveConfig;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibReserveConfig.NearbyLibReserveConfigService;

/**
 * @author ttkaz
 * 2022. 9. 27.
 *
 */

@Controller
@RequestMapping(value = {"/cms/module/nearbyLib"})
public class NearbyLibController extends BaseController {

	private final String basePath = "/cms/module/nearbyLib/";
	
	
	@Autowired
	private NearbyLibService service;
	
	@Autowired
	private NearbyLibDeviceService deviceService;
	
	@Autowired
	private NearbyLibLockerService lockerService;
	
	@Autowired
	private NearbyLibReserveConfigService configService;
	
	/** 대출관리(수동관리)페이지 불러오기
	 * @author ttkaz
	 * 2022. 12. 12.
	 *
	 */
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, NearbyLib nearbyLib, HttpServletRequest request)throws AuthException {
		checkAuth("R", model, request);
		NearbyLibDevice nearbyLibDevice = new NearbyLibDevice();
		List<NearbyLibDevice> deviceList = deviceService.getNeighborhoodLibraryDeviceList(nearbyLibDevice);
		String homepage_id = getAsideHomepageId(request);
		if(!"h90".equals(homepage_id)) {
			nearbyLib.setHomepage_id(homepage_id);
		}
		
		if(nearbyLib.getDevice_idx() > 0) {
			/*현재 사용 가능한 사물함의 갯수 뽑아오기*/
			NearbyLibLocker nearbyLibLocker = new NearbyLibLocker();
			nearbyLibLocker.setDevice_idx(nearbyLib.getDevice_idx());
			nearbyLibLocker.setEditMode("canUseLocker");
			List<NearbyLibLocker> lockerOneList = lockerService.getNeighborhoodLibraryLockerEachOneList(nearbyLibLocker); //현재 선택된 장비에 등록된 사물함리스트
			List<NearbyLib> useList = service.getNeighborhoodLibraryList(nearbyLib); //현재 선택된 장비를 쓰고있는 예약리스트
			for(int i = 0; i < lockerOneList.size();) {
				for(int j = 0; j < useList.size();) {
					if(lockerOneList.get(i).getLocker_each_idx() == useList.get(j).getLocker_idx()) {
						lockerOneList.remove(i);
						i = 0;
						j = 0;
						continue;
					}
					j++;
				}
				i++;
			}
			
			int nowLocker = lockerOneList.size();
			
			
			List<NearbyLibLocker> lockerList= new ArrayList<NearbyLibLocker>();
			List<NearbyLib> neighborhoodLibraryList = new ArrayList<NearbyLib>();
			/*사물함 배정 시 사용 가능한 사물함 번호 목록 뽑기, 변수명 : lockerList*/
			nearbyLibLocker.setEditMode("canUseLocker"); //사용중지 사물함은 제외
			lockerList = lockerService.getNeighborhoodLibraryLockerEachOneList(nearbyLibLocker); //선택된 디바이스에 등록된 사물함 개별정보 불러오기(사물함 총 갯수별 번호, 사용중인지 미사용중인지)
			if(lockerList.size() > 0) {
				lockerList = lockerService.getNeighborhoodLibraryLockerEachOneList(nearbyLibLocker); //선택된 디바이스에 등록된 사물함 개별정보 불러오기(사물함 총 갯수별 번호, 사용중인지 미사용중인지)
				if(lockerList.size() > 0) {
					nearbyLib.setDevice_idx(nearbyLibLocker.getDevice_idx());
					nearbyLib.setEditMode("lockerEmptycheck");
					neighborhoodLibraryList = service.getNeighborhoodLibraryList(nearbyLib); //장비에 예약된 예약목록 가져오기

				}
			}
			for(int i = 0 ; i < lockerList.size();) { //이미 배정되거나 사용중인 사물함은 뺀다 (사물함 선택해서 배정하는 용도 - select)
				for(int j = 0 ; j < neighborhoodLibraryList.size();) {
					if(lockerList.get(i).getLocker_each_idx() == neighborhoodLibraryList.get(j).getLocker_idx()) {
						lockerList.remove(i);
						i = 0;
						j = 0;
						continue;
					}
					j++;
				}
				i++;
			}
			
			model.addAttribute("lockerList", lockerList); // ex) 사물함 1,2,3,4.... 사물함 총 개별 정보
			model.addAttribute("nowLocker", nowLocker);
		}
//		List<nearbyLibLocker2> lockerOneList = lockerService.getnearbyLibLockerEachOneList(nearbyLibLocker);//사물함 번호&갯수 가져오기		
//		List<NeighborhoodLibrary2> usedLockerList = service.getNeighborhoodLibraryList(neighborhoodLibrary); //사물함을 사용하는 예약 내역만 가져오기 
		
		int count = service.getNeighborhoodLibraryCount(nearbyLib);
		nearbyLib.setTotalDataCount(count);
		
		service.setPaging(model, count, nearbyLib);
		
		model.addAttribute("deviceList", deviceList);
		model.addAttribute("reserveList", service.getNeighborhoodLibraryListAll(nearbyLib));		
		model.addAttribute("nearbyLib", nearbyLib);
		return basePath + "index";
	}
	
	/** 대출관리(사물함배정) 페이지 불러오기
	 * @author ttkaz
	 * 2022. 12. 12.
	 *
	 */
	
	@RequestMapping(value = {"/nearbyLibControll/controll_index.*"})
	public String controll_index(Model model, NearbyLibLocker nearbyLibLocker, HttpServletRequest request)throws AuthException {
		checkAuth("R", model, request);
		
		String homepage_id = getAsideHomepageId(request);
		NearbyLib neighborhoodLibrary = new NearbyLib();
		
		if(!"h90".equals(homepage_id)) { //내집앞 도서관이 아닌 도서관에서 페이지를 열때는 해당 홈페이지 자료만 보이게 한다
			neighborhoodLibrary.setHomepage_id(homepage_id);
		}
		
		NearbyLibDevice neighborhoodLibraryDevice = new NearbyLibDevice();
		
		List<NearbyLibDevice> deviceList = deviceService.getNeighborhoodLibraryDeviceList(neighborhoodLibraryDevice); //사물함 정보가 등록된 디바이스 목록 불러오기
		
		List<NearbyLibLocker> lockerOneList= new ArrayList<NearbyLibLocker>();
		NearbyLibLocker lockerOne = new NearbyLibLocker();
		List<NearbyLib> neighborhoodLibraryList = new ArrayList<NearbyLib>();
		int count = 0;
		if(deviceList.size() > 0) {
			if(nearbyLibLocker.getDevice_idx() == 0) { //처음 페이지 접속시 넘어온 device_idx가 없다
				if(deviceList.get(0).getDevice_idx() > 0) {	//장비리스트 조회했을때 장비가 존재할때
					nearbyLibLocker.setDevice_idx(deviceList.get(0).getDevice_idx());
					nearbyLibLocker.setEditMode("canUseLocker"); // 사용중지 사물함은 제외
					lockerOneList = lockerService.getNeighborhoodLibraryLockerEachOneList(nearbyLibLocker); //선택된 디바이스에 등록된 사물함 개별정보 불러오기(사물함 총 갯수별 번호, 사용중인지 미사용중인지)
					lockerOne = lockerService.getNeighborhoodLibraryLockerOne(nearbyLibLocker);	//선택된 디바이스에 등록된 사물함 정보 불러오기(장비 기본 등록 후 몇칸인지 정보 등록하는 table)
					if(lockerOneList.size() > 0){
						neighborhoodLibrary.setDevice_idx(nearbyLibLocker.getDevice_idx());
						neighborhoodLibrary.setEditMode("lockerDetail");						
						neighborhoodLibraryList = service.getNeighborhoodLibraryList(neighborhoodLibrary);
						count = neighborhoodLibraryList.size();
					}
				}
			}else { //페이지 접속 시 device_idx 값을 가지고 올때
				if(deviceList.get(0).getDevice_idx() > 0) {	//장비리스트 조회했을때 장비가 존재할때
					nearbyLibLocker.setEditMode("canUseLocker"); //사용중지 사물함은 제외
					lockerOneList = lockerService.getNeighborhoodLibraryLockerEachOneList(nearbyLibLocker); //선택된 디바이스에 등록된 사물함 개별정보 불러오기(사물함 총 갯수별 번호, 사용중인지 미사용중인지)
					lockerOne = lockerService.getNeighborhoodLibraryLockerOne(nearbyLibLocker);	//선택된 디바이스에 등록된 사물함 정보 불러오기(장비 기본 등록 후 몇칸인지 정보 등록하는 table)
					if(lockerOneList.size() > 0) {
						neighborhoodLibrary.setDevice_idx(nearbyLibLocker.getDevice_idx());
						neighborhoodLibrary.setEditMode("lockerDetail");
						neighborhoodLibraryList = service.getNeighborhoodLibraryList(neighborhoodLibrary); //장비에 예약된 예약목록 가져오기
						count = neighborhoodLibraryList.size();
					}
				}
			}
			for(int i = 0 ; i < lockerOneList.size();) { //이미 배정되거나 사용중인 사물함은 뺀다 (사물함 선택해서 배정하는 용도)
				for(int j = 0 ; j < neighborhoodLibraryList.size();) {
					if(lockerOneList.get(i).getLocker_each_idx() == neighborhoodLibraryList.get(j).getLocker_idx()) {
						lockerOneList.remove(i);
						i = 0;
						j = 0;
						continue;
					}
					j++;
				}
				i++;
			}
			
		}
		
		NearbyLibDevice searchDevice = new NearbyLibDevice();
		searchDevice.setDevice_idx(nearbyLibLocker.getDevice_idx());
		NearbyLibDevice nearbyLibDevice = deviceService.getNeighborhoodLibraryDeviceOne(searchDevice);
		
		if(!"h90".equals(homepage_id)) { //내집앞도서관에서 접속하는게 아니라면 해당 도서관의 예약만 보여주기
			for(int k = 0; k < neighborhoodLibraryList.size();) {
				if(!homepage_id.equals(neighborhoodLibraryList.get(k).getHomepage_id())){
					neighborhoodLibraryList.remove(k);
					k = 0;
					continue;
				}
				k++;
			}
		}
		
		//사물함 정보
		model.addAttribute("deviceList", deviceList);
		model.addAttribute("locker", nearbyLibLocker); // 
		model.addAttribute("lockerOne", lockerOne);	// 등록된 장비에 사물함이 총 몇개인지 정보
		model.addAttribute("lockerOneList", lockerOneList); // ex) 사물함 1,2,3,4.... 사물함 총 개별 정보
		model.addAttribute("nearbyLibLocker", nearbyLibLocker);
		model.addAttribute("deviceOne", nearbyLibDevice);
		//대출 정보
		model.addAttribute("neighborhoodLibrary", neighborhoodLibrary);
		model.addAttribute("neighborhoodLibraryList", neighborhoodLibraryList);
		model.addAttribute("neighborhoodLibraryCount", count);

		return basePath + "nearbyLibControll/controll_index";
	}
	
	/** 대출관리(사물함배정) 페이지 내에 사물함(레이아웃) 페이지 불러오기
	 * @author ttkaz
	 * 2022. 12. 12.
	 *
	 */
	
	@RequestMapping(value = {"/nearbyLibControll/deviceOne.*"})
	public String deviceOne(Model model, NearbyLibLocker nearbyLibLocker, HttpServletRequest request)throws AuthException {

		List<NearbyLibLocker> lockerOneList = new ArrayList<NearbyLibLocker>();
		Map<String, Map<String, Object>> lockerEachList = new HashMap<String, Map<String,Object>>();
		
		NearbyLib nearbyLib = new NearbyLib();
	
		nearbyLib.setDevice_idx(nearbyLibLocker.getDevice_idx());
		lockerOneList = lockerService.getNeighborhoodLibraryLockerEachOneList(nearbyLibLocker);
		List<NearbyLib> useList = service.getNeighborhoodLibraryList(nearbyLib); //현재 선택된 장비를 쓰고있는 예약리스트
		if(lockerOneList.size() > 0) { //map에 사물함 정보를 하나하나 넣는단
			for(int i = 0; i < lockerOneList.size(); i++) {
				Map<String,Object> lockerList = new HashMap<String,Object>();
				boolean status_yn = false;
				int reserveCount = 0;
				for(NearbyLib using : useList) { //사물함을 사용중인 대출건 비교
					if(lockerOneList.get(i).getLocker_each_idx() == using.getLocker_idx()) { //현재 사물함이 쓰고 있다면
						reserveCount = reserveCount + 1;
						lockerList.put("reserve_status", using.getReserve_status()); //상태값 넣기
						status_yn = true;
						continue;
					}
					
				}
				if(status_yn == false) {
					lockerList.put("reserve_status", "no-data");
				}
				lockerList.put("sameReserve", reserveCount);
				lockerList.put("device_idx", lockerOneList.get(i).getDevice_idx());
				lockerList.put("device_code", lockerOneList.get(i).getDevice_code());
				lockerList.put("device_name", lockerOneList.get(i).getDevice_name());
				lockerList.put("locker_idx", lockerOneList.get(i).getLocker_idx());
				lockerList.put("locker_each_idx", lockerOneList.get(i).getLocker_each_idx());
				lockerList.put("use_yn", lockerOneList.get(i).getUse_yn());
				lockerList.put("unused_reason", lockerOneList.get(i).getUnused_reason());
				lockerEachList.put("no" + (lockerOneList.get(i).getLocker_each_idx()), lockerList);
			}
		}
		
		NearbyLibDevice searchDevice = new NearbyLibDevice();
		searchDevice.setDevice_idx(nearbyLibLocker.getDevice_idx());
		NearbyLibDevice thisDevice = deviceService.getNeighborhoodLibraryDeviceOne(searchDevice);
		
		model.addAttribute("nearbyLibLocker", nearbyLibLocker);
		model.addAttribute("lockerEach", lockerEachList);
		
			return basePath + "nearbyLibLocker/locker_" + thisDevice.getDevice_code();
		}
		
		
//		else if(여기는 사말훔 3){
//			return basePath + "deviceThree";
//		}else if(여기는 사물함 4){
//			return basePath + "deviceFour";
//		}else if(여기는 사물함 5){
//			return basePath + "deviceFive";
//		}
	
	
	/** 사물함별 개별 사용유무 설정 form
	 * @author ttkaz
	 * 2022. 9. 27.
	 *
	 */
	
	@RequestMapping(value = {"/nearbyLibControll/use_edit.*"})
	public String use_edit(Model model, NearbyLibLocker neighborhoodLibraryLocker, HttpServletRequest request) {
		NearbyLibDevice neighborhoodLibraryDevice = new NearbyLibDevice();
		neighborhoodLibraryDevice.setDevice_idx(neighborhoodLibraryLocker.getDevice_idx());
		neighborhoodLibraryDevice = deviceService.getNeighborhoodLibraryDeviceOne(neighborhoodLibraryDevice);
		model.addAttribute("locker", neighborhoodLibraryLocker);
		model.addAttribute("device", neighborhoodLibraryDevice);
		return basePath + "nearbyLibLocker/use_edit_ajax";
	}
	
	
	
	/** 사물함별 개별 사용유무 설정(사용설정 or 사용중지)
	 * @author ttkaz
	 * 2022. 9. 27.
	 *
	 */
	
	@RequestMapping(value = {"/nearbyLibControll/locker_each_edit.*"})
	public @ResponseBody JsonResponse locker_edit(Model model, NearbyLibLocker neighborhoodLibraryLocker, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "locker_idx", "사물함IDX를 가져오는데 실패하였습니다.");
		ValidationUtils.rejectIfEmpty(result, "use_yn", "사물함 사용값을 가져오는데 실패하였습니다.");
		
		if (!result.hasErrors()) {			
			lockerService.modifyNeighborhoodLibraryLocker(neighborhoodLibraryLocker);
			res.setValid(true);
			res.setMessage("사물함 설정이 완료되었습니다.");
			
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	/** 장비(사물함) 삭제
	 * @author ttkaz
	 * 2022. 9. 27.
	 *
	 */
	
	@RequestMapping(value = {"/delete.*"})
	public String edit(Model model, NearbyLib neighborhoodLibrary, HttpServletRequest request) {
		
		model.addAttribute("neighborhoodLibrary", neighborhoodLibrary);
		return basePath + "delete_ajax";
	}
	
	/** 금일 반납·반출 도서의 목록
	 * @author ttkaz
	 * 2022. 9. 27.
	 *
	 */
	
	@RequestMapping(value = {"/importExport/today_inOut.*"})
	public String today_inOut(Model model, NearbyLib nearbyLib, HttpServletRequest request)throws AuthException {
		checkAuth("R", model, request);
		
		NearbyLibDevice nearbyLibDeviceOne = new NearbyLibDevice();
		List<NearbyLibDevice> deviceList = deviceService.getNeighborhoodLibraryDeviceList(nearbyLibDeviceOne); //사물함 정보가 등록된 디바이스 목록 불러오기
		List<NearbyLib> inList = new ArrayList<NearbyLib>();
		List<NearbyLib> outList = new ArrayList<NearbyLib>();
		NearbyLib searchInToday = new NearbyLib();
		NearbyLib searchOutToday = new NearbyLib();
		
		String homepage_id = getAsideHomepageId(request);
		
		if(!"h90".equals(homepage_id)) { //내집앞 도서관이 아닌 도서관에서 페이지를 열때는 해당 홈페이지 자료만 보이게 한다
			searchInToday.setHomepage_id(homepage_id);
			searchOutToday.setHomepage_id(homepage_id);
		}
		
		if(nearbyLib.getDevice_idx() == 0) {
			if(deviceList.size() > 0) {
				nearbyLib.setDevice_idx(deviceList.get(0).getDevice_idx());
				searchInToday.setDevice_idx(deviceList.get(0).getDevice_idx());
				searchInToday.setManage_code(nearbyLib.getManage_code());
				searchOutToday.setDevice_idx(deviceList.get(0).getDevice_idx());
				searchOutToday.setManage_code(nearbyLib.getManage_code());
			}
		}else {
			searchInToday.setDevice_idx(nearbyLib.getDevice_idx());
			searchInToday.setManage_code(nearbyLib.getManage_code());
			searchOutToday.setDevice_idx(nearbyLib.getDevice_idx());
			searchOutToday.setManage_code(nearbyLib.getManage_code());
		}
		
		searchInToday.setEditMode("todayIn");
		
		inList = service.getNeighborhoodLibraryList(searchInToday); //오늘 반입 목록
		int inCount = service.getNeighborhoodLibraryCount(searchInToday); //오늘 반입 목록
		searchOutToday.setEditMode("todayOut");
		outList = service.getNeighborhoodLibraryList(searchOutToday); //오늘 반축 목록
		int outCount = service.getNeighborhoodLibraryCount(searchOutToday); //오늘 반출 목록
		
		NearbyLibReserveConfig configOne = new NearbyLibReserveConfig();
		NearbyLibReserveConfig reserveConfig = new NearbyLibReserveConfig();
		configOne = configService.getNeighborhoodLibraryReserveConfigOne(reserveConfig);
		
		Date nowDate = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("HH24mm");
		SimpleDateFormat simpleDateFormat1 = new SimpleDateFormat("yyyy/MM/dd");
		int now = Integer.parseInt(simpleDateFormat.format(nowDate));
		int startTime = Integer.parseInt(configOne.getReserve_start_time()); //RESERVE_START_TIME -> DB컬럼 타입 : String, 데이터 삽입 형식 : 0900, 1212
		int endTime = Integer.parseInt(configOne.getReserve_end_time());
		Calendar cal = Calendar.getInstance();			
		
		String start_time = "";
		String end_time = "";
		String startTime1 = configOne.getReserve_start_time().substring(0,2);
		String startTime2 = configOne.getReserve_start_time().substring(2);
		String endTime1 = configOne.getReserve_end_time().substring(0,2);
		String endTime2 = configOne.getReserve_end_time().substring(2);
		
		if("Y".equals(configOne.getTomorrow_end_day_yn())) { // 예약 시작부터 예약 종료시간이 00시를 넘어간다면 "Y"(이틀날짜내로 검색)
				cal.setTime(nowDate);
				cal.add(Calendar.DATE, -1);
				start_time = simpleDateFormat1.format(cal.getTime()) + " " + startTime1 + ":" + startTime2;
				end_time = simpleDateFormat1.format(nowDate) + " " + endTime1 + ":" + endTime2;
		}
		if("N".equals(configOne.getTomorrow_end_day_yn())) { //예약 시작과 종료 시간이 하루안에 이루어지면 "N"
			if(now >= startTime && now < endTime) { //현재 시간이 9시 이상이면 오늘날짜 검색을 오늘날짜로(한건 예약가능 시간은 09시부터 다음날 09시까지) 		
				start_time = simpleDateFormat1.format(nowDate) + " " + startTime1 + ":" + startTime2;
				end_time = simpleDateFormat1.format(nowDate) + " " + endTime1 + ":" + endTime2;
			}
		}
		
		model.addAttribute("start_time", start_time);
		model.addAttribute("end_time", end_time);
		model.addAttribute("inList", inList);
		model.addAttribute("inCount", inCount);
		model.addAttribute("outList", outList);
		model.addAttribute("outCount", outCount);
		model.addAttribute("deviceList", deviceList);
		model.addAttribute("nearbyLib", nearbyLib);
		return basePath + "importExport/today_inOut";
	}
	
	/** 내집앞도서관 상태값 변경 메서드 (1:예약, 2: 예약확정, 3:사물함투입, 4:대출, 5:회수대기, 6:회수중, 7:회수완료, 8:취소, 9:반납완료 )
	 * @author ttkaz
	 * 2022. 9. 27.
	 * @throws UnsupportedEncodingException 
	 *
	 */

	@RequestMapping(value = {"/save.*"})
	public @ResponseBody JsonResponse save(Model model, NearbyLib nearbyLib, BindingResult result, HttpServletRequest request) throws UnsupportedEncodingException {
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "reserve_status", "상태값 정보를 가져오지 못했습니다.");
		
		if(nearbyLib.getReserve_idx_arr() != null && !"".equals(nearbyLib.getReserve_idx_arr())){
			ValidationUtils.rejectIfEmpty(result, "reserve_idx", "예약번호를 가져오지 못했습니다.");			
		}
		if (!result.hasErrors()) {
			if(nearbyLib.getReserve_idx_arr() != null && !"".equals(nearbyLib.getReserve_idx_arr())){
				String[] reserve_idx_arr = nearbyLib.getReserve_idx_arr().split("_");
				for(int i = 0; i < reserve_idx_arr.length; i++) {
					nearbyLib.setReserve_idx(Integer.parseInt(reserve_idx_arr[i]));
					service.updateNearbyLib(nearbyLib, request);
				}
			}else {
				res = service.updateNearbyLib(nearbyLib, request);
			}
//			res.setValid(true);
//			if("2".equals(nearbyLib.getReserve_status())) {
//				res.setMessage("예약확정 되었습니다.");
//			}else if("3  ".equals(nearbyLib.getReserve_status())) {
//				res.setMessage("사물함 투입 상태로 변경 되었습니다.");
//			}else if("4".equals(nearbyLib.getReserve_status())) {
//				res.setMessage("대출 상태로 변경 되었습니다.");
//			}else if("5".equals(nearbyLib.getReserve_status())) {
//				res.setMessage("회수대기 상태로 변경 되었습니다.");
//			}else if("6".equals(nearbyLib.getReserve_status())) {
//				res.setMessage("회수중 상태로 변경 되었습니다.");
//			}else if("7".equals(nearbyLib.getReserve_status())) {
//				res.setMessage("회수완료 상태로 변경 되었습니다.");
//			}else if("8".equals(nearbyLib.getReserve_status())) {
//				res.setMessage("해당 예약이 취소 되었습니다.");
//			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/importExport/save.*"})
	public @ResponseBody JsonResponse save2(Model model, NearbyLib nearbyLib, BindingResult result, HttpServletRequest request) throws UnsupportedEncodingException {
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "reserve_status", "상태값 정보를 가져오지 못했습니다.");
		
		if(nearbyLib.getReserve_idx_arr() != null && !"".equals(nearbyLib.getReserve_idx_arr())){
			ValidationUtils.rejectIfEmpty(result, "reserve_idx", "예약번호를 가져오지 못했습니다.");			
		}
		if (!result.hasErrors()) {
			if(nearbyLib.getReserve_idx_arr() != null && !"".equals(nearbyLib.getReserve_idx_arr())){
				String[] reserve_idx_arr = nearbyLib.getReserve_idx_arr().split("_");
				for(int i = 0; i < reserve_idx_arr.length; i++) {
					nearbyLib.setReserve_idx(Integer.parseInt(reserve_idx_arr[i]));
					service.updateNearbyLib(nearbyLib, request);
				}
			}else {
				res = service.updateNearbyLib(nearbyLib, request);
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/return/save.*"})
	public @ResponseBody JsonResponse save3(Model model, NearbyLib nearbyLib, BindingResult result, HttpServletRequest request) throws UnsupportedEncodingException {
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "reserve_status", "상태값 정보를 가져오지 못했습니다.");
		
		if(nearbyLib.getReserve_idx_arr() != null && !"".equals(nearbyLib.getReserve_idx_arr())){
			ValidationUtils.rejectIfEmpty(result, "reserve_idx", "예약번호를 가져오지 못했습니다.");			
		}
		if (!result.hasErrors()) {
			if(nearbyLib.getReserve_idx_arr() != null && !"".equals(nearbyLib.getReserve_idx_arr())){
				String[] reserve_idx_arr = nearbyLib.getReserve_idx_arr().split("_");
				for(int i = 0; i < reserve_idx_arr.length; i++) {
					nearbyLib.setReserve_idx(Integer.parseInt(reserve_idx_arr[i]));
					service.updateNearbyLib(nearbyLib, request);
				}
			}else {
				res = service.updateNearbyLib(nearbyLib, request);
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	/** 예약확정 도서 큰책 유무 체크 업데이트(크기가 큰 도서를 큰 사물함에 넣기위해 배송기사에게 전달하기 전 사서가 미리 체크해놓는 기능)
	 * @author ttkaz
	 * 2022. 9. 27.
	 *
	 */
	
	@RequestMapping(value = {"/nearbyLibControll/book_update.*"})
	public @ResponseBody JsonResponse book_update(Model model, NearbyLib nearbyLib, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "large_book_yn", "큰책 유무 값을 가져오지 못했습니다.");
		ValidationUtils.rejectIfEmpty(result, "reserve_idx", "예약번호를 가져오지 못했습니다.");
		
		if (!result.hasErrors()) {
			service.updateNeighborhoodLibraryBookSize(nearbyLib);
			res.setValid(true);
			res.setMessage("책 크기 정보가 수정 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	/** 배송기사 사물함 배정
	 * @author ttkaz
	 * 2022. 9. 27.
	 *
	 */
	
	@RequestMapping(value = {"/nearbyLibControll/lockerUpdate.*"})
	public @ResponseBody JsonResponse lockerUpdateOne(Model model, NearbyLib nearbyLib, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "device_idx", "장비idx을 가져오지 못했습니다.");
		ValidationUtils.rejectIfEmpty(result, "reserve_status", "현재 예약 상태값을 가져오지 못했습니다.");
		ValidationUtils.rejectIfEmpty(result, "device_code", "장비코드를 가져오지 못했습니다.");
		if("lockerOne".equals(nearbyLib.getEditMode())) {
			ValidationUtils.rejectIfEmpty(result, "locker_each_idx", "사물함 번호를 가져오지 못했습니다.");
		} else {
			ValidationUtils.rejectIfEmpty(result, "reserve_idx_arr", "예약번호를 가져오지 못했습니다.");
		}
		
		if (!result.hasErrors()) {
			res = service.updateNeighborhoodLibraryLocker_idx(nearbyLib, request);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	/** 반납 목록 리스트(상태값이 9인것들만)
	 * @author HWANI
	 * 2022. 9. 27.
	 *
	 */
	
	@RequestMapping(value = {"/return/returnList.*"})
	public String returnList(Model model, NearbyLib nearbyLib, HttpServletRequest request)throws AuthException {
		checkAuth("R", model, request);
		
		NearbyLibDevice nearbyLibDeviceOne = new NearbyLibDevice();
		List<NearbyLibDevice> deviceList = deviceService.getNeighborhoodLibraryDeviceList(nearbyLibDeviceOne); //사물함 정보가 등록된 디바이스 목록 불러오기
		List<NearbyLib> returnList = new ArrayList<NearbyLib>();
		NearbyLib nearbyLibReturnList = new NearbyLib();
		String homepage_id = getAsideHomepageId(request);
		
		if(!"h90".equals(homepage_id)) { //내집앞 도서관이 아닌 도서관에서 페이지를 열때는 해당 홈페이지 자료만 보이게 한다
			nearbyLibReturnList.setHomepage_id(homepage_id);
		}
		
		if(nearbyLib.getDevice_idx() == 0) {
			if(deviceList.size() > 0) {
				nearbyLib.setDevice_idx(deviceList.get(0).getDevice_idx());
				nearbyLibReturnList.setDevice_idx(deviceList.get(0).getDevice_idx());
			}
		} else {
			nearbyLibReturnList.setDevice_idx(nearbyLib.getDevice_idx());
		}
		
		returnList = service.getNeighborhoodLibraryRerturnList(nearbyLibReturnList); //반납 목록 list
		int returnCount = service.getNeighborhoodLibraryReturnCount(nearbyLibReturnList); //반납 목록 count
		NearbyLibReserveConfig configOne = new NearbyLibReserveConfig();
		NearbyLibReserveConfig reserveConfig = new NearbyLibReserveConfig();
		configOne = configService.getNeighborhoodLibraryReserveConfigOne(reserveConfig);	
		
		model.addAttribute("reserveConfig", configOne);
		model.addAttribute("returnList", returnList);
		model.addAttribute("returnCount", returnCount);
		model.addAttribute("deviceList", deviceList);
		model.addAttribute("nearbyLib", nearbyLib);
		
		return basePath + "return/returnList";
	}
	
	@RequestMapping(value = {"/statusChange/index.*"}, method = RequestMethod.GET)
	public String statusChangeIndex(Model model, NearbyLib nearbyLib, HttpServletRequest request)throws AuthException {
		checkAuth("R", model, request);
		NearbyLibDevice nearbyLibDevice = new NearbyLibDevice();
		List<NearbyLibDevice> deviceList = deviceService.getNeighborhoodLibraryDeviceList(nearbyLibDevice);
		String homepage_id = getAsideHomepageId(request);
		if(!"h90".equals(homepage_id)) {
			nearbyLib.setHomepage_id(homepage_id);
		}
		if(nearbyLib.getDevice_idx() == 0) {
			nearbyLib.setDevice_idx(deviceList.get(0).getDevice_idx());
		}
		int count = service.getNeighborhoodLibraryCount(nearbyLib);
		nearbyLib.setTotalDataCount(count);
		
		/*현재 사용 가능한 사물함의 갯수 뽑아오기*/
		NearbyLibLocker nearbyLibLocker = new NearbyLibLocker();
		nearbyLibLocker.setDevice_idx(nearbyLib.getDevice_idx());
		nearbyLibLocker.setEditMode("canUseLocker");
		List<NearbyLibLocker> lockerOneList = lockerService.getNeighborhoodLibraryLockerEachOneList(nearbyLibLocker); //현재 선택된 장비에 등록된 사물함리스트
		List<NearbyLib> useList = service.getNeighborhoodLibraryList(nearbyLib); //현재 선택된 장비를 쓰고있는 예약리스트
		for(int i = 0; i < lockerOneList.size();) {
			for(int j = 0; j < useList.size();) {
				if(lockerOneList.get(i).getLocker_each_idx() == useList.get(j).getLocker_idx()) {
					lockerOneList.remove(i);
					i = 0;
					j = 0;
					continue;
				}
				j++;
			}
			i++;
		}
		
		int nowLocker = lockerOneList.size();
		
		
		List<NearbyLibLocker> lockerList= new ArrayList<NearbyLibLocker>();
		List<NearbyLib> neighborhoodLibraryList = new ArrayList<NearbyLib>();
		/*사물함 배정 시 사용 가능한 사물함 번호 목록 뽑기, 변수명 : lockerList*/
		nearbyLibLocker.setEditMode("canUseLocker"); //사용중지 사물함은 제외
		lockerList = lockerService.getNeighborhoodLibraryLockerEachOneList(nearbyLibLocker); //선택된 디바이스에 등록된 사물함 개별정보 불러오기(사물함 총 갯수별 번호, 사용중인지 미사용중인지)
		if(lockerList.size() > 0) {
			lockerList = lockerService.getNeighborhoodLibraryLockerEachOneList(nearbyLibLocker); //선택된 디바이스에 등록된 사물함 개별정보 불러오기(사물함 총 갯수별 번호, 사용중인지 미사용중인지)
			if(lockerList.size() > 0) {
				nearbyLib.setDevice_idx(nearbyLibLocker.getDevice_idx());
				nearbyLib.setEditMode("lockerEmptycheck");
				neighborhoodLibraryList = service.getNeighborhoodLibraryList(nearbyLib); //장비에 예약된 예약목록 가져오기

			}
		}
		for(int i = 0 ; i < lockerList.size();) { //이미 배정되거나 사용중인 사물함은 뺀다 (사물함 선택해서 배정하는 용도 - select)
			for(int j = 0 ; j < neighborhoodLibraryList.size();) {
				if(lockerList.get(i).getLocker_each_idx() == neighborhoodLibraryList.get(j).getLocker_idx()) {
					lockerList.remove(i);
					i = 0;
					j = 0;
					continue;
				}
				j++;
			}
			i++;
		}
		
		service.setPaging(model, count, nearbyLib);
		
		model.addAttribute("lockerList", lockerList); // ex) 사물함 1,2,3,4.... 사물함 총 개별 정보
		model.addAttribute("nowLocker", nowLocker);
		model.addAttribute("deviceList", deviceList);
		model.addAttribute("reserveList", service.getNeighborhoodLibraryListAll(nearbyLib));		
		model.addAttribute("nearbyLib", nearbyLib);
		return basePath + "statusChange/index";
	}
}
