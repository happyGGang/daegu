package kr.go.gbelib.app.cms.module.blackList;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BlackListService extends BaseService{

	@Autowired
	private BlackListDao dao;

	public List<BlackList> getBlackListList(BlackList blackList) {
		return dao.getBlackListList(blackList);
	}

	public BlackList getBlackListOne(BlackList blackList) {
		return dao.getBlackListOne(blackList);
	}

	public boolean checkBlackList(BlackList blackList, String black_type) {
		BlackList one = dao.checkBlackList(blackList);
		if ( one != null ) {
			String[] list = one.getBlack_type().split(",");
			for ( String oneType : list ) {
				if ( black_type.equals(oneType) ) {
					return true;
				}
			}
		}
		return false;
	}

	public int checkSaveBlackList(BlackList blackList) {
		return dao.checkSaveBlackList(blackList);
	}

	public int addBlackList(BlackList blackList) {
		return dao.addBlackList(blackList);
	}

	public int modifyBlackList(BlackList blackList) {
		return dao.modifyBlackList(blackList);
	}

	public int deleteBlackList(BlackList blackList) {
		return dao.deleteBlackList(blackList);
	}

	public void blackTypeDelete(BlackList blackList) {
		String deleteBlackType = blackList.getBlack_type();

		BlackList target = dao.getBlackListOne(blackList);

		String[] typeList = target.getBlack_type().split(",");

		List<String> newBlackTypeList = new ArrayList<String>();
		// 기존 블랙리스트 타입 무엇을 가지고있는지 확인후 삭제해야 될 타입만 삭제한다.
		for ( String oneType : typeList ) {
			if ( !deleteBlackType.equals(oneType) ) {
				newBlackTypeList.add(oneType);
			}
		}

		// 새로 설정된 블랙리스트 타입이 1개 이상일때 수정을 한다.
		if ( newBlackTypeList.size() > 0 ) {
			target.setBlack_type(StringUtils.join(newBlackTypeList, ","));
			dao.modifyBlackList(target);
		}// 새로 설정된 블랙리스트 타입이 없다면 존재할 필요가 없으므로 해당 아이디는 삭제 한다.
		else {
			dao.deleteBlackList(target);
		}
	}

	/**
	 * @author YONGJU 2018. 7. 17.
	 * @param blackList
	 * @return
	 */
	public int getBlackListCount(BlackList blackList) {
		return dao.getBlackListCount(blackList);
	}
}
