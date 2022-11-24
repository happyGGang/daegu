package kr.go.gbelib.app.common.api;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CultureAPI {
    protected final static Logger log = LoggerFactory.getLogger(CultureAPI.class);

    /*
    * 지역별공연/전시목록조회
    * */
    public static Map<String, Object> areaRequest(Map<String, Object> parameter) {

        parameter.put("sido", "대구");        // 시 / 도

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        Calendar calendar = Calendar.getInstance();
        //현재 날짜로 설정
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);

        //현재 달의 시작일과 마지막일 구하기
        int start = calendar.getActualMinimum(Calendar.DAY_OF_MONTH);
        int end = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

        calendar.set(year, month, start);
        String startdate =  dateFormat.format(calendar.getTime());
        parameter.put("from", startdate);   // 시작기간
        calendar.set(year, month, end);
        String enddate = dateFormat.format(calendar.getTime());
        parameter.put("to", enddate);   // 종료기간

        parameter.put("sortStdr", "1"); //  등록일, 공연명, 지역

        return CommonAPI.sendCULTURE(parameter, "publicperformancedisplays/area");
    }

    /*
     * 지역별공연/전시 상세보기
     * */
    public static List<Map<String, Object>> areaRequestDetails(Map<String, Object> parameter, Map<String, Object> result) {

        System.out.println(result);

        Map<String, Object> msgBody = (Map<String, Object>) result.get("msgBody");

        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

        if (msgBody != null) {
            List<Map<String, Object>> perforList = new ArrayList<Map<String, Object>>();

            if ((Integer) msgBody.get("totalCount") > 0) {
                if ((Integer) msgBody.get("totalCount") == 1) {
                    perforList.add((Map<String, Object>) msgBody.get("perforList"));
                } else {
                    perforList = (List<Map<String, Object>>) msgBody.get("perforList");
                }

                if (perforList.size() > 0) {
                    for (Map<String, Object> map : perforList) {

                        parameter.put("seq", map.get("seq"));

                        Map<String, Object> detaile = (Map<String, Object>) CommonAPI.sendCULTURE(parameter, "publicperformancedisplays/d/").get("msgBody");
                        if ((Map<String, Object>) detaile.get("perforInfo") != null) {
                            detaile = (Map<String, Object>) detaile.get("perforInfo");
                        }

                        list.add(detaile);
                    }
                }
            }
        }

        return list;
    }

}