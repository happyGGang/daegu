package kr.go.gbelib.app.module.userPickBook;

import kr.co.whalesoft.app.cms.member.Member;

import java.util.List;
import java.util.Map;

public interface UserPickBookDao {
	List<Map<String, Object>> getUserPickBook(Member member);
}
