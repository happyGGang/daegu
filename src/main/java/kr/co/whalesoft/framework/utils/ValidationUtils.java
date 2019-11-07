package kr.co.whalesoft.framework.utils;

import java.io.UnsupportedEncodingException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.springframework.util.Assert;
import org.springframework.validation.Errors;

public class ValidationUtils extends org.springframework.validation.ValidationUtils{

	/**
	 * 이메일형식 체크 (@이하 ex : 'abc.com')
	 * @param email
	 * @return 
	 */
	public static void rejectNotEmailType(Errors errors, String field, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "(?:\\w+\\.)+\\w+$");
//		rejectIfEmpty(errors, field, errorCode, null, null);
	}
	
	/**
	 * 이메일형식 체크 ( ex : 'abc@abc.com')
	 * @param errors
	 * @param field
	 * @param errorCode
	 */
	public static void rejectNotFullEmailType(Errors errors, String field, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "^[_a-z0-9-]+([_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$");
	}
	
	/**
	 * 정규식 숫자만 가능 (0-9), 자릿수 반드시 일치
	 * @param errors
	 * @param field
	 * @param limit 제한 자릿수
	 * @param errorCode
	 */
	public static void rejectExceptNumber(Errors errors, String field, int limit, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "^[0-9]{"+limit+"}+$");
	}
	
	/**
	 * 정규식 숫자만 가능 (0-9), 자릿수 범위 일치
	 * @param errors
	 * @param field
	 * @param limit 제한 자릿수
	 * @param errorCode
	 */
	public static void rejectExceptNumber(Errors errors, String field, int minList, int maxLimit, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "^[0-9]{"+minList+","+maxLimit+"}+$");
	}
	
	/**
	 * 정규식 숫자만 가능 (0-9)
	 * @param errors
	 * @param field
	 * @param errorCode
	 */
	public static void rejectExceptNumber(Errors errors, String field, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "^[0-9]+$");
	}
	
	/**
	 * 0이상의 숫자만 가능
	 * @param errors
	 * @param field
	 * @param errorCode
	 */
	public static void rejectIfZero(Errors errors, String field, String errorCode) {
		rejectIfZero(errors, field, errorCode, null, null);
	}
	
	

	/**
	 * 한글불가
	 * @param errors
	 * @param field
	 * @param errorCode
	 */
	public static void rejectIfKor(Errors errors, String field, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "[^가-힣]+$");
	}

	/**
	 * 한글만가능
	 * @param errors
	 * @param field
	 * @param errorCode
	 */
	public static void rejectOnlyKor(Errors errors, String field, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "^[가-힣]+$");
	}

	/**
	 * 영어와 숫자만가능
	 * @param errors
	 * @param field
	 * @param errorCode
	 */
	public static void rejectOnlyEngNum(Errors errors, String field, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "^[a-zA-Z0-9]+$");
	}
	
	/**
	 * 영어와 숫자만가능
	 * @param errors
	 * @param field
	 * @param errorCode
	 */
	public static void rejectOnlyEngNum(Errors errors, String field, int limit, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "^[a-zA-Z0-9]{"+limit+"}+$");
	}
	
	/**
	 * 영어와 숫자만가능
	 * @param errors
	 * @param field
	 * @param errorCode
	 */
	public static void rejectOnlyEngNum(Errors errors, String field, int min, int max, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "^[a-zA-Z0-9]{"+min+","+max+"}+$");
	}
	
	/**
	 * 휴대폰번호체크 (01x-xxxx-xxxx) or (01x-xxx-xxxx)
	 * @param errors
	 * @param field
	 * @param errorCode
	 */
	public static void rejectPhone(Errors errors, String field, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "^01[0|1|6|7|8|9]-?[\\d]{3,4}-?[\\d]{4}$");
	}
	
	/**
	 * 전화번호체크 (xxx-xxxx-xxxx) or (xxx-xxx-xxxx)
	 * @param errors
	 * @param field
	 * @param errorCode
	 */
	public static void rejectPhone2(Errors errors, String field, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "^[\\d]{2,3}-?[\\d]{3,4}-?[\\d]{4}$");
	}
	
	/**
	 * 날짜형식체크 YYYY-MM-DD
	 * @param errors
	 * @param field
	 * @param errorCode
	 */
	public static void rejectIfNotDate(Errors errors, String field, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "^(19[0-9][0-9]|20\\d{2})-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$");
	}

	
	/**
	 * 주민번호 체크 SSN
	 * @param ssn
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
	 * DB 저장 할 컬럼 길이와 데이터 길이 비교 
	 * @param errors
	 * @param field
	 * @param maxLength
	 * @param fieldName
	 */
	public static void rejectIfStringLength(Errors errors, String field, int maxLength, String fieldName) {
		String value = String.valueOf(errors.getFieldValue(field));
		if ( StringUtils.isNotEmpty(value)) {
			int valueLength = 0;
			try {
//				valueLength = value.replaceAll("\r\n", "\n").getBytes("UTF-8").length;
				valueLength = value.getBytes("UTF-8").length;
			} catch ( UnsupportedEncodingException e ) {
				e.printStackTrace();
			}

			if ( maxLength < valueLength ) {
				errors.rejectValue(field, String.format("입력하신 길이가 큽니다. 현재 : %s byte, 제한 : %s byte", valueLength, maxLength), null, null);
				return;
			}	
		}
	}
	
	public static void rejectIfFileNameLength(Errors errors, String field, String fileName, int maxLength, String fieldName) {
		if ( StringUtils.isNotEmpty(fileName)) {
			int valueLength = 0;
			try {
				valueLength = fileName.replaceAll("\r\n", "\n").getBytes("UTF-8").length;
			} catch ( UnsupportedEncodingException e ) {
				e.printStackTrace();
			}

			if ( maxLength < valueLength ) {
				errors.rejectValue(field, String.format("%s 파일명이 길이가 큽니다. 현재 : %s, 제한 : %s", fieldName, valueLength, maxLength), null, null);
			}	
		}
	}
	
	/**
	 * 정규식검사
	 * @param errors
	 * @param field
	 * @param errorCode
	 * @param errorArgs
	 * @param defaultMessage
	 * @param regPattern
	 */
	private static void rejectIfRegex(Errors errors, String field, String errorCode, Object[] errorArgs, String defaultMessage, String regPattern) {
		Assert.notNull(errors, "Errors object must not be null");
		Object value = errors.getFieldValue(field);
		Pattern pattern = Pattern.compile(regPattern);
		Matcher matcher = pattern.matcher(value.toString());
		if (!matcher.matches()) {
			errors.rejectValue(field, errorCode, errorArgs, defaultMessage);
		}
	}

	/**
	 * 
	 * @param errors
	 * @param field
	 * @param errorCode
	 * @param errorArgs
	 * @param defaultMessage
	 * @param regPattern
	 */
	private static void rejectIfZero(Errors errors, String field, String errorCode, Object[] errorArgs, String defaultMessage) {
		Assert.notNull(errors, "Errors object must over 0");
		Object obj = errors.getFieldValue(field);
		int value = Integer.valueOf(obj.toString());
		if (value < 1) {
			errors.rejectValue(field, errorCode, errorArgs, defaultMessage);
		}
	}
	
	/**
	 * 숫자 거부
	 * @param errors
	 * @param field
	 * @param errorCode
	 */
	public static void rejectNumbers(Errors errors, String field, String errorCode) {
		rejectIfRegex(errors, field, errorCode, null, null, "[^0-9]+");
	}

}
