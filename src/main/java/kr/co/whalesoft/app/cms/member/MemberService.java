package kr.co.whalesoft.app.cms.member;

import java.io.IOException;
import java.io.StringReader;
import java.security.PrivateKey;
import java.security.Security;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.bouncycastle.openssl.PEMKeyPair;
import org.bouncycastle.openssl.PEMParser;
import org.bouncycastle.util.encoders.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ibatis.common.resources.Resources;

import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.memberAuth.MemberAuth;
import kr.co.whalesoft.app.cms.memberAuth.MemberAuthDao;
import kr.co.whalesoft.app.cms.memberGroupAuth.MemberGroupAuthService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.StrUtil;

@Service
public class MemberService extends BaseService {

	@Autowired
	private MemberDao dao;

	@Autowired
	private MemberAuthDao memberAuthDao;

	@Autowired
	private MemberGroupAuthService memberGroupAuthService;

	@Autowired
	private HomepageService homepageService;

	private static final long TIME_DELTA = 60 * 1000 * 30;	// 30분
	private String RSA_PRIVATE_KEY = "";
	private PEMParser parser = null;
	private PEMKeyPair keyPair = null;
	private PrivateKey privateKey = null;

	@PostConstruct
	private void init() {
		try {
			RSA_PRIVATE_KEY = IOUtils.toString(Resources.getResourceAsStream("rsa.pem"), "UTF-8");
		} catch (IOException e) {
			System.out.println("Reading classpath:rsa.pem failed: " + e.getMessage());
		}

		Security.addProvider(new BouncyCastleProvider());

		try {
			parser = new PEMParser(new StringReader(RSA_PRIVATE_KEY));
			keyPair = (PEMKeyPair) parser.readObject();
			privateKey = BouncyCastleProvider.getPrivateKey(keyPair.getPrivateKeyInfo());
		} catch (IOException e) {
			System.out.println("MemberService init failed: " + e.getMessage());
		} finally {
			try { parser.close(); } catch (IOException e) { }
		}
	}

	private String decrypt(String s) {
		Cipher cipher = null;
		byte[] decBytes = null;
		String decryptedText = "";

		if(StringUtils.isEmpty(s)) {
			return s;
		}

		try {
			cipher = Cipher.getInstance("RSA");
			cipher.init(Cipher.DECRYPT_MODE, privateKey);
			decBytes = cipher.doFinal(Base64.decode(s));
			decryptedText = new String(decBytes, "UTF-8");
		} catch (Exception e) {
			System.out.println("Decryption failed: " + e.getMessage());
		}

		return decryptedText;
	}

	private boolean checkDelta(String s, long now) {
		String[] tmp = null;
		long then = 0L;

		if(StringUtils.isEmpty(s)) {
			return true;
		}

		tmp = s.split(" ");

		if(tmp.length != 2) {
			System.out.println("Checking delta failed. Not a valid form: " + s);
			return false;
		}

		try {
			then = (long) Long.parseLong(tmp[1]);
		} catch(NumberFormatException e) {
			System.out.println("Checking delta failed: " + e.getMessage());
			return false;
		}

//		System.out.println("@@@@@@@@@@@@@@@@@ checkDelta delta: " + (now - then));

		if(now - then > TIME_DELTA) {
			System.out.println("Time limit exceeded");
			return false;
		}

		return true;
	}

	private String trimRest(String s) {
		if(StringUtils.isEmpty(s)) {
			return s;
		}

		return s.substring(0, s.indexOf(" "));
	}

	/**
	 * 암호화된 개인정보 복호화.
	 * member_id, member_name, member_pw, member_new_pw.
	 * @param member
	 * @return
	 */
	public boolean decryptMember(Member member) {
		String member_id = decrypt(member.getMember_id());
		String member_name = decrypt(member.getMember_name());
		String member_pw = decrypt(member.getMember_pw());
		String member_new_pw = decrypt(member.getMemberNewPw());
		long now = System.currentTimeMillis();

		if(checkDelta(member_id, now) == false) return false;
		if(checkDelta(member_name, now) == false) return false;
		if(checkDelta(member_pw, now) == false) return false;
		if(checkDelta(member_new_pw, now) == false) return false;

		member.setMember_id(trimRest(member_id));
		member.setMember_name(trimRest(member_name));
		member.setMember_pw(trimRest(member_pw));
		member.setMemberNewPw(trimRest(member_new_pw));

		return true;
	}

	public int getMemberCount(Member member) {
		return dao.getMemberCount(member);
	}

	public List<Member> getMember(Member member) {
		return dao.getMember(member);
	}

	public Member getMemberOne(Member member) {
		member = dao.getMemberOne(member);
//		member.setAuthGroupList(authConfigService.getAuthGroupList(member));
		if (member != null) {
			setMemberInfo(member);
//			member.setAuthGroupIdxList(memberGroupAuthService.getAuthGroupIdxList(member));
			//최고관리자 여부
			member.setAdmin(memberGroupAuthService.isAdminGroup(member));
			//관리사이트 목록
			member.setAuthorityHomepageList(homepageService.getMySiteList(member));
			if (!member.isAdmin()) {
				/**
				 * 최고관리자가 아닌경우 authMap을 세팅한다.
				 */
				member.setAuthMap(getMemberAuth(member));
			}
		}
		return member;
	}

	/**
	 * 사용자 정보 등록
	 * @param member
	 * @return
	 */
	@Transactional
	public int addMember(Member member) {
		member.setMember_pw(CalculateHashUtils.calculateHash(member.getMember_pw()));
		setMemberInfo(member);

		if (member.getAuthGroupIdxList() != null && member.getAuthGroupIdxList().size() > 0) {
			//권한 선택한게 있다면 다 몽땅 집어넣기
			memberGroupAuthService.addMemberGroupAuth(member);
		}

		//다중 권한 처리
//		String[] authList = member.getAuth_id().split(",");
//		for ( String oneAuth : authList ) {
//			if ( oneAuth.equals("100") ) {
//				member.setHomepage_id("CMS");
//			}
//			MemberAuth memberAuth = new MemberAuth();
//			memberAuth.setMember_id(member.getMember_id());
//			memberAuth.setAuth_id(oneAuth);
//			memberAuthDao.addMemberAuth(memberAuth);
//		}

		return dao.addMember(member);
	}

	/**
	 * 사용자 정보 수정
	 * @param member
	 * @return
	 */
	public int modifyMember(Member member) {
		if ( !StringUtils.isEmpty(member.getMember_pw()) ) {
			member.setMember_pw(CalculateHashUtils.calculateHash(member.getMember_pw()));
		}

		setMemberInfo(member);

		//다중 권한 처리
		if ( !StringUtils.isEmpty(member.getAuth_id()) ) {
			memberAuthDao.deleteMemberAuth(new MemberAuth(member.getMember_id()));
			String[] authList = member.getAuth_id().split(",");
			for ( String oneAuth : authList ) {
				MemberAuth memberAuth = new MemberAuth();
				memberAuth.setMember_id(member.getMember_id());
				memberAuth.setAuth_id(oneAuth);
				memberAuthDao.addMemberAuth(memberAuth);
			}
		}

		return dao.modifyMember(member);
	}

	/**
	 * 사용자 정보 삭제
	 * @param member
	 * @return
	 */
	public int deleteMember(Member member) {
		memberAuthDao.deleteMemberAuth(new MemberAuth(member.getMember_id()));
		return dao.deleteMember(member);
	}

	/**
	 * 전화번호, 휴대폰번호, 이메일
	 * @param member
	 */
	private void setMemberInfo(Member member) {
		try {
			String a = member.getCell_phone1();
			String b = member.getCell_phone2();
			String c = member.getCell_phone3();
			String d = member.getPhone1();
			String e = member.getPhone2();
			String f = member.getPhone3();
			String g = member.getEmail1();
			String h = member.getEmail2();
			if (StrUtil.hasNull(a, b, c)) {

			} else {
				member.setCell_phone(a + "-" + b + "-" + c);
			}
			if (StrUtil.hasNull(d, e, f)) {

			} else {
				member.setPhone(d + "-" + e + "-" + f);
			}
			if (StrUtil.hasNull(g, h)) {

			} else {
				member.setEmail(g+"@"+h);
			}

			String z = member.getCell_phone();
			String y = member.getPhone();
			String x = member.getEmail();
			if (!StrUtil.isNull(z)) {
				String[] temp = z.split("-");
				member.setCell_phone1(temp[0]);
				member.setCell_phone2(temp[1]);
				member.setCell_phone3(temp[2]);
			}
			if (!StrUtil.isNull(y)) {
				String[] temp = y.split("-");
				member.setPhone1(temp[0]);
				member.setPhone2(temp[1]);
				member.setPhone3(temp[2]);
			}
			if (!StrUtil.isNull(x)) {
				String[] temp = x.split("@");
				member.setEmail1(temp[0]);
				member.setEmail2(temp[1]);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}


	}

	public List<Member> getMemberListNotAuth(Member member) {
		return dao.getMemberListNotAuth(member);
	}

	public List<Member> getMemberListInAuth(Member member) {
		return dao.getMemberListInAuth(member);
	}

	public int getMemberListInAuthCount(Member member) {
		return dao.getMemberListInAuthCount(member);
	}

	public int checkMemberId(Member member) {
		return dao.checkMemberId(member);
	}

	public int checkMemberAuthInHomepage(Member member) {
		Member targetMember = dao.getMemberOne(member);
		String auth_id = targetMember.getAuth_id();
		if ( Integer.parseInt(auth_id) <= 200 ) {
			member.setHomepage_id(targetMember.getHomepage_id());
			member.setAuth_id(auth_id);
			return dao.checkMemberAuthInHomepage(member);
		}
		else {
			return 2;
		}
	}

	public List<Member> getMemberListInId(Member member) {
		return dao.getMemberListInId(member);
	}

	public boolean isPassDlsId(Member member) {
		return dao.getDlsMemberCount(member) > 0 ? true : false;
	}

	public int addDlsMember(Member member) {
		return dao.addDlsMember(member);
	}

	public int addChangeNameHistory(Member member) {
		return dao.addChangeNameHistory(member);
	}

	public int addMemberGroup(Member member) {
		return memberGroupAuthService.addMemberGroupAuth(member);
	}

	public Map<String, Object> getMemberAuth(Member member) {
		Map<String, Object> map = new HashMap<String, Object>();
		/**
		 * 그룹 권한 가져오기
		 */
		List<String> authList = dao.getMemberAuth(member);

		if (authList != null && authList.size() > 0) {
			for ( String key : authList ) {
				map.put(key, true);
			}
		}

		/**
		 * 사이트관리권한만 가져오기
		 */
		authList = dao.getMemberSiteAdminAuth(member);
		if (authList != null && authList.size() > 0) {
			for ( String key : authList ) {
				map.put(key, true);
			}
		}


		return map;
	}

	public Map<String, Object> getAnonymousAuth(Member member) {
		Map<String, Object> map = new HashMap<String, Object>();
		/**
		 * 그룹 권한 가져오기
		 */
		List<String> authList = dao.getAnonymousAuth(member);

		if (authList != null && authList.size() > 0) {
			for ( String key : authList ) {
				map.put(key, true);
			}
		}

		return map;
	}

	public List<Member> getMemberManageList(Member member) {
		return dao.getMemberManageList(member);
	}

	public int getMemberManageCount(Member member) {
		return dao.getMemberManageCount(member);
	}

	public List<Member> getMemberListBoardAdmin(BoardManage boardManage) {
		return dao.getMemberListBoardAdmin(boardManage);
	}

	public int addMemberLastLogin(Member member, HttpServletRequest request) {
		Member m = new Member();
		m.setSeq_no(member.getRec_key());
		m.setLast_login_ip(request.getRemoteAddr());
		m.setWeb_id(member.getMember_id());

		return dao.addMemberLastLogin(m);
	}
}
