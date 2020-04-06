/**
 *
 */
package kr.go.gbelib.app.cms.module.facilityStudy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;

/**
 * @author whaleesoft YONGJU 2020. 2. 17.
 *
 */
@Service
public class FacilityStudyService extends BaseService{

	@Autowired
	private FacilityStudyDao dao;

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 * @return
	 */
	public int getFacilityStudyCount(FacilityStudy facilityStudy) {
		if (StringUtils.isNotEmpty(facilityStudy.getApply_password()) && facilityStudy.getApply_password().length() != 88) {
			facilityStudy.setApply_password(CalculateHashUtils.calculateHash(facilityStudy.getApply_password()));
		}
		return dao.getFacilityStudyCount(facilityStudy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 * @return
	 */
	public List<FacilityStudy> getFacilityStudyList(FacilityStudy facilityStudy) {
		if (StringUtils.isNotEmpty(facilityStudy.getApply_password()) && facilityStudy.getApply_password().length() != 88) {
			facilityStudy.setApply_password(CalculateHashUtils.calculateHash(facilityStudy.getApply_password()));
		}
		return dao.getFacilityStudyList(facilityStudy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 * @return
	 */
	public FacilityStudy getFacilityStudyOne(FacilityStudy facilityStudy) {
		if (StringUtils.isNotEmpty(facilityStudy.getApply_password()) && facilityStudy.getApply_password().length() != 88) {
			facilityStudy.setApply_password(CalculateHashUtils.calculateHash(facilityStudy.getApply_password()));
		}
		return dao.getFacilityStudyOne(facilityStudy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 */
	public int deleteFacilityStudy(FacilityStudy facilityStudy) {
		return dao.deleteFacilityStudy(facilityStudy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 */
	public int approveFacilityStudy(FacilityStudy facilityStudy) {
		return dao.approveFacilityStudy(facilityStudy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 */
	public int cancelFacilityStudy(FacilityStudy facilityStudy) {
		if(facilityStudy.getApply_status().equals("2")) {
			facilityStudy.setCancel_reason("이용자 취소");
		} else if(facilityStudy.getApply_status().equals("3")) {
			facilityStudy.setCancel_reason("관리자 취소");
		}
		
		return dao.cancelFacilityStudy(facilityStudy);
	}
	
	public int cancelTxtFacilityStudy(FacilityStudy facilityStudy) {
		return dao.cancelTxtFacilityStudy(facilityStudy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param fs
	 */
	public int addFacilityStudy(FacilityStudy fs) {
		fs.setApply_password(CalculateHashUtils.calculateHash(fs.getApply_password()));
		return dao.addFacilityStudy(fs);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param fs
	 */
	public int cancelUserFacilityStudy(FacilityStudy fs) {
		if (StringUtils.isNotEmpty(fs.getApply_password()) && fs.getApply_password().length() != 88) {
			fs.setApply_password(CalculateHashUtils.calculateHash(fs.getApply_password()));
		}
		return dao.cancelUserFacilityStudy(fs);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 * @return
	 */
	public Map<String, String> getApplicableList(FacilityStudy facilityStudy) {
		List<FacilityStudy> list = dao.getFacilityStudyDailyList(facilityStudy);
		Map<String, String> m = new HashMap<String, String>();
		for (FacilityStudy fs : list) {
			m.put("num"+fs.getStudy_num()+fs.getStudy_time(), fs.getApply_status());
		}
		return m;
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 18.
	 * @param facilityStudy
	 */
	public int readyFacilityStudy(FacilityStudy facilityStudy) {
		return dao.readyFacilityStudy(facilityStudy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 18.
	 * @param facilityStudy
	 */
	public int modifyFacilityStudy(FacilityStudy facilityStudy) {
		return dao.modifyFacilityStudy(facilityStudy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 18.
	 * @param facilityStudy
	 */
	public boolean isAlready(FacilityStudy facilityStudy) {
		return dao.isAlready(facilityStudy) > 0 ? true : false;
	}

}
