package kr.go.gbelib.app.intro.search;

import java.util.Arrays;
import java.util.stream.Collectors;

public enum NearByNotShelfCodes {

    AA02, AA03, AA05, AA07, AA09, AA10, AA11, AA14, AA15, AA16,
    AA17, AA18, AA19, AA20, AA21, AA22, AA23, AA29, AA30, AA31,
    AA36, AA37, AA39, AA40, AA41, AA51, AA52, AA53, AA56, AA58,
    AA59, AA60, AA62, AA65, AA66, BA08, CA08, CB08, CB10, BA23,
    BA22, CB11, FM05, GU04, FP05, GX05, GR06, GW03, CA18,

    //동부도서관 임시자료실 AH64제외 전체
    AH01, AH02, AH03, AH04, AH05, AH06, AH07, AH08, AH09, AH10,
    AH11, AH12, AH13, AH14, AH15, AH16, AH17, AH18, AH19, AH20,
    AH21, AH22, AH23, AH24, AH25, AH26, AH27, AH28, AH29, AH30,
    AH31, AH33, AH35, AH36, AH37, AH38, AH39, AH40, AH41, AH42,
    AH43, AH44, AH45, AH46, AH47, AH48, AH49, AH50, AH51, AH52,
    AH53, AH54, AH55, AH56, AH57, AH58, AH59, AH60, AH61, AH62,
    AH63;


    public static String getNearByNotShelfCodes() {
        return Arrays.stream(NearByNotShelfCodes.values())
                     .map(Enum::name)
                     .collect(Collectors.joining(","));
    }
}


