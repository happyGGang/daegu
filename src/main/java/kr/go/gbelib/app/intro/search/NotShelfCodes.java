package kr.go.gbelib.app.intro.search;

import java.util.Arrays;
import java.util.stream.Collectors;

public enum NotShelfCodes {
  AB08, AB09, AB10, AB38, BW06, BW08, BW11, BW12, BW16, BW18,
  BW19, BW20, BW21, BW22, BW23, BW24, BW25, BW26, CB17, FG08,
  FM05, GU04, FP05, GX05, GR06, GW03, AB39, AE59, AF51, AF52,
  GR02, GR03, GR04, GS02, GS03, GT02, GT03, FP02, FP03, FP04,
  GW01, GU02, GU03, GV02, GV03, FL02, FL03, FL04, FM02, FM03,
  FM04, GY02, GY03, GX02, GX03, GX04,

  //동구립 검색대
  CB05, CB06,

  //동부도서관 = AH64(임시자료실 제외 모든 자료실 검색 노출 제거)
  AH01, AH02, AH03, AH04, AH05,
  AH06, AH07, AH08, AH09, AH10,
  AH11, AH12, AH13, AH14, AH15,
  AH16, AH17, AH18, AH19, AH20,
  AH21, AH22, AH23, AH24, AH25,
  AH26, AH27, AH28, AH29, AH30,
  AH31, AH33, AH35, AH36, AH37,
  AH38, AH39, AH40, AH41, AH42,
  AH43, AH44, AH45, AH46, AH47,
  AH48, AH49, AH50, AH51, AH52,
  AH53, AH54, AH55, AH56, AH57,
  AH58, AH59, AH60, AH61, AH62,
  AH63;

  public static String getNotShelfCode() {
    return Arrays.stream(NotShelfCodes.values())
        .map(Enum::name)
        .collect(Collectors.joining(","));
  }

}
