package kr.go.gbelib.app.cms.module.newelib.member;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.newelib.api.APIService;
import kr.go.gbelib.app.cms.module.newelib.api.ElibException;
import kr.go.gbelib.app.cms.module.newelib.book.Book;

@Service(value = "elibMemberNew")
public class ElibMemberService extends BaseService {
	
	@Autowired
	private ElibMemberDao dao;
	
	@Autowired
	private APIService apiService;
	
//	public int getUserIdxByUserId(String member_id) {
//		ElibMember member = dao.getMemberById(new ElibMember(member_id));
//		
//		if(member == null) {
//			
//		} else { return member.getUser_idx();
//	}
		
	public ElibMember getMemberById(ElibMember member) {
		return dao.getMemberById(member);
	}
	
	public int addMember(ElibMember member) {
		return dao.addMember(member);
	}
	
	public List<ElibMember> getMemberList() {
		return dao.getMemberList();
	}
	
	public int modifyMember(ElibMember member) {
		return dao.modifyMember(member);
	}
	
	public int addMemberIfNotExists(ElibMember member, Book book) throws ElibException {
		apiService.signup(member, book);
		
		return addMemberIfNotExistsLocal(member);
	}
	
	public int addMemberIfNotExistsLocal(ElibMember member) throws ElibException {
		ElibMember member1 = dao.getMemberById(member);
		
		if(member1 == null) {
			member.setBirth_day(StringUtils.defaultString(member.getBirth_day()).replaceAll("[^0-9]", ""));
			if(dao.addMember(member) == 0) {
				return -1;
			} else {
				return 1;
			}
		} else if(StringUtils.isEmpty(member1.getBirth_day()) || StringUtils.isEmpty(member1.getSex()) || StringUtils.isEmpty(member1.getSeq_no())) {
			dao.modifyMember(member);
			return 1;
		} else {
			return 0;
		}
	}
	
}
