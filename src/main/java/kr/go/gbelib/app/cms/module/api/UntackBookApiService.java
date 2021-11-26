package kr.go.gbelib.app.cms.module.api;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservation;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservationService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class UntackBookApiService extends BaseService {

    @Autowired
    private UntactBookReservationService service;

    public Map<String, Object> getData(UntactBookReservation untackBookReservation, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new LinkedHashMap<String, Object>();

        String success_yn = "N"; // Y 성공 N 실패
        String msg = "";

        if(!StringUtils.isEmpty(untackBookReservation.getHomepage_id()) && untackBookReservation.getLocker_number() > 0 && untackBookReservation.getLocker_password() > 0) {
            if(service.getLockerPasswordCheckCount(untackBookReservation) > 0) {
                success_yn = "Y";
                msg = "성공";
            } else {
                success_yn = "N";
                msg = "사물함 비밀번호가 맞지 않습니다.";
            }
        } else {
            success_yn = "N";
            msg = "잘못된 homepage_id,locker_number,locker_password 파라미터";
        }

        map.put("success_yn", success_yn);
        map.put("msg", msg);

        return map;
    }
}
