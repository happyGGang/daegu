package kr.go.gbelib.app.common.api;

public class ShareGpki {

	public ShareGpki(){

	}
	public static NewGpkiUtil getGpkiUtil(String targetServerId)throws Exception{
		NewGpkiUtil g = new NewGpkiUtil();
		// 이용기관 서버CN
		String myServerId = "SVR6271102001";

		String envCertFilePathName = "";
		String envPrivateKeyFilePathName = "";
		// 이용기관 서버인증서 경로
		g.setCertFilePath("/data/HOMEPAGE/WEB-INF/config/gpki");
		envCertFilePathName = "/data/HOMEPAGE/WEB-INF/config/gpki/SVR6271102001_env.cer";
		envPrivateKeyFilePathName = "/data/HOMEPAGE/WEB-INF/config/gpki/SVR6271102001_env.key";

		// 이용기관 서버인증서 비밀번호
		String envPrivateKeyPasswd = "!daegu6064";
		String sigCertFilePathName;
		String sigPrivateKeyFilePathName;

		// 이용기관 서버전자서명 경로
		 sigCertFilePathName = "/data/HOMEPAGE/WEB-INF/config/gpki/SVR6271102001_sig.cer";
		 sigPrivateKeyFilePathName = "/data/HOMEPAGE/WEB-INF/config/gpki/SVR6271102001_sig.key";

		// 이용기관 서버전자서명 비밀번호
		String sigPrivateKeyPasswd = "!daegu6064";


		// 이용기관 GPKI API 라이선스파일 경로
		g.setGpkiLicPath("/data/HOMEPAGE/WEB-INF/config/gpki");
		g.setEnvCertFilePathName(envCertFilePathName);
		g.setEnvPrivateKeyFilePathName(envPrivateKeyFilePathName);
		g.setEnvPrivateKeyPasswd(envPrivateKeyPasswd);
		// LDAP 의 사용유무
		// 미사용일 경우 암호화할 타겟의 인증서를 파일로 저장해놓고 사용하여야함.
		g.setIsLDAP(true);
		g.setMyServerId(myServerId);
		g.setSigCertFilePathName(sigCertFilePathName);
		g.setSigPrivateKeyFilePathName(sigPrivateKeyFilePathName);
		g.setSigPrivateKeyPasswd(sigPrivateKeyPasswd);

		g.setTargetServerIdList(targetServerId);

		g.init();
		return g;
	}
}
