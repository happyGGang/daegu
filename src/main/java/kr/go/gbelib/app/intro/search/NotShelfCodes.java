package kr.go.gbelib.app.intro.search;

import java.util.Arrays;
import java.util.stream.Collectors;

public enum NotShelfCodes {
    AB08, AB09, AB10, AB38, BW06, BW08, BW11, BW12, BW16, BW18,
    BW19, BW20, BW21, BW22, BW23, BW24, BW25, BW26, AH17, CB17,
    FM05, GU04, FP05, GX05, GR06, GW03, AB39, AE59, AF51, AF52,
    GR02, GR03, GR04, GS02, GS03, GT02, GT03, FP02, FP03, FP04,
    GW01, GU02, GU03, GV02, GV03, FL02, FL03, FL04, FM02, FM03,
    FM04, GY02, GY03, GX02, GX03, GX04, FG08;

    public static String getNotShelfCode() {
        return Arrays.stream(NotShelfCodes.values())
                     .map(Enum::name)
                     .collect(Collectors.joining(","));
    }

}
