package kr.go.gbelib.app.module.userPickBook;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserPickBookService extends BaseService {

	@Autowired
	private UserPickBookDao dao;

	public List<Map<String, Object>> getUserPickBook(Member member) {
		return dao.getUserPickBook(member);
	}
}
