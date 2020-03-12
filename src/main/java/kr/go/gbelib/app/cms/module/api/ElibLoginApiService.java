package kr.go.gbelib.app.cms.module.api;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.common.api.LoginAPI;

@Service
public class ElibLoginApiService extends BaseService {

	public ElibLoginXmlResult doApi(String login_uid, String login_pwd, HttpServletRequest request, HttpServletResponse response) {

		ElibLoginXmlResult ElibLoginXmlResult = new ElibLoginXmlResult();
		Member member = new Member();
		member.setMember_id(login_uid);
		member.setMember_pw(login_pwd);
		member.setManage_code("AP");
		Object result = null;

		try {
			result = LoginAPI.login(member);
		} catch(Exception e) {
			ElibLoginXmlResult.setResult("N");
			ElibLoginXmlResult.setMessage("로그인 실패");
			return ElibLoginXmlResult;
		}

		if ( result instanceof Member && "0".equals(((Member)result).getMember_class()) ) {
			ElibLoginXmlResult.setResult("Y");
			ElibLoginXmlResult.setMessage("로그인 성공");
			ElibLoginXmlResult.setManage_code(member.getUser_manage_code());
		} else {
			ElibLoginXmlResult.setResult("N");
			ElibLoginXmlResult.setMessage("로그인 실패");
		}

		return ElibLoginXmlResult;
	}

}
