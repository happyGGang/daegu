package kr.go.gbelib.app.cms.module.sttAIBook;

import com.google.cloud.speech.v1.RecognitionAudio;
import com.google.cloud.speech.v1.RecognitionConfig;
import com.google.cloud.speech.v1.RecognizeResponse;
import com.google.cloud.speech.v1.SpeechClient;
import com.google.cloud.speech.v1.SpeechRecognitionAlternative;
import com.google.cloud.speech.v1.SpeechRecognitionResult;
import com.google.protobuf.ByteString;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import net.bramp.ffmpeg.FFmpeg;
import net.bramp.ffmpeg.FFmpegExecutor;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.builder.FFmpegBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping(value = {"/stt", "/{homepagePath}/stt"})
public class SttController extends BaseController {

    @RequestMapping(value = {"/sttGoogleTest.*"}, method = RequestMethod.GET)
    public String sttTest(Model model, Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");

        String referer = request.getHeader("referer");
        request.getSession().setAttribute("boardCertReferer", referer);

        String basePath = "";
        String homepageFolder = "";

        if(homepage != null) {
            homepageFolder = "/homepage/" + homepage.getFolder();
        }

        basePath = homepageFolder + "/board/common/";
        model.addAttribute("board", board);
        return basePath + "sttGoogleTest";

    }

    @RequestMapping(value = {"/sttGooGleTestUpload.*"}, method = RequestMethod.POST)
    public @ResponseBody TranscriptionResponse handleFileUpload(@RequestParam("audio") MultipartFile file) throws IOException {
        // 업로드한 파일을 임시 위치에 저장
        File tempFile = File.createTempFile("uploaded", ".wav");
        file.transferTo(tempFile);

        // FFmpeg를 사용하여 파일을 16000Hz로 변환
        File convertedFile = File.createTempFile("converted", ".wav");
        String ffmpegPath = "ffmpeg";  // FFmpeg가 PATH에 등록되어 있어야 함

        FFmpeg ffmpeg = new FFmpeg(ffmpegPath);
        FFprobe ffprobe = new FFprobe(ffmpegPath.replace("ffmpeg", "ffprobe"));

        FFmpegBuilder builder = new FFmpegBuilder()
            .setInput(tempFile.getAbsolutePath())
            .addOutput(convertedFile.getAbsolutePath())
            .setAudioCodec("pcm_s16le")
            .setAudioSampleRate(16000)
            .addExtraArgs("-af", "highpass=f=200, lowpass=f=3000, volume=volume=1.5") // 노이즈 제거 및 음량 조절 필터
            .done();

        FFmpegExecutor executor = new FFmpegExecutor(ffmpeg, ffprobe);
        executor.createJob(builder).run();

        byte[] bytes = Files.readAllBytes(convertedFile.toPath());
        ByteString audioBytes = ByteString.copyFrom(bytes);
        System.out.println("Received file with size: " + bytes.length + " bytes");

        try (SpeechClient speechClient = SpeechClient.create()) {
            RecognitionConfig config = RecognitionConfig.newBuilder()
                                                        .setEncoding(RecognitionConfig.AudioEncoding.LINEAR16)
                                                        .setSampleRateHertz(16000)
                                                        .setLanguageCode("ko-KR")
                                                        .setUseEnhanced(true) // 고급 모델 사용
                                                        .build();

            RecognitionAudio audio = RecognitionAudio.newBuilder()
                                                     .setContent(audioBytes)
                                                     .build();

            RecognizeResponse response = speechClient.recognize(config, audio);
            StringBuilder transcription = new StringBuilder();
            for (SpeechRecognitionResult result : response.getResultsList()) {
                for (SpeechRecognitionAlternative alternative : result.getAlternativesList()) {
                    transcription.append(alternative.getTranscript());
                }
            }

            return new TranscriptionResponse(transcription.toString());
        } catch (Exception e) {
            e.printStackTrace();
            return new TranscriptionResponse("Error occurred: " + e.getMessage());
        } finally {
            tempFile.delete();
            convertedFile.delete();
        }
    }
}

