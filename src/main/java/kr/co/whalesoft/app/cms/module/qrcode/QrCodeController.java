package kr.co.whalesoft.app.cms.module.qrcode;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import kr.co.whalesoft.framework.utils.AttachmentUtils;

@Controller
@RequestMapping(value = { "/cms/module/qrcode" })
public class QrCodeController { 

	private String basePath = "/cms/module/qrcode/";

	/*public ModelAndView index(QRCode qrcode,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("/test/QRTest.jsp");
		mv.addObject("qrcode",qrcode);
		return mv;
	}*/

	@RequestMapping(value = { "/qrcode.*" })
	public String qrCode(Model model, QRCode qrcode,HttpServletRequest request,HttpServletResponse response) throws Exception{
		qrcode.setExtension("jpg");
		qrcode.setWidth(235);
		model.addAttribute("qrcode",qrcode);
		return basePath + "qrcode";
	}

	@RequestMapping(value = { "/qrcodeA.*" })
	public String qrCodeA(Model model, QRCode qrcode,HttpServletRequest request,HttpServletResponse response) throws Exception{
		model.addAttribute("qrcode",qrcode);
		return basePath + "qrcodeA";
	}

	@RequestMapping(value = { "/qrcodeB.*" })
	public String qrCodeB(Model model, QRCode qrcode,HttpServletRequest request,HttpServletResponse response) throws Exception{
		model.addAttribute("qrcode",qrcode);
		return basePath + "qrcodeB";
	}

	@RequestMapping(value = { "/qrcodeC.*" })
	public String qrCodeC(Model model, QRCode qrcode,HttpServletRequest request,HttpServletResponse response, BindingResult result) throws Exception{
		if ( StringUtils.isEmpty(qrcode.getTitle()) ) {
			model.addAttribute("qrcode",qrcode);
			return basePath + "qrcodeB";
		} else {
			qrcode.setExtension("jpg");
			qrcode.setWidth(235);
			model.addAttribute("qrcode",qrcode);
			return basePath + "qrcodeC";
		}
	}

	@RequestMapping(value = { "/qrImage.*" })
	public void QRImage( QRCode qrcode, HttpServletRequest request, HttpServletResponse response ) {

		QRCodeWriter q = new QRCodeWriter();
		try {
			String text1 = new String(qrcode.getText1().getBytes("UTF-8"), "ISO-8859-1");
			BitMatrix bitMatrix = q.encode(text1, BarcodeFormat.QR_CODE, qrcode.getWidth(), qrcode.getWidth());
			BufferedImage buff = MatrixToImageWriter.toBufferedImage(bitMatrix);
			File outFile = new File("qr_temp2.jpg");
			ImageIO.write(buff,"png",outFile);
			viewImageResult(outFile,"qrcode."+qrcode.getExtension(),request,response);
//			mv.addObject("viewImageResult",viewImageResult(outFile,"viewImg",request,response));
//			MatrixToImageWriter.writeToStream(bitMatrix, "png", out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	protected void viewImageResult( File serverFile, String filename, HttpServletRequest request, HttpServletResponse response) {
		try {
			if(null != serverFile){
				download(
						request,
						response,
						new FileInputStream( serverFile ),
						filename,
						"image/png",
						(int) serverFile.length()
					);
			}
		}
		catch ( FileNotFoundException e ) {
			e.printStackTrace();
		}
    }


	public static void download( HttpServletRequest request, HttpServletResponse response, InputStream in, String fileName, String contentType, Integer contentLength ) {
		setupResponse( request, response, fileName, contentType, contentLength );

		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;

		try {
			try {
				bis = new BufferedInputStream( in );
				bos = new BufferedOutputStream( response.getOutputStream() );

				int read;

				while ( ( read = bis.read() ) != -1 ) bos.write( read );
			}
			finally {
				if ( bis != null ) bis.close();
				if ( bos != null ) bos.close();
			}
		}
		catch ( IOException e ) {
			e.printStackTrace();
		}
	}

	public static void setupResponse( HttpServletRequest request, HttpServletResponse response, String fileName, String contentType, Integer contentLength ) {
		if ( contentLength != null ) response.setContentLength( contentLength );
		if ( contentType != null ) response.setContentType( contentType );

		
		if ( fileName != null ) {
			try {
				response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
			}
			catch ( Exception e ) {
				e.printStackTrace();
			}
		}
	}
}
