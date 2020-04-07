/**
 *
 */
package kr.go.gbelib.app.cms.module.facilityStudy;

import java.util.List;

/**
 * @author whaleesoft YONGJU 2020. 2. 17.
 *
 */
public interface FacilityStudyDao {

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 * @return
	 */
	public int getFacilityStudyCount(FacilityStudy facilityStudy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 * @return
	 */
	public List<FacilityStudy> getFacilityStudyList(FacilityStudy facilityStudy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 * @return
	 */
	public FacilityStudy getFacilityStudyOne(FacilityStudy facilityStudy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 * @return
	 */
	public int deleteFacilityStudy(FacilityStudy facilityStudy);
	
	public int deleteFacilityStudyALL(FacilityStudy facilityStudy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 * @return
	 */
	public int approveFacilityStudy(FacilityStudy facilityStudy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 * @return
	 */
	public int cancelFacilityStudy(FacilityStudy facilityStudy);
	
	public int cancelTxtFacilityStudy(FacilityStudy facilityStudy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param fs
	 * @return
	 */
	public int addFacilityStudy(FacilityStudy fs);

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param fs
	 * @return
	 */
	public int cancelUserFacilityStudy(FacilityStudy fs);

	/**
	 * @author whalesoft YONGJU 2020. 2. 17.
	 * @param facilityStudy
	 * @return
	 */
	public List<FacilityStudy> getFacilityStudyDailyList(FacilityStudy facilityStudy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 18.
	 * @param facilityStudy
	 * @return
	 */
	public int readyFacilityStudy(FacilityStudy facilityStudy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 18.
	 * @param facilityStudy
	 * @return
	 */
	public int modifyFacilityStudy(FacilityStudy facilityStudy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 18.
	 * @param facilityStudy
	 * @return
	 */
	public int isAlready(FacilityStudy facilityStudy);
	
	public List<FacilityStudy> getFacilityStudyAll(FacilityStudy facilityStudy);

}
