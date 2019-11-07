package kr.go.gbelib.app.cms.module.push;

import java.util.List;

public interface PushDao {
	
	public List<Push> getPushList(Push push);
	
	public int getPushListCount(Push push);
	
	public Push getPushOne(Push push);
	
	public int addPush(Push push);
	
	public int modifyPush(Push push);
	
	public int deletePushFile(Push push);
}
