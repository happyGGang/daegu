package kr.go.gbelib.app.cms.module.elib.lending;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import kr.go.gbelib.app.cms.module.elib.api.ElibException;

public class LendingAutoReturnService {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private LendingDao dao;

	@Autowired
	private LendingService service;

	/**
	 * 자동 반납
	 * dispatcherServlet.xml 에서 on, off 설정
	 */
	public void autoReturn() {
		// WAS2_HOMEPAGE2 컨테이너에서만 실행
		if(StringUtils.equals(System.getProperty("whalesoft.container"), "WAS2_HOMEPAGE2")) {
        	logger.info("### autoReturn starts ###");
        	System.out.println("### autoReturn starts ###");
        
        	List<Lending> lendingList = dao.getBooksToAutoReturn();
        
        	if(lendingList == null) return;
        
        	if(!StringUtils.equals(System.getProperty("spring.profiles.active"), "localServer")) {
        		for(Lending lending: lendingList) {
        			try {
        				service.autoReturnProc(lending);
        			} catch (ElibException e) {
        				System.out.println("### autoReturn API 호출 에러(lend_idx: " + lending.getLend_idx() + "): " + e.getMessage());
        				try { service.autoReturnProcNoApi(lending); } catch (Exception e1) {}
        			} catch (Exception e) {
        				System.out.println("### autoReturn 기타 에러");
        				try { service.autoReturnProcNoApi(lending); } catch (Exception e1) {}
        				e.printStackTrace();
        			}
        		}
        	}
        
        	List<Lending> reserveList = dao.getReservesLendable();
        
        	if(reserveList != null && !StringUtils.equals(System.getProperty("spring.profiles.active"), "localServer")) {
        		for(Lending reserve: reserveList) {
        			try {
        				service.autoReserveToLendProc(reserve);
        			} catch (ElibException e) {
        				System.out.println("### autoReturn API 호출 에러(lend_idx: " + reserve.getReserve_idx() + "): " + e.getMessage());
        				try { service.autoReserveToLendProcNoApi(reserve); } catch (Exception e1) {}
        			} catch (Exception e) {
        				System.out.println("### autoReturn 기타 에러");
        				try { service.autoReserveToLendProcNoApi(reserve); } catch (Exception e1) {}
        				e.printStackTrace();
        			}
        		}
        	}
        
        	autoUpdateLendableDt();
        
        	logger.info("### autoReturn ends ###");
        	System.out.println("### autoReturn ends ###");
		}
	}

	public void autoUpdateLendableDt() {
		logger.info("### autoUpdateLendableDt starts ###");
		System.out.println("### autoUpdateLendableDt starts ###");

		List<Lending> reserveList = dao.getBookstoAutoUpdateLendableDt();

		System.out.println("@@@@@@@@@@ autoUpdateLendableDt reserveList: " + reserveList);

		if(reserveList == null) return;

		for(Lending reserve: reserveList) {
			try {
				service.updateDateAndCnt(reserve);
			} catch (Exception e) {
				System.out.println("### autoUpdateLendableDt 기타 에러");
				e.printStackTrace();
			}
		}

		logger.info("### autoUpdateLendableDt ends ###");
		System.out.println("### autoUpdateLendableDt ends ###");
	}

}
