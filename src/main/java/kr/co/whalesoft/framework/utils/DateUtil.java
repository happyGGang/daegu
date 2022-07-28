package kr.co.whalesoft.framework.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {


    public static String dashFormat(String nonDash) throws ParseException {
        SimpleDateFormat beforeDateFormat = new SimpleDateFormat("yyyyMMdd");
        Date date = beforeDateFormat.parse(nonDash);

        SimpleDateFormat afterDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return afterDateFormat.format(date);
    }


    /**
     * 날짜 1일 추가
     */
    public static String addDateOneDay(String request_date) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        Calendar calendar = Calendar.getInstance();
        Date date = dateFormat.parse(request_date);

        calendar.setTime(date);
        calendar.add(Calendar.DATE, 1);

        return dateFormat.format(calendar.getTime());
    }
}
