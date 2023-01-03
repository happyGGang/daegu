package kr.co.whalesoft.app.homepage.index;

import java.text.NumberFormat;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import org.springframework.util.StopWatch;

public class GyeongStopWatch extends StopWatch {

    @Override
    public String shortSummary() {
        String id = "서구 도서관 StopWatch";
        return "StopWatch '" + id + "': running time (millis) = " + getTotalTimeMillis();
    }

    @Override
    public String prettyPrint() {
        StringBuilder sb = new StringBuilder(shortSummary());
        sb.append('\n');
            sb.append("-----------------------------------------\n");
            sb.append("s     %     Task name\n");
            sb.append("-----------------------------------------\n");
            NumberFormat nf = NumberFormat.getNumberInstance();
            nf.setMinimumIntegerDigits(5);
            nf.setGroupingUsed(false);
            NumberFormat pf = NumberFormat.getPercentInstance();
            pf.setMinimumIntegerDigits(3);
            pf.setGroupingUsed(false);

        List<TaskInfo> taskInfos = Arrays.asList(getTaskInfo());
        Collections.sort(taskInfos, new Comparator<TaskInfo>() {
            @Override
            public int compare(TaskInfo o1, TaskInfo o2) {
                return (int) (o2.getTimeMillis() - o1.getTimeMillis());
            }
        });

//        Collections.sort(taskInfos, (o1, o2) -> (int) (o2.getTimeMillis() - o1.getTimeMillis()));

        for (TaskInfo task :taskInfos) {
                //secode로 바꾸기
                double seconds = (double) task.getTimeMillis() / 1000;
                sb.append(String.format("%.2f", seconds)).append("  ");
                sb.append(pf.format(task.getTimeSeconds() / getTotalTimeSeconds())).append("  ");
                sb.append(task.getTaskName()).append("\n");
            }
        return sb.toString();
    }
}
