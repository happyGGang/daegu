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

	public boolean checkBlackList(BlackList blackList, String black_type, String teachCode) {
		BlackList one = dao.checkBlackList(blackList);

		// 블랙리스트에 존재하지 않음
		if (one == null) {
			return false;
		}
		// 대분류 확인
		String teachCodes = one.getTeach_code();

		// 블랙리스트 타입
		String[] list = one.getBlack_type().split(",");

		boolean isBlack = false;

		// 차단 타입 체크
		for ( String oneType : list ) {
			if ( black_type.equals(oneType) ) {
				isBlack = true;
			}
		}
		// 기존에 있던 블랙리스트는 teachCode가 null 이므로 전체 차단으로 판단 (기존 블랙리스트 기능은 무조건 전체 차단이였기 때문에)
		if (teachCodes == null) {
			return isBlack;
		}

		String[] teachCodeList = teachCodes.split(",");
		// 블랙을 당한 대분류 카테고리 체크
		if (isBlack) {
			for ( String code : teachCodeList) {
				if (teachCode.equals(code)) {
					return isBlack;
				}
			}
			return false;
		}
		return isBlack;

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
