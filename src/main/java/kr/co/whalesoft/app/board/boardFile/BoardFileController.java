package kr.co.whalesoft.app.board.boardFile;

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
@RequestMapping(value = {"/board/boardFile"})
public class BoardFileController extends BaseController {

	@Autowired
	private BoardFileService service;

	/**
	 * Request 요청이 익스플로어에서 컨텐츠 타입이 flash로 들어와 json 으로 맵핑이 되지 않아서 @ResponseBody 사용 안함
	 * @param mpRequest
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/upload.*", method = RequestMethod.POST)
	public void upload(MultipartHttpServletRequest mpRequest, HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/x-json;  charset=UTF-8");

		MultipartFile mfile = mpRequest.getFileMap().get("multiFile");
		
		BoardFile boardFile = service.upload(mfile, request);

		PrintWriter out = response.getWriter();

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String jsonOutput = gson.toJson(boardFile);
		
		out.println(jsonOutput);
		out.flush();
		out.close();
	}

	@RequestMapping(value = "/download/{manage_idx}/{board_idx}/{file_idx}.*", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<byte[]> getFile(@PathVariable("manage_idx") int manage_idx, @PathVariable("board_idx") int board_idx, @PathVariable("file_idx") int file_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardFile boardFile = service.getBoardFileOne(new BoardFile(board_idx, file_idx));

		HttpHeaders responseHeaders = new HttpHeaders();

		if (boardFile == null) {
			responseHeaders.setContentType(MediaType.valueOf("text/html"));
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}
		String filePath;
		if(manage_idx == 1008) {
			String replace = boardFile.getServer_file_name().replace(".jpg", ".pdf");
			filePath = service.getFilePath() + "/" + manage_idx + "/" + board_idx + "/" + replace;
		}else {
			filePath = service.getFilePath() + "/" + manage_idx + "/" + board_idx + "/" + boardFile.getServer_file_name();
		}

		File file = new File(filePath);
		byte[] bytes = null;

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			responseHeaders.setContentType(MediaType.valueOf("text/html"));
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

		service.addBoardFileCount(boardFile);

		String fileName = boardFile.getOrg_file_name().substring(0,boardFile.getOrg_file_name().lastIndexOf("."));
		String fileType = boardFile.getOrg_file_name().substring(boardFile.getOrg_file_name().lastIndexOf(".")+1);
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

	@RequestMapping(value = "/download/{manage_idx}/{board_idx}/{file_idx}/{org_file_name}.*", method = RequestMethod.GET)
	@ResponseBody
    public ResponseEntity<byte[]> getFileName(@PathVariable("manage_idx") int manage_idx, @PathVariable("board_idx") int board_idx, @PathVariable("file_idx") int file_idx, @PathVariable("org_file_name") String org_file_name, HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardFile boardFile = service.getBoardFileOne(new BoardFile(board_idx, file_idx));

		HttpHeaders responseHeaders = new HttpHeaders();

		if (boardFile == null) {
			responseHeaders.setContentType(MediaType.valueOf("text/html"));
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}
		String filePath;
		if(manage_idx == 1008) {
			String replace = boardFile.getServer_file_name().replace(".jpg", ".pdf");
			filePath = service.getFilePath() + "/" + manage_idx + "/" + board_idx + "/" + replace;
		}else {
			filePath = service.getFilePath() + "/" + manage_idx + "/" + board_idx + "/" + boardFile.getServer_file_name();
		}

		File file = new File(filePath);
		byte[] bytes = null;

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			responseHeaders.setContentType(MediaType.valueOf("text/html"));
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

		service.addBoardFileCount(boardFile);

		String fileName = boardFile.getOrg_file_name().substring(0,boardFile.getOrg_file_name().lastIndexOf("."));
		String fileType = boardFile.getOrg_file_name().substring(boardFile.getOrg_file_name().lastIndexOf(".")+1);
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
	public @ResponseBody JsonResponse deleteFile(BoardFile boardFile, BindingResult result, HttpServletRequest request) throws IOException {

		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			service.deleteFile(boardFile, request);
			
			res.setValid(true);
			res.setData(boardFile.getFile_list_seq());
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}