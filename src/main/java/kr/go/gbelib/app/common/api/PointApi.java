package kr.go.gbelib.app.common.api;

import com.drew.lang.StringUtil;
import java.util.HashMap;
import java.util.Map;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PointApi {
    protected final static Logger log = LoggerFactory.getLogger(PointApi.class);

    // 제휴업체의 포인트 플렛폼 상태 및 포인트 계약조건 조회
    public static Map<String,Object> info ( PointReqeust reqeust) {
        Map<String, Object> parameter = new HashMap<String, Object>();

        parameter.put("apiKey", reqeust.getApiKey()); // 제휴사 포인트 플랫폼 가입시 발급된 api key값 (필수)

        return CommonAPI.sendPOINT("/biz/info" ,parameter);
    }

    // 제휴업체 및 도서관별 플랫폼 룰 설정 리스트 조회
    public static Map<String, Object> rule(PointReqeust reqeust) {
        Map<String, Object> parameter = new HashMap<String, Object>();

        parameter.put("apiKey", reqeust.getApiKey()); // 제휴사 포인트 플랫폼 가입시 발급된 api key값 (필수)

        return CommonAPI.sendPOINT("/biz/rule", parameter);
    }

    // 제휴업체 회원 포인트 적립/차감 기능
    public static Map<String, Object> proc(PointReqeust reqeust) {
        Map<String, Object> parameter = new HashMap<String, Object>();

        parameter.put("apiKey", reqeust.getApiKey()); // 제휴사 포인트 플랫폼 가입시 발급된 api key값 (필수)
        parameter.put("user_id", reqeust.getUser_id()); // 적립/차감할 회원 아이디 (필수)
        parameter.put("rule_code", reqeust.getRule_code()); // 제휴업체 룰에서 사용할 포인트 룰 코드값 (필수)
        if (StringUtils.isNotEmpty(reqeust.getRule_point())) {
            parameter.put("rule_point", reqeust.getRule_point()); // 제휴업체 포인트 룰에서 부여 포인트 0일 경우, 관리자가 부여할 포인트 정보 기술
        }
        if (StringUtils.isNotEmpty(reqeust.getRule_desc())) {
            parameter.put("rule_desc", reqeust.getRule_desc()); // 포인트 적립시 추가로 관리자가 부여할 내용
        }

        return CommonAPI.sendPOINT("/point/proc", parameter);
    }

    // 제휴업체 회원 포인트 적립/차감 조회 기능
    public static Map<String, Object> record(PointReqeust reqeust) {
        Map<String, Object> parameter = new HashMap<String, Object>();

        if (StringUtils.isNotEmpty(reqeust.getApiKey())) {
            parameter.put("apiKey", reqeust.getApiKey()); // 제휴사 포인트 플랫폼 가입시 발급된 api key값
        }

        if (StringUtils.isNotEmpty(reqeust.getRecord_type())) {
            parameter.put("record_type", reqeust.getRecord_type()); // 포인트 조회내역의 구분(B-업체, U-사용자)
        }

        if (StringUtils.isNotEmpty(reqeust.getUser_id())) {
            parameter.put("user_id", reqeust.getUser_id()); // 적립/차감할 회원 아이디
        }
        if (StringUtils.isNotEmpty(reqeust.getRule_code())) {
            parameter.put("rule_code", reqeust.getRule_code()); // 제휴업체 룰에서 사용할 포인트 룰 코드값
        }
        if (StringUtils.isNotEmpty(reqeust.getType_code())) {
            parameter.put("type_code", reqeust.getType_code()); // 조회할 정책 유형형 (A-적립, M-차감, B-보너스, P-패널티 차감, E-이벤트, C-환전)
        }
        if (StringUtils.isNotEmpty(reqeust.getStart_date())) {
            parameter.put("start_date", reqeust.getStart_date()); // 조회 시작일
        }
        if (StringUtils.isNotEmpty(reqeust.getEnd_date())) {
            parameter.put("end_date", reqeust.getEnd_date()); // 조회 종료일
        }

        parameter.put("pageNo", reqeust.getPageNo()); // 페이지번호(10개씩 반환)

        return CommonAPI.sendPOINT("/point/record", parameter);
    }
}

