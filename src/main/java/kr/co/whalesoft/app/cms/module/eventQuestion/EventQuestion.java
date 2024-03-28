package kr.co.whalesoft.app.cms.module.eventQuestion;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class EventQuestion extends PagingUtils {
    
    private int event_idx;  //이벤트IDX
    private int event_question_idx;  //이벤트문항IDX
    private String event_question_title;  //이벤트문항제목
    private String event_question_type;  //이벤트문항타입
    private String event_question_item;  //이벤트문항보기
    private String event_question_answer;  //정답

    public EventQuestion() { }

    public EventQuestion(String homepage_id, int event_idx) {
        setHomepage_id(homepage_id);
        this.event_idx = event_idx;
    }

    public int getEvent_idx() {
        return event_idx;
    }

    public void setEvent_idx(int event_idx) {
        this.event_idx = event_idx;
    }

    public int getEvent_question_idx() {
        return event_question_idx;
    }

    public void setEvent_question_idx(int event_question_idx) {
        this.event_question_idx = event_question_idx;
    }

    public String getEvent_question_title() {
        return event_question_title;
    }

    public void setEvent_question_title(String event_question_title) {
        this.event_question_title = event_question_title;
    }

    public String getEvent_question_type() {
        return event_question_type;
    }

    public void setEvent_question_type(String event_question_type) {
        this.event_question_type = event_question_type;
    }

    public String getEvent_question_item() {
        return event_question_item;
    }

    public void setEvent_question_item(String event_question_item) {
        this.event_question_item = event_question_item;
    }

    public String getEvent_question_answer() {
        return event_question_answer;
    }

    public void setEvent_question_answer(String event_question_answer) {
        this.event_question_answer = event_question_answer;
    }
}

