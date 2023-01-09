package kr.go.gbelib.app.cms.module.supportMember;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.app.cms.memberGroupAuth.MemberGroupAuthService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.dataSource.DataSource;
import kr.co.whalesoft.framework.dataSource.DataSourceType;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;

@Service
public class SupportMemberService extends BaseService {
	
	@Autowired
	private SupportMemberDao dao;
	
	@Autowired
	private MemberGroupAuthService memberGroupAuthService;
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private MemberService memberService;

	@WorkingLogger(comment="228회원 관리 조회", type="P")
	public List<SupportMember> getSupportMemberList(SupportMember supportMember) {
		return dao.getSupportMemberList(supportMember);
	}

	public int getSupportMemberCount(SupportMember supportMember) {
		return dao.getSupportMemberCount(supportMember);
	}

	@WorkingLogger(comment="228회원 관리 1건 조회", type="P")
	public SupportMember getSupportMemberOne(SupportMember supportMember) {
		return dao.getSupportMemberOne(supportMember);
	}
	
	public int memberIdDuplCheck(SupportMember supportMember) {
		return dao.memberIdDuplCheck(supportMember);
	}

	public int addSupportMember(SupportMember supportMember) {
		supportMember.setMember_password(CalculateHashUtils.calculateHash(supportMember.getMember_password()));
		return dao.addSupportMember(supportMember);
	}

	@WorkingLogger(comment="228회원 관리 1건 수정", type="P")
	public int modifySupportMember(SupportMember supportMember) {
		if(StringUtils.isNotEmpty(supportMember.getMember_password())) {
			supportMember.setMember_password(CalculateHashUtils.calculateHash(supportMember.getMember_password()));
		}
		return dao.modifySupportMember(supportMember);
	}
	
	public int modifySupportMemberGroup(SupportMember supportMember) {
		return dao.modifySupportMemberGroup(supportMember);
	}

	@WorkingLogger(comment="228회원 관리 1건 삭제", type="P")
	public int deleteSupportMember(SupportMember supportMember) {
		return dao.deleteSupportMember(supportMember);
	}

	@WorkingLogger(comment="228회원 관리 선택 회원 삭제", type="P")
	public int deleteCheckSupportMember(SupportMember supportMember) {
		return dao.deleteCheckSupportMember(supportMember);
	}

	public SupportMember getSupportMemberLogin(SupportMember supportMember) {
		supportMember.setMember_password(CalculateHashUtils.calculateHash(supportMember.getMember_password()));
		
		supportMember = dao.getSupportMemberLogin(supportMember);
		if(supportMember != null) {
			Member member = new Member(supportMember.getMember_id());
			//최고관리자 여부
			supportMember.setAdmin(memberGroupAuthService.isAdminGroup(member));
			//관리사이트 목록
			supportMember.setAuthorityHomepageList(homepageService.getMySiteList(member));
			if (!supportMember.isAdmin()) {
				/**
				 * 최고관리자가 아닌경우 authMap을 세팅한다.
				 */
				supportMember.setAuthMap(memberService.getMemberAuth(member));
			}
		}
		
		return supportMember;
	}

	public int addLastLogin(SupportMember supportMember) {
		return dao.addLastLogin(supportMember);
	}
	
	public int passwordChange(SupportMember supportMember) {
		supportMember.setMember_password(CalculateHashUtils.calculateHash(supportMember.getMember_password()));
		return dao.passwordChange(supportMember);
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getMySqlList() {
		return dao.getMySqlList();
	}

	public int addParseTibero(SupportMember supportMember) {
		supportMember.setMember_password(CalculateHashUtils.calculateHash(supportMember.getMember_password()));
		return dao.addParseTibero(supportMember);
	}

	public SupportMember getSessionSupport(HttpServletRequest request) {
		HttpSession session = request.getSession();
		return (SupportMember)session.getAttribute("loginSupport");
	}

	public int excelUploadSave(SupportMember supportMember) {
		return dao.excelUploadSave(supportMember);
	}

	public int excelUploadSave(MultipartFile mfile) throws BiffException, IOException {
		try {
			Workbook workbook = Workbook.getWorkbook(mfile.getInputStream());
			Sheet sheet = workbook.getSheet(0);
			
			int rowCount = sheet.getRows();
				
			for(int i = 1; i < rowCount; i++) {
				String id = (sheet.getCell(0, i).getContents().trim());
				String name = (sheet.getCell(1, i).getContents().trim());
				
				SupportMember supportMember = new SupportMember();
				
				supportMember.setMember_id(id);
				supportMember.setSchool_name(name);
				supportMember.setMember_password(CalculateHashUtils.calculateHash(id));
				supportMember.setAdd_id(id);
				
				if(dao.memberIdDuplCheck(supportMember) > 0) {
					return 2;
				}
				
				dao.excelUploadSave(supportMember);
			}
			
			workbook.close();
			
			return 1;
		} catch (Exception e) {
			log.error("엑셀다운로드 에러");
		}
		
		return 0;
	}

}
