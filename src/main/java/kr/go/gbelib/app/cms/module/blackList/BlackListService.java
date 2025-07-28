package kr.go.gbelib.app.cms.module.blackList;

import java.util.ArrayList;
import java.util.List;

import kr.go.gbelib.app.cms.module.blackListDetail.BlackListDetail;
import kr.go.gbelib.app.cms.module.blackListDetail.BlackListDetailService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BlackListService extends BaseService{

	@Autowired
	private BlackListDao dao;

	@Autowired
	private BlackListDetailService blackListDetailService;

	public List<BlackList> getBlackListList(BlackList blackList) {
		return dao.getBlackListList(blackList);
	}

	public BlackList getBlackListOne(BlackList blackList) {
		return dao.getBlackListOne(blackList);
	}

	public boolean checkBlackList(BlackList blackList, String black_type, int teachCode, int group_idx, int category_idx) {
		BlackList one = dao.checkBlackList(blackList);
		System.out.println("@@@@@@@ teachCode " + teachCode);
		System.out.println("@@@@@@@ group_idx " + group_idx);
		System.out.println("@@@@@@@ category_idx " + category_idx);

		System.out.println("@@@@@@ one = " + (one == null) );
		// 블랙리스트에 존재하지 않음
		if (one == null) {
			return false;
		}
		// 블랙리스트 타입
		String[] list = one.getBlack_type().split(",");
		boolean isBlack = false;
		// 차단 타입 체크
		for ( String oneType : list ) {
			if ( black_type.equals(oneType) ) {
				isBlack = true;
			}
		}
		if (isBlack) {
			BlackListDetail blackListDetail = new BlackListDetail();
			blackListDetail.setBlack_idx(one.getBlack_idx());
			blackListDetail.setBlack_type(one.getBlack_type());
			blackListDetail.setHomepage_id(one.getHomepage_id());
			blackListDetail.setTeach_code(teachCode);
			blackListDetail.setGroup_idx(group_idx);
			blackListDetail.setCategory_idx(category_idx);
			BlackListDetail detail = blackListDetailService.checkBlackListCode(blackListDetail);
			System.out.println("@@@@@@ detail!= null " + (detail != null) );
            return detail != null;
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
