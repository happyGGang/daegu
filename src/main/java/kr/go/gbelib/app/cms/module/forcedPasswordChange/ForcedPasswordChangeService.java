package kr.go.gbelib.app.cms.module.forcedPasswordChange;

import java.util.List;
import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ForcedPasswordChangeService extends BaseService{

	@Autowired
	private ForcePasswordChangeDao dao;

	public int addForcedPasswordChangeUser(ForcedPasswordChange forcedPasswordChange) {
		return dao.addForcedPasswordChangeUser(forcedPasswordChange);
	}

	public List<ForcedPasswordChange> getForcedPasswordChangeList(ForcedPasswordChange forcedPasswordChange) {
		return dao.getForcedPasswordChangeList(forcedPasswordChange);
	}

	public int getForcedPasswordChangeListCount(ForcedPasswordChange forcedPasswordChange) {
		return dao.getForcedPasswordChangeListCount(forcedPasswordChange);
	}

	public ForcedPasswordChange getForcedPasswordChangeOne(ForcedPasswordChange forcedPasswordChange) {
		return dao.getForcedPasswordChangeOne(forcedPasswordChange);
	}

	public void modifyForcedPasswordChangeUser(ForcedPasswordChange forcedPasswordChange) {
		dao.modifyForcedPasswordChangeUser(forcedPasswordChange);
	}

	public void deleteForcedPasswordChangeUser(ForcedPasswordChange forcedPasswordChange) {
		dao.deleteForcedPasswordChangeUser(forcedPasswordChange);
	}

	public int getForcedPasswordOneUser(String getForcedUserId) {
		return dao.getForcedPasswordOneUser(getForcedUserId);
	}

	public void updateForcedPasswordUserStatus(String memberId) {
		dao.updateForcedPasswordUserStatus(memberId);
	}
}
