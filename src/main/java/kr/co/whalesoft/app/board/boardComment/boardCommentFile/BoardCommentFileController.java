package kr.co.whalesoft.app.board.boardComment.boardCommentFile;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/boardComment/boardCommentFile"})
public class BoardCommentFileController extends BaseController {

	@Autowired
	private BoardCommentFileService service;

	@RequestMapping(value="/upload.*", method = RequestMethod.POST)
	public void upload(MultipartHttpServletRequest mpRequest, HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/x-json;  charset=UTF-8");

		MultipartFile mfile = mpRequest.getFileMap().get("multiFile");

		BoardCommentFile boardCommentFile = service.upload(mfile, request);

		PrintWriter out = response.getWriter();

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String jsonOutput = gson.toJson(boardCommentFile);

		out.println(jsonOutput);
		out.flush();
		out.close();
	}


	@RequestMapping(value = "/download/{manage_idx}/{comment_idx}/{comment_file_idx}.*", method = RequestMethod.GET)
	@ResponseBody
    public ResponseEntity<byte[]> getFile(@PathVariable("manage_idx") int manage_idx, @PathVariable("comment_idx") int comment_idx, @PathVariable("comment_file_idx") int comment_file_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardCommentFile boardFile = service.getBoardCommentFileOne(new BoardCommentFile(comment_idx, comment_file_idx));

		HttpHeaders responseHeaders = new HttpHeaders();

		if (boardFile == null) {
			responseHeaders.setContentType(MediaType.valueOf("text/html"));
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}
		String filePath = service.getFilePath() + "/" + manage_idx + "/" + comment_idx + "/" + boardFile.getReal_file_name();
		File file = new File(filePath);

		byte[] bytes = null;

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			responseHeaders.setContentType(MediaType.valueOf("text/html"));
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

		service.addBoardCommentFileCount(boardFile);

		String fileName = boardFile.getFile_name().substring(0,boardFile.getFile_name().lastIndexOf("."));
		String fileType = boardFile.getFile_name().substring(boardFile.getFile_name().lastIndexOf(".")+1).toUpperCase();
		String fullFilename = fileName+"."+fileType;

		//responseHeaders.set("charset", "utf-8");
		responseHeaders.set("Content-Disposition", AttachmentUtils.getContentDisposition(fullFilename, request.getHeader("user-agent")));
		responseHeaders.setPragma("no-cache;");
		responseHeaders.setExpires(-1);
//		responseHeaders.setContentLength(file.length());
		responseHeaders.setContentType(MediaType.valueOf(AttachmentUtils.getContentType(fileType)));
		responseHeaders.setContentLength(bytes.length);

	    return new ResponseEntity<byte[]>(bytes, responseHeaders, HttpStatus.OK);
    }

	@RequestMapping(value = { "/deleteFile.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteFile(BoardCommentFile boardCommentFile, BindingResult result, HttpServletRequest request) throws IOException {

		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		/* <<<<< 유효성 검증 */
		if (!result.hasErrors()) {
			service.deleteFile(boardCommentFile, request);

			res.setValid(true);
			res.setData(boardCommentFile.getFile_list_seq());
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
