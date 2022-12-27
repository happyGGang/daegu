package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibLocker;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.NeighborhoodLibraryDao;

/**
 * @author ttkaz
 * 2022. 10. 12.
 *
 */
@Service
public class NearbyLibLockerService extends BaseService {
	
	@Autowired
	private NearbyLibLockerDao dao;
	
	@Transactional
	public int addNeighborhoodLibraryLocker(NearbyLibLocker neighborhoodLibraryLocker) {
			int result = 0;
			if(dao.addNeighborhoodLibraryLocker(neighborhoodLibraryLocker) > 0) {
				NearbyLibLocker thisLocker = dao.getNeighborhoodLibraryLockerOne(neighborhoodLibraryLocker); 
				int locker_each_idx = 1;
				neighborhoodLibraryLocker.setLocker_each_idx(locker_each_idx);
				for(int i = 0; i < thisLocker.getTotal_count(); i++) {
					if(dao.addNeighborhoodLibraryLockerEach(neighborhoodLibraryLocker) > 0) {
						locker_each_idx = locker_each_idx + 1;
						neighborhoodLibraryLocker.setLocker_each_idx(locker_each_idx);
						result = result + 1;
					}
					
				}
				if(result == thisLocker.getTotal_count()) {
					result = 1;
				}
//				String machine_yn = thisLocker.getReturn_machine_yn(); //반납기가 들어가는지 여부
//				int monitorPosition = thisLocker.getMonitor_position(); //모니터 위치(반납기 열과 동일 : 반납기 대신 들어갈 사물함 위치를 알기 위해 사용)
//				neighborhoodLibraryLocker.setCol_num(1);
//				neighborhoodLibraryLocker.setRow_num(1);		
//				neighborhoodLibraryLocker.setLocker_each_idx(1);
//				
//				for(int i = 0; i < thisLocker.getCol_no(); i++) {					
//					
//					if((i+1) == monitorPosition) { //현재 열이 모니터(반납기) 위치와 같을때
//						if("N".equals(machine_yn) && thisLocker.getAdd_row_no() > 0) { //반납기 대신 사물함이 들어갈때 && 들어간 사물함 갯수
//							if(monitorPosition == 1) {
//								neighborhoodLibraryLocker.setRow_num(thisLocker.getRow_no() - thisLocker.getAdd_row_no() + 1); //반납기가 첫번째 열에 있을 시 행 시작위치
//							}
//							for(int j = 0; j < thisLocker.getAdd_row_no(); j++) {																		
//								dao.addNeighborhoodLibraryLockerEach(neighborhoodLibraryLocker);
//								neighborhoodLibraryLocker.setLocker_each_idx(neighborhoodLibraryLocker.getLocker_each_idx() + 1);
//								neighborhoodLibraryLocker.setRow_num(neighborhoodLibraryLocker.getRow_num() + 1); //하나의 사물함을 insert 하면 행을 하나 내린다
//							}
//						}
//					}else {
//						for(int j = 0; j < thisLocker.getRow_no(); j++) {											
//							dao.addNeighborhoodLibraryLockerEach(neighborhoodLibraryLocker);
//							neighborhoodLibraryLocker.setLocker_each_idx(neighborhoodLibraryLocker.getLocker_each_idx() + 1);
//							neighborhoodLibraryLocker.setRow_num(neighborhoodLibraryLocker.getRow_num() + 1); //하나의 사물함을 insert 하면 행을 하나 내린다
//						}
//					}
//					
//					//다음 열의 행 셋팅
//					if((i+1) == (monitorPosition -1)) { //현재 열의 다음 열이 모니터(반납기) 위치와 같을때 행 시작 위치
//						if("N".equals(machine_yn) && thisLocker.getAdd_row_no() > 0) {
//							neighborhoodLibraryLocker.setRow_num(thisLocker.getRow_no() - thisLocker.getAdd_row_no() + 1); //반납기 대신 사물함 들어갈때 사물함 행 시작 위치
//						}
//					}else {
//						neighborhoodLibraryLocker.setRow_num(1);
//					}
//					//다음 열 셋팅
//					neighborhoodLibraryLocker.setCol_num(neighborhoodLibraryLocker.getCol_num() + 1);
//					
//				}										
			}
			return result;		
	}

	public NearbyLibLocker getNeighborhoodLibraryLockerOne(NearbyLibLocker neighborhoodLibraryLocker) {
		return dao.getNeighborhoodLibraryLockerOne(neighborhoodLibraryLocker);
	}

	public int getNeighborhoodLibraryLockerCount(NearbyLibLocker neighborhoodLibraryLocker) {
		return dao.getNeighborhoodLibraryLockerCount(neighborhoodLibraryLocker);
	}

	public List<NearbyLibLocker> getNeighborhoodLibraryLockerEachOneList(NearbyLibLocker neighborhoodLibraryLocker) {
		return dao.getNeighborhoodLibraryLockerEachOneList(neighborhoodLibraryLocker);
	}

	public int modifyNeighborhoodLibraryLocker(NearbyLibLocker neighborhoodLibraryLocker) {
		return dao.modifyNeighborhoodLibraryLocker(neighborhoodLibraryLocker);
		
	}

	public int getNeighborhoodLibraryLockerEachOneListCount(NearbyLibLocker neighborhoodLibraryLocker) {
		return dao.getNeighborhoodLibraryLockerEachOneListCount(neighborhoodLibraryLocker);
	}

}
