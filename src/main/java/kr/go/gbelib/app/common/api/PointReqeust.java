package kr.go.gbelib.app.common.api;

import java.util.Map;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class PointReqeust extends PagingUtils {
    private String apiKey; // 제휴사 포인트 플랫폼 가입시 발급된 api key값
    private String user_id; // 적립/차감할 회원 아이디
    private String rule_code; // 제휴업체 룰에서 사용할 포인트 룰 코드값
    private String rule_point; // 제휴업체 포인트 룰에서 부여 포인트 0일 경우, 관리자가 부여할 포인트 정보 기술
    private String rule_desc; // 포인트 적립시 추가로 관리자가 부여할 내용
    private String record_type; // 포인트 조회내역의 구분(B-업체, U-사용자)
    private String type_code; // 조회할 정책 유형형 (A-적립, M-차감, B-보너스, P-패널티 차감, E-이벤트, C-환전)
    private String start_date; // 조회 시작일
    private String end_date; // 조회 종료일
    private int pageNo = 10; // 페이지번호(10개씩 반환) 디폴트 10

    public PointReqeust () {}

    private PointReqeust (String apiKey) {
        this.apiKey = apiKey;
    }

    public static PointReqeust formApikey (String apiKey) {
        return new PointReqeust(apiKey);
    }

    public String getApiKey() {
        return apiKey;
    }

    public void setApiKey(String apiKey) {
        this.apiKey = apiKey;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getRule_code() {
        return rule_code;
    }

    public void setRule_code(String rule_code) {
        this.rule_code = rule_code;
    }

    public String getRule_point() {
        return rule_point;
    }

    public void setRule_point(String rule_point) {
        this.rule_point = rule_point;
    }

    public String getRule_desc() {
        return rule_desc;
    }

    public void setRule_desc(String rule_desc) {
        this.rule_desc = rule_desc;
    }

    public String getRecord_type() {
        return record_type;
    }

    public void setRecord_type(String record_type) {
        this.record_type = record_type;
    }

    public String getType_code() {
        return type_code;
    }

    public void setType_code(String type_code) {
        this.type_code = type_code;
    }

    public String getStart_date() {
        return start_date;
    }

    public void setStart_date(String start_date) {
        this.start_date = start_date;
    }

    public String getEnd_date() {
        return end_date;
    }

    public void setEnd_date(String end_date) {
        this.end_date = end_date;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }
}
