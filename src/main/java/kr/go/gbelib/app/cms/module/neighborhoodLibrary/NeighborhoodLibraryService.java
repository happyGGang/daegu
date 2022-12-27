package kr.go.gbelib.app.cms.module.neighborhoodLibrary;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryLocker.NeighborhoodLibraryLocker;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryLocker.NeighborhoodLibraryLockerService;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryReserveConfig.NeighborhoodLibraryReserveConfig;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryReserveConfig.NeighborhoodLibraryReserveConfigService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

/**
 * @author SeongHyeon
 * 2022. 9. 27.
 *
 */
@Service
public class NeighborhoodLibraryService extends BaseService {

	@Autowired
	private NeighborhoodLibraryDao dao;
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private NeighborhoodLibraryLockerService lockerService;
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private NeighborhoodLibraryReserveConfigService reserveConfigService;

	public List<NeighborhoodLibrary> getNeighborhoodLibraryList(NeighborhoodLibrary neigborhoodLibrary) {
		return dao.getNeighborhoodLibraryList(neigborhoodLibrary);
	}

	public int insertNeighborhoodLibrary(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.insertNeighborhoodLibrary(neighborhoodLibrary);
	}

	public List<NeighborhoodLibrary> getNeighborhoodLibraryUseList(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.getNeighborhoodLibraryUseList(neighborhoodLibrary);
	}

	public int addNeighborhoodLibrary(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.addNeighborhoodLibrary(neighborhoodLibrary);
	}
	
	public int getNeighborhoodLibraryBundleIdx(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.getNeighborhoodLibraryBundleIdx(neighborhoodLibrary);
	}

	public int getNeighborhoodLibraryCount(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.getNeighborhoodLibraryCount(neighborhoodLibrary);
	}

	public List<NeighborhoodLibrary> getNeighborhoodLibraryListAll(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.getNeighborhoodLibraryListAll(neighborhoodLibrary);
	}
	
	public @ResponseBody JsonResponse updateNeighborhoodLibrary(NeighborhoodLibrary neighborhoodLibrary, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Member member = (Member)loginService.getSessionMember(request);
		int result = 0;
		if("2".equals(neighborhoodLibrary.getReserve_status())) { // 2: 예약확정
			
			NeighborhoodLibrary neighborhoodLibrary2 = new NeighborhoodLibrary();
			neighborhoodLibrary2.setReserve_status("2"); // 2: 예약확정 , 예약 확정은 한건씩 처리하므로 동일한 장비에 같은 id로 이미 예약 확정된 건이 있는지 검색한다
			neighborhoodLibrary2.setReserve_idx(neighborhoodLibrary.getReserve_idx()); //예약 idx
			neighborhoodLibrary2.setReserve_bundle_idx(neighborhoodLibrary.getReserve_bundle_idx()); //번들 idx가 같으면 같은 건수 이므로 같은 번들 idx가 있는지 검색
			NeighborhoodLibrary sameReserveOne = sameNeighborhoodLibraryForUser(neighborhoodLibrary2); 
			
			NeighborhoodLibraryReserveConfig searchConfig = new NeighborhoodLibraryReserveConfig();
			NeighborhoodLibraryReserveConfig ReserveConfig = reserveConfigService.getNeighborhoodLibraryReserveConfigOne(searchConfig); //예약설정 불러오기
			
			
			
			if(sameReserveOne == null) { //사물함 배정 내역이 없으면 사물함 배정 and 비밀번호 생성
				int useLocker = 0; //기본 사물함 배정idx값을 0으로 준다
				/*사물함 정보 가져와서 사용중인 내역과 매칭하고 비어있는 사물함 배정하기*/				
				NeighborhoodLibraryLocker neighborhoodLibraryLocker = new NeighborhoodLibraryLocker();				
				neighborhoodLibraryLocker.setDevice_idx(neighborhoodLibrary.getDevice_idx());
				List<NeighborhoodLibraryLocker> lockerOneList = lockerService.getNeighborhoodLibraryLockerEachOneList(neighborhoodLibraryLocker);//사물함 번호&갯수 가져오기		
				List<NeighborhoodLibrary> usedLockerList = getNeighborhoodLibraryList(neighborhoodLibrary); //사물함을 사용하는 예약 내역만 가져오기 
				
				if(lockerOneList.size() <= usedLockerList.size()) {
					res.setValid(false);
					res.setMessage("빈 사물함이 없습니다.");
					return res;
				}
				loopOut:
				for(int i = 0; i < lockerOneList.size(); i++ ){ //총 사물함 갯수만큼 루프
					if(usedLockerList != null) {
						if(usedLockerList.size() > 0) {
							for(int j = 0; j < usedLockerList.size(); j ++) { //사용중인 사물함 갯수만큼 루프
								if(lockerOneList.get(i).getLocker_each_idx() == usedLockerList.get(j).getLocker_idx()) { //현재 루프중인 사물함 idx가 사용중인 사물함 idx리스트에 포함되어 있으면 다음 루프로 이동
									continue;
								}else {
									useLocker = lockerOneList.get(i).getLocker_each_idx(); //현재 루프중인 사물함 idx가 사용중인 사물함에 포함되지 않았으면 useLocker에 사물함 idx 담기
									break loopOut;	//모든 루프 스탑
								}
							}
							
						}else {
							useLocker = 1; //사물함 사용내역이 0이면
						}
					}else {
						useLocker = 1; //사물함 사용내역이 null
					}
				}
				
				/*비밀번호 랜덤 생성(숫자네자리)*/
				int temp = 0;
				int pass = 0;
				
				Random random = new Random();
				random.setSeed(new Date().getTime());
				
				int p = (int)(Math.random()*(9 - 1 + 1))+ 1;
				String a = Integer.toString(random.nextInt(10));
				String s = Integer.toString(random.nextInt(10));
				String ss = Integer.toString(random.nextInt(10));
				pass = Integer.parseInt(p+a+s+ss);
				
				/*정보 업데이트하기*/
				neighborhoodLibrary.setLocker_idx(useLocker);
				neighborhoodLibrary.setDevice_password(pass);	
				neighborhoodLibrary.setTake_term(ReserveConfig.getTake_term());
				neighborhoodLibrary.setExpire_date_cnt(ReserveConfig.getExpire_date_cnt());
				result = dao.updateNeighborhoodLibrary(neighborhoodLibrary);
				if(result > 0) {
					NeighborhoodLibrary searchOne = new NeighborhoodLibrary();
					searchOne.setReserve_idx(neighborhoodLibrary.getReserve_idx());
					searchOne.setReserve_status(neighborhoodLibrary.getReserve_status());
					NeighborhoodLibrary reserveOne = dao.getSameNeighborhoodLibraryBundle_idx(searchOne); 
					Homepage homepage = homepageService.getHomepageOne(new Homepage(reserveOne.getHomepage_id()));
					
			        LibrarySearch librarySearch = new LibrarySearch();
			        librarySearch.setManageCode(reserveOne.getManage_code());
			        librarySearch.setUserkey(reserveOne.getUser_key());
			        String userIp = reserveOne.getAdd_ip();
			        String book_name = reserveOne.getBook_name();
			        String lockerIdx = String.valueOf(reserveOne.getLocker_idx());
			        if(lockerIdx.length() == 1 ) {
			        	lockerIdx = "00" + lockerIdx;	
			        }else if(lockerIdx.length() == 2) {
			        	lockerIdx = "0" + lockerIdx;
			        }
					String mes = "http://library.daegu.go.kr/" + homepage.getContext_path() 
							+ "/module/nearLib/bacode.do?pass=" + reserveOne.getDevice_password() + lockerIdx + reserveOne.getDevice_idx()
							+ "\n[" + reserveOne.getLib_name() + "]\n" + reserveOne.getMember_name() + "님 도서예약이 확정되었습니다."
							+ "\n도서 정보 : " + book_name 
							+ "\n장비명 : " + reserveOne.getDevice_name()
							+ "\n사물함 번호 : " + reserveOne.getLocker_idx() 
							+ "\n사물함 비밀번호 : " + reserveOne.getDevice_password() 
							+ "\n사물함 도서비치 완료되면 문자가 발송됩니다.";
					LibSearchAPI.sendSms(librarySearch, mes, userIp);
					NeighborhoodLibrary sms_send = new NeighborhoodLibrary();
					sms_send.setSms_send_yn("Y");
					sms_send.setReserve_idx(neighborhoodLibrary.getReserve_idx());
					dao.updateNeighborhoodLibrarySms(sms_send);
				}else {
					res.setValid(false);
					res.setMessage("업데이트에 실패 하였습니다.");
					return res;
				}
				
			}else { //이미 예약 확정된 내역이 있다면 사물함번호, 비밀번호 동일하게 배정
				neighborhoodLibrary.setTake_term(ReserveConfig.getTake_term());
				neighborhoodLibrary.setExpire_date_cnt(ReserveConfig.getExpire_date_cnt());
				neighborhoodLibrary.setLocker_idx(sameReserveOne.getLocker_idx());
				neighborhoodLibrary.setDevice_password(sameReserveOne.getDevice_password());
				result = dao.updateNeighborhoodLibrary(neighborhoodLibrary);
				if(result > 0) {
					NeighborhoodLibrary searchOne = new NeighborhoodLibrary();
					searchOne.setReserve_idx(neighborhoodLibrary.getReserve_idx());
					searchOne.setReserve_status(neighborhoodLibrary.getReserve_status());
					NeighborhoodLibrary reserveOne = dao.getSameNeighborhoodLibraryBundle_idx(searchOne); 
					Homepage homepage = homepageService.getHomepageOne(new Homepage(reserveOne.getHomepage_id()));
					
			        LibrarySearch librarySearch = new LibrarySearch();
			        librarySearch.setManageCode(reserveOne.getManage_code());
			        librarySearch.setUserkey(reserveOne.getUser_key());
			        String userIp = reserveOne.getAdd_ip();
			        String book_name = reserveOne.getBook_name();
			        String lockerIdx = String.valueOf(reserveOne.getLocker_idx());
			        if(lockerIdx.length() == 1 ) {
			        	lockerIdx = "00" + lockerIdx;	
			        }else if(lockerIdx.length() == 2) {
			        	lockerIdx = "0" + lockerIdx;
			        }
					String mes = "http://library.daegu.go.kr/" + homepage.getContext_path() 
							+ "/module/nearLib/bacode.do?pass=" + reserveOne.getDevice_password() + lockerIdx + reserveOne.getDevice_idx() 
							+ "\n[" + reserveOne.getLib_name() + "]\n" + reserveOne.getMember_name() + "님 도서예약이 확정되었습니다."
							+ "\n도서 정보 : " + book_name 
							+ "\n장비명 : " + reserveOne.getDevice_name()
							+ "\n사물함 번호 : " + reserveOne.getLocker_idx() 
							+ "\n사물함 비밀번호 : " + reserveOne.getDevice_password() 
							+ "\n사물함 도서비치 완료되면 문자가 발송됩니다.";
					LibSearchAPI.sendSms(librarySearch, mes, userIp);	 
					NeighborhoodLibrary sms_send = new NeighborhoodLibrary();
					sms_send.setSms_send_yn("Y");
					sms_send.setReserve_idx(neighborhoodLibrary.getReserve_idx());
					dao.updateNeighborhoodLibrarySms(sms_send);
					
				}else {
					res.setValid(false);
					res.setMessage("업데이트에 실패 하였습니다.");
					return res;
				}
			}
		}else if("3".equals(neighborhoodLibrary.getReserve_status())|| 
				"4".equals(neighborhoodLibrary.getReserve_status()) || 
				"5".equals(neighborhoodLibrary.getReserve_status()) ||
				"6".equals(neighborhoodLibrary.getReserve_status()) ||
				"7".equals(neighborhoodLibrary.getReserve_status())) { //3: 사물함 투입, 4: 대출, 5: 회수대기, 6: 회수중, 7:회수완료
			NeighborhoodLibrary status3 = new NeighborhoodLibrary();
			NeighborhoodLibrary status3_update = new NeighborhoodLibrary();
			status3_update.setDevice_code(neighborhoodLibrary.getDevice_code());
			if("3".equals(neighborhoodLibrary.getReserve_status())) {
				status3.setReserve_status("2"); // 2: 예약확정(이 전 단계 검색용)
				status3_update.setReserve_status("3"); //3: 사물함투입(업데이트용 상태값)
			}else if("4".equals(neighborhoodLibrary.getReserve_status())) {
				status3.setReserve_status("3"); // 3: 사물함 투입
				status3_update.setReserve_status("4"); // 4:대출
			}else if("5".equals(neighborhoodLibrary.getReserve_status())) {
				status3.setReserve_status("3"); // 3: 사물함 투입
				status3_update.setReserve_status("5"); // 5: 회수대기
			}else if("6".equals(neighborhoodLibrary.getReserve_status())) {
				status3.setReserve_status("5"); // 5: 회수대기
				status3_update.setReserve_status("6"); //6: 회수중
			}else if("7".equals(neighborhoodLibrary.getReserve_status())) {
				status3.setReserve_status("6"); // 6: 회수중
				status3_update.setReserve_status("7"); //7: 회수완료
			}
			
			status3.setReserve_idx(neighborhoodLibrary.getReserve_idx()); //예약 idx
			NeighborhoodLibrary sameReserveOne = getSameNeighborhoodLibraryBundle_idx(status3); //reserve_idx, reserve_status로 번들 idx 가져오기
			status3.setReserve_bundle_idx(sameReserveOne.getReserve_bundle_idx()); //번들 idx가 같으면 같은 건수 이므로 같은 번들 idx가 있는지 검색			
			List<NeighborhoodLibrary> sameList = dao.getSameNeighborhoodLibraryBundleList(status3);
			
			if(sameReserveOne != null) { // 
				if("7".equals(neighborhoodLibrary.getReserve_status())) {
					status3_update.setReserve_idx(neighborhoodLibrary.getReserve_idx());
				}else {
					if(sameList.size() == 1) {
						status3_update.setReserve_idx(neighborhoodLibrary.getReserve_idx());
					}else if(sameList.size() == 2 ) {
						status3_update.setReserve_bundle_idx(sameReserveOne.getReserve_bundle_idx());	
					}
				}
				result = dao.updateNeighborhoodLibrary(status3_update);
			}
			
			if(result > 0) {
				if("3".equals(neighborhoodLibrary.getReserve_status())) {
					NeighborhoodLibrary searchOne = new NeighborhoodLibrary();
					searchOne.setReserve_idx(neighborhoodLibrary.getReserve_idx());
					searchOne.setReserve_status(neighborhoodLibrary.getReserve_status());
					NeighborhoodLibrary reserveOne = dao.getSameNeighborhoodLibraryBundle_idx(searchOne); //해당 건 데이터 가져오기
					List<NeighborhoodLibrary> bundleList = dao.getSameNeighborhoodLibraryBundleList(reserveOne); //건당 데이터 다 가져오기 (1건에 한권 or 두권)
					Homepage homepage = new Homepage();
					
					Date nowDate = new Date();
					SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년MM월dd일");
					Calendar cal = Calendar.getInstance();
					cal.setTime(nowDate);
			        cal.add(Calendar.DATE, reserveOne.getTake_term()); 
			        LibrarySearch librarySearch = new LibrarySearch();
			        librarySearch.setUserkey(reserveOne.getUser_key());
			        String userIp = reserveOne.getAdd_ip();
			        
			        for(int i = 0; i < bundleList.size() ; i++) {
			        	homepage = homepageService.getHomepageOne(new Homepage(bundleList.get(i).getHomepage_id()));
				        librarySearch.setManageCode(bundleList.get(i).getManage_code());
				        String book_name = bundleList.get(i).getBook_name();
				        String mes = "";
				        String lockerIdx = String.valueOf(bundleList.get(i).getLocker_idx());
				        if(lockerIdx.length() == 1 ) {
				        	lockerIdx = "00" + lockerIdx;	
				        }else if(lockerIdx.length() == 2) {
				        	lockerIdx = "0" + lockerIdx;
				        }
				        if(i == 0 ) {
							mes = "http://library.daegu.go.kr/" + homepage.getContext_path() 
									+ "/module/nearLib/bacode.do?pass=" + bundleList.get(i).getDevice_password() + lockerIdx + bundleList.get(i).getDevice_idx() 
									+ "\n[" + bundleList.get(i).getLib_name() + "]\n" + bundleList.get(i).getMember_name() + "님 도서 비치가 완료되었습니다."
									+ "\n도서 정보 : " + book_name 
									+ "\n장비명 : " + bundleList.get(i).getDevice_name()
									+ "\n사물함 번호 : " + bundleList.get(i).getLocker_idx() 
									+ "\n사물함 비밀번호 : " + bundleList.get(i).getDevice_password();
				        }else{
				        	mes = "[" + bundleList.get(i).getLib_name() + "]\n" + bundleList.get(i).getMember_name() + "님 도서 비치가 완료되었습니다."
									+ "\n도서 정보 : " + book_name;
				        }
				        if(i == (bundleList.size()-1)) {
				        	mes = mes
				        			+ "\n" + simpleDateFormat.format(cal.getTime()) 
									+ " 까지 찾아가지 않을 시 해당 대출은 취소처리 되며, 페널티가 부과 되오니 유의 바랍니다. ";
				        }
						LibSearchAPI.sendSms(librarySearch, mes, userIp);	
						status3_update.setReserve_idx(bundleList.get(i).getReserve_idx());
						status3_update.setSms_send_yn("Y");
						dao.updateNeighborhoodLibrarySms(status3_update);
			        }
				}
				
				 if("7".equals(neighborhoodLibrary.getReserve_status())) {
					 	NeighborhoodLibrary searchOne = new NeighborhoodLibrary();
						searchOne.setReserve_idx(neighborhoodLibrary.getReserve_idx());
						searchOne.setReserve_status("7"); //예약 상태일때만 취소 가능하므로 상태가 1인 데이터 찾기
						searchOne.setPk(neighborhoodLibrary.getPk());
						NeighborhoodLibrary reserveOne = null;
						
						reserveOne = dao.getSameNeighborhoodLibraryBundle_idx(searchOne); //해당 건 데이터 가져오기
						NeighborhoodLibrary gsList = new NeighborhoodLibrary();
						gsList.setReserve_bundle_idx(reserveOne.getReserve_bundle_idx());
						List<NeighborhoodLibrary> sblList = dao.getSameNeighborhoodLibraryBundleList(gsList);
						
						for(int i = 0; i < sblList.size(); i++) {
						 	LibrarySearch librarySearch2 = new LibrarySearch();			
							librarySearch2.setUserkey(sblList.get(i).getUser_key());
							librarySearch2.setBookkey(sblList.get(i).getPk());
							
							NeighborhoodLibrary update8 = new NeighborhoodLibrary();
							update8.setReserve_idx(sblList.get(i).getReserve_idx());
							update8.setReserve_status("8");
							ApiResponse apiResult = null;
							try {
								/*예약취소 API 호출*/
								apiResult = LibSearchAPI.cancelResve(librarySearch2);
								if (apiResult.getStatus()) { //취소 API 성공					
									/*홈페이지DB 예약취소 */
									//result = dao.updateNeighborhoodLibrary(update8);
								} else { //api는 정상적이나 취소처리가 되지 않음
									res.setValid(false);
									res.setMessage("무인예약 취소 api 업데이트에 실패 하였습니다.");
									return res;
								}
							}catch (Exception e) {
								e.printStackTrace();
								res.setValid(false);
								res.setMessage("무인예약 취소 api 호출 실패, 업데이트에 실패 하였습니다.");
								return res;
							}
							
							LibrarySearch librarySearch = new LibrarySearch();
					        librarySearch.setManageCode(sblList.get(i).getManage_code());
					        librarySearch.setUserkey(sblList.get(i).getUser_key());
					        String userIp = "0:0:0:0:0:0:0:1";
					        String book_name = sblList.get(i).getBook_name();
					        String mes = "[" + sblList.get(i).getLib_name() + "]\n" + sblList.get(i).getMember_name() + "님 도서예약이 취소 되었습니다."
										+ "\n도서 정보 : "+book_name;
							
							LibSearchAPI.sendSms(librarySearch, mes, userIp);	 
							NeighborhoodLibrary sms_send = new NeighborhoodLibrary();
							sms_send.setSms_send_yn("Y");
							sms_send.setReserve_idx(sblList.get(i).getReserve_idx());
							dao.updateNeighborhoodLibrarySms(sms_send);	
							
						}
				 }
			}else {
				res.setValid(false);
				res.setMessage("업데이트에 실패 하였습니다.");
				return res;
			}
		}else if("8".equals(neighborhoodLibrary.getReserve_status())) { //8:취소
			NeighborhoodLibrary neighborhoodLibraryDelete = new NeighborhoodLibrary();
			neighborhoodLibraryDelete.setCancel_id(member.getMember_id());
			neighborhoodLibraryDelete.setCancel_ip(request.getRemoteAddr());
			neighborhoodLibraryDelete.setCancel_yn("Y");
			neighborhoodLibraryDelete.setReserve_status(neighborhoodLibrary.getReserve_status());
			neighborhoodLibraryDelete.setDevice_code(neighborhoodLibrary.getDevice_code());
			if("memberCancel".equals(neighborhoodLibrary.getEditMode())) {
				neighborhoodLibraryDelete.setCancel_reason(neighborhoodLibrary.getCancel_reason());
				neighborhoodLibraryDelete.setEditMode(neighborhoodLibrary.getEditMode());
				neighborhoodLibraryDelete.setPk(neighborhoodLibrary.getPk());
			}else {
				neighborhoodLibraryDelete.setCancel_id(member.getMember_id());
				neighborhoodLibraryDelete.setCancel_ip(request.getRemoteAddr());
				neighborhoodLibraryDelete.setCancel_yn("Y");
				neighborhoodLibraryDelete.setReserve_status(neighborhoodLibrary.getReserve_status());
				neighborhoodLibraryDelete.setReserve_idx(neighborhoodLibrary.getReserve_idx());
			}
			
			
			NeighborhoodLibrary searchOne = new NeighborhoodLibrary();
			searchOne.setReserve_idx(neighborhoodLibrary.getReserve_idx());
			searchOne.setReserve_status("1"); //예약 상태일때만 취소 가능하므로 상태가 1인 데이터 찾기
			searchOne.setPk(neighborhoodLibrary.getPk());
			NeighborhoodLibrary reserveOne = null;
			if("memberCancel".equals(neighborhoodLibrary.getEditMode())) { //회원이 직접 취소
				reserveOne = dao.getSameNeighborhoodLibraryPkData(searchOne); //해당 건 데이터 가져오기
			}else {
				reserveOne = dao.getSameNeighborhoodLibraryBundle_idx(searchOne); //해당 건 데이터 가져오기
			}

			LibrarySearch librarySearch2 = new LibrarySearch();			
			librarySearch2.setUserkey(reserveOne.getUser_key());
			librarySearch2.setBookkey(reserveOne.getPk());
			
			ApiResponse apiResult = null;
			try {
				/*예약취소 API 호출*/
				apiResult = LibSearchAPI.cancelResve(librarySearch2);
				if (apiResult.getStatus()) { //취소 API 성공					
					/*홈페이지DB 예약취소 */
						result = dao.updateNeighborhoodLibrary(neighborhoodLibraryDelete);
				} else { //api는 정상적이나 취소처리가 되지 않음
					res.setValid(false);
					res.setMessage("무인예약 취소 api 업데이트에 실패 하였습니다.");
					return res;
				}
			}catch (Exception e) {
				e.printStackTrace();
				res.setValid(false);
				res.setMessage("무인예약 취소 api 호출 실패, 업데이트에 실패 하였습니다.");
				return res;
			}
	        LibrarySearch librarySearch = new LibrarySearch();
	        librarySearch.setManageCode(reserveOne.getManage_code());
	        librarySearch.setUserkey(reserveOne.getUser_key());
	        String userIp = reserveOne.getAdd_ip();
	        String book_name = reserveOne.getBook_name();
	        String mes = "";
	        if(reserveOne.getCancel_reason() != null && "".equals(reserveOne.getCancel_reason())){
		        mes = "[" + reserveOne.getLib_name() + "]\n" + reserveOne.getMember_name() + "님 도서예약이 취소 되었습니다."
							+ "\n도서 정보 : "+book_name 
							+ "\n[취소사유]\n" + reserveOne.getCancel_reason();
			}else {
				mes = "[" + reserveOne.getLib_name() + "]\n" + reserveOne.getMember_name() + "님 도서예약이 취소 되었습니다."
						+ "\n도서 정보 : "+book_name;
			}
			LibSearchAPI.sendSms(librarySearch, mes, userIp);	 
			NeighborhoodLibrary sms_send = new NeighborhoodLibrary();
			sms_send.setSms_send_yn("Y");
			sms_send.setReserve_idx(neighborhoodLibrary.getReserve_idx());
			dao.updateNeighborhoodLibrarySms(sms_send);	
		}
		return res;
	}
	
	public NeighborhoodLibrary sameNeighborhoodLibraryForUser(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.sameNeighborhoodLibraryForUser(neighborhoodLibrary);
	}
	
	public NeighborhoodLibrary getSameNeighborhoodLibraryBundle_idx(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.getSameNeighborhoodLibraryBundle_idx(neighborhoodLibrary);
	}

	public Map<String, Object> updateNeighborhoodLibraryApi(NeighborhoodLibrary neighborhoodLibrary) {
		Map<String, Object> result = new HashMap<String, Object>();
		int success = 0;
		NeighborhoodLibrary searchSame = new NeighborhoodLibrary();
		String result_message = "";
		String result_error_mssage = "";		
		if(neighborhoodLibrary.getReserve_idx() == 0) {
			result.put("result", "fail");
			result.put("message", "reserve_idx 값이 없습니다.");
		}else if(neighborhoodLibrary.getReserve_status() == null || "".equals(neighborhoodLibrary.getReserve_status())) {
			result.put("result", "fail");
			result.put("message", "reserve_status 값이 없습니다.");
		}else if(neighborhoodLibrary.getDevice_code() == null || "".equals(neighborhoodLibrary.getDevice_code())) {
			result.put("result", "fail");
			result.put("message", "device_cod 값이 없습니다.");
		}else {
			if("3".equals(neighborhoodLibrary.getReserve_status())) { //api로 사물함 투입완료 값이 넘어오면
				searchSame.setReserve_status("2"); //2 :예약확정, 3 : 사물함투입
				result_message = "사물함투입 처리 되었습니다.";
				result_error_mssage = "[업데이트 실패]사물함투입 처리 실패.";
			}else if("4".equals(neighborhoodLibrary.getReserve_status())){
				searchSame.setReserve_status("3"); //3 :사물함 투입, 4 : 대출
				result_message = "대출 처리 되었습니다..";
				result_error_mssage = "[업데이트 실패]대출 처리 실패.";
			}else if("5".equals(neighborhoodLibrary.getReserve_status())){
				searchSame.setReserve_status("3"); //3 : 사물함 투입 (사물함 투입이 됐는데 기간내 가져가지 않으면 회수 대기로 바뀜) -> api로 처리할 데이터가 아닌 것 같으나 일단은 만들어 둠
				result_message = "회수대기 처리 되었습니다.";
				result_error_mssage = "[업데이트 실패]회수대기 처리 실패.";
			}
			else if("6".equals(neighborhoodLibrary.getReserve_status())){
				searchSame.setReserve_status("5"); //5 : 회수대기, 6 : 회수중
				result_message = "회수중으로 처리 되었습니다.";
				result_error_mssage = "[업데이트 실패]회수중으로 처리 실패.";
			}
			else if("7".equals(neighborhoodLibrary.getReserve_status())){
				searchSame.setReserve_status("6"); //6 : 회수중 , 7 : 회수완료
				result_message = "회수완료 처리 되었습니다.";
				result_error_mssage = "[업데이트 실패]회수완료 처리 실패.";
			}else {
				result.put("result", "fail");
				result.put("message", "reserve_status이 유효하지 않습니다. 업데이트가 불가능한 상태값 입니다.");
				return result;
			}
//			else if("8".equals(neighborhoodLibrary.getReserve_status())){ // api로 취소가 필요한 경우가 없어보이나 일단 만들어 둠
//				searchSame.setReserve_status("1"); //1 : 예약신청
//				result_message = "취소 처리 되었습니다.";
//			}
			
			//모든 값이 제대로 넘어 왔을때 상태값에따라 데이터 셋팅 후 공통으로 update해주는 코드
			searchSame.setReserve_idx(neighborhoodLibrary.getReserve_idx()); //예약idx
			NeighborhoodLibrary same_bundle_idx = getSameNeighborhoodLibraryBundle_idx(searchSame); // api로 넘어온 파라미터로 업데이트 할 예약 데이터 검색
			if(same_bundle_idx == null) { //현재 업데이트 할 데이터 select 결과가 없을때
				result.put("result", "fail");
				result.put("message", "요청한 상태값으로 업데이트 가능한 이전 상태값의 데이터가 존재하지 않습니다. 예약번호와 상태값을 확인해주세요.");
				return result;
			}else { //현재 업데이트 할 데이터 select 결과가 있을때
				NeighborhoodLibrary searchSameData = new NeighborhoodLibrary();
				searchSameData.setReserve_idx(neighborhoodLibrary.getReserve_idx());
				searchSameData.setReserve_status(searchSame.getReserve_status()); 
				searchSameData.setReserve_bundle_idx(same_bundle_idx.getReserve_bundle_idx());
				NeighborhoodLibrary sameReserveOne = sameNeighborhoodLibraryForUser(searchSameData); // 현재 업데이트 할 건 수에 포함된 다른 예약데이터가 있는지 검색(총 두개인지 하나인지)
				
				if(sameReserveOne == null) { //같은 예약건 없고 단일 업데이트 해야할때
					
					try {
						success = dao.updateNeighborhoodLibrary(neighborhoodLibrary); //예약idx로 상태값 업데이트
					}catch (Exception e) {
						e.printStackTrace();
					}
					if(success > 0) {
						NeighborhoodLibrary resultData = dao.getSameNeighborhoodLibraryBundle_idx(neighborhoodLibrary);
						Date nowDate = new Date();
						SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
						Calendar cal = Calendar.getInstance();
						cal.setTime(nowDate);
				        cal.add(Calendar.DATE, resultData.getTake_term());
						result.put("result", "success");
						result.put("success_Count", success);
						result.put("message", result_message);
						if("3".equals(neighborhoodLibrary.getReserve_status())){
							result.put("expire_date", simpleDateFormat.format(cal.getTime()));
						}
					}else {
						result.put("result", "fail");
						result.put("message", result_error_mssage);
					}
				}else { //같은 예약건이 존재하고 두개 한꺼번에 업데이트 해야할때
					NeighborhoodLibrary neighborhoodLibrary3 = new NeighborhoodLibrary();
					neighborhoodLibrary3.setReserve_bundle_idx(sameReserveOne.getReserve_bundle_idx());
					neighborhoodLibrary3.setReserve_status(neighborhoodLibrary.getReserve_status());
					neighborhoodLibrary3.setDevice_code(neighborhoodLibrary.getDevice_code());
					try {
						success = dao.updateNeighborhoodLibrary(neighborhoodLibrary3);
					}catch (Exception e) {
						e.printStackTrace();
					}
					/*사물함에 도서가 투입되고 만기가 되는 날짜*/
					NeighborhoodLibrary resultData = dao.getSameNeighborhoodLibraryBundle_idx(neighborhoodLibrary);
					Date nowDate = new Date();
					SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
					Calendar cal = Calendar.getInstance();
					cal.setTime(nowDate);
			        cal.add(Calendar.DATE, resultData.getTake_term());
					
			        if(success == 1) {
						result.put("result", "success");
						result.put("success_Count", success);
						result.put("message", "1건 : " + result_message + ", 1건 : [업데이트 실패]" );
						if("3".equals(neighborhoodLibrary.getReserve_status())) {
							result.put("expire_date", simpleDateFormat.format(cal.getTime()));
						}
					}else if(success == 2) {
						result.put("result", "success");
						result.put("success_Count", success);
						result.put("message", "2건 : " + result_message );
						result.put("expire_date", cal.getTime());
						if("3".equals(neighborhoodLibrary.getReserve_status())) {
							result.put("expire_date", simpleDateFormat.format(cal.getTime()));
						}
					}else {
						result.put("result", "fail");
						result.put("message", "2건 : [업데이트 실패]" );
					}
				}
				/*문자발송(사물함투입)*/
				if("3".equals(neighborhoodLibrary.getReserve_status())) {
					if(success > 0) {
						NeighborhoodLibrary status3_update = new NeighborhoodLibrary();
						NeighborhoodLibrary searchOne = new NeighborhoodLibrary();
						searchOne.setReserve_idx(neighborhoodLibrary.getReserve_idx());
						searchOne.setReserve_status(neighborhoodLibrary.getReserve_status());
						NeighborhoodLibrary reserveOne = dao.getSameNeighborhoodLibraryBundle_idx(searchOne); //해당 건 데이터 가져오기
						List<NeighborhoodLibrary> bundleList = dao.getSameNeighborhoodLibraryBundleList(reserveOne); //건당 데이터 다 가져오기 (1건에 한권 or 두권)
						Homepage homepage = new Homepage();
						
						Date nowDate = new Date();
						SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년MM월dd일");
						Calendar cal = Calendar.getInstance();
						cal.setTime(nowDate);
				        cal.add(Calendar.DATE, +reserveOne.getTake_term()); 
						
				        LibrarySearch librarySearch = new LibrarySearch();
				        librarySearch.setUserkey(reserveOne.getUser_key());
				        String userIp = reserveOne.getAdd_ip();
				        
				        for(int i = 0; i < bundleList.size() ; i++) {
				        	homepage = homepageService.getHomepageOne(new Homepage(bundleList.get(i).getHomepage_id()));
					        librarySearch.setManageCode(bundleList.get(i).getManage_code());
					        String book_name = bundleList.get(i).getBook_name();
					        String mes = "";
					        String lockerIdx = String.valueOf(bundleList.get(i).getLocker_idx());
					        if(lockerIdx.length() == 1 ) {
					        	lockerIdx = "00" + lockerIdx;	
					        }else if(lockerIdx.length() == 2) {
					        	lockerIdx = "0" + lockerIdx;
					        }
					        if(i == 0 ) {
								mes = "http://library.daegu.go.kr/" + homepage.getContext_path() + "/module/nearLib/bacode.do?pass=" + bundleList.get(i).getDevice_password() + lockerIdx + bundleList.get(i).getDevice_idx() 
										+ "\n[" + bundleList.get(i).getLib_name() + "]\n" + bundleList.get(i).getMember_name() + "님 도서 비치가 완료되었습니다."
										+ "\n도서 정보 : " + book_name 
										+ "\n장비명 : " + bundleList.get(i).getDevice_name()
										+ "\n사물함 번호 : " + bundleList.get(i).getLocker_idx() 
										+ "\n사물함 비밀번호 : " + bundleList.get(i).getDevice_password();
					        }else {
					        	mes = "\n[" + bundleList.get(i).getLib_name() + "]\n" + bundleList.get(i).getMember_name() + "님 도서 비치가 완료되었습니다."
										+ "\n도서 정보 : " + book_name; 
					        }
					        if(i == (bundleList.size() -1)) {
					        	mes = mes
					        			+ "\n" + simpleDateFormat.format(cal.getTime()) 
										+ " 까지 찾아가지 않을 시 해당 대출은 취소처리 되며, 페널티가 부과 되오니 유의 바랍니다.";
					        }
							LibSearchAPI.sendSms(librarySearch, mes, userIp);	
							status3_update.setReserve_idx(bundleList.get(i).getReserve_idx());
							status3_update.setSms_send_yn("Y");
							dao.updateNeighborhoodLibrarySms(status3_update);
				        }
					}
				}
				
				 if("7".equals(neighborhoodLibrary.getReserve_status())) {
					 	NeighborhoodLibrary searchOne = new NeighborhoodLibrary();
						searchOne.setReserve_idx(neighborhoodLibrary.getReserve_idx());
						searchOne.setReserve_status("7"); //예약 상태일때만 취소 가능하므로 상태가 1인 데이터 찾기
						searchOne.setPk(neighborhoodLibrary.getPk());
						NeighborhoodLibrary reserveOne = new NeighborhoodLibrary();
						
						reserveOne = dao.getSameNeighborhoodLibraryBundle_idx(searchOne); //해당 건 데이터 가져오기
						NeighborhoodLibrary gsList = new NeighborhoodLibrary();
						gsList.setReserve_bundle_idx(reserveOne.getReserve_bundle_idx());
						List<NeighborhoodLibrary> sblList = dao.getSameNeighborhoodLibraryBundleList(gsList);
						
						for(int i = 0; i < sblList.size(); i++) {
						 	LibrarySearch librarySearch2 = new LibrarySearch();			
							librarySearch2.setUserkey(sblList.get(i).getUser_key());
							librarySearch2.setBookkey(sblList.get(i).getPk());
							
							NeighborhoodLibrary update8 = new NeighborhoodLibrary();
							update8.setReserve_idx(sblList.get(i).getReserve_idx());
							update8.setReserve_status("8");
							ApiResponse apiResult = null;
							try {
								/*예약취소 API 호출*/
								apiResult = LibSearchAPI.cancelResve(librarySearch2);
								if (apiResult.getStatus()) { //취소 API 성공					
									/*홈페이지DB 예약취소 */
									//result = dao.updateNeighborhoodLibrary(update8);
								} else { //api는 정상적이나 취소처리가 되지 않음
									
								}
							}catch (Exception e) {
								result.put("result", "fail");
								result.put("message", "무인예약 취소 api 호출 실패, 업데이트에 실패 하였습니다." );
							}
							
							LibrarySearch librarySearch = new LibrarySearch();
					        librarySearch.setManageCode(sblList.get(i).getManage_code());
					        librarySearch.setUserkey(sblList.get(i).getUser_key());
					        String userIp = "0:0:0:0:0:0:0:1";
					        String book_name = sblList.get(i).getBook_name();
					        String mes = "[" + sblList.get(i).getLib_name() + "]\n" + sblList.get(i).getMember_name() + "님 도서예약이 취소 되었습니다."
										+ "\n도서 정보 : "+book_name;
							
							LibSearchAPI.sendSms(librarySearch, mes, userIp);	 
							NeighborhoodLibrary sms_send = new NeighborhoodLibrary();
							sms_send.setSms_send_yn("Y");
							sms_send.setReserve_idx(sblList.get(i).getReserve_idx());
							dao.updateNeighborhoodLibrarySms(sms_send);	
							
						}
				 }
				/*api예약취소 문자발송*/
//				else if("8".equals(neighborhoodLibrary.getReserve_status())) {
//					if(success > 0) {
//						NeighborhoodLibrary searchOne = new NeighborhoodLibrary();
//						searchOne.setReserve_idx(neighborhoodLibrary.getReserve_idx());
//						searchOne.setReserve_status(neighborhoodLibrary.getReserve_status());
//						NeighborhoodLibrary reserveOne = dao.getSameNeighborhoodLibraryBundle_idx(searchOne); 
//						Homepage homepage = homepageService.getHomepageOne(new Homepage(reserveOne.getHomepage_id()));
//						
//				        LibrarySearch librarySearch = new LibrarySearch();
//				        librarySearch.setManageCode(reserveOne.getManage_code());
//				        librarySearch.setUserkey(reserveOne.getUser_key());
//				        String userIp = reserveOne.getAdd_ip();
//				        String book_name = reserveOne.getBook_name();
//						String mes = "[" + reserveOne.getLib_name() + "]\n" + reserveOne.getMember_name() + "님 도서예약이 취소 되었습니다."
//									+ "\n도서 정보 : "+book_name 
//									+ "\n[취소사유]\n" + reserveOne.getCancel_reason(); 
//						LibSearchAPI.sendSms(librarySearch, mes, userIp);	 
//						NeighborhoodLibrary sms_send = new NeighborhoodLibrary();
//						sms_send.setSms_send_yn("Y");
//						sms_send.setReserve_idx(neighborhoodLibrary.getReserve_idx());
//						dao.updateNeighborhoodLibrarySms(sms_send);
//					}
//				}
			}
		}
		return result;
	}

	public NeighborhoodLibrary getNeighborhoodLibraryBookOne(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.getNeighborhoodLibraryBookOne(neighborhoodLibrary);
	}

	public int getSameNeighborhoodLibraryReserveCallIdx(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.getSameNeighborhoodLibraryReserveCallIdx(neighborhoodLibrary);
	}

	public int updateNeighborhoodLibraryPK(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.updateNeighborhoodLibraryPK(neighborhoodLibrary);
	}

	public NeighborhoodLibrary getSameNeighborhoodLibraryPkData(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.getSameNeighborhoodLibraryPkData(neighborhoodLibrary);
	}

	public int updateNeighborhoodLibrarySms(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.updateNeighborhoodLibrarySms(neighborhoodLibrary);
		
	}

	public int updateNeighborhoodLibrary(NeighborhoodLibrary neighborhoodLibrary) {
		return dao.updateNeighborhoodLibrary(neighborhoodLibrary);
	}

	public Map<String, Object> checkReserveLocker(NeighborhoodLibrary neighborhoodLibrary) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		
		
		if(neighborhoodLibrary.getLocker_idx() == 0) {
			result.put("result", "fail");
			result.put("message", "사물함번호 번호 오류");			
		}
		if(String.valueOf(neighborhoodLibrary.getDevice_password()).length() != 4) {
			result.put("result", "fail");
			result.put("message", "비밀번호가 일치하지 않습니다.");
		}
		
		List<NeighborhoodLibrary> resultReserve = dao.checkReserveLocker(neighborhoodLibrary);
		
		if(resultReserve != null) {
			if(resultReserve.size() > 0) {
				NeighborhoodLibrary searchBundleList = new NeighborhoodLibrary();
				searchBundleList.setReserve_bundle_idx(resultReserve.get(0).getReserve_bundle_idx());
				List<NeighborhoodLibrary> bundleList = dao.getSameNeighborhoodLibraryBundleList(searchBundleList);
			
				if(bundleList.size() == 1) {
					resultMap.put("user_no", bundleList.get(0).getUser_no());
					resultMap.put("member_id", bundleList.get(0).getMember_id());
					resultMap.put("device_idx", bundleList.get(0).getDevice_idx());
					resultMap.put("locker_idx", bundleList.get(0).getLocker_idx());
					resultMap.put("locker_password", bundleList.get(0).getDevice_password());
					
					Map<String,Object> resultMapList = new HashMap<String,Object>();
					resultMapList.put("pk", bundleList.get(0).getPk());
					resultMapList.put("lib_name", bundleList.get(0).getLib_name());
					resultMapList.put("manage_code", bundleList.get(0).getManage_code());
					resultMapList.put("book_name", bundleList.get(0).getBook_name());
					resultMapList.put("book_key", bundleList.get(0).getBook_key());
					resultMapList.put("reg_no", bundleList.get(0).getReg_no());
					resultList.add(0, resultMapList);
					resultMap.put("result-list", resultList);
					result.put("result", "success");
					result.put("result-data", resultMap);
				}else if(bundleList.size() == 2) {
					resultMap.put("user_no", bundleList.get(0).getUser_no());
					resultMap.put("member_id", bundleList.get(0).getMember_id());
					resultMap.put("device_idx", bundleList.get(0).getDevice_idx());
					resultMap.put("locker_idx", bundleList.get(0).getLocker_idx());
					resultMap.put("locker_password", bundleList.get(0).getDevice_password());
					for(int i = 0 ; i < 2; i++) {
						Map<String,Object> resultMapList = new HashMap<String,Object>();
						resultMapList.put("pk", bundleList.get(i).getPk());
						resultMapList.put("lib_name", bundleList.get(i).getLib_name());
						resultMapList.put("manage_code", bundleList.get(i).getManage_code());
						resultMapList.put("book_name", bundleList.get(i).getBook_name());
						resultMapList.put("book_key", bundleList.get(i).getBook_key());
						resultMapList.put("reg_no", bundleList.get(i).getReg_no());
						resultList.add(i, resultMapList);
					}
					resultMap.put("result-list", resultList);
					result.put("result", "success");
					result.put("result-data", resultMap);
				}
			}else {
				result.put("result", "fail");
				result.put("message", "일치하는 데이터가 없습니다.");
			}
		}else {
			result.put("result", "fail");
			result.put("message", "일치하는 데이터가 없습니다.");
		}
		return result;
	}

}
