package kr.go.gbelib.app.cms.module.forcedPasswordChange;

import java.util.List;

public interface ForcePasswordChangeDao {


	int addForcedPasswordChangeUser(ForcedPasswordChange forcedPasswordChange);

	List<ForcedPasswordChange> getForcedPasswordChangeList(ForcedPasswordChange forcedPasswordChange);

	int getForcedPasswordChangeListCount(ForcedPasswordChange forcedPasswordChange);

	ForcedPasswordChange getForcedPasswordChangeOne(ForcedPasswordChange forcedPasswordChange);

	void modifyForcedPasswordChangeUser(ForcedPasswordChange forcedPasswordChange);

	void deleteForcedPasswordChangeUser(ForcedPasswordChange forcedPasswordChange);

	int getForcedPasswordOneUser(String getForcedUserId);

	void updateForcedPasswordUserStatus(String memberId);
}
