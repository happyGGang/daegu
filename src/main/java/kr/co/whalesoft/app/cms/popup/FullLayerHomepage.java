package kr.co.whalesoft.app.cms.popup;

import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

public enum FullLayerHomepage {
    H1("h1"),  //228
    H3("h3"),  //남부
    H4("h4"), //달성
    H5("h5"), //동부
    H6("h6"), //두류
    H7("h7"), //북부
    H8("h8"), //서부
    H9("h9"); //수성

    private final String code;

    FullLayerHomepage(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }

    private static final Set<String> excludedCodes = Arrays.stream(values())
        .map(FullLayerHomepage::getCode)
        .collect(Collectors.toSet());

    public static boolean isExcluded(String homepageId) {
        return excludedCodes.contains(homepageId);
    }
}
