package kr.go.gbelib.app.cms.module.teach.student;

import java.util.Arrays;

public enum StudentHack {
    GRADE1(1, "초등 1학년"),
    GRADE2(2, "초등 2학년"),
    GRADE3(3, "초등 3학년"),
    GRADE4(4, "초등 4학년"),
    GRADE5(5, "초등 5학년"),
    GRADE6(6, "초등 6학년"),
    GRADE7(7, "중등 1학년"),
    GRADE8(8, "중등 2학년"),
    GRADE9(9, "중등 3학년"),
    GRADE10(10, "고등 1학년"),
    GRADE11(11, "고등 2학년"),
    GRADE12(12, "고등 3학년");

    private final int value;
    private final String description;

    StudentHack(int value, String description) {
        this.value = value;
        this.description = description;
    }

    public static String getDescriptionByValue(int value) {
        return Arrays.stream(values())
                     .filter(hack -> hack.value == value)
                     .findFirst()
                     .map(hack -> hack.description)
                     .orElse("해당 학년이 없습니다.");
    }
}
