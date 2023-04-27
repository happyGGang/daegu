package kr.co.whalesoft.framework.utils;

import kr.co.whalesoft.framework.base.CommonBean;
import org.springframework.util.Assert;
import org.springframework.validation.Errors;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ValidationUtilsFromMap {

	public static boolean rejectIfEmpty(JsonResponse res, CommonBean bean, String field, String errorCode) {
		if (isEmpty(bean, field)) {
			res.addError(field, errorCode);
			return true;
		}
		return false;
	}

	/**
	 * 이메일형식 체크 (@이하 ex : 'abc.com')
	 * @return
	 */
	public static void rejectNotEmailType(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "(?:\\w+\\.)+\\w+$");
	}

	/**
	 * 이메일형식 체크 ( ex : 'abc@abc.com')
	 */
	public static void rejectNotFullEmailType(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^[_a-z0-9-]+([_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$");
	}

	/**
	 * 정규식 숫자만 가능 (0-9), 자릿수 반드시 일치
	 */
	public static void rejectExceptNumber(JsonResponse res, CommonBean bean, String field, String errorCode, int limit) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^[0-9]{"+limit+"}+$");
	}

	/**
	 * 정규식 숫자만 가능 (0-9), 자릿수 범위 일치
	 */
	public static void rejectExceptNumber(JsonResponse res, CommonBean bean,String field, int minList, int maxLimit, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^[0-9]{"+minList+","+maxLimit+"}+$");
	}

	/**
	 * 정규식 숫자만 가능 (0-9)
	 */
	public static void rejectExceptNumber(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^[0-9]+$");
	}

	/**
	 * 0이상의 숫자만 가능
	 */
	private static void rejectIfZero(JsonResponse res, CommonBean bean, String field, String errorCode) {
		Assert.notNull(res, "Errors object must over 0");
		if (isEmpty(bean, field)) {
			return;
		}
		int value = Integer.valueOf(bean.get(field).toString());
		if (value < 1) {
			res.addError(field, errorCode);
		}
	}

	/**
	 * 한글불가
	 */
	public static void rejectIfKor(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "[^가-힣]+$");
	}

	/**
	 * 한글만가능
	 */
	public static void rejectOnlyKor(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^[가-힣]+$");
	}

	/**
	 * 영어와 숫자만가능
	 */
	public static void rejectOnlyEngNum(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^[a-zA-Z0-9]+$");
	}

	/**
	 * 영어와 소문자와 숫자만가능
	 */
	public static void rejectOnlySmallEngNum(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^[a-z0-9]+$");
	}

	/**
	 * 영어와 숫자만가능
	 */
	public static void rejectOnlyEngNum(JsonResponse res, CommonBean bean,String field, int limit, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^[a-zA-Z0-9]{"+limit+"}+$");
	}

	/**
	 * 영어와 숫자만가능
	 */
	public static void rejectOnlyEngNum(JsonResponse res, CommonBean bean,String field, int min, int max, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^[a-zA-Z0-9]{"+min+","+max+"}+$");
	}

	/**
	 * 휴대폰번호체크 (01x-xxxx-xxxx) or (01x-xxx-xxxx)
	 */
	public static void rejectPhone(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^01[0|1|6|7|8|9]-?[\\d]{3,4}-?[\\d]{4}$");
	}

	/**
	 * 전화번호체크 (xxx-xxxx-xxxx) or (xxx-xxx-xxxx)
	 */
	public static void rejectPhone2(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^[\\d]{2,3}-?[\\d]{3,4}-?[\\d]{4}$");
	}

	/**
	 * 날짜형식체크 YYYY-MM-DD
	 */
	public static void rejectIfNotDate(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^(19[0-9][0-9]|20\\d{2})-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$");
	}

	/**
	 * 'Y','N' 만 가능
	 */
	public static void rejectYN(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^[YN]$");
	}

	/**
	 * 주민번호 체크 SSN
	 */
	public static void rejectKoreaSSN(Errors errors, String field1, String field2, String errorCode) {
		String ssn = (String) errors.getFieldValue(field1) + errors.getFieldValue(field2);
		if (ssn.length() < 13) {
			errors.reject("주민번호의 길이가 짧습니다.");
			return;
		}

	    int a = Integer.parseInt( ssn.substring(0, 1) );
	    int b = Integer.parseInt( ssn.substring(1, 2) );
	    int c = Integer.parseInt( ssn.substring(2, 3) );
	    int d = Integer.parseInt( ssn.substring(3, 4) );
	    int e = Integer.parseInt( ssn.substring(4, 5) );
	    int f = Integer.parseInt( ssn.substring(5, 6) );
	    int g = Integer.parseInt( ssn.substring(6, 7) );
	    int h = Integer.parseInt( ssn.substring(7, 8) );
	    int i = Integer.parseInt( ssn.substring(8, 9) );
	    int j = Integer.parseInt( ssn.substring(9, 10) );
	    int k = Integer.parseInt( ssn.substring(10, 11) );
	    int l = Integer.parseInt( ssn.substring(11, 12) );
	    int m = Integer.parseInt( ssn.substring(12, 13) );

	 	// 월,일 검사.
	    int month = Integer.parseInt( ssn.substring(2,4) );
	    int day = Integer.parseInt( ssn.substring(4,6) );

	    if ( month <= 0 || month > 12 ) {
	    	errors.rejectValue(field1, errorCode, null, null);
	    	return;
		}

	    if(day <= 0 || day > 31) {
	    	errors.rejectValue(field1, errorCode, null, null);
	    	return;
    	}

		// checksum 검사.
	    int temp=a*2+b*3+c*4+d*5+e*6+f*7+g*8+h*9+i*2+j*3+k*4+l*5;
	    temp=temp%11;
	    temp=11-temp;
	    temp=temp%10;

	    if ( temp != m ) {
	    	errors.rejectValue(field1, errorCode, null, null);
	    	return;
	    }
	}

	/**
	 * 정규식검사
	 */
	private static void rejectIfRegex(JsonResponse res, CommonBean bean, String field, String errorCode, Object[] errorArgs, String defaultMessage, String regPattern) {
		Assert.notNull(res, "Errors object must not be null");
		if (rejectIfEmpty(res, bean, field, String.format("해당 입력값이 비어있습니다 :  %s", field))) {
			return;
		}
		Pattern pattern = Pattern.compile(regPattern);
		Matcher matcher = pattern.matcher((String) bean.get(field));
		if (!matcher.matches()) {
			res.addError(field, errorCode);
		}
	}

	/**
	 * 숫자 거부
	 */
	public static void rejectNumbers(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "[^0-9]+");
	}

	/**
	 * 영어와 숫자, 특수문자를 모두 포함
	 */
	public static void rejectPasswordSpecieal(JsonResponse res, CommonBean bean, String field, String errorCode) {
		rejectIfRegex(res, bean, field, errorCode, null, null, "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[$@$!%*#?&])[A-Za-z[0-9]$@$!%*#?&]+$");
	}

	/**
	 * Null Check & Blank Check
	 */
	private static boolean isEmpty(CommonBean bean, String field) {
		return bean.get(field) == null || "".equals(bean.get(field).toString().trim());
	}
}
