package kr.co.whalesoft.framework.utils;

public class AuthUtils {
	
	public static final String anonymous = "ANONYMOUS";

	/**
	 * 권한 목록을 가져온다.
	 * @return
	 */
	/*public static String[] getAuthorities() {
		List<String> authCdes = new ArrayList<String>();
		if(getAuthentication() != null) {
			for(GrantedAuthority authority : getAuthentication().getAuthorities()){
				authCdes.add(authority.getAuthority().replaceAll("ROLE_", ""));
			}
		}
		
		String[] authoritys = new String[authCdes.size()];
		return authCdes.toArray(authoritys);
	}
	
	*//**
	 * 현재 권한을 가져온다.
	 * @return
	 *//*
	public static Authentication getAuthentication() {
		return SecurityContextHolder.getContext().getAuthentication();
	}
	
	*//**
	 * 해당 권한을 가지고 있는지 여부를 반환
	 * @param role
	 * @return
	 *//*
	public static boolean hasAuthority(String role) {
		if(getAuthentication() != null) {
			for(GrantedAuthority authority : getAuthentication().getAuthorities()){
				if (authority.getAuthority().endsWith(role)) {
					return true;
				}
			}
		}
		

		return false;
	}
	
	*//**
	 * 현재 사용자 ID를 가져온다.
	 * @return
	 *//*
	public static String getCurrentUserId() {
		Object obj = getAuthentication().getPrincipal();
		String user_Id = "";
		if (obj instanceof UserDetails) {
			user_Id = ((UserDetails)obj).getUsername();
		}
		else {
			user_Id = obj.toString();
		}
		return user_Id;
	}*/
}