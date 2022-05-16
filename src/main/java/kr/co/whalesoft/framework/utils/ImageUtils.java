package kr.co.whalesoft.framework.utils;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.exif.ExifIFD0Directory;
import com.drew.metadata.jpeg.JpegDirectory;
import org.imgscalr.Scalr;

import java.awt.Image;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.imageio.ImageIO;

/**
 * 이미지 관련 유용한 메소드들
 * 
 */
public class ImageUtils {
	
	/**
	 * 이미지를 리사이징하고 PNG로 변환한다.
	 * 너비, 높이가 둘 다 0이면 리사이징하지 않는다.
	 * 
	 * @param in 원본 이미지(gif, jpg 등)
	 * @param out 결과 이미지(png)
	 * @param width 너비
	 * @param height 높이
	 * @throws IOException
	 */
	public static void resize( InputStream in , OutputStream out , int width , int height ) throws IOException {
		
		// 이미지 파일을 읽어서 BufferedImage에 저장한다.
		BufferedImage image = ImageIO.read( in );
		
		// 원본크기 대비 리사이즈 배율을 구한다.
		double scaleX = (double) width / image.getWidth();
		double scaleY = (double) height / image.getHeight();
		
		// 리사이즈 크기가 지정되어 있으면 리사이즈한다.
		if ( width != 0 || height != 0 ) {
			
			// width나 height 한쪽이 0으로 지정된 경우 가로세로 비율을 맞춘다.
			if ( width  == 0 ) scaleX = scaleY;
			if ( height == 0 ) scaleY = scaleX;
			
			// 축소 리사이징만 한다. (확대는 하지 않는다.)
			if ( scaleX < 1.0 && scaleY < 1.0 ) {
				AffineTransform trans = AffineTransform.getScaleInstance( scaleX, scaleY );
				// Bicubic 알고리즘을 사용하여 리사이즈한다.
				AffineTransformOp transOp = new AffineTransformOp( trans, AffineTransformOp.TYPE_BICUBIC );
				// 리사이징 결과를 저장할 BufferedImage
				BufferedImage dest = new BufferedImage( (int) Math.round( scaleX * image.getWidth() ), (int) Math.round( scaleY * image.getHeight() ), image.getType() );
				// 리사이즈
				transOp.filter( image, dest );
				
				image = dest;
			}
		}
		
		// PNG 형식으로 인코딩해서 전송한다.
		ImageIO.write( image, "png", out );
	}
	
	/**
	 * 이미지를 jpg 로 리사이징한다.
	 * @param filePath
	 * @param fileName
	 * @param maxX
	 * @param maxY
	 * @param margin
	 */
	public static void thumbMakeImg( String filePath , String fileName , int maxX , int maxY , int margin ) {
		try {
			// 파일로 부터 이미지를 얻는다. 사이즈를 결정한다.
			Image inImage = ImageIO.read(new File(filePath + fileName));
			double scaleX = (double) (maxX - margin * 2) / inImage.getWidth(null);
			double scaleY = (double) (maxY - margin * 2) / inImage.getHeight(null);
			double scale = scaleX;
			if (scaleX > scaleY)      
				scale = scaleY;
			// 새이미지의 크기를 결정한다.     
			int scaledW = (int) (scale * inImage.getWidth(null));
			int scaledH = (int) (scale * inImage.getHeight(null));
			// 이미지 버퍼를 생성한다.
			int orientation = getOrientation(filePath, fileName);
			 BufferedImage outImage = ImageProcessor.scaling(inImage, scaledW, scaledH, orientation);
			 ImageProcessor.saveJpeg(filePath + "thumb/" + fileName , outImage, 0.7f);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static int getOrientation(String filePath, String fileName) throws ImageProcessingException, IOException, MetadataException {
		int orientation = 1;
		File imageFile = new File(filePath + fileName);
		Metadata metadata = ImageMetadataReader.readMetadata(imageFile);
		Directory directory = metadata.getFirstDirectoryOfType(ExifIFD0Directory.class);
		if(directory != null) {
			orientation = directory.getInt(ExifIFD0Directory.TAG_ORIENTATION);
		}
		return orientation;
	}


}
