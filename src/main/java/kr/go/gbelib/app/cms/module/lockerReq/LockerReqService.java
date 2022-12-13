package kr.go.gbelib.app.cms.module.lockerReq;

import java.util.List;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.locker.Locker;
import kr.go.gbelib.app.cms.module.locker.LockerDao;
import kr.go.gbelib.app.common.api.MemberAPI;

@Service
public class LockerReqService extends BaseService {

	@Autowired
	private LockerDao lockerDao;

	@Autowired
	private LockerReqDao Dao;

	public List<LockerReq> getLockerReq(LockerReq lockerReq) {
		List<LockerReq> list = Dao.getLockerReq(lockerReq);
		for ( LockerReq lockerReq2 : list ) {
			Member member = new Member();
			member.setUser_id(lockerReq2.getAdd_id());
//			member.setCheck_certify_type("SEQNO");
//			member.setCheck_certify_data(lockerReq2.getMember_key());
			try {
//				Map<String, String> apiResult = MemberAPI.getMemberCertify("WEB", member);
//				String web_id = apiResult.get("WEB_ID");
//				if (StringUtils.isNotEmpty(web_id)) {
//					lockerReq2.setWeb_id(web_id);
//				}
			}
			catch ( Exception e ) {
				// TODO: handle exception
			}
		}
		return list;
	}

	public List<LockerReq> getLockerUnassignReq(LockerReq lockerReq) {
		return Dao.getLockerUnassignReq(lockerReq);
	}

	public List<LockerReq> getLockerReqListAll(LockerReq lockerReq) {
		return Dao.getLockerReqListAll(lockerReq);
	}

	public int getLockerReqCount(LockerReq lockerReq) {
		return Dao.getLockerReqCount(lockerReq);
	}

	public int getBlackListCheck(LockerReq lockerReq) {
		return Dao.getBlackListCheck(lockerReq);
	}

	public int getLockerApplyCheck(LockerReq lockerReq) {
		return Dao.getLockerApplyCheck(lockerReq);
	}

	public LockerReq getLockerReqOne(LockerReq lockerReq) {
		return Dao.getLockerReqOne(lockerReq);
	}

	@Transactional
	public int addLockerReq(LockerReq lockerReq, String addType) {
		if (addType.equals("HOMEPAGE") && "SELECT".equals(lockerReq.getLocker_pre_type()) ) {
			lockerDao.updateLockerStatus(new Locker(lockerReq.getHomepage_id(), lockerReq.getLocker_pre_idx(), lockerReq.getLocker_idx(), "2"));
		} else if(addType.equals("PRIVATEHOMEPAGE") && "SELECT".equals(lockerReq.getLocker_pre_type())) {
			lockerDao.updateLockerStatus(new Locker(lockerReq.getHomepage_id(), lockerReq.getLocker_pre_idx(), lockerReq.getLocker_idx(), "2"));
		}

		return Dao.addLockerReq(lockerReq);
	}

	public int modifyLocekrReq(LockerReq lockerReq) {
		return Dao.modifyLocekrReq(lockerReq);
	}

	public int assingLocker(LockerReq lockerReq) {
		return Dao.assingLocker(lockerReq);
	}

	public int unassingLocker(LockerReq lockerReq) {
		return Dao.unassingLocker(lockerReq);
	}

	public int modifyLocekr(LockerReq lockerReq) {
		return Dao.modifyLocekr(lockerReq);
	}

	public int clearLocker(LockerReq lockerReq) {
		return Dao.clearLocker(lockerReq);
	}

	public int clearLockerReq(LockerReq lockerReq) {
		return Dao.clearLockerReq(lockerReq);
	}

	public int deleteReqLocker(LockerReq lockerReq) {
		LockerReq targetLockerReq = Dao.getLockerReqOne(lockerReq);
		if ( targetLockerReq.getLocker_idx() > 0 ) {
			lockerDao.updateLockerStatus(new Locker(targetLockerReq.getHomepage_id(), targetLockerReq.getLocker_pre_idx(), targetLockerReq.getLocker_idx(), "1"));
		}
		return Dao.deleteReqLocker(lockerReq);
	}

	public List<LockerReq> getHistoryOfLockerReq(LockerReq lockerReq) {
		return Dao.getHistoryOfLockerReq(lockerReq);
	}
}
