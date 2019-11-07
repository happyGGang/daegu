package kr.co.whalesoft.framework.utils;

import java.io.ByteArrayInputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CharsetEncoder;
import java.nio.charset.CodingErrorAction;

import javax.servlet.http.HttpServletResponse;

public class HangulEnDecoder {
	
	private static CharsetDecoder decoder(String encoding) {
		return Charset.forName(encoding).newDecoder()
				.onMalformedInput(CodingErrorAction.IGNORE)
				.onUnmappableCharacter(CodingErrorAction.IGNORE);
	}

	private static CharsetEncoder encoder(String encoding) {
		return Charset.forName(encoding).newEncoder()
				.onMalformedInput(CodingErrorAction.IGNORE)
				.onUnmappableCharacter(CodingErrorAction.IGNORE);
	}
	
	public static void encodeDataOutput(StringBuffer sb, String decoder, String encoder, HttpServletResponse response) {
		InputStreamReader isr = null;
		OutputStreamWriter osw = null;
		try {
			isr = new InputStreamReader(new ByteArrayInputStream(sb.toString().getBytes()), decoder(decoder));
			osw = new OutputStreamWriter(response.getOutputStream(), encoder(encoder));
			
			char[] buffer = new char[4096];
			int length;
			
			while ((length = isr.read(buffer)) != -1) {
				osw.write(buffer, 0, length);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(osw != null) try { osw.close(); } catch(Exception e) { }
			if(isr != null) try { isr.close(); } catch(Exception e) { }
		}
	}

	public static void encodeDataOutput(String s, String decoder, String encoder, HttpServletResponse response) {
		InputStreamReader isr = null;
		OutputStreamWriter osw = null;
		try {
			isr = new InputStreamReader(new ByteArrayInputStream(s.getBytes()), decoder(decoder));
			osw = new OutputStreamWriter(response.getOutputStream(), encoder(encoder));
			
			char[] buffer = new char[4096];
			int length;
			
			while ((length = isr.read(buffer)) != -1) {
				osw.write(buffer, 0, length);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(osw != null) try { osw.close(); } catch(Exception e) { }
			if(isr != null) try { isr.close(); } catch(Exception e) { }
		}
	}
	
}
