package kr.co.whalesoft.framework.utils;

import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StrUtil {



	/**
	 * 문자열 배열을 ,를 구분한 문자열 반환메서드
	 * @param arr
	 * @return
	 */
	public static String arrayToString(String arr[]) {
		StringBuffer str = null;
		if(arr != null){
			str = new StringBuffer();
			for(int i =0;i<arr.length;i++){
				if(i!=0)
					str.append(",");
				str.append(arr[i]);

			}
		}
		if(str != null)
			return str.toString();
		return null;
	}

	/**
	 * 문자열안에 입력받은 문자가 있다면 true 없으면 false
	 * @param str
	 * @param str2
	 * @return
	 */
	public static boolean isInStr(String str,String str2) {
		boolean ck = false;

		if(str != null){
			if(!(str.indexOf(str2)<0))
				ck=true;
		}
		return ck;

	}

	/**
	 * String 이 null일 경우 "" 값 반환 메서드
	 * @param value
	 * @return
	 */
	public static String getVal(String value){
		if(value != null)
			return value;

		return "";
	}

	/**
	 * "" 혹은 null인지 비교 메서드
	 * @param value
	 * @return
	 */
	public static boolean isNull(String value){
		boolean ck = false;
		if(value == null){
			ck=true;
		}else if("".equals(value.trim())){
			ck=true;
		}
		return ck;
	}

	/**
	 * "" 혹은 null인지 비교 메서드 2
	 * @param value
	 * @return 하나라도 포함되면 true
	 */
	public static boolean hasNull(String... values){
		if (values == null || values.length < 1) return true;
		for (String str : values) {
			if(str == null){
				return true;
			}else if("".equals(str.trim())){
				return true;
			}
		}
		return false;
	}

	/**
	 * "" 혹은 null인지 비교 메서드
	 * == NVL(vlaue, returnStr)
	 * @param value
	 * @return true=returnStr, false=value
	 */
	public static String isNull(String value, String returnStr){
			if(value == null){
				return returnStr;
			}else if("".equals(value.trim())){
				return returnStr;
			}
		return value;
	}

	/**
	 * 한글, 영문 같은 길이로 문자열 자르기
	 * @param str
	 * @param size
	 * @return
	 */
	public static String cutStr(String str,int size){
		str = getVal(str);

		if(str.length() <= size)
			return str;

		byte[] strByte = str.getBytes();

		int hanCount=0;

		for(int i=0;i<size;i++){
			if(strByte[i]<0)
				++hanCount;
		}

		if(hanCount%2!=0){
			size+=1;
		}

		return new String(strByte,0,size)+"...";
	}


	/**
	 * UTF-8로 글자 자르기
	 * @param str
	 * @param size
	 * @return
	 */
	public static String previewContent(String str,int size) {
		int 	cutNum;
		String returnStr="";

		byte strByte[];
		try {
			strByte = str.getBytes("UTF-8");
			int trailByteSize = 0;

			cutNum = size - trailByteSize;
			//마지막 바이트 위치
			int endPos = 0;
			//현재까지 조사한 바이트 수
			int currByte = 0;

			for (int i = 0; i < str.length(); i++) {
			   //순차적으로 문자들을 가져옴.
				char ch = str.charAt(i);

			    //이 문자가 몇 바이트로 구성된 UTF-8 코드인지를 검사하여 currByte에 누적 시킨다.
			    currByte = currByte + availibleByteNum(ch);

			   //현재까지 조사된 바이트가 maxSize를 넘는다면 이전 단계 까지 누적된 바이트 까지를 유효한 바이트로 간주한다.
			    if (currByte >= cutNum) {
			    	endPos = currByte - availibleByteNum(ch);
			    	break;
			    }
			}

			byte newStrByte[] = new byte[endPos];
			System.arraycopy(strByte, 0, newStrByte, 0, endPos);
			if(endPos !=0) {
				returnStr = new String(newStrByte, "UTF-8")+"..";
			} else {
				returnStr = str;
			}
		} catch (UnsupportedEncodingException e2) {
			e2.printStackTrace();
		}
		return returnStr;
	}

	/**
	 * 태그제거
	 * @param content
	 * @return
	 */
	public static String delHtmlTag( String content ) {
		Pattern p = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>");
		Matcher m = p.matcher( content );
		content = m.replaceAll("").trim();
		return content;
	}

	/**
	 * 태그존재유무
	 * @param content
	 * @return
	 */
	public static boolean isHtmlTag( String content ) {
		Pattern p = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>");
		Matcher m = p.matcher( content );
		return m.find();
	}

	public static int availibleByteNum(char c) {
		int ONE_BYTE_MIN = 0x0000;
		int ONE_BYTE_MAX = 0x007F;

		int TWO_BYTE_MIN = 0x0800;
		int TWO_BYTE_MAX = 0x07FF;

		int THREE_BYTE_MIN = 0x0800;
		int THREE_BYTE_MAX = 0xFFFF;

		int SURROGATE_MIN = 0x10000;
		int SURROGATE_MAX = 0x10FFFF;
		int digit = (int)c;

		if (ONE_BYTE_MIN <= digit && digit <= ONE_BYTE_MAX)
		return 1;
		else if (TWO_BYTE_MIN <= digit && digit <= TWO_BYTE_MAX)
			return 2;
		else if (THREE_BYTE_MIN <= digit && digit <= THREE_BYTE_MAX)
			return 3;
		else if (SURROGATE_MIN <= digit && digit <= SURROGATE_MAX)
			return 4;
		return -1;
	}

	public static int stringToNum(String str){
		int temp = 0;
		if(isNull(str)) return temp;
		temp = Integer.parseInt(str);
		return temp;

	}
	public static boolean isSChar(String str){
		String strval = "";
		if ( str != null && str.length() > 0){
			for(int i=0; i < str.length(); i++) {
				strval = str.substring(i,i+1);
	            if( strval.equals("`") ) return false;
	            if( strval.equals("~") ) return false;
	            if( strval.equals("!") ) return false;
	            if( strval.equals("@") ) return false;
	            if( strval.equals("#") ) return false;
	            if( strval.equals("$") ) return false;
	            if( strval.equals("%") ) return false;
	            if( strval.equals("^") ) return false;
	            if( strval.equals("&") ) return false;
	            if( strval.equals("*") ) return false;
	            if( strval.equals("(") ) return false;
	            if( strval.equals(")") ) return false;
	            if( strval.equals("-") ) return false;
	            if( strval.equals("_") ) return false;
	            if( strval.equals("+") ) return false;
	            if( strval.equals("=") ) return false;
	            if( strval.equals("|") ) return false;
	            if( strval.equals("[") ) return false;
	            if( strval.equals("]") ) return false;
	            if( strval.equals("{") ) return false;
	            if( strval.equals("}") ) return false;
	            if( strval.equals(":") ) return false;
	            if( strval.equals(";") ) return false;
	            if( strval.equals("<") ) return false;
	            if( strval.equals(">") ) return false;
	            if( strval.equals("?") ) return false;
	            if( strval.equals(",") ) return false;
	            if( strval.equals(".") ) return false;
	            if( strval.equals("/") ) return false;
	        }
	    }
	 return true;
	}

	/**
	 * String To Date
	 * @param str
	 * @return
	 */
	public static Date strToDate(String str){


		Date wantDate = null;
		int len;

		if(str != null){
			str = str.replaceAll("-", "");
			if(str.length() < 14){
				len = 14 - str.length();
				for(int i=0; i < len; i++){
					str +="0";
				}
			}
		}
		SimpleDateFormat dateForm = new SimpleDateFormat("yyyyMMddHHmmss");
		try{
			wantDate = dateForm.parse(str);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return wantDate;
	}

	/**
	 * null to blank
	 * @param str
	 * @return
	 */
	public static String nullToBlank(String str){
		String value = str;
		if(value == null){
			return "";
		}else{
			return value;
		}

	}

	public static String delHtmlTagPatterns( String content ) {
        Matcher m;

        try {
        	m = Patterns.SCRIPTS.matcher(content);
        	content = m.replaceAll("");
        	m = Patterns.STYLE.matcher(content);
        	content = m.replaceAll("");
        	m = Patterns.TAGS.matcher(content);
        	content = m.replaceAll("");
        	m = Patterns.TAGS2.matcher(content);
        	content = m.replaceAll("");
        	m = Patterns.ENTITY_REFS.matcher(content);
        	content = m.replaceAll("");
        	m = Patterns.WHITESPACE.matcher(content);
        	content = m.replaceAll(" ");
		} catch (StackOverflowError e) {
			return "";
		}

        return content;
    }

	public static String delTagPatterns( String content ) {
        Matcher m;

        m = Patterns.STARTTAGS.matcher(content);
        if (m.find()) {
        	content = m.replaceAll(m.group().replace("<", "&lt;").replace(">", "&gt;"));
		}
        m = Patterns.ENDTAGS.matcher(content);
        if (m.find()) {
        	content = m.replaceAll(m.group().replace("<", "&lt;").replace(">", "&gt;"));
		}

        return content;
    }

	private static interface Patterns {
        public static final Pattern SCRIPTS = Pattern.compile("&lt;(no)?script[^>]*>.*?</(no)?script>", Pattern.DOTALL);

        public static final Pattern STYLE = Pattern.compile("&lt;style[^>]*>.*</style>", Pattern.DOTALL);

        public static final Pattern TAGS = Pattern.compile("&lt;(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");

        public static final Pattern TAGS2 = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");

        @SuppressWarnings("unused")
				public static final Pattern nTAGS = Pattern.compile("&lt;\\w+\\s+[^<]*\\s*>");

        public static final Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");

        public static final Pattern WHITESPACE = Pattern.compile("\\s\\s+");

        public static final Pattern STARTTAGS = Pattern.compile("<(?i)(iframe)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>");

        public static final Pattern ENDTAGS = Pattern.compile("<(/)?(?i)(iframe)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>");
    }

	/**
	 * 한글인 지확인하는 메서드
	 * @param name
	 * @return
	 */
	public static boolean isHangul(String name){
		boolean isHangul = true;
		int len = name.length();
	    for (int i = 0; i < len; i++)  {
	    	if (name.charAt(i) != 32 && (name.charAt(i) < 44032 || name.charAt(i) > 55203)){
	    		isHangul = false;
	    		break;
	    	}
	    }

	    return isHangul;
	}

	/**
	 * 난수를 발생시켜 ID를 생성한다.
	 * 중복 검사는 하지 않는다.
	 * 1:무자혼합 2:숫자로 생성
	 * @return 세션ID
	 */
	public static String createRandamId( int length, String type ) {

		Random random = new Random( new Date().getTime() );
		StringBuffer sb = new StringBuffer();


		if("2".equals(type)){
			for ( int i = 0; i < length; i++ ) {
				int r = random.nextInt( 64 )%10;

				sb.append( (char) ( '0' + r ) );


			}
		}else{
			for ( int i = 0; i < length; i++ ) {
				int r = random.nextInt( 64 );

				if ( r >= 0 && r <= 9 )
					sb.append( (char) ( '0' + r ) );
				else if ( r >= 10 && r <= 35 )
					sb.append( (char) ( 'A' + ( r - 10 ) ) );
				else if ( r >= 36 && r <= 61 )
					sb.append( (char) ( 'a' + ( r - 36 ) ) );
				else if ( r == 62 )
					sb.append( '-' );
				else
					sb.append( '_' );
			}
		}

		return sb.toString();
	}

	/**
	 * 정상 전화번호 확인 메서드
	 * @param name
	 * @return
	 */
	public static boolean isTelNumber(String tel){

		if(isNull(tel)) return false;
		String telTemp = tel.replaceAll("-", "").trim();
		int len = telTemp.length();
		if(len < 10 || len > 11) return false;

		try{
			Long.parseLong(telTemp);
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * 정상 전화번호 확인 메서드
	 * @param name
	 * @return
	 */
	public static boolean isPhoneNumber(String tel){

		if(isNull(tel)) return false;

		boolean result = true;

		String telTemp = tel.replaceAll("-", "").trim();
		if (!telTemp.startsWith("01")) result = false;
		int len = telTemp.length();
		if(len < 10 || len > 11) result = false;

		try{
			Long.parseLong(telTemp);
		}catch(Exception e){
			e.printStackTrace();
			result = false;
		}

		if (!tel.startsWith("0")) {
			tel = "0" + tel;
		}

		telTemp = tel.replaceAll("-", "").trim();
		len = telTemp.length();
		if (!telTemp.startsWith("01")) result = false;
		if(len < 10 || len > 11) result = false;
		try{
			Long.parseLong(telTemp);
		}catch(Exception e){
			e.printStackTrace();
			result = false;
		}

		return result;
	}

	/**
	 * 정상 전화번호 확인 메서드
	 * @param name
	 * @return
	 */
	public static String getPhoneNumber(String tel){

		if(isNull(tel)) return "";

		boolean result = true;

		String telTemp = tel.replaceAll("-", "").trim();
		int len = telTemp.length();
		if(len < 10 || len > 11) result = false;

		try{
			Long.parseLong(telTemp);
		}catch(Exception e){
			e.printStackTrace();
			result = false;
		}

		if (!tel.startsWith("0")) {
			tel = "0" + tel;
		}

		telTemp = tel.replaceAll("-", "").trim();
		len = telTemp.length();
		if(len < 10 || len > 11) result = false;

		try{
			Long.parseLong(telTemp);
		}catch(Exception e){
			e.printStackTrace();
			result = false;
		}

		if (result) {
			return tel;
		} else {
			return "";
		}
	}


	/**
	 * 날자간  일자 리턴
	 * @param from
	 * @param to
	 * @return
	 * @throws java.text.ParseException
	 */
	public static int daysBetween(Date from, Date to) {
        Date d1 = from;
        Date d2 = to;

        long duration = d2.getTime() - d1.getTime();

        return (int)( duration/(1000 * 60 * 60 * 24) );
        // seconds in 1 day
    }


	public static String LocalString( String val)
	 {

	  if (val == null)
	   return null;
	  else {
	   byte[] b;

	   try {
	    b = val.getBytes("8859_1");
	    CharsetDecoder decoder = Charset.forName("UTF-8").newDecoder();
	    try {
	     CharBuffer r = decoder.decode( ByteBuffer.wrap( b));
	     return r.toString();
	    } catch (CharacterCodingException e) {
	     return new String( b, "EUC-KR");
	    }
	   } catch (UnsupportedEncodingException e1) {
	    e1.printStackTrace();
	   }
	  } return null;
	 }

	/**
	 * 오늘 날짜 하기
	 * @return
	 */
	public static String Todate(String checkVal){
		String nowDate = null;
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
		Date currentTime = new Date ( );
		String dTime = formatter.format ( currentTime );
		if(checkVal.equals("first")){
			nowDate = dTime.substring(0, 8) + "01";
			return nowDate;
		}else{
			return dTime;
		}
	}

	public static String valueLanfill(int value,int len){
		String strVal = Integer.toString(value);
		@SuppressWarnings("unused")
		int fillVal = 0;
		String fillvalue = "";
		fillVal = len - strVal.length();
		for(int i=0;i<len;i++){
			if(fillvalue.length() < len-1){
				fillvalue += "0";
			}
		}

		return fillvalue+strVal;
	}

	/**
	 * 길이 만큼 문자를 채워줌
	 * @param str
	 * @param fill
	 * @param len
	 * @return
	 */
	public static String wordToFill(String str,String fill,int len){
		String fullWord="";
		for(int i=0;i<len-str.length();i++){
			fullWord += fill;
		}
		return fullWord+str;
	}

	public static boolean hasKorean(String suspect) {
		if(suspect != null && !suspect.equals("")){
			for (int i = 0; i < suspect.length(); i++) {

				char c = suspect.charAt(i);

				// 한글이 있는지 체크
				if ((0xAC00 <= c && c <= 0xD7A3) || (0x3131 <= c && c <= 0x318E)) {
					return true;
				}
				//영어가 있는지 체크
				else if ((0x61 <= c && c <= 0x7A) || (0x41 <= c && c <= 0x5A)) {
					// english
				}
				//숫자가 있는지 체크
				else if (0x30 <= c && c <= 0x39) {
					// integer/decimal
				} else {
					// unknown
				}
			}
		}
		return false;
	}

	/**
	 * Date형을 String형으로 변환 (Date,format)
	 * @param date
	 * @param forMat
	 * @return
	 */
	public static String dateToString(Date date,String format){
		DateFormat formating = new SimpleDateFormat(format);
		String dateString = formating.format(date);
		return dateString;
	}

	/**
	 * 문자형 NULL 또는 공백일경우 true리턴
	 * 정수형 NULL 또는 0 일경우 true 리턴
	 * @param str
	 * @return
	 */
	public static boolean nullCheck(Object obj){
		boolean checkBoolean = true;
		if(obj != null){
			String type = obj.getClass().getName();
			if("String".equals(type.substring(type.indexOf(".",5)+1))){
				if("".equals(obj.toString())){
					checkBoolean = true;
				}else{
					checkBoolean = false;
				}
			}else if("Integer".equals(type.substring(type.indexOf(".",5)+1))){
				if(	(Integer)obj == 0){
					checkBoolean = true;
				}else{
					checkBoolean = false;
				}
			}
		}
		return checkBoolean;
	}
}